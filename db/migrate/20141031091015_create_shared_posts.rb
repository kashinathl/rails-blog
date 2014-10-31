class CreateSharedPosts < ActiveRecord::Migration
  def change
    create_table :shared_posts do |t|
      t.string :post_id
      t.string :password
      t.text :users

      t.timestamps
    end
  end
end
