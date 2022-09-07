class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.boolean :status
      t.string :name
      t.datetime :date_in
      t.datetime :date_end

      t.timestamps
    end
  end
end
