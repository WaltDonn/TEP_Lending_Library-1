class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.date :start_date
      t.date :end_date
      t.date :pick_up_date
      t.date :return_date
      t.integer :release_form_id
      t.references :kit
      t.references :user

      t.timestamps
    end
  end
end
