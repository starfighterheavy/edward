class AddCalloutMethodToSteps < ActiveRecord::Migration[5.1]
  def change
    add_column :steps, :callout_method, :string
    add_column :steps, :callout_body, :string
  end
end
