class AddMessagesTable < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :classroom
      t.string :username
      t.string :message
    end
  end
end
