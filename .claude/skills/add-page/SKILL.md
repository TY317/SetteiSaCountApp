---
name: add-page
description: 機種に汎用の空ページ(サブメニュー)を1枚追加する。commonVar にメニューバッジ、<prefix>View<PageName>.swift の空Listスケルトンを生成、pbxproj登録、ViewTop にメニューリンク(unitLabelMenu)を配線する。ページ識別子(PageName)・navigationTitle・unitLabelMenu の imageSystemName/textBody は都度ユーザー入力。中身は後から実装する土台のみ。「ページを追加」「サブページを追加」「空ページを作って」等で起動。SetteiSaCountApp 専用。
---

# 汎用ページ（サブメニュー）の追加

機種のトップメニューに**新しいサブページを1枚**追加する汎用作業。中身は空の `List{}` スケルトンで、後から実装する前提の土台のみを作る（例：sencole6 の「AT中」＝`sencole6ViewDuringAt`）。4点（commonVarバッジ／新規View／pbxproj／ViewTopリンク）を編集する。雛形：`.claude/skills/add-page/templates/View.swift.tmpl`。

## 1. 質問（都度）
- **prefix**：対象機種（`SetteiSaCountApp/<prefix>/<prefix>ViewTop.swift` 存在前提＝add-machine 済み）。`Prefix`＝先頭大文字。
- **PageName**：PascalCase の識別子（例 `DuringAt`）。→ ファイル `<prefix>View<PageName>.swift`、struct `<prefix>View<PageName>`、バッジ `<prefix>Menu<PageName>Badge`。
- **navigationTitle**：ページのナビタイトル（例 `AT中`）。
- **imageSystemName**：`unitLabelMenu` のSFシンボル（例 `figure.equestrian.sports`）。
- **textBody**：メニュー表示名（例 `AT中`。navigationTitle と同じことが多い）。

## 2. commonVar 編集（`SetteiSaCountApp/Common/class/commonVar.swift`）
対象機種のバッジブロック（`// ---- <fullName>` 配下）の**最後の `<prefix>Menu*Badge` 行の直後**に1行追加：
```swift
    @AppStorage("<prefix>Menu<PageName>Badge") var <prefix>Menu<PageName>Badge: String = "none"
```

## 3. View 生成（テンプレ置換）
`templates/View.swift.tmpl` を以下置換して `SetteiSaCountApp/<prefix>/<prefix>View<PageName>.swift` に生成：
- `__prefix__`→prefix、`__Prefix__`→Prefix、`__PAGENAME__`→PageName、`__TITLE__`→navigationTitle

## 4. pbxproj 登録（`<prefix>View<PageName>.swift`・1ターゲット）
`cp SetteiSaCountApp.xcodeproj/project.pbxproj /tmp/pbxproj_<prefix>page.bak`。同じ `<prefix>` グループ内の兄弟（例 `<prefix>ViewNormal.swift`）を手本に、GUID2つ生成（FR/BF）して：PBXFileReference 1行、PBXBuildFile 1行、`<prefix>`グループ children 1行、メインアプリの PBXSourcesBuildPhase 1行。
確認：`grep -c "<prefix>View<PageName>.swift in Sources"` が **2**。

## 5. ViewTop 配線（`<prefix>ViewTop.swift`）
メニュー Section 内の「トロフィー」`NavigationLink` の**直前**（トロフィーが無ければ、コメントアウトされた `//                } header: {` の直前＝Section 末尾）に挿入：
```swift

                    // <textBody>
                    NavigationLink(destination: <prefix>View<PageName>(
                        <prefix>: <prefix>,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "<imageSystemName>",
                            textBody: "<textBody>",
                            badgeStatus: common.<prefix>Menu<PageName>Badge,
                        )
                    }
```

## 6. 検証・報告
- `xcodebuild -scheme SetteiSaCountApp -destination 'generic/platform=iOS Simulator' -configuration Debug build` で `** BUILD SUCCEEDED **`。失敗時は pbxproj をバックアップ復元して報告。
- 提案コミットメッセージ：`[機能]<prefix> <navigationTitle>ページ（空）を追加`（末尾に `Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>`）。**コミットはユーザー指示後**。
- 案内：ページ本体（カウント要素・テーブル・グラフ等）は別途実装。既存ユーザーへ新ページを通知したい場合は、開発中バージョンの `verNNNNFirstLaunch()` で `<prefix>Menu<PageName>Badge = "new"` を設定（任意）。

## 注意
- バッジ変数名・View struct 名・ファイル名の `<PageName>` を揃える（`<prefix>Menu<PageName>Badge` / `<prefix>View<PageName>`）。
- スケルトンはツールバー無し・空List（意図的）。カウント/リセット等は中身実装時に追加。
- pbxproj はバックアップ＋ビルド検証必須（imageset 等リソースは無いので Resources 登録は不要）。
