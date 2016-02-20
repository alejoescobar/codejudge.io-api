class CreateSubmits < ActiveRecord::Migration
  def change
    create_table :submits do |t|
      t.text :code
      t.integer :status
      t.references :challenge, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
