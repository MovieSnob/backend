# frozen_string_literal: true

class AddStateToFilms < ActiveRecord::Migration[5.2]
  def change
    add_column :films, :state, :integer, default: 0
  end
end
