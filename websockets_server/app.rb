require 'sinatra/base'
require 'json'
require_relative 'lib/database.rb'

configure :production do
  DataMapper.setup(:default, ENV['DATABASE_URL'])
  DataMapper.auto_upgrade!
end

module TytoChat
  class App < Sinatra::Base
    get "/" do
      erb :"index.html"
    end

    get '/past' do
    end

    post '/message' do
    end
  end
end
