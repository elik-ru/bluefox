class CreateCandidateAbilities < ActiveRecord::Migration
  def change
    create_table :candidate_abilities do |t|
      t.integer :candidate_id
      t.integer :ability_id

      t.timestamps null: false
    end
  end
end
