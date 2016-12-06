class AddDonorColumnToRepresentatives < ActiveRecord::Migration[5.0]

  def change
    add_column :representatives, :contributors, :text, array: true
  end

end
