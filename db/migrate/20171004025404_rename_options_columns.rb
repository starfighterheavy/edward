class RenameOptionsColumns < ActiveRecord::Migration[5.1]
  def change
    rename_column :options, :value, :text
    rename_column :options, :name, :value
  end
end
