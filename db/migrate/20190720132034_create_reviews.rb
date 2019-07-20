class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.references :user, foreign_key: true
      t.references :film, foreign_key: true
      t.date :date_watched
      t.date :date_reviewed
      t.integer :score

      t.timestamps
    end
  end
end
