class AddTimestampsToEverythingReally < ActiveRecord::Migration
  def change
    add_column(:assignments, :created_at, :datetime)
    add_column(:assignments, :updated_at, :datetime)

    add_column(:chapters, :created_at, :datetime)
    add_column(:chapters, :updated_at, :datetime)

    add_column(:classrooms, :created_at, :datetime)
    add_column(:classrooms, :updated_at, :datetime)

    add_column(:courses, :created_at, :datetime)
    add_column(:courses, :updated_at, :datetime)

    add_column(:questions, :created_at, :datetime)
    add_column(:questions, :updated_at, :datetime)

    add_column(:responses, :created_at, :datetime)
    add_column(:responses, :updated_at, :datetime)

    add_column(:sessions, :created_at, :datetime)
    add_column(:sessions, :updated_at, :datetime)

    add_column(:students, :created_at, :datetime)
    add_column(:students, :updated_at, :datetime)

    add_column(:teachers, :created_at, :datetime)
    add_column(:teachers, :updated_at, :datetime)

  end
end
