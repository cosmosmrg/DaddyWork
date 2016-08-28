class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :altername1
      t.string :altername2
      t.string :altername3
      t.integer :timeofbirthhour
      t.integer :timeofbirthmin
      t.integer :date
      t.integer :month
      t.integer :year
      t.string :birthdate
      t.integer :age
      t.string :moonyear
      t.string :phone
      t.string :lineid
      t.string :email
      t.string :username
      t.string :password
      t.string :memberid

      t.timestamps
    end
  end
end
