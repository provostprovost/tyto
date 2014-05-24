require 'data_mapper'
class Message
  include DataMapper::Resource
  property :id, Serial
  property :username, String, :required => true
  property :message, String, :required => true
  property :classroom_id, Integer
end
DataMapper.finalize
