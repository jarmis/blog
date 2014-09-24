class CreateDragons < ActiveRecord::Migration
  def change
    create_table :dragons do |t|
      t.string :name
      t.datetime :asleep
      t.integer :stuffinbelly, :stuffinintestine
      t.timestamps
    end
  end
end
