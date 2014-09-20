class CreatePossibleAnswers < ActiveRecord::Migration
  def self.up
    create_table :possible_answers do |t|
      t.integer :question_id
      t.text :text

      t.timestamps
    end
  end

  def self.down
    drop_table :possible_answers
  end
end
