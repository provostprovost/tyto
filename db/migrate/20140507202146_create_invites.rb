class CreateInvites < ActiveRecord::Migration
  def add_datetime
    tables = ActiveRecord::Base.connection.tables
    tables.each do |t|
      ActiveRecord::Base.connection.add_timestamps t
    end
  end
end
