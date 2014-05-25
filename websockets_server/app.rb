require 'sinatra/base'

module TytoChat
  class App < Sinatra::Base
    get "/" do
      erb :"index.html"
    end
  end
end
