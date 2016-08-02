class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :avatar
      t.integer :role, default: 0
      t.string :provider
      t.string :uid
      
      t.timestamps null: false
    end
  end
end
