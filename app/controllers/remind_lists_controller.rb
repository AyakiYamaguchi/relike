class RemindListsController < ApplicationController
  before_action :logged_in?
  before_action :date_parse , only:[:finish , :check_list , :update]
  before_action :get_remind_list , only:[:show , :update]
  include OembedTweet

  def index
    remind_lists_count = current_user.remind_lists.group(:remind_count).order(remind_count: :desc).count(:remind_count)

    @remind_group = []
    # map使えそう
    remind_lists_count.each do |remind_count , number|
      count = remind_count
      remind_list = RemindList.where(user: current_user , remind_count: count).first
      tweet = get_oembed_tweet_only_one(remind_list)

      @remind_group.push(
        count: count ,
        number: number ,
        remind_list: remind_list,
        tweet: tweet
      )
      
    end
  end

  def list_by_count
    remind_lists = RemindList.where(user_id: current_user.id , remind_count: params[:remind_count]).limit(30)
    memos = remind_lists.joins(:memos).group("remind_lists.id").count

    remind_lists_items = remind_lists.map do |remind_list|
      {
        remind_list: remind_list ,
        memo_counts: memos[remind_list.id] ,
        tweet: get_oembed_tweet_only_one(remind_list)
      }
    end

    @remind_lists_items = Kaminari.paginate_array(remind_lists_items).page(params[:page]).per(5)
  end

  def show
    @memos = @remind_list.memos
    @tweet = get_oembed_tweet_only_one(@remind_list)
    @memo = Memo.new
  end


  def check_list

    @remind_list = RemindList.find_remind_tweet_list(current_user.id , @remind_date).first

    # リマインドリストが存在しない場合は完了画面へリダイレクトさせる
    if @remind_list.blank?
      redirect_to not_found_remind_lists_path
      return
    end

    @memos = @remind_list.memos
    @memo = Memo.new

    # リマインドリストの埋め込みツイートを取得
    @tweet = get_oembed_tweet_only_one(@remind_list)
  end


  def update
    # いいねチェック結果の更新処理へ
    @remind_list.iine_check!(params[:commit])

    @memo = Memo.new

    # まだリマインドリストが存在したらリストを取得してリダイレクトさせる
    @remind_list = RemindList.find_remind_tweet_list(current_user.id , @remind_date).first
    
    if @remind_list.present?
      redirect_to check_remind_lists_path(current_user.id, params[:remind_date])
      # redirect_to "/remind_lists/#{current_user.id}/#{params[:remind_date]}"
    else
      redirect_to check_finish_remind_lists_path(current_user.id, params[:remind_date])
      # redirect_to "/remind_lists/#{current_user.id}/#{params[:remind_date]}/finish"
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
    logger.debug(@remind_date.class)
  end

  def get_remind_list
    @remind_list = RemindList.find(params[:id])
  end

  # def wday_check
  #   if @remind_date.wday == 0 # 日曜日の場合
  #     return
  #   elsif @remind_date.wday == 3 # 水曜日の場合
  #     return
  #   else
  #     redirect_to not_found_remind_lists_path
  #   end
  # end
end
