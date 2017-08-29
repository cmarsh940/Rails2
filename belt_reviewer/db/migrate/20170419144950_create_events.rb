class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :date
      t.string :address
      t.string :state
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
