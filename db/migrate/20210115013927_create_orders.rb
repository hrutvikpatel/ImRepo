class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.references :account, foreign_key: true
      t.references :product, foreign_key: true
      t.decimal :cost, precision: 10, scale: 2, null: false, default: 0
      t.timestamps
    end
  end
end
