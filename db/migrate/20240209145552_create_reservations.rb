class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.boolean :already_booked
      t.belongs_to :guest, foreign_key: {to_table: :users}
      t.belongs_to :listing
      t.timestamps
    end
  end
end
