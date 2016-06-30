desc "This task is called by the Heroku scheduler add-on"

task :send_notifications => :environment do
  User.notify_not_viewed_cards
end