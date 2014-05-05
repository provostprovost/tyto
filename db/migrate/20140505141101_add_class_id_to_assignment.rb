class AddClassIdToAssignment < ActiveRecord::Migration
  def change
    add_reference :assignments, :class, index: true
  end
end
