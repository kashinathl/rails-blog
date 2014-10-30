class AddPasswordToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :password, :string
    add_column :posts, :users, :text
  end
end
