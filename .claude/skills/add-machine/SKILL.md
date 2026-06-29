---
name: add-machine
description: 新機種(パチスロ台)のモジュール一式を追加する。ViewTop/Class/ViewNormal/ViewFirstHit/View95Ci ＋ アセットカタログを雛形から生成し、project.pbxproj へ自動登録、commonVar(initMachine/バッジ/ver初回起動処理)・ContentViewVer2.getLinkView に配線する。機種固有値は都度質問。「新機種を追加」「機種を追加して」等で起動。SetteiSaCountApp 専用。
---

# 新機種の追加

karakuri2(からくりサーカス2, id 5019, コミット `0a8c2eb`) と同型の機種モジュールを、雛形テンプレートから生成して追加する。雛形は `.claude/skills/add-machine/templates/` に同梱（karakuri2 が後で実装されてもドリフトしない）。**コメントアウト部（ViewTopのheader/Bayesリンク、View95Ciのチャート）も雛形に含まれ、後の実装で有効化する前提**。

## 1. 機種固有値を質問する（都度）
以下を順に質問して集める：
- **prefix**：機種共通の文字列（小文字始まり、例 `karakuri2`）。ファイル名・struct名・@AppStorageキー・iconName に使う。先頭大文字版 `Prefix`（例 `Karakuri2`）はこれから導出（先頭1文字を大文字化）。
- **id**：DMM URL 下4桁（例 `5019`）。
- **name**：短縮表示名（ホームのアイコン用、例 `からくり2`）。
- **fullName**：正式名称（例 `からくりサーカス2`）。
- **maker**：メーカー（例 `SANKYO`）。
- **btBadge**：`true`/`false`。
- **copyright**：コピーライト表記（`Text("...")` を1行以上）。
- **rewardLock**：リワードロックするか（`isUnlocked=false`）。新台は通常 `true`（ロックする）。

導出値：`iconName = <prefix>MachineIcon`、`Prefix = prefixの先頭大文字`。

## 2. ファイル生成（テンプレートをトークン置換してコピー）
`SetteiSaCountApp/<prefix>/` を作り、`templates/*.tmpl` を以下トークン置換して配置（拡張子 `.tmpl` を除く）：
- `__prefix__` → prefix、`__Prefix__` → Prefix、`__ID__` → id、`__FULLNAME__` → fullName
- `__COPYRIGHT__` → コピーライトの `Text("...")` 行（20スペース字下げ）。複数行可。
- `__CAUTION_SECTION__` → メーカー法則で注意事項（前提ツール）Section or 空（→「2.6 注意事項セクション」参照）。
- `__TROPHY_LINK__` → メーカー法則でトロフィー系リンクブロック or 空（→「2.5 トロフィー系リンク」参照）。
生成ファイル：
- `<prefix>ViewTop.swift`（ViewTop.swift.tmpl）
- `<prefix>Class.swift`（Class.swift.tmpl）
- `<prefix>ViewNormal.swift`（ViewNormal.swift.tmpl）
- `<prefix>ViewFirstHit.swift`（ViewFirstHit.swift.tmpl）
- `<prefix>View95Ci.swift`（View95Ci.swift.tmpl）

## 2.5 トロフィー系リンク（`__TROPHY_LINK__` の置換）
トロフィー（プレート/凪/コイン含む）は**メーカー単位の機能**。step1 の `maker` が下表にあれば `__TROPHY_LINK__` を当該ブロックに、無ければ**空文字（行ごと削除）**に置換する。`imageSystemName` は常に `"trophy.fill"`。ビューは全て `SetteiSaCountApp/Common/view/` に既存。

| maker | ビュー struct | textBody |
|---|---|---|
| コナミ | `commonViewArisuTrophy` | アリストロフィー |
| サミー | `commonViewSammyTrophy` | サミートロフィー |
| 大都技研 | `commonViewKopandaTrophy` | コパンダトロフィー |
| 山佐 | `commonViewKerottoTrophy` | ケロットトロフィー |
| エンターライズ | `commonViewEnteriseTrophy` | エンタトロフィー |
| ニューギン | `commonViewGinchanTrophy` | ギンちゃんトロフィー |
| Spiky | `commonViewNamichanTrophy` | ナミちゃんトロフィー |
| 京楽 | `commonViewTamachanTrophy` | 玉ちゃんトロフィー |
| SANYO | `commonViewKujiluckyTrophy` | クジラッキートロフィー |
| UNIVERSAL | `commonViewUniversalPlate` | ユニバプレート |
| 平和 | `commonViewKakureNagi` | 隠れ凪 |
| 藤商事 | `commonViewFujimaruCoin` | 藤丸コイン |

表に無いメーカー（SANKYO・北電子・パイオニア・オーイズミ 等）は `__TROPHY_LINK__` を空に置換（リンク無し）。

該当時の置換ブロック（初当りブロックと同じ字下げ＝行頭20スペース。先頭に空行1つ）：
```swift

                    // トロフィー
                    NavigationLink(destination: <struct>()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "<textBody>"
                        )
                    }
```

## 2.6 注意事項セクション（`__CAUTION_SECTION__` の置換）
機種トップ最上部の「注意事項（前提ツール）」セクションは**メーカー単位**。step1 の `maker` が下表にあれば `__CAUTION_SECTION__` を当該ツール名で展開した Section に、無ければ**空文字（先頭セクションごと省略）**に置換する。

| maker | ツール名（Text内文字列） |
|---|---|
| コナミ | e-slot+ |
| UNIVERSAL | ユニメモ |
| 京楽 | ぱちログ |
| 山佐 | スロプラNEXT |
| SANYO | スロプラNEXT |
| 大都技研 | ダイトモ |
| サミー | マイスロ |
| 平和 | 打-WIN |

表に無いメーカー（Spiky・藤商事・ニューギン・北電子・パイオニア・オーイズミ・SANKYO・エンターライズ 等）は `__CAUTION_SECTION__` を空に置換（先頭セクション無し＝`unitLabelMachineTopTitle` ヘッダーも出ない。既存の `godzilla`/`karakuri2` と同形）。同一メーカーで揺れる／判断に迷う場合はユーザーに確認・手動調整可。

該当時の置換ブロック（行頭16スペース字下げ。末尾に空行1つ＝次の通常時 Section と1行空ける）：
```swift
                Section {
                    // 注意事項
                    Text("<TOOL>の利用を前提としています\n遊技前に<TOOL>を開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(
                        machineName: <prefix>.machineName,
                    )
                }

```

## 3. アセットカタログ生成（画像PNGはユーザーがXcodeで後入れ）
- `SetteiSaCountApp/<prefix>/<prefix>Assets.xcassets/Contents.json`：
  `{ "info" : { "author" : "xcode", "version" : 1 } }`
- `.../<prefix>Assets.xcassets/<prefix>MachineIcon.imageset/Contents.json`（**PNGは入れず空スロット**。ユーザーがXcodeで1xに配置）：
  ```json
  { "images" : [ { "idiom" : "universal", "scale" : "1x" }, { "idiom" : "universal", "scale" : "2x" }, { "idiom" : "universal", "scale" : "3x" } ], "info" : { "author" : "xcode", "version" : 1 } }
  ```

## 4. project.pbxproj へ自動登録（要バックアップ・要ビルド検証）
**先に `cp SetteiSaCountApp.xcodeproj/project.pbxproj /tmp/pbxproj_<prefix>.bak`。**
既存の機種モジュール（例 karakuri2）のエントリ群を**パターンの手本**にして、新 prefix 用の同型エントリを追加する。各エントリには `uuidgen | tr -d '-' | head -c 24 | tr a-f A-F` 等で**一意な24桁HEX GUID**を生成（pbxproj内に未出現を確認）。必要GUID：各 .swift に FileReference+BuildFile（5×2）、アセットに FileReference+BuildFile（2）、グループ1 = 計13。
追加箇所（karakuri2 の該当行の直後に同型挿入が安全）：
- **PBXBuildFile section**：5 swift（`... in Sources ...`）＋ アセット（`<prefix>Assets.xcassets in Resources`）。
- **PBXFileReference section**：5 swift（`sourcecode.swift`）＋ アセット（`lastKnownFileType = folder.assetcatalog; path = <prefix>Assets.xcassets;`）。
- **PBXGroup**：新グループ `<GRP> /* <prefix> */ = { isa = PBXGroup; children = ( 5 swift FR, アセット FR ); path = <prefix>; sourceTree = "<group>"; };` を追加し、**karakuri2 グループを子に持つ親グループ**の children に `<GRP> /* <prefix> */,` を追加。
- **PBXSourcesBuildPhase**：5 swift の BuildFile を追加。
- **PBXResourcesBuildPhase**：アセットの BuildFile を追加。

## 5. 既存ファイルへ配線
- **commonVar.swift**
  - `initMachine` 配列の**先頭**（`[` の直後）に：
    `Machine(id: "<id>", name: "<name>", fullName: "<fullName>", iconName: "<prefix>MachineIcon", btBadge: <btBadge>, maker: "<maker>"),`
  - バッジ@AppStorage（ハナハナ等の並びの近くに）：
    ```swift
    // ---- <fullName>
    @AppStorage("<prefix>MenuNormalBadge") var <prefix>MenuNormalBadge: String = "none"
    @AppStorage("<prefix>MenuFirstHitBadge") var <prefix>MenuFirstHitBadge: String = "none"
    @AppStorage("<prefix>MenuBayesBadge") var <prefix>MenuBayesBadge: String = "none"
    @AppStorage("<prefix>MenuScreenBadge") var <prefix>MenuScreenBadge: String = "none"
    ```
  - **開発中バージョンの `verNNNNFirstLaunch()`**（最新版。現状 `ver410FirstLaunch`。MARKETING_VERSION と一致するもの）の `if isVersionCompare(...)` ブロック内に：
    `machines.updateMachineBadgeStatus(id: "<id>", newStatus: "new")`
    rewardLock=true なら加えて：`machines.updateMachineIsUnlocked(id: "<id>", isUnlocked: false)`
- **ContentViewVer2.swift**：`getLinkView(for:)` の `switch id {` 直後に
  `case "<id>": return AnyView(<prefix>ViewTop())`

## 6. 検証・報告
- `xcodebuild -scheme SetteiSaCountApp -destination 'generic/platform=iOS Simulator' -configuration Debug build` で `** BUILD SUCCEEDED **`。失敗時は pbxproj をバックアップから復元して原因報告。
- ビルド成功後、ユーザーに「**Xcodeで `<prefix>MachineIcon` の imageset に機種アイコンPNGを配置してください**」と案内。
- トロフィー系リンク・注意事項セクションをメーカー法則で追加/省略した旨を報告（この機種固有で法則と異なる場合は手動で調整可、と案内）。
- 提案コミットメッセージ：`[機能]新機種 <fullName>(id:<id>) を追加`（末尾に `Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>`）。**コミットはユーザー指示後**。

## 注意
- pbxproj はファイル追加＝GUID生成を伴うため必ずバックアップ＋ビルド検証。失敗時は復元。
- 雛形のコメントアウト部・空のList/メモ関数は意図的（後の機能実装で埋める）。削らない。
- カウント処理・テーブル・Bayes・95Ciチャートの中身は本スキルでは作らない（雛形のみ）。実装は機種ごとに別途。
