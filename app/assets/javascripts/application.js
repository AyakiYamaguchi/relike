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
//= require rails-ujs
//= require activestorage
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require jquery.jscroll.min.js
//= require typing_cursor.js
//= require ityped.js


// テキストエリアで改行に合わせて高さを自動調整する
$(function() {
  var $textarea = $('.memo-input-text-area');
  var lineHeight = parseInt($textarea.css('lineHeight'));
  console.log('test');
  $textarea.on('input', function(e) {
    var lines = ($(this).val() + '\n').match(/\n/g).length;
    $(this).height(lineHeight * lines);
  });
});



// ローディングエフェクトの設定
$(function(){
	var loader = $('.loader-wrapper');
	//ページの読み込みが完了したらアニメーションを非表示
	$(window).on('load',function(){
		loader.fadeOut();
	});

	// ページの読み込みが完了してなくても3秒後にアニメーションを非表示にする
	setTimeout(function(){
		loader.fadeOut();
	},3000);
});


$(window).on('scroll', function() {
  scrollHeight = $(document).height();
  scrollPosition = $(window).height() + $(window).scrollTop();
  if ( (scrollHeight - scrollPosition) / scrollHeight <= 0.05) {
    $('.jscroll').jscroll({
      contentSelector: '.remind-history-list__wrapper' ,
      nextSelector: 'span.next a',
      callback: function() {
        $script = $('<script>')
        $script.attr('src', 'https://platform.twitter.com/widgets.js')
        $('body').append($script)
      }
    });
  }
});