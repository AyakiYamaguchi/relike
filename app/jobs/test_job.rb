class TestJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    logger.debug(Date.today)
    logger.debug('実行しました。')

    response = RemindList.line_push_message
    logger.debug(response)
  end
end
