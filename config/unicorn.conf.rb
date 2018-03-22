# config/unicorn.conf.rb
# https://github.com/defunkt/unicorn/blob/master/examples/unicorn.conf.rb
worker_processes 8
listen 8080, :tcp_nopush => true
pid "tmp/unicorn.pid"
preload_app true

run_once = true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
