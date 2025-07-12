# LaTeX Settings

LaTeX文書作成用の設定ファイル集です。日本語LaTeX文書の作成を効率化するためのテンプレートとユーティリティが含まれています。

## ファイル構成

- **[jpreamble.tex](jpreamble.tex)** - 日本語LaTeX文書用のプリアンブル設定
- **[latexmkrc.txt](latexmkrc.txt)** - latexmkの設定ファイル
- **[settingsjson.txt](settingsjson.txt)** - エディタ設定用のJSONファイル

## 使用方法

### プリアンブルの使用

LaTeX文書で以下のように読み込んでください：

```latex
\documentclass[a4paper,11pt]{ltjsarticle}
\input{/path/to/jpreamble}
```

### latexmkの設定

1. `latexmkrc.txt`の内容をコピー
2. プロジェクトルートに`latexmkrc`として配置（ピリオドなし）
   - またはホームディレクトリに`.latexmkrc`として配置（ピリオドあり）
3. `latexmk`コマンドでPDFを生成（BibTeX処理も自動実行）

```bash
latexmk document.tex
```

### エディタ設定

`settingsjson.txt`の内容をエディタの設定ファイルにコピーして使用してください。
`files.exclude`でエディタのエクスプローラ上では中間ファイルが見えないようにしていますが、実際には存在しています。

TeXと関係のない設定は適宜省略してください。

## 主な機能

- LuaTeX-jaによる日本語サポート
- 数式・物理記法の充実
- 量子回路図の描画サポート
- 参考文献の自動フォーマット
- 図表の日本語化

## 依存関係

- LuaTeX
- 各種LaTeXパッケージ（詳細は[jpreamble.tex](jpreamble.tex)を参照）

## ライセンス

MIT License