class RemindListsController < ApplicationController
  before_action :authenticate_user!
  before_action :date_parse , only:[:finish , :not_found , :check_list]
  before_action :get_remind_list , only:[:show , :update]
  include OembedTweet

  def index
    remind_lists_count = RemindList.group(:remind_count).where(user_id: current_user.id).order('remind_count DESC').count(:remind_count)

    @remind_group = []
    remind_lists_count.each do |remind_count , number|
      count = remind_count
      remind_list = RemindList.where(user_id: current_user.id , remind_count: count).first
      tweet = get_oembed_tweet_only_one(remind_list)

      @remind_group.push(
        count: count ,
        number: number ,
        tweet: tweet
      )
    end
  end

  def list_by_count
    remind_lists = RemindList.where(user_id: current_user.id , remind_count: params[:remind_count]).limit(5)
    @memos = remind_lists.joins(:memos).group("remind_lists.id").count

    @remind_lists_items = remind_lists.map do |remind_list|
      {
        remind_list: remind_list ,
        memo_counts: @memos[remind_list.id] ,
        tweet: get_oembed_tweet_only_one(remind_list)
      }
    end
  end

  def show
    @memos = @remind_list.memos
    @tweet = get_oembed_tweet_only_one(@remind_list)
    @memo = Memo.new
  end


  def check_list
    wday_check(@remind_date)

    @remind_list = RemindList.new.find_remind_tweet_list(current_user.id , remind_date).first

    # リマインドリストが存在しない場合は完了画面へリダイレクトさせる
    if @remind_list.blank?
      redirect_to "/remind_lists/#{current_user.id}/#{params[:remind_date]}/finish"
      return
    end

    @memos = @remind_list.memos

    # リマインドリストの埋め込みツイートを取得
    @tweet = get_oembed_tweet_only_one(@remind_list)
  end


  def update
    # いいねチェック結果の更新処理へ
    @remind_list.iine_check(params[:commit])

    @memo = Memo.new

    # まだリマインドリストが存在したらリストを取得してリダイレクトさせる
    @remind_list = RemindList.new.find_remind_tweet_list(current_user.id , params[:remind_date]).first
    
    if @remind_lists.present?
      redirect_to test_remind_lists_path(current_user.id, remind_date)
      redirect_to "/remind_lists/#{current_user.id}/#{params[:remind_date]}"
    else
      redirect_to "/remind_lists/#{current_user.id}/#{params[:remind_date]}/finish"
    end
  end

  def finish
  end

  def not_found
  end


  private

  def get_remind_tweet(user_id , remind_date)
    # 受け取ったremind_dateをDateオブジェクトに変換
    remind_date = Date.parse(remind_date)
    RemindList.new.find_remind_tweet_list(user_id, remind_date )
  end

  def date_parse
    @remind_date = Date.parse(params[:remind_date])
  end

  def wday_check(remind_date)
    if remind_date.wday == 0 # 日曜日の場合
      return
    elsif remind_date.wday == 3 # 水曜日の場合
      return
    else
      redirect_to not_found_remind_list_path
    end
  end

  def get_remind_list
    @remind_list = RemindList.find(params[:id])
  end

end
