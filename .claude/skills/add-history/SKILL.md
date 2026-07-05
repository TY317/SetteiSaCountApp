---
name: add-history
description: 機種の「履歴」ページ(液晶ゲーム数＋種類を登録して履歴表示)の中身を実装する。Class に inputGame/selectedKind/gameArray/kindArray と addHistory/removeLastHistory/resetHistory を追加、ViewHistory に登録Section＋表示Section＋toolbarを実装する。inputGameはデフォルト、selectedKindの内容・選択肢数・型(String/Int)は都度ユーザー確認。add-page で作った空の履歴ページ前提。JSON配列(Data?)保持。「履歴ページを実装」「履歴を追加」等で起動。SetteiSaCountApp 専用。
---

# 履歴ページの実装

`/add-page` で作った空の履歴ページ（`<prefix>ViewHistory.swift`）に、「液晶ゲーム数＋種類を登録し履歴表示する」中身を実装する定番作業。**inputGame（ゲーム数）はデフォルトで必ず追加**。**種類（selectedKind）はラベル・選択肢・型（String/Int）が機種ごとに異なる**ため都度質問。JSON配列(`Data?`)保持＝otome5 系。参照：`karakuri2ViewHistory`（String種類）、`otome5ViewHistory`（Int種類=周期）。雛形：`.claude/skills/add-history/templates/ViewHistoryBody.swift.tmpl`。ヘルパー：`SetteiSaCountApp/Common/function/myFunction.swift`。

## 前提
`/add-page` 実行済み（`<prefix>ViewHistory.swift` 空スケルトン＋バッジ `<prefix>MenuHistoryBadge`＋pbxproj登録＋ViewTop リンクが在る）。無ければ先に `/add-page` を実施。

## 1. 質問（都度）
- **prefix**：対象機種。`Prefix`＝先頭大文字。
- **入力タイトル**（`__INPUT_TITLE__`、既定「液晶ゲーム数」）／**G数列ラベル**（`__GAME_COLUMN__`、例「液晶G数」）。
- **登録ヘッダー文言**（`__REGISTER_HEADER__`、例「CZ結果登録」）／**ヘルプ本文**（`__REGISTER_HELP__`）。
- **種類ラベル**（`__KIND_COLUMN__`、例「CZ種類」）。
- **種類の型**：**String** or **Int**。
- **選択肢リスト**（kindList の中身）。
- Int の場合：**ピッカー単位**（`__KIND_UNIT__`）と**表示接尾**（`__KIND_SUFFIX__`、例「周期」）。

## 2. Class 実装（`<prefix>Class.swift`）
`resetScreen()` 等の後・`// -----------` / `// 共通` の**直前**に「履歴」ブロックを挿入（`<T>`=String/Int、`array<T>*`=`arrayString*`/`arrayInt*`）：
```swift

    // ----------
    // 履歴
    // ----------
    // 選択肢
    let kindList: [<T>] = [<選択肢>]
    // 選択結果
    @AppStorage("<prefix>InputGame") var inputGame: Int = 0
    @AppStorage("<prefix>SelectedKind") var selectedKind: <T> = <default>

    // ゲーム数配列
    let gameArrayKey: String = "<prefix>GameArrayKey"
    @AppStorage("<prefix>GameArrayKey") var gameArrayData: Data?
    // 種類配列
    let kindArrayKey: String = "<prefix>KindArrayKey"
    @AppStorage("<prefix>KindArrayKey") var kindArrayData: Data?

    // データ登録
    func addHistory() {
        arrayIntAddData(arrayData: gameArrayData, addData: inputGame, key: gameArrayKey)
        array<T>AddData(arrayData: kindArrayData, addData: selectedKind, key: kindArrayKey)
        addRemoveCommon()
    }
    // 1行削除
    func removeLastHistory() {
        arrayIntRemoveLast(arrayData: gameArrayData, key: gameArrayKey)
        array<T>RemoveLast(arrayData: kindArrayData, key: kindArrayKey)
        addRemoveCommon()
    }
    func resetHistory() {
        arrayIntRemoveAll(arrayData: gameArrayData, key: gameArrayKey)
        array<T>RemoveAll(arrayData: kindArrayData, key: kindArrayKey)
        addRemoveCommon()
        inputGame = 0
        minusCheck = false
    }
    func addRemoveCommon() {

    }
```
`resetAll()` の末尾に `resetHistory()` を追加。
（`<default>`：String は選択肢の先頭を `"..."`、Int は先頭値そのまま。）

## 3. ViewHistory 実装（`<prefix>ViewHistory.swift`）
雛形 `templates/ViewHistoryBody.swift.tmpl` に沿って：
- 空 `List { }` を、雛形の `List { …登録Section＋表示Section… }` に置換（トークン置換）。
- `.applyOrientationHandling(...)` の**直後**に、雛形の `.toolbar { …minus/reset/keyboard… }` を追加。
- `__KIND_PICKER__`・`__KIND_DECODE_DISPLAY__` は**型に応じて**雛形末尾の String版/Int版から選び、`//` を外して字下げのまま採用（String=`unitPickerMenuString`/`decodeStringArray`/`Text(kindArray[i])`、Int=`unitPickerMenuIntToString`/`decodeIntArray`/`Text("\(kindArray[i])<接尾>")`）。

## 4. 検証・報告
- `xcodebuild -scheme SetteiSaCountApp -destination 'generic/platform=iOS Simulator' -configuration Debug build` で `** BUILD SUCCEEDED **`。
- 提案コミット：`[機能]<prefix> 履歴ページを実装`（末尾 `Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>`）。**コミットはユーザー指示後**。
- **案内**：履歴のJSON配列 `gameArrayData`/`kindArrayData`（`Data?`）はメモリー保存対象。**`/sync-memory` を実行して Memory1/2/3 に同期**（load は decode＋saveArray の B パターン）。`inputGame`/`selectedKind` はメモリー対象外。

## 注意
- `inputGame` は Int 固定・必須。`selectedKind` の型で Class 配列ヘルパー／View ピッカー／表示 decode が分岐（String↔Int を取り違えない）。
- `resetAll()` への `resetHistory()` 追加を忘れない。
- 複数種類ディメンション（otome5 の周期＋種類の様な2列以上）や time 列付きは本スキルのスコープ外（`unitHeaderHistoryColumnsWithoutTimes` の2データ列前提）。手動で拡張。
- ページshell（バッジ/新規View/pbxproj/ViewTopリンク）は `/add-page`、メモリー同期は `/sync-memory`。
