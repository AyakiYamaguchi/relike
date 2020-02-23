class GetFavTweetJob < ApplicationJob
  queue_as :default

  def perform(*args)
    @users = User.all

    @users.each do |user|
      last_tweet = user.remind_lists.last

      @client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV["TWITTER_KEY"]
        config.consumer_secret     = ENV["TWITTER_SECRET"]
        config.access_token        = user.twitter_access_token
        config.access_token_secret = user.twitter_access_secret
      end

      logger.debug(last_tweet.tweet_id)
  
      # 最後に登録したリマインドリスト以降のお気に入りツイートを取得
      @fav_tweets = @client.favorites(since_id: last_tweet.tweet_id).reverse!

      # リマインド日の設定
      remind_date = Date.today + 30

      ActiveRecord::Base.transaction do
        @fav_tweets.each do |tweet|

          RemindList.create!(
            user_id:         user.id,
            tweet_acount_id: tweet.attrs[:user][:id],
            tweet_id:        tweet.attrs[:id],
            next_remind_at:  remind_date
          )
        end
      end
    end
  end

end
