class CreateCodeResults < ActiveRecord::Migration
  def change
    create_table :code_results do |t|
      t.text :actual_output
      t.text :expected_output
      t.integer :passed
      t.boolean :has_errors
      t.references :submit, index: true, foreign_key: true
      t.references :test_case, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
