#!/usr/local/bin/ruby
# -*- coding: utf-8 -*-
# $Id: catch.rb 19 2011-09-14 10:31:12Z karino $ 

require 'cgi'
require 'rubygems'
require 'msgpack/rpc'

evlist = ['up', 'down', 'right', 'left']

cgi = CGI.new

# WebSocketサーバへのRPCセッションの生成
#$ws = MessagePack::RPC::Client.new('127.0.0.1', 18800)

#event = cgi['direction']

#if (evlist.include?(event))
#   out = 'Accepted event: ' + event
#   $ws.call(:push_event, {"event" => event})

# else
#   out = 'Denied event: ' + event

#end


print <<-"HTML"
Content-Type: text/html\n\n

<!DOCTYPE html>
<html lang='ja'>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=480, user-scalable=no, maximum-scale=0.6667" />
  <script type="text/javascript" src="http://www.google.com/jsapi"></script>
  <script type="text/javascript">google.load('jquery', '1')</script>
  <script type="text/javascript" src="./handler.js"></script>
  <script type="text/javascript" src="./wsc.js"></script>
  <title></title>
</head>
<body>
  <span class='display'></span>
</body>
</html>
HTML
