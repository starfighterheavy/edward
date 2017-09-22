class CreateSteps < ActiveRecord::Migration[5.1]
  def change
    create_table :steps do |t|
      t.text :text
      t.text :conditions
      t.timestamps
    end

    create_table :answers do |t|
      t.string :name
      t.string :input_type
      t.timestamps
    end

    create_table :options do |t|
      t.string :name
      t.string :value
    end

    create_table :answers_options do |t|
      t.integer :answer_id
      t.integer :option_id
      t.timestamps
    end
  end
end
