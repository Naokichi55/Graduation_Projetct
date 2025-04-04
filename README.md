# (仮)ラケットシェアアプリ
***
### ■サービス概要
***
自分自身が使っているラケットについてシェアすることでご自身の自慢のラケットについてみんなに知ってもらうことができます。使用しているガットや張りの強さ等カスタマイズした一本をみんなに自慢しましょう。また投稿だけでなく憧れの方が使っているラケットを知ることができます。
***
### ■ このサービスへの思い・作りたい理由
***
作成者が学生自体から10年以上続けていテニス愛好家としてプレイしてきましたが、誰しもがご自身が使っているラケットについて思い入れがあり、またカスタマイズをしています。そのこだわりの部分についてお互いに話すことが、プレイ以外の楽しい部分でもありました。そういったこだわりについてアプリを通じて伝えることができれば楽しいのではないかと考えこのアプリを作成することとしました。
***
### ■ユーザー層について
***
- テニスをしている方

　メインはテニス愛好家の方の男性で10代〜50代の方
ラケットに対するこだわりが女性より男性の方が強い印象があります。また年齢層についても競技志向の方の方がこだわりが強い傾向にあるためその人口が多い世代をユーザー層としました。
***
### ■サービスの利用イメージ
***
自分のカスタマイズしたラケットを投稿するだけでなく仲間のラケットについて知ることができるので、テニス仲間との交流が盛んになる1つのツールとなります。また上手い方や上手な方の投稿を見ることで自分自身のテニス向上のためにも利用することができます。
***
### ■ ユーザーの獲得について
xでの通知
知り合いのテニストレーナー、テニスコーチ、テニス仲間、その方たちと繋がりのある方に使用していただく
***
### ■ サービスの差別化ポイント・推しポイント
***
テニスラケットについてはレビューサイトはあるが自分が使用しているラケットの写真のそれぞれのカスタマイズを投稿するアプリはないと考えております。しかしながら、類似アプリとしてはラケットのレビューサイトや写真アプリがあります。その２つの観点から差別化ポイントを考えてみました。

テニスに関するWEBアプリ

- テニスベア（https://www.tennisbear.net/）

テニス、ラケットのレビューに関するもので、テニスベアというサイトが類似アプリとして考えられます。このアプリはテニスをやるメンバーを探すことを主な目的としておりますが、アプリ内で使用しているラケットについてのレビューも書くことが可能です。使用している方のレベル帯がもわかりラケット購入という観点では非常に参考になるものです。しかしながら同じラケットでも、グリップ（持ち手）の蓋さ、ガット（ボールを捉える網目状の部分）の材質や貼る時の強さ、ラケットにおもりをつけているかどうかといった、使用している方のカスタマイズ性までは書かれていないものとなります。私の作成するアプリは思い入れのあるラケットについて自分のラケット写真を投稿や投稿やこだわりのある部分を投稿することで、投稿者自身のちょっとしたカスタマイズ性をシェアすることが目的のため、レビューを投稿するというものとはその部分で差別化を図ることができると考えています。

写真投稿のシェアアプリ

- インスタグラム
- カウシェ（https://kauche.com/）

思い入れのある写真や使用者自身が良いと感じるものの投稿については上記アプリで行えますが、自分が使用している、使用していたラケットに特化しているものではないと考えております。その部分で差別化を図れるものと考えております。
***
### ■ 機能候補
現状作ろうと思っている機能、案段階の機能をしっかりと固まっていなくても構わないのでMVPリリース時に作っていたいもの、本リリースまでに作っていたいものをそれぞれ分けて教えてください。

#### MVPリリース
ログイン機能
ラケット投稿機能（ラケット画像、ラケットの種類、ガットの種類等）
投稿一覧機能

#### 本リリース
コメント機能(コメントチャット機能）
プロフィール登録機能
コメント投稿機能
いいね機能
ブックマーク機能
タグ機能
投稿検索機能
テニスショップ検索機能
ラケット検索機能（グリップ、ガット、重り等付属品を含む）
ラケット投稿時のメーカー名やラケット名について予測する機能
Xシェア機能
***
### ■ 機能の実装方針予定
一般的なCRUD以外の実装予定の機能についてそれぞれどのようなイメージ(使用するAPIや)で実装

する予定なのか現状考えているもので良いので教えて下さい。

#### MVP
認証・・・devise
ページネーション・・・kaminari

#### 本リリース
投稿一覧検索機能・・・ransack', '3.2.1’

x認証/xシェア機能・・・Twitter API
 google認証でと当初考えておりましたが、投稿内容にシェア機能があれば楽しいのではないかと思い。X(Twitter)シェア機能の実装を考えました。それに伴いX(Twitter)認証の方がいいのでは思い追加しました。

（google認証)

コメントチャット機能 ・・・Websocket /Action Cable
 コメント欄にチャット機能を掲載することで、よりユーザー同士のコミュニケーションが活発になるのではと考えて実装を予定しております。

テニスショップ検索機能・・・Google Maps Platform
 欲しいラケットがあった際に現在地から見にいくことができるのでユーザーの利便性向上につながるとかんがえました。

ラケット検索機能・・・Rakuten Ichiba APIs
 楽天市場APIを使うことで楽天市場からの情報でラケットを検索できればと考えております。

# 画面遷移図
***
https://www.figma.com/design/wichPgtqOhPH0OozRxSxg4/%E7%84%A1%E9%A1%8C?node-id=0-1&m=dev&t=D7iMxa1x5ovk8WfN-1