Rails.application.config.sorcery.submodules = [:external]

Rails.application.config.sorcery.configure do |config|
  config.external_providers = [:twitter]

  config.twitter.key = ENV['TWITTER_KEY']
  config.twitter.secret = ENV['TWITTER_SECRET']
  config.twitter.callback_url = ENV['TWITTER_CALLBACK_URL']
  config.twitter.user_info_mapping = { email: "email" }

  config.user_config do |user|
    user.authentications_class = Authentication
  end

  config.user_class = "User"
end
