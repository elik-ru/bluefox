class CandidaternametitletoisActive < ActiveRecord::Migration
  def change
    rename_column :candidates, :title, :is_active
  end
end
