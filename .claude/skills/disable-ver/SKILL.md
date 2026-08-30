---
name: disable-ver
description: 特定バージョンの初回起動移行コードを撤去する。verNNNNFirstLaunch()・verNNNN.swift(Tip群)・その全使用箇所を削除し、isUnlockedロックがあればforcedUnlockReward()へ引き継ぐ。引数に対象（例 ver3271 / 3271）。新バージョン開発の整理で「verクラスの無効化」「古い移行コードを削除」等で起動。SetteiSaCountApp 専用。
---

# 特定 verクラス（移行コード）の無効化・削除

新バージョン開発のたびに、古い `verNNNNFirstLaunch()`（初回起動時のバッジ付与/ロック等の移行処理）と関連 `verNNNN.swift`（TipKit の Tip 群）を撤去する。ver3241 で実施した手順（コミット `f0d2b95`）の一般化。

対象は引数で受け取る（例 `ver3271` または `3271`）。`verNNNN` 形に正規化する。指定がなければ尋ねる。

## 手順

1. **影響調査**（読み取りのみ）
   - `grep -rn "verNNNN\|VerNNNN" SetteiSaCountApp --include="*.swift"`
   - `grep -n "verNNNN" SetteiSaCountApp.xcodeproj/project.pbxproj`
   - 想定される対象：
     - `commonVar.swift` の `func verNNNNFirstLaunch() { ... }`
     - `SetteiSaCountApp/Common/class/verNNNN.swift`（`tipVerNNNN...` の Tip 群。存在しないバージョンもある）
     - `splashScreenView.swift` の `common.verNNNNFirstLaunch()` 呼び出し
     - 各機種Viewの `.popoverTip(tipVerNNNN...())`（コメントアウト済み含む）

2. **isUnlocked ロックの引き継ぎ（関数削除より先に必ず実施）**
   `func verNNNNFirstLaunch()` の本文を読み、**ロック処理があれば必ず `forcedUnlockReward()` へ移す**。ロックのパターンは2種類あり、**新しい方（B）が現行**：

   | | パターン | 引き継ぎ先に追加する行 |
   |---|---|---|
   | **A（旧）** | `XXXisUnlocked = false` | `XXXisUnlocked = true` |
   | **B（現行）** | `machines.updateMachineIsUnlocked(id: "<id>", isUnlocked: false)` | `machines.updateMachineIsUnlocked(id: "<id>", isUnlocked: true)` |

   - **A は 4.0.0 以前の書き方で、現在 `commonVar` には1件も残っていない。** ver410 以降はすべて B。**A だけを探して「該当なし」と判断しないこと。**
   - 追加先はどちらも `commonVar` の `func forcedUnlockReward()`（splash から毎起動呼ばれる）。既に同じ行があれば不要。
   - 理由：移行関数を消すと、リワード未視聴のままロックされているユーザーが永久に解放されなくなる。B のロックを解除する `updateMachineIsUnlocked(..., isUnlocked: true)` はコード中に他に存在せず、解放は UI のリワード視聴のみ。
   - ※badge 代入（`= "update"`/`"new"` / `updateMachineBadgeStatus`）だけなら引き継ぎ不要。

   確認コマンド：
   ```bash
   sed -n '/func verNNNNFirstLaunch/,/^    }/p' SetteiSaCountApp/Common/class/commonVar.swift | grep -n "isUnlocked"
   ```

3. **削除**
   - `commonVar.swift`：`func verNNNNFirstLaunch() { ... }` をブロックごと削除（前後の余分な空行も整理）。`isVersionCompare` や各 `@AppStorage` バッジ/ロック変数、他の `verXXXXFirstLaunch` は**残す**。
   - `splashScreenView.swift`：`common.verNNNNFirstLaunch()` の行を削除（他の呼び出しは残す）。
   - 各View：`.popoverTip(tipVerNNNN...())` の行を削除（コメント行も掃除）。チェーンは前段で完結するので構文OK。
   - `verNNNN.swift` が存在する場合：
     - 事前バックアップ：`cp SetteiSaCountApp.xcodeproj/project.pbxproj /tmp/pbxproj_verNNNN.bak`
     - pbxproj から該当4参照を除去：対象は `verNNNN.swift` を含む行のみ（PBXBuildFile / PBXFileReference / group children / Sources）。`grep -cF 'verNNNN.swift'` で件数確認後、`grep -vF 'verNNNN.swift' /tmp/pbxproj_verNNNN.bak > SetteiSaCountApp.xcodeproj/project.pbxproj`。
     - ファイル削除：`rm SetteiSaCountApp/Common/class/verNNNN.swift`。

4. **検証**
   - `grep -rn "verNNNN\|VerNNNN" SetteiSaCountApp --include="*.swift"` が **0件**、pbxproj も `verNNNN` 0件。
   - **フルビルドは行わない**（`xcodebuild` はおよそ10分かかるため add-machine のみ。方針：`skill-build-verify-policy`）。削除対象の `verNNNN` が全ファイルから消えているか grep で確認し（残骸ゼロ）、pbxproj を編集した場合は `plutil -lint` を通す。報告時に「フルビルド検証は省略（コミット前ビルドに委ねる）」と一言添える。

5. **報告**（コミットはしない）
   - 削除した対象一覧、isUnlocked 引き継ぎの有無（A/B どちらのパターンだったか、`forcedUnlockReward()` に追加した機種ID）を報告。
   - 提案コミットメッセージ：`[整理]verNNNN関連(移行コード/Tip)を削除`（末尾に `Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>`）。
   - **コミットはユーザーが差分を確認して指示してから**行う（多ファイル削除＋pbxproj編集のため）。

## 注意
- 他の `verXXXXFirstLaunch`・Tip・バッジ/ロック変数は対象外（触らない）。
- pbxproj は必ずバックアップしてから編集。`verNNNN.swift` を含む行が想定数（通常4）か必ず確認してから除去。
