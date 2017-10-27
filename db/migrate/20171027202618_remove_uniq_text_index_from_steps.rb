class RemoveUniqTextIndexFromSteps < ActiveRecord::Migration[5.1]
  def up
    remove_index :steps, name: 'index_steps_on_text_and_workflow_id'
    add_index :steps, [:text, :conditions, :workflow_id], unique: true
  end

  def down
    add_index :steps, [:text, :workflow_id], unique: true
    remove_index :steps, name: 'index_steps_on_text_and_conditions_and_workflow_id'
  end
end
