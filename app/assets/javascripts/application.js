// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
// = require rails-ujs
//= require activestorage
//= require_tree .
//= require jquery
//= require jquery_ujs

// window.onpageshow = function(event) {
//   if (event.persisted) {
//        window.location.reload();
//    }
// };

// iOSデバイスでフォーム入力時にズームしてしまうのを防ぐ
// var ua = navigator.userAgent.toLowerCase();
// var isiOS = (ua.indexOf('iphone') > -1) || (ua.indexOf('ipad') > -1);
// if(isiOS) {
//   var viewport = document.querySelector('meta[name="viewport"]');
//   if(viewport) {
//     var viewportContent = viewport.getAttribute('content');
//     viewport.setAttribute('content', viewportContent + ', user-scalable=no');
//   }
// }


// テキストエリアで改行に合わせて高さを自動調整する
$(function() {
  var $textarea = $('.memo-input-text-area');
  var lineHeight = parseInt($textarea.css('lineHeight'));
  $textarea.on('input', function(e) {
    var lines = ($(this).val() + '\n').match(/\n/g).length;
    $(this).height(lineHeight * lines);
  });
});


// 入力したメモの内容を画面に追加する
$(function() {

  $('#memo_btn').click(function() {

    var memo_content = $('.memo-input-text-area').val();

    var today = new Date();
    var year = today.getFullYear();
    var month = today.getMonth()+1;
    var day = today.getDate();
    var hour = today.getHours();
    var minute = today.getMinutes();

    var memo_date = year + '/' + month + '/' + day + ' ' + hour + ':' + minute ;

    // 所定の要素に新たな要素とテキストを追加する
    $('.memo-add-area').append('<li class="memo-history__item"><p class="memo-history__item__date">' + memo_date + '</p><p class="memo-history__item__content"></p><p>'+ memo_content +'</p></li>');

    $('.memo-no-content').addClass('.no-content');
    // 入力していたメモをリセット
    // $('.memo-input-text-area').val("");
    // ボタンのクリック状態をリセット
    $('.memo-input-tweet-details__submit').attr('disabled', false);
  });
});