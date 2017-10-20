class AddDetailsToStepCta < ActiveRecord::Migration[5.1]
  def change
    add_column :steps, :cta_class, :string
    add_column :steps, :cta_href, :text
  end
end
