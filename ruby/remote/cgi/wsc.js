// -*- coding: utf-8; -*-
// $Id: wsc.js 7 2011-02-07 12:25:02Z karino $

var Remote = {
    ws: null,
    protocol: '',
    host: '',
    url: '',

    initialize: function() {
        // httpsで接続している場合セキュアにする
        Remote.protocol = (location.protocol == 'https:') ? 'wss' : 'ws';
        // ホスト名の取得
        Remote.host = location.hostname;

        // 接続先URL
        Remote.url = Remote.protocol + '://' + Remote.host + ':8080';

        // インスタンスの作成
        var Socket = "MozWebSocket" in window ? MozWebSocket : WebSocket;
        Remote.ws = new Socket(Remote.url);

        // WebSocketイベントの登録
        Remote.ws.addEventListener('open', Remote.open, false);
        Remote.ws.addEventListener('close', Remote.close, false);
        Remote.ws.addEventListener('message', Remote.message, false);

        // WebSocketの切断
        window.addEventListener('unload', Remote.unload, false);
    },

    open: function() {
        console.log('WebSocket open');
        Remote.ws.send('client open');
    },

    close: function() {
        console.log('WebSocket close');
    },

    unload: function() {
        Remote.ws.close();
    },

    message: function(event) {
        var data = event.data;

	switch (data) {
	case "up":
	case "down":
	case "left":
	case "right":
	    console.log("catchdata: " + data);
            Remote.ws.send("catchlog: " + data);
	    break;
	default:
	    console.log("error");
            Remote.ws.send("catchlog: error");
	    break;
        }
    }
};

// onloadのときのイベント
window.addEventListener('load', Remote.initialize, false);
