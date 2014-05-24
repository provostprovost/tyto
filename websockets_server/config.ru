require './app'
require './middlewares/chat_backend'

use TytoChat::ChatBackend

run TytoChat::App
