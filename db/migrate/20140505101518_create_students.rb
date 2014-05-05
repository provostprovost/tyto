class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :username, :password, :email, :phone_number
    end
  end
end
