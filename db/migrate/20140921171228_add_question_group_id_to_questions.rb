class AddQuestionGroupIdToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :question_group_id, :integer
  end

  def self.down
    remove_column :questions, :question_group_id
  end
end
