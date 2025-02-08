class CreateQuizzes < ActiveRecord::Migration[7.1]
  def change
    create_table :quizzes, id: :uuid do |t|
      t.string :title

      t.timestamps
    end
  end
end
