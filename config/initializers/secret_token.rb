# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
Rails.application.config.secret_token = Salva::SiteConfig.app('secret_token')
Rails.application.config.secret_key_base = Salva::SiteConfig.app('secret_token_base')

