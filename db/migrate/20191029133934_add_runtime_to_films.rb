class AddRuntimeToFilms < ActiveRecord::Migration[5.2]
  def change
    add_column :films, :runtime, :integer
  end
end
