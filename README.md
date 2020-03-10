# バッチファイルのテスト

`set /p VARIABLE="please input: "` でコンソールで入力した文字を配列に格納したくて試行錯誤したメモを残しておきます。

```cmd
@echo off
setlocal enabledelayedexpansion

set NUM=0
:Input
set INPUT=
set /p INPUT="Please input: "
if defined INPUT (
    set STORE[%NUM%]=%INPUT%
    set /a NUM+=1
    goto :Input
)

echo.

if %NUM% equ 0 (
    echo No input.
) else (
    set /a NUM-=1
    for /l %%i in (0, 1, !NUM!) do (
        echo store[%%i] is !STORE[%%i]!
    )
)
```

## 解説

### if defined VAR

変数 `VAR` に値が定義されていれば処理します。

### set STORE[%NUM%]=%INPUT%

`STORE[n]` という疑似配列変数に入力値を格納します。

`n` は上記では `set /a` で計算して 1ずつ増加します。

### for /l %%i in (初期値, 増加値, 終了値) do コマンド

`/l` で一般的な For ループを指定します。

`%%i` は `%%` に英語 1文字を付けるのが決まりとのこと。

終了値までコマンドは実行されますので、1 減らしました。

### !NUM!

`!NUM!`、`!STORE[%i%]!` は遅延環境変数と呼ばれるもので、バッチの `()` 内のコマンド内の変数が最初に展開されてしまう仕様などを回避するために使っています。（使用するためには冒頭の `setlocal enabledelayedexpansion` が必要です。）

- `set /a NUM-=1` の結果をその後の For ループに反映させるために `!` で括ります。
- `%STORE[%i%]%` だと `%STORE[%` と `i` と `%]%` として分割されてしまうので、`!` で括ります。




参考：

- [バッチファイルでよく使う書き方まとめ \- Qiita](https://qiita.com/sta/items/8cab80fe74b8dcfa5336)
- [\.bat（バッチファイル）のforコマンド解説。 \- Qiita](https://qiita.com/plcherrim/items/67be34bab1fdf3fb87f9)
- [バッチファイルで配列とforeachを使う方法 \- Qiita](https://qiita.com/rai_suta/items/5ebdffc56e7e7768528b)
- [バッチファイル界の魔境『遅延環境変数』に挑む（おまけもあるよ） \- Qiita](https://qiita.com/plcherrim/items/c7c477cacf8c97792e17)


