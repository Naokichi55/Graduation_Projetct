class CreateRackets < ActiveRecord::Migration[7.2]
  def change
    create_table :rackets do |t|
      t.string :product_name, null: false
      t.string :maker_name,  null: false



      t.timestamps
    end
  end
end
