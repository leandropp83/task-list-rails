class AddTaskToProject < ActiveRecord::Migration[7.0]
  def change
    add_reference :tasks, :project, index: true, foreign_key: true
  end
end
