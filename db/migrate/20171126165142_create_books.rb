class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.integer :user_id
      t.integer :book_id
      t.string  :name
      t.string  :author
      t.string  :series
      t.string  :price
      t.timestamps
    end
  end
end
