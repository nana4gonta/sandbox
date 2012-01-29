# -*- coding: utf-8 -*-
# $Id: rev_wssrv.rb 4 2010-10-27 09:24:23Z karino $ 
require 'rubygems'
require 'em-websocket'


EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 8080) do |ws|
  ws.onopen do
    # 接続したら呼ばれる
    puts "connection is open"
  end

  ws.onmessage do |data|
    # メッセージが届いたら呼ばれる
    puts "#{data} received"
  
  end

  ws.onclose do
    # 切断したら呼ばれる
    puts "connection is close"
  end
end
