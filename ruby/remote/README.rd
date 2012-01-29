= 概要
PC側で開いているHTML5によるプレゼンツールNerineをAndroidを操作端末として操作するためのものです。
Android端末から受け取ったイベントをWebSocketsサーバ経由でブラウザにプッシュしています。
プッシュする際にはRubyライブラリのMessagePack-RPCを使っています。

= 使い方
あらかじめライブラリをgemでインストールしておいてください。
 sudo gem install rev-websocket msgpack-rpc

PC側のブラウザはGoogleChrome、またはSafariをお使いください。

また仮にPCのIPアドレスを 192.168.11.1 とします。

(1) Webサーバの起動
WEBrickを使わないのであれば、この部分は飛ばしてください。
起動には
 ruby server.rb (document_root)
引数としてサーバのドキュメントルートを取ります。
何も指定しなければカレントディレクトリが使われます。

(2) WebSocketサーバの起動
起動には
 ruby rev_wssrv.rb

また
 * WebSocketの通信に使うポート番号は8080
 * MessagePack-RPCの通信に使うポート番号は18800
となっています。

(3) Android端末でのアクセス
以下のアドレスにアクセスしてください。
PCは同じLAN内か、アクセスポイント化しておいてください。
((<URL:http://192.168.11.1:3000/html/touch.html>))

(4) PC側でのアクセス
以下のアドレスにアクセスすればWebSocketのコネクションが張られます。
((<URL:http://192.168.11.1:3000/slide/example.html>))

example.htmlはNerineによるスライドのために作ったHTMLファイルに名前を置き換えてください。


= リンク
((<Nerine - Simple HTML5 Presentation Tool|URL:http://www.aduca.org/nerine/>))
((<WebSocketサーバライブラリ rev-websocket リリース|URL:http://d.hatena.ne.jp/viver/20100717/p1>))
((<WebSocketでブラウザにプッシュ配信する - MessagePack-RPC+Rev-WebSocket -|URL:http://d.hatena.ne.jp/viver/20100722/p1>))
