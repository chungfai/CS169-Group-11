class AddDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.references :project
      t.references :user
      t.text :email
      t.integer :amount
      t.text :stripe_charge_id
      t.timestamps
    end
    
    add_column :users, :donations_id, :integer
    add_index :users, :donations_id
    
    add_column :projects, :donations_id, :integer
    add_index :projects, :donations_id
  end
end
