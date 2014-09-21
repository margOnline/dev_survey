class AddExplanationToQuestion < ActiveRecord::Migration
  def self.up
    add_column :questions, :explanation, :text
  end

  def self.down
    remove_column :questions, :explanation
  end
end
