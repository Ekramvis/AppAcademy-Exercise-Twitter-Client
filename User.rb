require 'debugger'
require_relative 'twitterclient.rb'
require_relative 'status.rb'
require 'json'
require 'addressable/uri'

class User

  def initialize(username)
    @username = username
  end

  def timeline

    timeline_address = Addressable::URI.new(
      :scheme => "https",
      :host => "api.twitter.com",
      :path => "1.1/statuses/user_timeline.json",
      :query_values => {
        :screen_name => @username,
        :count => "10"
      }
    ).to_s

    raw_timeline = TwitterSession.access_token.get(timeline_address)
    timeline = JSON.parse(raw_timeline.body)

    tweets = []
    timeline.each do |tweet|
      text = tweet["text"]
      tweets << Status.new(@username, text)
    end
    tweets.each do |tweet|
      puts tweet.text
    end

  end

  def followers
    followers_address = Addressable::URI.new(
      :scheme => "https",
      :host => "api.twitter.com",
      :path => "1.1/followers/ids.json",
      :query_values => {
        :screen_name => @username,
        :count => "10"
      }
    ).to_s

    raw_followers = TwitterSession.access_token.get(followers_address)
    follower_list = JSON.parse(raw_followers.body)

    p follower_list

    followers = follower_list["ids"]

    p followers

  end

  def followed_users
  end

  private

  def self.parse
  end

end