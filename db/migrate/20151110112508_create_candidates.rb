class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.string :name
      t.string :contact_info
      t.boolean :title
      t.integer :salary

      t.timestamps null: false
    end
  end
end
