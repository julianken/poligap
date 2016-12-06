class AddEmailToRepresentatives < ActiveRecord::Migration[5.0]
  def change
    add_column :representatives, :email, :string
  end
end
