class LineMessageRegularlyJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["CHANNEL_SECRET"]
      config.channel_token = ENV["CHANNEL_ACCESS_TOKEN"]

      logger.debug(config.channel_secret)
    }

    remind_date = Date.today

    if remind_date.wday == 0 # 日曜日の場合
      start_date = remind_date - 4
    elsif remind_date.wday == 3 # 水曜日の場合
      start_date = remind_date - 3
    else
      return
    end

    @derively_lists = User.joins(:remind_lists).select('users.id, users.line_uid, count(users.id) as remind_count').group(:id).where(remind_lists: { next_remind_at: start_date...remind_date})

    ActiveRecord::Base.transaction do
      @derively_lists.each do |list|
        # 対象が0件の場合は処理をスキップ
        next if list.remind_count == 0

        message = {
          type: 'text',
          text: "https://relike.herokuapp.com/remind_lists/#{list.id}/#{remind_date.strftime("%Y%m%d")}"
        }
        response = @client.push_message(list.line_uid , message)
        logger.debug(response)
      end
    end
  end
end
