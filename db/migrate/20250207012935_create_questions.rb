class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions, id: :uuid do |t|
      t.references :quiz, null: false, foreign_key: true, type: :uuid
      t.text :content

      t.timestamps
    end
  end
end
