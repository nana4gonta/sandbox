// -*- coding: utf-8; -*-
// $Id: handler.js 20 2011-09-14 10:43:36Z karino $

var Touch = {
    start: {
        x: 0,
        y: 0
    },
    end: {
        x: 0,
        y: 0
    },
    angle: 0,
    direction: '',

    // 初期化
    initialize: function() {
        document.addEventListener('touchstart', Touch.touchHandler, false);
        document.addEventListener('touchend', Touch.touchHandler, false);
        document.addEventListener('mousedown', Touch.touchHandler, false);
        document.addEventListener('mouseup', Touch.touchHandler, false);

    },


    sendEvent: function(direction) {
        if (direction != null && direction.match(/^(left|right|up|down)$/)) {
            $.ajax({type: 'POST',
                url: './catch.rb',
                data: 'direction=' + direction,
                success: function(){
                    $('.display').html(direction).fadeIn();
                    Remote.ws.send($('.display').text());
                    setTimeout(function() {
                        $('.display').fadeOut();
                    }, 1000);}
            });
        }
    },

    touchHandler: function(event) {
        // タッチ位置を取得
        if (event) {
            switch (event.type) {
                case 'touchstart':
                    Touch.start.x = event.touches[0].pageX;
                    Touch.start.y = event.touches[0].pageY;
                    break;

                case 'touchend':
                    Touch.end.x = event.changedTouches[0].pageX;
                    Touch.end.y = event.changedTouches[0].pageY;
                    break;

                case 'mousedown':
                    // タッチした座標を取得し、セット
                    Touch.start.x = event.pageX;
                    Touch.start.y = event.pageY;
                    break;

                case 'mouseup':
                    // 離した座標を取得し、セット
                    Touch.end.x = event.pageX;
                    Touch.end.y = event.pageY;

                default:
                    return false;
            }

            var SWIPE_SIZE = 150;
            var deltaX = Touch.start.x - Touch.end.x;
            var deltaY = Touch.start.y - Touch.end.y;
            var direction = null;
            if (deltaX > SWIPE_SIZE) {
                direction = 'left';
            }else if (deltaX < -SWIPE_SIZE) {
                direction = 'right';
            }else {
                if (deltaY > (SWIPE_SIZE * 2)) {
                    direction = 'up';
                }else if (deltaY < (-SWIPE_SIZE * 2)) {
                    direction = 'down';
                }
            }
            // cgiに方向を送る
            Touch.sendEvent(direction);
        }
        event.preventDefault();
    }
};

window.addEventListener('load', Touch.initialize, false);
