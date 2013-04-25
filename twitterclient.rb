require_relative 'secrets.rb'
require 'launchy'
require 'oauth'
require 'yaml'


class TwitterSession

  CONSUMER = OAuth::Consumer.new(
  CONSUMER_KEY, CONSUMER_SECRET, :site => "https://twitter.com")

  def self.access_token
    @@access_token ||= self.request_access_token
  end

  def self.request_access_token
    request_token = CONSUMER.get_request_token
    authorize_url = request_token.authorize_url

    puts "Go to this URL: #{authorize_url}"
    Launchy.open(authorize_url)

    puts "Login, and type your verification code in"
    oauth_verifier = gets.chomp

    request_token.get_access_token(
          :oauth_verifier => oauth_verifier)
  end

end