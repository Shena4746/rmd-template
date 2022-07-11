# 概要

Gitbook 出力するとき用のテンプレ.
scr ディレクトリで書いてビルドすると, knit されたファイルが docs ディレクトリに保存される.

## Tasks.json

ワークスペースを開いてると仮定する.

- Render Book : ビルドタスク. scr 内のソースを見つけて `bookdown::render_book()` を実行する.
- Open index.html in Chrome : ビルドされた index.html を見つけて Chrome で開く.
- Serve and Open Book: `bookdown::serve_book()` を実行して Chrome で開く.
- Clear Rendered Results : docs ディレクトリのファイルおよび一時オブジェクトを破棄し, メモリを掃除する.

## ./tools/

Tasks.json で実行される R スクリプト達.

- dir_config.yml: `bookdown::render_book()` などのオプション引数を算出するためのディレクトリ構成の情報などが入っている. config パッケージで読んで情報を取り出す. ディレクトリ構成を変えたらこの中身もそれに応じて変えること.
- tools.R: `bookdown::render_book()` 等が使うディレクトリを見つける係. VSCode のワークスペースを見つけてそこを起点にディレクトリの検索を行う.
- render_book.R: 同名のタスクの具体的な実行内容. dir_config.yml と tools.R から取ってきたディレクトリやファイル情報を取得して `bookdown::render_book()` に流し込む.

# 参考

[Authoring Books with R Markdown](https://bookdown.org/yihui/bookdown/configuration.html)
[R Markdown: The Definitive Guide](https://bookdown.org/yihui/rmarkdown/)
