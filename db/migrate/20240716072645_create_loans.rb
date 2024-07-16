class CreateLoans < ActiveRecord::Migration[7.1]
  def change
    create_table :loans do |t|
      t.decimal :amount, precision: 10, scale: 2
      t.decimal :interest_rate, precision: 5, scale: 2, default: 5.0
      t.integer :status, default: 0
      t.references :user, null: false, foreign_key: true
      t.references :admin, null: false, foreign_key: true

      t.timestamps
    end
  end
end
