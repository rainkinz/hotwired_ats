class CreateAircrafts < ActiveRecord::Migration[7.1]
  def change
    create_table :aircrafts, id: :uuid do |t|
      t.string :registration
      t.string :model
      t.string :category
      t.boolean :complex
      t.boolean :taa
      t.boolean :high_performance
      t.boolean :pressurized

      t.timestamps
    end
  end
end
