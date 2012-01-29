# -*- coding: utf-8; -*-
# $Id: server.rb 4 2010-10-27 09:24:23Z karino $

require 'webrick'
include WEBrick

module WEBrick::HTTPServlet
  FileHandler.add_handler('rb', CGIHandler)
end


document_root = ARGV[0] || "."
ruby_bin = `which ruby`
server = WEBrick::HTTPServer.new({
                                   :DocumentRoot => document_root,
                                   :BindAddress => '0.0.0.0',
                                   :CGIInterpreter => ruby_bin,
                                   :Port => '3000'
})


['INT','TERM'].each do |signal|
  Signal.trap(signal){ server.shutdown }
end

server.start
