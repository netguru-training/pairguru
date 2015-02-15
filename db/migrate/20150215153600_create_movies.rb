class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.text :description
      t.timestamp :released_at
      t.string :avatar
      t.references :genre, index: true

      t.timestamps
    end
  end
end
