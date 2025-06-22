class CreatePatients < ActiveRecord::Migration[8.0]
  def change
    create_table :patients do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.date :date_of_birth
      t.text :address
      t.string :medical_record_number
      t.references :registered_by, null: false, foreign_key: {to_table: :users}
      t.references :doctor, null: false, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
