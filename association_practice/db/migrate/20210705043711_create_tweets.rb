class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.text :body
      t.integer :user_id #foreign_key

      t.timestamps
    end
  end
end
