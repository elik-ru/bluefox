class CreateVacancyAbilities < ActiveRecord::Migration
  def change
    create_table :vacancy_abilities do |t|
      t.integer :vacancy_id
      t.integer :ability_id

      t.timestamps null: false
    end
  end
end
