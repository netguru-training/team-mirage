class AddUserRefToPayments < ActiveRecord::Migration
  def change
    add_reference :payments, :user, index: true, foreign_key: true
    add_reference :payments, :project, index: true, foreign_key: true
  end
end
