class RemindListsController < ApplicationController
  before_action :authenticate_user!
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
    @remind_list = RemindList.find_by(id: params[:id])
    @memos = @remind_list.memos
    @tweet = get_oembed_tweet_only_one(@remind_list)
    @memo = Memo.new
  end


  def check_list
    # before_action で日曜日と水曜日以外だったらリダイレクトする処理を追加する

    remind_date = Date.parse(params[:remind_date])
    @remind_list = RemindList.new.find_remind_tweet_list(current_user.id , remind_date).first

    # リマインドリストが存在しない場合は完了画面へリダイレクトさせる
    if @remind_list.blank?
      redirect_to "/remind_lists/#{current_user.id}/#{params[:remind_date]}/finish"
      return
    end

    @memos = @remind_list.memos

    # リマインドリストの埋め込みツイートを取得
    @tweet = get_oembed_tweet_only_one(@remind_list)
    logger.debug(@tweet)
  end


  def update
    # いいねチェック結果の更新処理へ
    @remind_list = RemindList.find(params[:id])
    @remind_list.iine_check(params[:commit])

    # メモがあれば内容を保存
    # if params[:memo_content].present?
    #   Memo.create!(remind_list_id: params[:id] , content: params[:memo_content])
    # end
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
    @remind_date = Date.parse(params[:remind_date])
  end

  def not_found
    @remind_date = Date.parse(params[:remind_date])
  end


  private

  def get_remind_tweet(user_id , remind_date)
    # 受け取ったremind_dateをDateオブジェクトに変換
    remind_date = Date.parse(remind_date)
    RemindList.new.find_remind_tweet_list(user_id, remind_date )
  end

end
