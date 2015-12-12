class RenameProjectDescriptionColumn < ActiveRecord::Migration
  def change
    rename_column :projects, :descrition, :description
  end
end
