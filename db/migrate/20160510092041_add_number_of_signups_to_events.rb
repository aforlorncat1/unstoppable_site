class AddNumberOfSignupsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :number_of_signups, :integer
  end
end
