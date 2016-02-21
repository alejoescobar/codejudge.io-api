class AddCodeErrorsColumnToCodeResult < ActiveRecord::Migration
  def change
    add_column :code_results, :code_errors, :text
  end
end
