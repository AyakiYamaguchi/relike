// import { init } from 'ityped';

$(function() {
  ityped.init(`#ityped1`, {
    // required - for now, only accepting texts
      strings: ['いいねリマインダーは、過去にいいねしたツイートをLINE経由でリマインド通知してくれるサービスです。'],
      //表示させる文字
      typeSpeed: 60, //default
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

  ityped.init(`#ityped2`, {
    // required - for now, only accepting texts
      strings: ['感銘を受けたツイートや、明日からやろうと思って「いいね」したツイートが放置されていませんか？'],
      //表示させる文字
      typeSpeed: 60, //default
      //表示する時のスピード
      //戻る時のスピード
      startDelay: 4000, //default
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

  ityped.init(`#ityped3`, {
    // required - for now, only accepting texts
      strings: ['リマインドを通じて「いいね」した時の気持ちを思い出させてくれる、そんなサービスです。'],
      //表示させる文字
      typeSpeed: 60, //default
      //表示する時のスピード
      //戻る時のスピード
      startDelay: 8000, //default
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
});