class ChangeProjectDatesType < ActiveRecord::Migration
  def change
    change_column :projects, :setup_date, :datetime
    change_column :projects, :finish_date, :datetime
  end
end
