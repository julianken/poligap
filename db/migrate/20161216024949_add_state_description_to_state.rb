class AddStateDescriptionToState < ActiveRecord::Migration[5.0]
  def change
    add_column :states, :state_description, :text
  end
end
