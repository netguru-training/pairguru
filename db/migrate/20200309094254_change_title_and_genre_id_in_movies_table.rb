class ChangeTitleAndGenreIdInMoviesTable < ActiveRecord::Migration[5.2]
  def change
    change_column :movies, :title, :string, null: false
    change_column :movies, :genre_id, :integer, null: false
  end
end
