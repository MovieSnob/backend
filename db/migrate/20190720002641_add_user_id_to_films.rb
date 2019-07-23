# frozen_string_literal: true

class AddUserIdToFilms < ActiveRecord::Migration[5.2]
  def change
    add_reference :films, :user, foreign_key: true
  end
end
