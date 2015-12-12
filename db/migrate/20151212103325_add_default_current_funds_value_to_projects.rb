class AddDefaultCurrentFundsValueToProjects < ActiveRecord::Migration
  def change
    change_column :projects, :current_funds, :integer, default: 0
  end
end
