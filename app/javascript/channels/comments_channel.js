import consumer from "./consumer"

document.addEventListener('DOMContentLoaded', function() {
  //constにて変数を定義
  const racketElement = document.querySelector('[data-racket-id]');
  const racketId = racketElement?.dataset.racketId;

 console.log('Racket I:', racketId);
 console.log('Racket Element:', racketElement);

if(racketId) {
  const subscription = consumer.subscriptions.create({
  channel: "CommentsChannel",
  racket_id: racketId
 }, {
  connected() {
    console.log("Connected to comments channel for racket")
    // サブスクリプションがサーバー上で使用可能になったときに呼び出される。
  },
//接続が切断された時の処理。デバッグとし記録。
  disconnected() {
    console.log("Disconnected from comments channel")
    // サブスクリプションがサーバー上で終了した時に呼び出される。
  },
//データを受け取った時の処理について記載。
  received(data) {
     console.log("Received data:", data); 
     //　リアルタイムでコメントを追加
     //table-commentをracket-idに変更すると投稿がワンクリックで2回コメントが投稿される。
    const commentsContainer = document.getElementById('table-comment')
    console.log("Comments container:", commentsContainer);

    if(commentsContainer && data.comment) {
      commentsContainer.insertAdjacentHTML('afterbegin', data.comment);
      console.log("Comment add successfully")
    }else{
     console.error("Comments container not found or no comment data");
    }
  }
  });
}else{
  console.log("No racket ID found, skipping WebSocket connection");
  }
    //チャネルのWebSocketで受信データがあるときに呼び出される
});
