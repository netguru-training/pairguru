class CreateCommentsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :description, null: false
      t.references :movie, index: true, null: false
      t.references :user, index: true, null: false

      t.timestamps
    end

    add_index :comments, [:movie_id, :user_id], unique: true
  end
end
