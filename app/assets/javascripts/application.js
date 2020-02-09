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
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require jquery.jscroll.min.js


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


$(window).on('scroll', function() {
  scrollHeight = $(document).height();
  scrollPosition = $(window).height() + $(window).scrollTop();
  if ( (scrollHeight - scrollPosition) / scrollHeight <= 0.05) {
      $('.jscroll').jscroll({
        contentSelector: '.remind-history-list' ,
        nextSelector: 'span.next a'
      });
  }
});