require 'spec_helper'

describe Tweet do
  after(:each) do 
    Tweet.destroy_all
  end

  describe ".seed_tweets" do 
    it "creates tweets from the feed" do 
      tweets = [mock("tweet", { :created_at => Time.now, :text => "tweets", :id_str => "12345678910" }),
                mock("tweet", { :created_at => Time.now, :text => "tweets", :id_str => "23456789101"}) ]

      Twitter.stub!(:user_timeline).and_return(tweets)

      Tweet.seed_tweets
      Tweet.count.should == 2
    end

    it "grabs tweets from Twitter" do 
      Twitter.should_receive(:user_timeline).and_return([])
      Tweet.seed_tweets
    end
  end
end
