// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"  //action_cable使用する際にリロードしないと非同期処理されない事象、リロードを複数回実施すると2回コメントが投稿されるためturboをoffに変更しました。←turboを使う箇所があるためturboはON
import "./controllers"
import "./channels"