Rails.application.config.sorcery.submodules = [:external]

Rails.application.config.sorcery.configure do |config|
  config.external_providers = [:twitter, :vk, :github]

  config.github.key = ENV['GITHUB_KEY']
  config.github.secret = ENV['GITHUB_SECRET']
  config.github.callback_url = ENV['GITHUB_CALLBACK_URL']
  config.github.user_info_mapping = { email: "name" }

  config.twitter.key = ENV['TWITTER_KEY']
  config.twitter.secret = ENV['TWITTER_SECRET']
  config.twitter.callback_url = ENV['TWITTER_CALLBACK_URL']
  config.twitter.user_info_mapping = { email: "screen_name" }

  config.vk.key = ENV["VK_KEY"]
  config.vk.secret = ENV["VK_SECRET"]
  config.vk.callback_url = ENV["VK_CALLBACK_URL"]
  config.vk.user_info_mapping = { email: "email" }

  config.user_config do |user|
    user.authentications_class = Authentication
  end

  config.user_class = "User"
end
