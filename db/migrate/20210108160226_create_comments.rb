class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :user_id
      t.integer :movie_id

      t.timestamps
    end

    add_index :comments, [:movie_id, :user_id], unique: true
  end
end
