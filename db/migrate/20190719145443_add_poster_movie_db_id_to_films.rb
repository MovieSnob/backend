class AddPosterMovieDbIdToFilms < ActiveRecord::Migration[5.2]
  def change
    add_column :films, :poster, :string
    add_column :films, :movie_db_id, :integer
    add_index :films, :movie_db_id
  end
end
