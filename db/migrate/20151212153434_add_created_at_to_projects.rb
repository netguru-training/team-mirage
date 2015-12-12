class AddCreatedAtToProjects < ActiveRecord::Migration
  def change
    add_timestamps(:projects)
  end
end
