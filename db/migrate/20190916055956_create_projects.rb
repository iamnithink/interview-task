class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.column :title, :string
      t.column :category_id, :integer, :null => false
      t.column :user_id, :integer, :null => false

      t.timestamps
    end
  end
end
