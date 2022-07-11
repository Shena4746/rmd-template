# 概要

Gitbook 出力するとき用のテンプレ.
scr ディレクトリで書いてビルドすると, knit された html ファイルが docs ディレクトリに生成される.

## Tasks.json

ワークスペースを開いてると仮定する.

- Render Book : ビルドタスク. scr 内のソースを見つけてビルドする.
- Open index.html in Chrome : ビルドされた index.html を見つけてブラウザで開く.
- Render Book and Open index.html in Chrome : その名の通り上2つの合体版.
- Clear Cashes : ビルドの全出力と一時オブジェクトの全消去, およびメモリのお掃除.

## .yml ヘッダー

_output.yml で `split_by: none` としているので, 各拡張子の出力ファイルは単一ファイルにまとめられる. その名前は,_bookdown.yml で `book_filename: index.Rmd` により index.format という形になる.

`split_by: chapter` とかにすると, 日本語で書いている場合, はじめに.Rmd みたいなファイルができてしまってイヤなので, none としている. 出力ファイルの名前が個別に決められるなら none 以外にしてもいいけど, 可能なのか分からない.

# 参考

[Authoring Books with R Markdown](https://bookdown.org/yihui/bookdown/configuration.html)
[R Markdown: The Definitive Guide](https://bookdown.org/yihui/rmarkdown/)
