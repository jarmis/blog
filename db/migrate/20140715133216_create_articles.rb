class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles2 do |t|
      t.string :title
      t.text :text

      t.timestamps
    end
  end
end
