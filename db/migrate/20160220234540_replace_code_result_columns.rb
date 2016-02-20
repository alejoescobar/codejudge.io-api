class ReplaceCodeResultColumns < ActiveRecord::Migration
  def change
    remove_column :code_results, :passed
    remove_column :code_results, :has_errors
    add_column :code_results, :evaluator_status, :integer
    add_column :code_results, :status, :integer
  end
end
