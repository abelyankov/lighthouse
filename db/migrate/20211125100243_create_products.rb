class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.bigint :wildberries_id
      t.date :date
      t.integer :position, default: 0
      t.timestamps
    end
  end
end
