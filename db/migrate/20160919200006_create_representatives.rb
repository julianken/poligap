class CreateRepresentatives < ActiveRecord::Migration[5.0]
  def change
    create_table :representatives do |t|
      t.integer :state_id
      t.string :full_name
      t.string :first_name
      t.string :last_name
      t.string :cid
      t.string :state_abbreviated
      t.string :state_full
      t.string :chamber
      t.string :image_url
      t.string :gender
      t.string :website
      t.string :phone_number
      t.string :fax_number
      t.string :twitter_id
      t.string :youtube_url
      t.string :facebook_id
      t.string :congress_office
      t.string :party
      t.string :birthdate
      t.string :webform

      t.timestamps
    end
  end
end
