class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.string :name
      t.text :description
      t.references :item, foreign_key: true

      t.timestamps
    end
  end
end
