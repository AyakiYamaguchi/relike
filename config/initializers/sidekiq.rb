# Sidekiq.configure_server do |config|
#   if Rails.env.production?
#     if ENV['REDIS_URL']
#       config.redis = { url: ENV['REDIS_URL'], namespace: 'sidekiq' }
#     end
#   else
#     config.redis = { url: 'redis://localhost:6379', namespace: 'sidekiq' }
#   end
# end

if Rails.env.development?
  Sidekiq.configure_server do |config|
    config.redis = { url: 'redis://localhost:6379' }
  end
end

if Rails.env.production?
  Sidekiq.configure_client do |config|
    config.redis = { url: ENV['REDIS_URL'], size: 2 }
  end

  Sidekiq.configure_server do |config|
    config.redis = { url: ENV['REDIS_URL'], size: 20 }
  end
end