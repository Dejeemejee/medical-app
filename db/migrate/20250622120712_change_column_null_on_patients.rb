class ChangeColumnNullOnPatients < ActiveRecord::Migration[8.0]
  def change
    change_column_null :patients, :doctor_id, true
  end
end
