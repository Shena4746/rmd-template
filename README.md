# 概要

VSCode で Rmd から `bookdown::render()` を使ってファイル出力するとき用のテンプレ.
scr ディレクトリで書いてビルドタスクを実行すると, 出力ファイルが docs ディレクトリに保存される.

## Tasks.json

VSCode のワークスペースを開いていると仮定する. 以下のタスクは全て, tools フォルダ内のスクリプトを `${workspaceFolder}` から実行しているだけ. 各タスクの具体的な中身はその名前に対応するスクリプトを参照.

- Render Book : ビルドタスク. scr 内の先頭の Rmd ファイルを見つけて `bookdown::render_book()` を実行する.
- Open index.html in Chrome : ビルドされた book_filename.html を見つけて Chrome で開く. book_filename は _bookdown.yml を読み込んで自動的に取得される.
- Serve and Open Book: `bookdown::serve_book()` を実行して Chrome で開く.
- Clear Rendered Results : 一時オブジェクトおよび docs ディレクトリ (より正確には, dir_config.yml の記載に従って動的に検索された出力フォルダ) 内のファイルを破棄し, メモリを掃除する.

## tools

Tasks.json で実行される R スクリプト達.

- dir_config.yml: `bookdown::render_book()` などのオプション引数を算出するためのディレクトリ構成の情報などが入っている. config パッケージで読んで情報を取り出す. ディレクトリ構成を変えたらこの中身もそれに応じて変えること.
- tools.R: `bookdown::render_book()` 等が使う各種ディレクトリやファイルのパスを見つける関数の寄せ集め.
- render_book.R: 同名のタスクの具体的な実行内容. dir_config.yml から取ってきたディレクトリやファイル情報を取得して `bookdown::render_book()` に流し込む.
  - `input =` dir_config.yml の `rmd_basename`.
  - `output_dir =` `${workspaceFolder}` 直下のフォルダで, dir_config.yml の `output_dir_basename` に記載された名前と等しいフォルダ. このフォルダが存在しなければ自動的に作成される.
- serve_book.R: render_book.R と同様.

tools.R の関数を読み込むために `source("./tools/tools.R")` としており, `${workspaceFolder}` から呼ばれることを想定していることに注意. もし他所から呼ぶ際は `source(path/to/tools.R)` の中身を適切に設定する必要がある. それさえ済ませば, `get_vscode_workspace()` が `${workspaceFolder}` を見つけてくれるので, 他の変更は必要ないはず. ディレクトリ構造を根本的に変えた場合は, この限りではない.

## 参考

- [Authoring Books with R Markdown](https://bookdown.org/yihui/bookdown/configuration.html)
- [R Markdown: The Definitive Guide](https://bookdown.org/yihui/rmarkdown/)
