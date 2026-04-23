# LaTeX_Settings

**LuaLaTeX**, **pdfLaTeX**, **upLaTeX** の3つに対応し、さらに言語設定も切り替えられるよう設計されています。  
**bibTeX**, **bibLaTeX + Biber** にも対応しています。  
文法・綴りチェッカー **LTeX** のための基本的な設定も含まれています。  
既存の `cls` や `sty` などにより体裁が決まっている文書にも柔軟に対応できます。  

## ファイルの構成
```txt
latex_settings
├── latexmkrc                     : latexmk の設定ファイル
├── .vscode                       : VSCode 設定ファイル群
│   ├── settings.json             : VSCode 全体の設定
│   ├── ltex.json                 : LTeX の辞書ファイル (.txt) 有効化の設定
│   └── latex.json.code-snippets  : LaTeX 用のコードスニペット
├── macros                        : LaTeX スタイルファイル群
│   ├── sn-preamble.sty           : 網羅的なスタイルファイル
│   ├── sn-core.sty               : LaTeX 文書の土台となるスタイルファイル
│   ├── sn-links.sty              : リンクと相互参照の設定
│   ├── sn-locale.sty             : 自動表示の言語設定
│   ├── sn-bib.sty                : biblatex のスタイル設定
│   └── sn-code.sty               : コードのスタイル設定
├── LICENSE                       : ライセンスファイル
└── README.md                     : README ファイル
```

## ファイルの役割

### [`latexmkrc`](latexmkrc)
latexmk の設定ファイルです。  
latexmk を使うときはこのファイルをプロジェクトルートまたはホームディレクトリに置いてください。  
ホームディレクトリに置くと全プロジェクトでこの設定を使うことができます。  
隠しファイルにしても有効なので、ホームディレクトリに置くときは `.latexmkrc` とすることをお勧めします。

### [`settings.json`](.vscode/settings.json)
VSCode 全体の設定ファイルです。LaTeX を利用する際のエディタの挙動や、LTeX の設定などを記述しています。  
確認して必要に応じて変更してください。

### [`ltex.json`](.vscode/ltex.json)
LTeX の辞書ファイル (.txt) を有効化するための設定ファイルです。  
グローバルの設定ファイル `settings.json` に追加しても良いですが、プロジェクトごとに異なる辞書を使いたい場合はこのファイルを `.vscode/settings.json` としてプロジェクトルートに置いてください。  
`dict.txt` には以下のように単語を平文で列挙します。  
```txt
qubit
qubits
```
行単位で無視したいときは以下のようにします。
```tex
% ltex: enabled=false
無視したい文字列
% ltex: enabled=true
```

### [`latex.json.code-snippets`](.vscode/latex.json.code-snippets)
LaTeX 用のコードスニペットを定義するファイルです。  
`.vscode/latex.json.code-snippets` としてプロジェクトルートに置くか、VSCode のユーザースニペットとして `latex.json` に追加してください。

### [`sn-preamble.sty`](macros/sn-preamble.sty)
特に指定がないときに使用するスタイルファイルです。
`lang=ja` / `lang=en` のオプションを受け取ります。  
オプションを省略した場合は 

- LuaLaTeX：`luatexja` が読み込まれていれば `ja`、読み込まれていなければ `en`
- pdfLaTeX：`en`
- upLaTeX：`ja`

と自動で判定します。

`geometry` および `hyperref` が未ロードであれば、 `sn-preamble.sty` が既定値のオプションでそれらを読みます。  
このファイルは内部で `sn-core.sty`、`sn-links.sty`、`sn-locale.sty` を順番に読みます。  
フォント指定とページ設定は `sn-preamble.sty` にのみ記述されています。  
体裁が指定されている場合は`sn-preamble.sty` を使わず、必要なものを順番に読むことでその体裁に合わせることができます。  

### [`sn-core.sty`](macros/sn-core.sty)
LaTeX 文書の土台となるスタイルファイルです。  
エンジンを自動検出して必要なパッケージを読み込みます。  
- LuaLaTeX : `fontspec`、`unicode-math`、`\symrm` 系のマクロを含みます。  
- pdfLaTeX : `fontenc`、`\mathrm` 系のマクロを含みます。  
- upLaTeX : `fontenc`、`\mathrm` 系のマクロを含みます。  

### [`sn-links.sty`](macros/sn-links.sty)
リンクと相互参照の設定です。`hyperref` が未ロードであれば既定値のオプションで読みます。`bookmark` と `cleveref` もここでまとめて読みます。  
`hyperref` のオプションは後ろで `\hypersetup` で変更できます。  

### [`sn-locale.sty`](macros/sn-locale.sty)
`lang=ja` / `lang=en` のオプションを受け取ります。オプションを省略した場合は `sn-preamble.sty` と同様の自動判定を行います。  

### [`sn-bib.sty`](macros/sn-bib.sty)
`biblatex` のスタイルファイルです。`biblatex` を使うときはこれを読みます。  

### [`sn-code.sty`](macros/sn-code.sty)
コードスタイルのファイルです。`lstlisting` 環境のスタイルを定義しています。コードを表示するときはこれを読みます。

## texmf ツリーへの配置とシンボリックリンク
独自のスタイルファイルを認識させるため、`macros` フォルダを `texmf` ツリー内に配置します。

### 1. 配置パスの確認
`texmf` ツリーの場所は OS や TeX 環境によって異なります。以下のコマンドを実行し、ご自身の環境のパス（TEXMFHOME）を確認してください。
```bash
kpsewhich -var-value=TEXMFHOME
```
- 一般的な配置パスの例：
  - macOS : `~/Library/texmf`
  - Linux : `~/texmf`
  - Windows : `C:\Users\<ユーザー名>\texmf`

### 2. ディレクトリの作成とファイルの配置
確認したパス (以下`<TEXMF>`) に合わせて、以下の操作を行います。

**macOS / Linux の場合**  
ターミナルで以下のコマンドを実行してください。
```bash
# パスの自動取得とフォルダ作成
export TEXMF=$(kpsewhich -var-value=TEXMFHOME)
mkdir -p $TEXMF/tex/latex/local

# シンボリックリンクを張る場合（推奨：リポジトリの変更が即時反映されます）
ln -s $(pwd)/macros $TEXMF/tex/latex/local/macros

# ファイルを直接コピーする場合（変更を反映させるには再度コピーが必要）
# cp -r ./macros $TEXMF/tex/latex/local/
```

**Windows の場合**  
PowerShell を「管理者として実行」して以下を実行してください。
```powershell
# パスの自動取得とフォルダ作成
$TEXMF = kpsewhich -var-value=TEXMFHOME
New-Item -Path "$TEXMF\tex\latex\local" -ItemType Directory -Force

# シンボリックリンクを張る（推奨）
New-Item -ItemType SymbolicLink -Path "$TEXMF\tex\latex\local\macros" -Value "$PWD\macros"

# または、ファイルを直接コピーする場合
# Copy-Item -Path ".\macros" -Destination "$TEXMF\tex\latex\local\" -Recurse
```
**動作確認**  
以下のコマンドを実行して、パスが表示されれば成功です。
```bash
kpsewhich sn-preamble.sty
```
### 4. 文献データベース (`.bib`) ファイルの配置
`.bib` ファイルもシステム全体から参照できるように、`texmf` ツリーにリンクを張ると便利です。  
本文で以下のようにパスを省略して記述できるようになります。
```tex
\addbibresource{library.bib}
```
**macOS / Linux の場合**  
ターミナルで以下のコマンドを実行してください。
```bash
# パスの取得とディレクトリ作成
export TEXMF=$(kpsewhich -var-value=TEXMFHOME)
mkdir -p $TEXMF/bibtex/bib

# シンボリックリンクを張る
# ※ リンク元のパス（/path/to/bib）は`.bib`ファイルを管理しているディレクトリに置き換えてください。
ln -s /path/to/bib $TEXMF/bibtex/bib/local
```

**Windows の場合**  
PowerShell を「管理者として実行」して以下を実行してください。
```powershell
# パスの取得とディレクトリ作成
$TEXMF = kpsewhich -var-value=TEXMFHOME
New-Item -Path "$TEXMF\bibtex\bib" -ItemType Directory -Force

# シンボリックリンクを張る
# ※ -Value の後のパス(\path\to\bib)は`.bib`ファイルを管理しているディレクトリに置き換えてください。
New-Item -ItemType SymbolicLink -Path "$TEXMF\bibtex\bib\local" -Value "$HOME\path\to\bib"
```
**動作確認**  
以下のコマンドを実行して、パスが表示されれば成功です。
```bash
# library.bib はご自身の `.bib` ファイルの名前に置き換えてください。
kpsewhich library.bib
```

### 普段の使い方

```tex
\documentclass[a4paper,11pt]{ltjsarticle}
\usepackage[lang=ja]{sn-preamble} % lang = ja or en (default: auto-detect)
\usepackage{sn-bib} % biblatex を使うとき
\addbibresource{library.bib} % biblatex を使うとき
\begin{document}
...
\printbibliography % biblatex を使うとき
\end{document}
```

### 配布された `cls` や指定の書式に合わせたいとき

`sn-preamble.sty` を使わず、必要なものを順番に読みます。
`sn-preamble.sty` の内容を参考に、以下のような感じで書いてください。

```tex
\documentclass[a4paper,dvipdfmx,11pt]{article}

% 自分で指定したいなら、sn-core より前に書く (省略可)
% \usepackage[top=25mm,bottom=20mm,left=20mm,right=20mm]{geometry}

% エンジンの土台
\usepackage{sn-core}

% 先に hyperref を書くならそのオプションを指定してから読む (省略可)
% \usepackage[colorlinks=true,allcolors=violet,linktocpage]{hyperref}
\usepackage{sn-links}

% 自動表示の言語設定
\usepackage[lang=en]{sn-locale} % lang = ja or en (default: auto-detect)

\begin{document}
...
\end{document}
```

## 補足

- `sn-preamble` 系のファイルは、既存の `cls` や他の `sty` と競合しない範囲で使います。
- `hyperref` の色や表示は、`\PassOptionsToPackage` または `\hypersetup` で調整できます。
- upLaTeX を使う場合は、documentclass に dvipdfmx オプションを指定してください。
