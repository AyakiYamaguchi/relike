class TestJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    logger.debug(Date.today)
    logger.debug('実行しました。')
  end
end
