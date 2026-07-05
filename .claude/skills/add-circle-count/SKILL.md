---
name: add-circle-count
description: 既存ページにホイール(サークル)ピッカーのカウント機能を追加する。ピッカーで要素を選び登録ボタンでその要素のカウントを+1、結果に各要素の出現率(unitResultCountListPercent)を表示。Class に <element>Count1..N/CountSum/SumFunc/reset を追加し、View にピッカー選択Section＋結果Section＋toolbar＋ヘルパー3関数(sisaText/binding/flushColor)を挿入。要素名・選択肢・示唆文言・色・数は都度ユーザー確認。終了画面のサイン/ボイス示唆等で多用。「サークルピッカーのカウントを追加」「ボイスカウントを追加」等で起動。SetteiSaCountApp 専用。
---

# サークルピッカーのカウント機能の追加

既存ページ（`/add-page` 等で作った View）に、ホイールピッカーで要素を選んで登録ボタンでカウントし、結果に各要素の出現率を出す機能を追加する定番作業。終了画面のサイン/ボイス示唆などで多用（`unitCountSubmitWithResult`＋`unitResultCountListPercent`）。**カウント対象はボイス以外（サイン・キャラ・当選画面 等）もある**ため、要素名・選択肢・示唆・色・数は都度質問。参照：`rioAceViewEnding`（ボイス）／`rioAceViewScreen`（サイン）。雛形：`.claude/skills/add-circle-count/templates/CircleCount.swift.tmpl`。

## 1. 質問（都度）
- **prefix** ＋ **対象ページ**（`<PageName>`＝`SetteiSaCountApp/<prefix>/<prefix>View<PageName>.swift`。add-page 済み前提）。`Prefix`＝先頭大文字。
- **要素名**：`<Element>`（PascalCase、例 `Voice`）→ `<element>Count1..N`/`<element>CountSum`/`<element>SumFunc`/`reset<Element>`/`binding<Element>`。`<element>`＝先頭小文字。
- **選択セクションのヘッダー**（例「ボイス選択」＝Class の区切りコメントにも使う）／**結果セクションのヘッダー**（例「カウント結果」）。
- **N**：選択肢数。
- **selectList**（N個。ピッカーの選択肢文字列）。
- **sisaList**（N個。各選択肢の示唆文言＝結果タイトル）。
- **flushColorList**（N個。`.blue`/`.yellow`/`.green`/`.red`/`.purple` 等）。
- **default 選択**（`selectedItem` の初期値。既定＝selectList の先頭。「サインなし」等の未選択文字列でも可）。

## 2. Class 実装（`<prefix>Class.swift`）
雛形 (A) を、クラス末尾の既存 count 群の後（クラス閉じ `}` の前）に挿入。トークン展開（k=0..N-1）：
- `__COUNT_APPSTORAGE__`：`    @AppStorage("<prefix><Element>Count<k+1>") var <element>Count<k+1>: Int = 0`
- `__COUNT_SUMARGS__`：`            <element>Count<k+1>,`
- `__COUNT_RESET__`：`        <element>Count<k+1> = 0`
`resetAll()` に `reset<Element>()` を1行追加。

## 3. View 実装（`<prefix>View<PageName>.swift`）
- **(B) プロパティ**を標準 @State 群の後・`var body` の前に挿入（`__SELECT_LIST__`/`__SISA_LIST__` は各行字下げ8、`__DEFAULT_ITEM__`）。
- **(C) 2 Section** を `List { }` の中に挿入（空ページなら中身として）。
- **(D) toolbar** を `.applyOrientationHandling(...)` の直後に追加。**既に `.toolbar` があれば新規追加せず、中に minus/reset の ToolbarItem 2つを統合**。
- **(E) ヘルパー3関数** を struct 末尾 `}` の前に挿入。switch は N ケース生成：
  - `__SISA_SWITCH__`：`        case self.selectList[k]: return self.sisaList[k]`
  - `__BINDING_SWITCH__`：`        case self.selectList[k]: return $<prefix>.<element>Count<k+1>`
  - `__COLOR_SWITCH__`：`        case self.selectList[k]: return <colorK>`

## 4. 検証・報告
- `xcodebuild -scheme SetteiSaCountApp -destination 'generic/platform=iOS Simulator' -configuration Debug build` で `** BUILD SUCCEEDED **`。
- 提案コミット：`[機能]<prefix> <選択ヘッダー>カウントを追加`（末尾 `Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>`）。**コミットはユーザー指示後**。
- **案内**：`<element>Count1..N`/`<element>CountSum`（単純 @AppStorage）はメモリー対象。**`/sync-memory` を実行して Memory に同期**。

## 注意
- selectList・sisaList・flushColorList は必ず N 個ずつ（過不足でズレる）。
- `binding<Element>` は要素名で個別化するが、`selectedItem`/`selectList`/`sisaList`/`sisaText`/`flushColor` は共有名＝**1ページに1つのサークルカウンター前提**。複数は手動リネーム。
- 対象 View に既に `selectedItem`/`sisaText`/`flushColor` がある場合は名前衝突に注意（rioAceViewScreen 等）。
- ページshell＝`/add-page`、メモリー同期＝`/sync-memory`、画像付き画面カウント＝`/add-screen`。
