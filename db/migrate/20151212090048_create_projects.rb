class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :descrition
      t.integer :goal
      t.integer :current_funds
      t.date :setup_date
      t.date :finish_date
    end
  end
end
