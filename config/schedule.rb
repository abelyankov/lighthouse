set :output, 'log/cron_log.log'
set :environment, ENV['RAILS_ENV']
ENV.each { |k, v| env(k, v) }

every 1.day do
  runner "Sync.new.call"
end