class AddIndexToEventUsers < ActiveRecord::Migration
  def change
     def change
    add_index :event_users, :attendee_id
    add_index :event_users, :attended_event_id
    add_index :event_users, [:attendee_id, :attended_event_id], unique: true
  end
  end
end
