class AddUsersRefToAnalytics < ActiveRecord::Migration[6.0]
  def change
    add_reference :analytics, :user, null: false, foreign_key: true
  end
end
