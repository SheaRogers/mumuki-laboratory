class AddLayoutToExercise < ActiveRecord::Migration
  def change
    add_column :exercises, :layout, :integer, default: 0, null: false
  end
end
