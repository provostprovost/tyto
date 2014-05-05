class RemoveIndexFromAssignment < ActiveRecord::Migration
  def change
    remove_index :assignments, :class_id
  end
end
