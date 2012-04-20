class Tweet

  KARL = 'dadboner'

  include Mongoid::Document
  field :created_at, :type => Time
  field :twitter_id, :type => String, :unique => true
  field :text, :type => String

  def self.seed_tweets
    tweets = Twitter.user_timeline(KARL, :trim_user => true, :count => 200)
    max_id = tweets.map{|t| t.id}.sort.first

    while tweets.any?
      tweets = Twitter.user_timeline(KARL, :trim_user => true, :count => 200, :max_id => max_id)
      max_id = tweets.map{|t| t.id}.sort.first

      tweets.each do |twoot|
        tweet = create(:twitter_id => twoot.id.to_s, :created_at => twoot.created_at, :text => twoot.text)
      end
    end
  end

end
