class Tweet < ActiveRecord::Base
  attr_accessible :account, :message, :name, :picURL, :tweetID
  validates :tweetID, :uniqueness => true
  
  def self.get_tweets    
    require 'net/http'
    require 'uri'
    require 'JSON'
    
    # in case checking the hash doesn't work for some reason
    # self.delete_all
    
    uri = URI.parse('http://search.twitter.com/search.json?q=%23bieber&rpp=50')
    # puts ("uri.host = #{uri.host}")
    # puts ("uri.port = #{uri.port}")
    # puts ("uri.request_uri #{uri.request_uri}")
    
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    
    response = http.request(request)
    # puts "response is #{response.class.name}"
    
    body = response.body
    # puts "body is #{body.class.name}"
    # puts "\n \n \nbody = #{body}"
    
    parsed_body = JSON.parse(body)
    results = parsed_body["results"]
    # puts "results is #{results.class.name}"
    # puts "\n\n\nresults = #{results}"
    
    first_result = results[0]
    # puts "first_result is #{first_result.class.name}"
    # puts "\n\n\n\nfirst_result = #{first_result}"
    
    # created_of_first_result = first_result["created_at"]
    # puts "created_of_first_result is #{created_of_first_result.class.name}"
    # puts "created_of_first_result = #{created_of_first_result}"
    
    results.each do |tweet|
      t = Tweet.new(:name => tweet["from_user_name"], :account => tweet["from_user"], :message => tweet["text"], :picURL => tweet["profile_image_url"],
                    :tweetID => tweet["id"])
      t.save
    end

    # return response
    
    
    
  end
end
