class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :value
      t.timestamps null: false
    end
  end
end
