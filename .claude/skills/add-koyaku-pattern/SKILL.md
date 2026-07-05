---
name: add-koyaku-pattern
description: 機種の通常時ページに「レア役停止系」(レア役停止形テーブル)を追加する。<prefix>TableKoyakuPattern.swift を雛形から生成しpbxproj登録、<prefix>ViewNormal の List に「小役」セクション＋unitLinkButtonViewBuilderを配線する。新機種追加時の定番作業。引数に prefix（例 karakuri2）。「レア役停止系を追加」「停止形テーブルを追加」等で起動。SetteiSaCountApp 専用。
---

# レア役停止系（停止形テーブル）の追加

新機種の通常時ページに「レア役停止系」の参照テーブルを追加する定番作業。テーブルの**図柄/役の中身は機種固有**なので、雛形（代表例：弱🍒/強🍒/チャンス目/🍉）を生成し、ユーザーが実機に合わせて編集する前提。雛形は `.claude/skills/add-koyaku-pattern/templates/`。karakuri2 の実装（コミット参照）と同型。

## 1. 対象を質問
- **prefix**：対象機種の共通文字列（例 `karakuri2`）。`SetteiSaCountApp/<prefix>/` と `<prefix>ViewNormal.swift` が存在する前提（先に add-machine 済み）。

## 2. テーブルファイル生成
- `templates/TableKoyakuPattern.swift.tmpl` を `__prefix__`→prefix 置換して
  `SetteiSaCountApp/<prefix>/<prefix>TableKoyakuPattern.swift` に生成。
- 中身は代表例。**生成後、ユーザーに「実機の停止形に合わせて図柄/役を編集してください」と案内**。

## 3. pbxproj 登録（<prefix>グループ＋**2ターゲットのSources**へ）
レア役停止形テーブルは **2つのターゲットのSourcesに登録するのが既定**（既存の `godKisekiKoyakuPattern` / `bioRe3TableKoyakuPattern` / `rioAceTableKoyakuPattern` / `kokakukidotaiTableKoyakuPattern` が2ターゲット登録）。**手本として既存の *KoyakuPattern テーブル（例 `godKisekiKoyakuPattern.swift`）の登録のされ方をそのまま真似る**。
- `cp SetteiSaCountApp.xcodeproj/project.pbxproj /tmp/pbxproj_<prefix>koyaku.bak`。
- GUID を3つ一意生成（`uuidgen | tr -d '-' | tr a-f A-F | cut -c1-24`、pbxproj内未出現を確認）：FileReference用 `FR`、BuildFile用 `BF1`/`BF2`。
- **PBXFileReference**：1行 `FR /* <prefix>TableKoyakuPattern.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = <prefix>TableKoyakuPattern.swift; sourceTree = "<group>"; };`
- **PBXBuildFile**：**2行**（どちらも `fileRef = FR`）。`BF1 ... in Sources ...` と `BF2 ... in Sources ...`。← 2ターゲット分。
- **PBXGroup**：`<prefix>` グループの children に `FR /* <prefix>TableKoyakuPattern.swift */,` を1つ追加。
- **PBXSourcesBuildPhase（2箇所）**：手本テーブル（godKisekiKoyakuPattern 等）が登場する**2つのSourcesフェーズ両方**に、片方へ `BF1`、もう片方へ `BF2` を1つずつ追加（手本の2箇所と同じフェーズに並べる）。
- 確認：`grep -c "<prefix>TableKoyakuPattern.swift in Sources"` が **4**（PBXBuildFile定義2＋Sourcesフェーズ参照2）。手本テーブルと同数。

## 4. ViewNormal へ配線
`SetteiSaCountApp/<prefix>/<prefix>ViewNormal.swift` の `var body` 内 `List {` に、次のセクションを追加（既存セクションがあれば適切な位置、無ければ List 先頭）：
```swift
// レア役
Section {
    // レア役停止系
    unitLinkButtonViewBuilder(sheetTitle: "レア役停止系") {
        <prefix>TableKoyakuPattern()
    }
} header: {
    Text("小役")
}
```

## 5. 検証・報告
- ビルド成功（`xcodebuild -scheme SetteiSaCountApp -destination 'generic/platform=iOS Simulator' -configuration Debug build`）。失敗時は pbxproj をバックアップから復元して報告。
- 提案コミットメッセージ：`[機能]<prefix> 通常時にレア役停止系を追加`（末尾に `Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>`）。**コミットはユーザー指示後**。
- ユーザーに「テーブルの図柄/役は実機に合わせて編集してください」と再度案内。

## 注意
- pbxproj は必ずバックアップ＋ビルド検証。本テーブルは**2ターゲット登録が既定**（`in Sources` が計4）。ちょうど2になるようにし、1（片方のみ）や3以上（過剰）にしない。判断に迷ったら既存 *KoyakuPattern テーブルの登録を手本にする。
- 図柄パーツ：`unitReelPattern / unitReelColumn / unitReelAny / unitReelHazure / unitReelSpacer / unitReelLongTitle / unitReelReplay(xmarkBool:) / unitReelBar / unitReelText(textBody:) / unitReelDefault`。
