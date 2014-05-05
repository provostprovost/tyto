class Createteachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :username, :password, :email, :phone_number
    end
  end
end
