class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.references :user, foreign_key: true
      t.decimal :balance, precision: 10, scale: 2, null: false, default: 0
      t.timestamps
    end
  end
end
