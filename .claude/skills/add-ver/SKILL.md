---
name: add-ver
description: 新バージョンの初回起動処理スケルトンを追加する。commonVarに verNNNNFirstLaunch() を追加、splashScreenに呼び出しを追加、verNNNN.swift(Tip雛形)を用意する。引数に対象（例 ver410 / 4.1.0）。新バージョン開発の頭で「新バージョン処理を追加」「verクラスを追加」等で起動。disable-ver の逆操作。SetteiSaCountApp 専用。
---

# 新バージョンの初回起動処理（スケルトン）を追加

新バージョン開発の頭で、`verNNNNFirstLaunch()`（更新時のバッジ/ロック付与用の入れ物）と `verNNNN.swift`（TipKit の Tip 雛形）を追加する。disable-ver の逆。ver410 追加時の手順の一般化。

対象は引数（例 `ver410` / `4.1.0`）。指定がなければ尋ねる。`verNNNN`（ファイル/関数名）と `"N.N.N"`（targetVersion文字列）を導出。例：`4.1.0` → `ver410`、`"4.1.0"`。

## 手順
1. **verNNNN.swift の用意（pbxproj登録）**
   - `grep -c "verNNNN.swift" SetteiSaCountApp.xcodeproj/project.pbxproj` で登録済みか確認。
   - **未登録なら、ユーザーに Xcode で空の `verNNNN.swift` を `SetteiSaCountApp/Common/class` グループに新規作成してもらう**（手動でのpbxprojへのファイル追加＝GUID生成は壊しやすいので避ける）。作成・登録後に続行。
2. **verNNNN.swift の中身**：直近版の `verXXXX.swift` に倣い Tip 雛形を書く。`import Foundation/SwiftUI/TipKit` ＋ 最低限：
   - `struct tipVerNNNNUpdateInfo: Tip`（機種/機能追加の告知。title 例「機種追加！」、message 雛形、image `star`）
   - `struct tipVerNNNN: Tip`（機能更新の告知。title「機能更新」、message 雛形、image `exclamationmark.bubble`）
   - 文言は空/プレースホルダでよい（実装時に埋める）。
3. **commonVar.swift**：`// バージョンごとの処理` セクションの先頭（直近最新 `verXXXXFirstLaunch` の直前）に `func verNNNNFirstLaunch()` を追加。直近版関数の体裁をコピーし版だけ変更：
   ```swift
   func verNNNNFirstLaunch() {
       let targetVersion: String = "N.N.N"
       if firstLaunchAppVersion != nil {
           let lastVersion = lastLaunchAppVersion ?? "0.0.0"
           if isVersionCompare(lastVersion, lessThan: targetVersion) {
               print("\(targetVersion)未満からアップデートされました")
               // ここに更新時のバッジ付与等を後で追記
           } else {
               print("\(targetVersion)以上です")
           }
       } else {
           print("初回起動です")
       }
   }
   ```
4. **splashScreenView.swift**：`common.ver<直近版>FirstLaunch()` の直後（`common.saveAppVersions()` の前）に `common.verNNNNFirstLaunch()` を追加。呼び出しは**版の昇順で末尾に追加**する。
5. **検証**：ビルド成功（`xcodebuild -scheme SetteiSaCountApp -destination 'generic/platform=iOS Simulator' -configuration Debug build`）。`verNNNN` が commonVar/splash/ファイルに揃っているか grep 確認。
6. **報告**（コミットはユーザー指示後）。提案コミットメッセージ：`[追加]verNNNN 初回起動処理スケルトンを追加`（末尾に `Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>`）。

## 注意
- スケルトンは print のみ。実際のバッジ付与/リワードロック（`XXXisUnlocked = false` 等）は機能追加のタイミングで本文に追記する。
- 既存の他 verXXXXFirstLaunch・その呼び出し順は変えない（新版は呼び出し末尾に追加、関数定義はセクション先頭に追加）。
- TipKit の Tip 雛形は定義のみで未使用でもビルドは通る。実際の `.popoverTip(...)` 配置は機能実装時に行う。
