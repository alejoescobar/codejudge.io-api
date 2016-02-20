class AddColumnToSubmit < ActiveRecord::Migration
  def change
    add_column :submits, :language, :string
  end
end
