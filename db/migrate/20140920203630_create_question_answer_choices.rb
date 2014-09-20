class CreateQuestionAnswerChoices < ActiveRecord::Migration
  def self.up
    create_table :question_answer_choices do |t|
      t.integer :answer_id
      t.integer :possible_answer_id

      t.timestamps
    end
  end

  def self.down
    drop_table :question_answer_choices
  end
end
