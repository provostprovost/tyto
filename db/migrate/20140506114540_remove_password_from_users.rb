class RemovePasswordFromUsers < ActiveRecord::Migration
  def change
    drop_table :teachers

    create_table :teachers do |t|
      t.string :username, :password_digest, :email, :phone_number
    end

    drop_table :students

    create_table :students do |t|
      t.string :username, :password_digest, :email, :phone_number
    end
  end
end
