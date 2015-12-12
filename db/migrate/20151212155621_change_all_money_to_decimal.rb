class ChangeAllMoneyToDecimal < ActiveRecord::Migration
  def change
    change_column :payments, :value, :decimal
    change_column :projects, :goal, :decimal
    change_column :projects, :current_funds, :decimal
  end
end
