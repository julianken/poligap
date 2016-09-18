class CreateStates < ActiveRecord::Migration[5.0]
  def change
    create_table :states do |t|
      t.string :abbreviated_name
      t.string :full_name
    end
  end
end
