class RemoveUniqTextIndexFromSteps < ActiveRecord::Migration[5.1]
  def up
    remove_index :steps, name: 'index_steps_on_workflow_id_and_text'
    add_index :steps, [:text, :conditions, :workflow_id], unique: true
  end

  def down
    add_index :steps, [:workflow_id, :text], unique: true
    remove_index :steps, name: 'index_steps_on_text_and_conditions_and_workflow_id'
  end
end
