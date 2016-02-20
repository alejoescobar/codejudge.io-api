class CreateTestCases < ActiveRecord::Migration
  def change
    create_table :test_cases do |t|
      t.text :input
      t.text :output
      t.references :challenge, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
