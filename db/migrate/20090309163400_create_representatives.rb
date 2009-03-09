class CreateRepresentatives < ActiveRecord::Migration
  def self.up
    create_table :representatives do |t|
      t.string :name
      t.string :party
      t.string :sc_url

      t.timestamps
    end
  end

  def self.down
    drop_table :representatives
  end
end
