class AddTweetIdToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :tweetID, :integer
  end
end
