class AddIndexesToTopicAndComment < ActiveRecord::Migration[5.1]
  def change
    add_index :topics, :updated_at
    add_index :comments, :topic_id
  end
end
