---
name: add-screen
description: 機種に「終了画面」カウントページを実装する。Class に screenCount1..N/screenCountSum/screenSumFunc/resetScreen を追加、<prefix>ViewScreen.swift を雛形生成、Screen画像アセットを作成、pbxproj登録、ViewTop に終了画面リンクを配線する。画面枚数N・upperBeltTextList・lowerBeltTextList・flashColorList は都度ユーザー入力。新機種追加後の高頻度な定番作業。「終了画面を実装」「終了画面カウントを追加」等で起動。SetteiSaCountApp 専用。
---

# 終了画面カウントページの実装

新機種に「終了画面」カウントページ（`<prefix>ViewScreen.swift`）を実装する高頻度の定番作業。Class / 新規 ViewScreen / 画像アセット / pbxproj / ViewTop を横断編集する。**画面の枚数 N・上段/下段ベルト文言・フラッシュ色**は機種ごとに異なるため都度ユーザーに質問する。参照実装：`sencole6ViewScreen` / `neoplaViewScreen`。雛形：`.claude/skills/add-screen/templates/ViewScreen.swift.tmpl`。

## 1. 質問（都度）
- **prefix**：対象機種（`SetteiSaCountApp/<prefix>/<prefix>Class.swift`・`<prefix>ViewTop.swift`・`<prefix>Assets.xcassets` 存在前提＝add-machine 済み）。`Prefix`＝先頭大文字。
- **N**：画面枚数。
- **upperBeltTextList**：N個。各画面の上段ベルト文言（画面名など）。
- **lowerBeltTextList**：N個。各画面の下段ベルト文言（示唆内容。結果行のタイトルにも使う）。
- **flashColorList**：N個。`.blue` / `.yellow` / `.green` / `.red` / `.brown` / `.orange` / `.purple` 等の `Color`。

導出：`imageNameList = <prefix>Screen1 … <prefix>ScreenN`、`indexList = [0, 1, …, N-1]`。バッジ変数 `<prefix>MenuScreenBadge` は add-machine 生成済み前提。

## 2. Class 編集（`<prefix>Class.swift`）
`resetFirstHit()` の閉じ括弧の後、`// -----------` / `// 共通` ブロックの**直前**に挿入：
```swift

    // --------
    // 終了画面
    // --------
    @AppStorage("<prefix>ScreenCount1") var screenCount1: Int = 0
    …（n=1..N）
    @AppStorage("<prefix>ScreenCount<N>") var screenCount<N>: Int = 0
    @AppStorage("<prefix>ScreenCountSum") var screenCountSum: Int = 0

    func screenSumFunc() {
        screenCountSum = countSum(
            screenCount1,
            …,
            screenCount<N>,
        )
    }

    func resetScreen() {
        screenCount1 = 0
        …
        screenCount<N> = 0
        screenCountSum = 0
        minusCheck = false
    }
```
`resetAll()` の `resetFirstHit()` の直後に `resetScreen()` を追加。

## 3. ViewScreen 生成（テンプレ置換）
`templates/ViewScreen.swift.tmpl` を以下置換して `SetteiSaCountApp/<prefix>/<prefix>ViewScreen.swift` に生成：
- `__prefix__`→prefix、`__Prefix__`→Prefix
- `__IMAGE_NAME_LIST__`→ `<prefix>Screen1`…`<prefix>ScreenN` の各行（`                "<name>",` 字下げ16、末尾カンマ）
- `__UPPER_BELT_LIST__` / `__LOWER_BELT_LIST__`→ 各リストの `                "<text>",`（字下げ16）
- `__FLASH_COLOR_LIST__`→ 各色 `                <color>,`（字下げ16）
- `__INDEX_LIST__`→ `[0,1,…,N-1]`
- `__BINDING_SWITCH__`→ N ケース（字下げ8）：
  ```swift
        case 0: return $<prefix>.screenCount1
        …
        case <N-1>: return $<prefix>.screenCount<N>
  ```
  （`default: return .constant(0)` は雛形に既存）

## 4. 画像アセット生成（PNGはユーザーがXcodeで後入れ）
n=1..N について `SetteiSaCountApp/<prefix>/<prefix>Assets.xcassets/<prefix>Screen<n>.imageset/Contents.json` を**空スロット**で作成（filename無し。ユーザーが後で1xに配置）：
```json
{ "images" : [ { "idiom" : "universal", "scale" : "1x" }, { "idiom" : "universal", "scale" : "2x" }, { "idiom" : "universal", "scale" : "3x" } ], "info" : { "author" : "xcode", "version" : 1 } }
```
※imageset は既存の `folder.assetcatalog` 参照（`<prefix>Assets.xcassets`）配下なので **pbxproj 追加は不要**（フォルダ参照が自動包含）。

## 5. pbxproj 登録（`<prefix>ViewScreen.swift` のみ・1ターゲット）
`cp SetteiSaCountApp.xcodeproj/project.pbxproj /tmp/pbxproj_<prefix>screen.bak`。同じ `<prefix>` グループ内の兄弟（例 `<prefix>ViewNormal.swift`）を手本に、GUID2つ生成（FR/BF）して：PBXFileReference 1行、PBXBuildFile 1行、`<prefix>`グループ children 1行、メインアプリの PBXSourcesBuildPhase 1行。imageset は登録しない。
確認：`grep -c "<prefix>ViewScreen.swift in Sources"` が **2**。

## 6. ViewTop 配線（`<prefix>ViewTop.swift`）
初当りの `NavigationLink(destination: <prefix>ViewFirstHit(...)){…}` ブロックの**直後**に挿入：
```swift

                    // 終了画面
                    NavigationLink(destination: <prefix>ViewScreen(
                        <prefix>: <prefix>,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "終了画面",
                            badgeStatus: common.<prefix>MenuScreenBadge,
                        )
                    }
```

## 7. 検証・報告
- `xcodebuild -scheme SetteiSaCountApp -destination 'generic/platform=iOS Simulator' -configuration Debug build` で `** BUILD SUCCEEDED **`。失敗時は pbxproj をバックアップ復元して報告。
- 案内：「Xcode で `<prefix>Screen1`…`<prefix>Screen<N>` の imageset に画面PNGを配置してください」。ベルト文言・色は実機に合わせ調整可。
- 提案コミットメッセージ：`[機能]<prefix> 終了画面カウントページを実装`（末尾に `Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>`）。**コミットはユーザー指示後**。

## 注意
- `.toolbar` は雛形で「画面選択解除（`unitButtonToolbarScreenSelectReset`、`currentKeyword: $selectedImageName`）／マイナスチェック／リセット」の3ボタンを既定生成する。**画面選択解除は終了画面の必須ボタン**（選択中の画面をクリアする）なので削除しない。
- `screenCountSum`・`countSum(...)`・`resetScreen()` 内 `minusCheck = false` を忘れない。`resetAll()` への `resetScreen()` 追加も必須。
- 3リスト（upper/lower/flashColor）は必ず N 個ずつ。過不足があるとインデックスの `indices.contains` ガードで表示/結果が欠ける。
- 終了画面のベイズ判別（`logPostPercentMulti` で `screenCount*` を尤度化）は本スキルのスコープ外＝別途 add-bayes-element。
- pbxproj はバックアップ＋ビルド検証必須。
