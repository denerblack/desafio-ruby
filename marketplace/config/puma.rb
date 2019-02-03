=begin
threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }.to_i
threads threads_count, threads_count
port        ENV.fetch("PORT") { 3000 }

environment ENV.fetch("RAILS_ENV") { "development" }

plugin :tmp_restart
=end

#!/usr/bin/env puma


if environment ENV['RAILS_ENV'] == 'production'
=begin
daemonize true

pidfile "/home/deploy/apps/marketplace/shared/tmp/pids/puma.pid"
stdout_redirect "/home/deploy/apps/marketplace/shared/tmp/log/stdout", "/home/deploy/apps/marketplace/shared/tmp/log/stderr"

threads 0, 16

bind "unix:///home/deploy/apps/marketplace/shared/tmp/sockets/puma.sock"
=end

  bind  "unix:///home/deploy/apps/marketplace/shared/tmp/sockets/puma.sock"
  pidfile "/home/deploy/apps/marketplace/shared/tmp/pids/puma.pid"
  state_path "/home/deploy/apps/marketplace/shared/tmp/sockets/puma.state"
  stdout_redirect "/home/deploy/apps/marketplace/shared/tmp/log/stdout", "/home/deploy/apps/marketplace/shared/tmp/log/stderr"
  stdout_redirect "/home/deploy/apps/marketplace/shared/tmp/log/stdout", "/home/deploy/apps/marketplace/shared/tmp/log/stderr", true
  directory "/home/deploy/apps/marketplace/current"

  workers 2
  threads 1,2

  daemonize true

  activate_control_app 'unix:///home/deploy/apps/marketplace/shared/tmp/sockets/pumactl.sock'

  prune_bundler
end
