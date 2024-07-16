class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.decimal :wallet_balance, precision: 10, scale: 2, default: 10000

      t.timestamps
    end
  end
end
