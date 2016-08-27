class RemoveMemberidFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :memberid, :string
  end
end
