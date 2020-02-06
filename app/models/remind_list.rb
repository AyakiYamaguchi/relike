class RemindList < ApplicationRecord

  belongs_to :user
  has_many :memos

  # 初めてTwitter連携した時に、初回のリマインドリストを一括取得する処理
  def set_first_remind_tweet(user)

    # Twitterの認証情報をセット
    @client = set_twitter_Authentication

    # お気に入りした最新ツイート100件まで取得する
    @fav_tweets = @client.favorites( count: 100 ).reverse!

    today = Date.today
    count = 0                # リマインドタイミングを計算するカウント数 
    loop_count = 1           # ループ処理を回した回数をカウントする

    logger.debug(@fav_tweets)
    
    ActiveRecord::Base.transaction do
      @fav_tweets.each do |tweet|
        remind_date = count * 3  # 今日から◯日後にリマンドするか設定

        RemindList.create!(
          user_id:         user.id,
          tweet_acount_id: tweet.attrs[:user][:id],
          tweet_id:        tweet.attrs[:id],
          next_remind_at:  today.since(remind_date.to_i.days)
        )

        # ループ処理の回数が3の倍数だったらカウントアップする
        if loop_count % 3 == 0
          count += 1
        end

        loop_count += 1
      end
    end
  end


  # 最新のお気に入りツイートを取得するメソッド
  def get_fav_tweet 
    # Twitterの認証情報をセット
    @client = set_twitter_Authentication

    # 一番最後に登録されたリマインドリストを取得
    last_tweet = RemindList.last

    # 最後に登録したリマインドリスト以降のお気に入りツイートを取得
    @fav_tweets = @client.favorites( since_id: last_tweet.tweet_id )

    # リマインド日の設定
    remind_date = Date.today + 30

    @fav_tweets.each do |tweet|

      RemindList.create!(
        user_id:         user.id,
        tweet_acount_id: tweet.attrs[:user][:id],
        tweet_id:        tweet.attrs[:id],
        next_remind_at:  remind_date
      )
    end
  end


  # いいねチェック画面に表示するツイートを取得するメソッド
  def find_remind_tweet_list(user_id , remind_date)

    # リマインド日の曜日によってツイート取得の開始日を変える
    if remind_date.wday == 0 # 日曜日の場合
      start_date = remind_date - 4
    elsif remind_date.wday == 3 # 水曜日の場合
      start_date = remind_date - 3
    end
    
    # 表示対象のツイートの検索処理
    RemindList.where(
      user_id: user_id ,
      next_remind_at: start_date...remind_date,
    ).limit(1)
  end


  # いいねチェック結果の処理メソッド
  def iine_check(check_result)

    # 残すを選択した場合
    if check_result === 'また見たい'
      self.next_remind_at = Date.today + 30
      self.remind_count += 1
    # 残さない選択をした場合
    elsif check_result == 'もう見ない'
      self.next_remind_at = null
    end

    self.save
  end

  private

  def set_twitter_Authentication
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_KEY"]
      config.consumer_secret     = ENV["TWITTER_SECRET"]
      config.access_token        = user.twitter_access_token
      config.access_token_secret = user.twitter_access_secret
    end
  end
end
