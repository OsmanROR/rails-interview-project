class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers do |t|
      t.string      :body
      t.references  :question, null: false, foreign_key: true
      t.references  :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
