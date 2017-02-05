# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
 set :output, "log/cron.log"
#
# every 1.day, :at => '4:20 pm' do
# #   command "/usr/bin/some_great_command"
# #   runner "MyModel.some_method"
# #   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

every 30.minutes, do
  rake 'meme'
end
