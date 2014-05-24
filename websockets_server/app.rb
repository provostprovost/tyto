require 'sinatra/base'
require 'json'

module TytoChat
  class App < Sinatra::Base
    get "/" do
      erb :"index.html"
    end
  end
end
