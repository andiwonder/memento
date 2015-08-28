class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.string :logo
      t.string :date

      t.references :user, index: true, foreign_key: true
    end
  end
end
