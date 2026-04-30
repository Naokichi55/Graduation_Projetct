import consumer from "./consumer"

document.addEventListener('DOMContentLoaded', function(){
  //constにて変数を定義
  const racketElement = document.querySelector('[data-racket-id]');
  const racketId = racketElement?.dataset.racketId;

//現在のユーザーIDを取得
const currentUserId = racketElement?.dataset.currentUserId;

 console.log('Racket Id:', racketId);
 console.log('Racket Element:', racketElement);
 console.log('Current User Id:', currentUserId);

if(racketId) {
  const subscription = consumer.subscriptions.create({
  channel: "CommentsChannel",
  racket_id: racketId
 }, {
  connected() {
    console.log("Connected to comments channel for racket");
    // サブスクリプションがサーバー上で使用可能になったときに呼び出される。
  },
//接続が切断された時の処理。デバッグとし記録。
  disconnected() {
    console.log("Disconnected from comments channel");
    // サブスクリプションがサーバー上で終了した時に呼び出される。
  },
//データを受け取った時の処理について記載。
  received(data) {
     console.log("Received data:", data); 
     //　リアルタイムでコメントを追加
     //table-commentをracket-idに変更すると投稿がワンクリックで2回コメントが投稿される。
    // const commentsContainer = document.getElementById('table-comment'); createアクション内で定義し直すため、コメントアウト。
    // console.log("Comments container:", commentsContainer);const commentsContainerの定義をコメントアウトしたため、こちらもコメントアウト。
    //createアクションを受け取った時の動作を追加
    if (data.action === 'create'){
      // コメントIDで条件分岐をする際に変数を設定をした方が少なくて済むため変数を追加
      const tableComment = document.getElementById('table-comment');

      if(tableComment){
      //ログインユーザーのコメントかどうかを判定
      const isOwnComment = String(data.user_id) === String(currentUserId);
      //HTMLを組み立てる
      const commentHTML = `
        <div id="comment-${data.comment_id}" data-user-id="${data.user_id}">
          <div class="flex ${isOwnComment ? 'justify-end' : ' '}">
            <div>
              <div class='flex items-center ${isOwnComment ? "flex-row-reverse mr-1" : "ml-1" }'>
                <div class='mb-2'>
                  <img src="${data.icon_url}" class="rounded-full w-30 h-30" width="30" height="30">
                </div>
              <div class='text-xs mx-1 mb-3'>
                ${data.user_name}
              </div>
            </div>
              <div class="max-w-80 rounded-md p-3 break-words mb-2 relative ${isOwnComment ? 'bg-green text-navy mr-1' : 'bg-orange-700 text-white ml-1'}">
              ${data.body.replace(/\n/g, '<br>')}
              <div class="w-0 h-0 absolute border-l-8 border-l-transparent border-r-8 border-r-transparent border-t-8 border-t-transparent ${isOwnComment ? 'border-b-8 border-b-green -top-4 right-1' : 'border-b-8 border-b-orange-700 -top-4 left-1'}">
              </div>
              ${isOwnComment ? `
                <div class='text-right mt-1'>
                  <a href="/comments/${data.comment_id}" class="delete-button text-s text-right text-white bg-red rounded-md py-1 px-1 text-right" data-turbo="false" data-comment-id="${data.comment_id}" data-confirm="削除しますか？">削除</a>
                </div>
                `: '' }
              </div>
            </div>
          </div>
        </div>
      `;
        //HTMLを挿入
        tableComment.insertAdjacentHTML('afterbegin', commentHTML);

        console.log("Comment and successfully") //コメントを追加しました。
        //挿入したコメントの要素取得
        const newComment = tableComment.firstElementChild;
        //投稿後のコメントフォームをクリア
        const form = document.querySelector('#comment-form form');
        if(form){
          form.reset(); //←フォームをクリア
        }
      }
    }
    //削除ボタンを押下時の動作を追加。
    if(data.action === 'destroy'){
      const commentElement = document.getElementById(`comment-${data.comment_id}`)
      if(commentElement){
        commentElement.remove();
        console.log(`Comment ${data.comment_id} removed`);
      }else{
        console.error(`Comment ${data.comment_id} nota found`);
      }
    }
    //データの内容、(create,destroy)によって動作を変えるために一旦コメントアウト
    // if(commentsContainer && data.comment) {
    //   commentsContainer.insertAdjacentHTML('afterbegin', data.comment);
    //   console.log("Comment add successfully")
    // }else{
    //  console.error("Comments container not found or no comment data");
    // }
  }
  });
}

//コメントアウト（削除ボタンのイベント処理（イベント譲渡)を記載するため）
// else{
//   console.log("No racket ID found, skipping WebSocket connection");
//   }
    //チャネルのWebSocketで受信データがあるときに呼び出される
//削除ボタンのイベント処理（イベント譲渡)
document.addEventListener('click', function(e){
  if(e.target.classList.contains('delete-button')){
    e.preventDefault();

    const confirmMessage = e.target.dataset.confirm;
    if(!confirm(confirmMessage)){
      return;
    }
    const url = e.target.href;
    //fetchでDELETEリクエスト
    fetch(url,{
      method: 'DELETE',
      headers:{
        'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content,
        'Accept': 'application/json'
      }
    })
    .then(response =>{
      if(!response.ok){
        alert('削除に失敗しました!');
      }
    })
    .catch(error => {
    console.error('Error:',error);
    alert('エラーが発生しました');
    });


  }
});
});
