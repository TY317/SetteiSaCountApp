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
- **リンク挿入位置**：まず `<prefix>ViewTop.swift` のメニュー Section（`Section {` 〜 `} header:`）を読み、**既存メニュー項目を上から順に一覧提示**（各項目の `// <textBody>` コメント／`destination: <prefix>View<X>` で識別）。そのうえでユーザーに挿入位置を確認する。指定形式は既存項目基準：
  - 「〈既存項目〉の**直後**」／「〈既存項目〉の**直前**」
  - 「**先頭**」（Section の最初のメニュー項目の前）
  - 「**末尾**」（トロフィーがあればその直前、無ければ Section 末尾＝従来の挿入位置）
  - **既定は設けない。毎回必ずユーザーに確認する**（未指定のまま挿入しない）。挿入位置はページによって異なるため毎回確認する（旧仕様の“トロフィー除く末尾固定”は『末尾』選択時の挙動として残存）。
- **既存ユーザーへの通知バッジ（`verNNNNFirstLaunch()` への追加）を行うか**：**毎回ユーザーに確認する**。既存機種へのページ追加は通常「行う」（既定＝はい）、新機種の初回追加時は「行わない」（新機種は初回インストールで全ページが揃うため通知不要）。行う場合、開発中バージョンの `verNNNNFirstLaunch()`（`commonVar.swift`。最新版の関数）の更新ブランチ（`if isVersionCompare(...)` 内）に `<prefix>Menu<PageName>Badge = "new"` を追加する（手順6参照）。

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
**手順1で確定した挿入位置**に、以下のコード片を挿入する（先頭の空行1つも付与。インデントは既存メニュー項目に合わせ 20 スペース字下げ）：
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
**アンカーの決め方**（手順1の指定に応じて）：
- 「〈既存項目〉の**直後／直前**」→ 対象項目の `NavigationLink(destination: <prefix>View<Target>(...))` ブロック全体を特定し、その閉じ `}` の**直後**／`// <targetTextBody>` コメントの**直前**に挿入。
- 「**先頭**」→ Section 内の最初のメニュー項目 `// <comment>` の直前に挿入。
- 「**末尾**」→ 従来どおりトロフィー `NavigationLink` の**直前**（トロフィーが無ければ、コメントアウトされた `//                } header: {` の直前＝Section 末尾）に挿入。
- **トロフィーは常に最下部を維持**（トロフィーの後ろには挿入しない）。

## 6. 通知バッジ（手順1で「行う」と確認した場合のみ）
- 開発中の**最新版** `verNNNNFirstLaunch()`（`SetteiSaCountApp/Common/class/commonVar.swift`）の更新ブランチ（`if isVersionCompare(lastVersion, lessThan: targetVersion) {` 〜 `else` の間）に、その機種のブロック（`machines.updateMachineBadgeStatus(id: "<機種ID>", newStatus: "update")` 付近）へ次を追加：
```swift
                <prefix>Menu<PageName>Badge = "new"
```
機種のブロックがまだ無ければ、機種アイコンバッジ更新（`machines.updateMachineBadgeStatus(id: "<機種ID>", newStatus: "update")`）とセットで追加する。手順1で「行わない」（新機種の初回追加等）を選んだ場合はこの手順をスキップ。

## 7. 検証・報告
- `xcodebuild -scheme SetteiSaCountApp -destination 'generic/platform=iOS Simulator' -configuration Debug build` で `** BUILD SUCCEEDED **`。失敗時は pbxproj をバックアップ復元して報告。
- 提案コミットメッセージ：`[機能]<prefix> <navigationTitle>ページ（空）を追加`（末尾に `Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>`）。**コミットはユーザー指示後**。
- 案内：ページ本体（カウント要素・テーブル・グラフ等）は別途実装。

## 注意
- バッジ変数名・View struct 名・ファイル名の `<PageName>` を揃える（`<prefix>Menu<PageName>Badge` / `<prefix>View<PageName>`）。
- スケルトンはツールバー無し・空List（意図的）。カウント/リセット等は中身実装時に追加。
- pbxproj はバックアップ＋ビルド検証必須（imageset 等リソースは無いので Resources 登録は不要）。
