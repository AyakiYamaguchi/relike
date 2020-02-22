web: bin/rails server -p $PORT -e $RAILS_ENV
worker: bundle exec sidekiq -e production -t 25 -C config/sidekiq.yml