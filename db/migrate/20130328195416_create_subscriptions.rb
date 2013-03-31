class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :subscribed_by, :subscribed_to
      t.timestamps
    end
  end
end
