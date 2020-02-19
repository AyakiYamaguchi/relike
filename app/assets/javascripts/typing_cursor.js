// import { init } from 'ityped';

$(function() {
  if ($('#ityped1').length > 0) {
    ityped.init('#ityped1', {
      // required - for now, only accepting texts
        strings: ['ReLike（リライク）は、Twitterの「いいね機能」を情報ストックに使っている人のためのサービスです。'],
        //表示させる文字
        typeSpeed: 50, //default
        //表示する時のスピード
        //戻る時のスピード
        startDelay: 500, //default
        //スタート時の遅延時間
        backDelay: 500, //default
        //戻る時の遅延時間
        loop: false, //default
        //ループの有無   
        showCursor: true, //default
        //カーソル表示の有無   
        cursorChar: "", //default
        //カーソルの形状
        onFinished: function(){}
    });
  }

  if ($('#ityped2').length > 0) {
    ityped.init('#ityped2', {
      // required - for now, only accepting texts
        strings: ['ReLikeに登録すると、過去にいいねしたツイートをLINE経由でリマインド通知してくれます。'],
        //表示させる文字
        typeSpeed: 50, //default
        //表示する時のスピード
        //戻る時のスピード
        startDelay: 3500, //default
        //スタート時の遅延時間
        backDelay: 500, //default
        //戻る時の遅延時間
        loop: false, //default
        //ループの有無   
        showCursor: true, //default
        //カーソル表示の有無   
        cursorChar: "", //default
        //カーソルの形状
        onFinished: function(){}
      });
    }

  if ($('#ityped3').length > 0) {
    ityped.init('#ityped3', {
      // required - for now, only accepting texts
        strings: ['感銘を受けたツイートや、明日からやろうと思って「いいね」したツイートが埋もれていませんか？'],
        //表示させる文字
        typeSpeed: 50, //default
        //表示する時のスピード
        //戻る時のスピード
        startDelay: 6500, //default
        //スタート時の遅延時間
        backDelay: 500, //default
        //戻る時の遅延時間
        loop: false, //default
        //ループの有無   
        showCursor: true, //default
        //カーソル表示の有無   
        cursorChar: "", //default
        //カーソルの形状
        onFinished: function(){}
    });
  }
});