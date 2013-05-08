class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :name
      t.string :account
      t.string :message
      t.string :picURL

      t.timestamps
    end
  end
end
