class CreateMovements < ActiveRecord::Migration[7.0]
  def change
    create_table :movements do |t|
      t.references :product, null: false, foreign_key: true
      t.integer :movement_type
      t.integer :quantity
      t.text :comment

      t.timestamps
    end
  end
end
