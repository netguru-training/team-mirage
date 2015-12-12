class AddOwnersToProjects < ActiveRecord::Migration
  def change
    add_reference :projects, :owner
  end
end
