class AddUidToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :uid, :string
  end
end
