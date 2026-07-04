---
name: sync-memory
description: 機種Class の @AppStorage 状態変数と Memory1/2/3 クラスを比較し、メモリーに不足している変数を Memoryクラス＋ViewTop の saveMemory/loadMemory に同期追加する。新機種追加時や、既存機種の Class に変数を増やした後の追随作業。JSON配列(Data?)変数は load 処理が異なり otome5 を参照。「メモリーを同期」「メモリーに変数を追加」「メモリー更新」等で起動。SetteiSaCountApp 専用。
---

# メモリー（セーブ/ロード）同期

機種Class に増やしたカウント状態変数を、メモリー機能（Memory1/2/3 への保存/復元）へ追随させる定番作業。`<prefix>Class.swift` の機種Class（`<Prefix>`）と Memory クラス（`<Prefix>Memory1/2/3`）を比較し、**不足変数を Memory クラス＋ViewTop の `saveMemory<N>()`/`loadMemory<N>()` に追加**する。参照：通常型=`sencole6`、JSON配列(`Data?`)型=`otome5`（`otome5Class.swift`/`otome5ViewTop.swift`）。

## 1. 質問：prefix
対象機種（`SetteiSaCountApp/<prefix>/<prefix>Class.swift`・`<prefix>ViewTop.swift` 存在前提）。`Prefix`＝先頭大文字。

## 2. 解析（`<prefix>Class.swift`）
- **機種Class `<Prefix>`** の `@AppStorage` 変数を列挙：`name` / `type`（Int/Bool/String/Double/`Data?`）/ `default` / `key`（`@AppStorage("...")` の文字列）。
  - `Data?` 型＝**JSON配列パターン(B)**。対になる `let <name>Key: String = "<key>"` を採取（load の `forKey:` に使う）。
- **除外**：`minusCheck`・`selectedMemory`（共通/UI）と、入力セレクタ系（例 `inputGame` / `selected*` 等の「現在の入力/選択」変数）。判断に迷うものは step3 で確認。
- **`<Prefix>Memory1`** の既存変数（`memo`/`dateDouble` を除く）を列挙。
- **不足 = 機種Class にあり Memory1 に無い**変数を算出（Memory2/3 も同一構成前提）。

## 3. 確認（ユーザー）
- 不足変数リストを提示（既定＝追加）。保存不要な入力セレクタ等があれば除外してもらう。
- **`Data?` 変数は要素型を確認**：`[Int]` → `decodeIntArray`、`[String]` → `decodeStringArray`。
- 不足なしなら「同期済み」と報告して終了（変更なし）。

## 4. 適用
確定した各変数について、Memory1/2/3 と Save/Load の**3クラス・6関数すべて**に追加（1つでも漏らさない）。

### (a) Class：`<Prefix>Memory1/2/3` それぞれの `memo` 行（`@AppStorage("<prefix>MemoMemory<N>") var memo = ""`）の**直前**に挿入
- 通常型：
  ```swift
  @AppStorage("<mainKey>Memory<N>") var <name>: <type> = <default>
  ```
- `Data?` 型：
  ```swift
  @AppStorage("<key>Memory<N>") var <name>Data: Data?
  ```
（`<name>Key`（`let`）は Memory に複製しない）

### (b) ViewTop `saveMemory<N>()`（N=1,2,3）に追加
```swift
        <prefix>Memory<N>.<name> = <prefix>.<name>
```
`Data?` も同様に直接コピー（`<prefix>Memory<N>.<name>Data = <prefix>.<name>Data`）。

### (c) ViewTop `loadMemory<N>()`（N=1,2,3）に追加
- 通常型：
  ```swift
        <prefix>.<name> = <prefix>Memory<N>.<name>
  ```
- `Data?` 型（**直接代入しない**。デコードして saveArray で書き戻す）：
  ```swift
        let <name>Decoded = decodeIntArray(from: <prefix>Memory<N>.<name>Data)   // [String]なら decodeStringArray
        saveArray(<name>Decoded, forKey: <prefix>.<name>Key)
  ```
  （ヘルパー：`SetteiSaCountApp/Common/function/myFunction.swift` の `decodeIntArray`/`decodeStringArray`/`saveArray`）

## 5. 検証・報告
- `xcodebuild -scheme SetteiSaCountApp -destination 'generic/platform=iOS Simulator' -configuration Debug build` で `** BUILD SUCCEEDED **`。
- 提案コミットメッセージ：`[機能]<prefix> メモリーに不足変数を同期`（末尾に `Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>`）。**コミットはユーザー指示後**。

## 注意
- **3クラス（Memory1/2/3）× {宣言, save, load}** に必ず全部追加。1つでも欠けると保存/復元が不整合になる。
- Memory の AppStorage キーは必ず `<mainKey>Memory<N>`（機種Class のキー＋`Memory<N>`）。
- `Data?` の load は decode＋saveArray（直接代入だと UserDefaults 実キーと同期しない）。要素型の取り違えに注意（`decodeIntArray`↔`decodeStringArray`）。
- `minusCheck`/`selectedMemory`/`memo`/`dateDouble`/入力セレクタは対象外。
- 既に同期済みなら何も変更しない（冪等）。
