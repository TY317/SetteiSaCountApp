---
name: add-firsthit
description: 機種の「初当り」ページを雛形の空Listから実データ入力ページへ実装する。最初に「新方式（履歴入力とカウント入力をページ先頭で切り替える2パターン）」か「旧方式（ゲーム数入力＋カウントボタンのみ）」かをユーザーに確認する。旧方式では Class に normalGame/ratioFirstHit<Type>/firstHitCount<Type> を追加、ViewFirstHit にゲーム数入力＋カウントボタン＋初当り確率テーブル＋95Ci/設定期待値リンクを生成、View95Ci に種類別グラフセクション、ViewTop の設定推測グラフ selection を配線する。初当りの種類（AT/CZ/ボーナス等）と ratioFirstHit の値は都度ユーザー入力。新機種追加後の定番作業。「初当りページを実装」「初当りを追加」等で起動。SetteiSaCountApp 専用。
---

# 初当りページの実装

新機種の「初当り」ページ（`<prefix>ViewFirstHit.swift`）を、雛形の空 `List{}` から実データ入力ページへ実装する定番作業。4ファイル（Class / ViewFirstHit / View95Ci / ViewTop）を横断編集する。**初当りの種類は機種ごとに様々**（AT のみ／CZ＋AT／CZ＋ボーナス＋ST 等）。追加する種類の構成と各 `ratioFirstHit<Type>` の値は都度ユーザーに質問する。参照実装：旧方式＝`sencole6`（AT のみ）、`tekken6`（CZ/ボーナス/AT の多種）。新方式＝`seiya`（`seiyaViewFirstHit` / `seiyaClass`、コミット 88d1fa7c）。

## 0. 方式の確認（毎回最初に聞く）
**新方式（既定・今後のスタンダード）で進めてよいかをユーザーに確認する。**

| 方式 | 内容 | 手順 |
|---|---|---|
| **新方式** | ページ先頭のセグメントピッカーで「履歴入力」と「カウント入力」を切り替える。履歴入力＝ゲーム数・種類・AT当否などを1件ずつ登録し、通常ゲーム数と初当り回数を自動算出。カウント入力＝通常ゲーム数の手動入力＋初当りのカウントボタン。選択中の方式の値で確率・95Ci・設定期待値を計算する | 手順1 → **手順7** |
| **旧方式** | ゲーム数入力＋カウントボタンのみ（従来どおり） | 手順1〜6 |

## 1. 質問（都度）
- **prefix**：対象機種（`SetteiSaCountApp/<prefix>/<prefix>ViewFirstHit.swift` 存在前提＝add-machine 済み）。`Prefix`＝先頭大文字。
- **初当り種類のリスト**（1つ以上）。各要素につき：
  - **Suffix**：var 名用の識別子（PascalCase）。例 `At` / `Cz` / `Bonus` / `St`。
  - **label**：表示名。例 `AT` / `CZ` / `ボーナス` / `ST`。
  - **color**：カウントボタン色。例 `.personalSummerLightRed`（他 `Green` / `Blue` / `Purple` / `Yellow` 等のパレット）。
  - **ratioFirstHit 値**：カンマ区切り。通常6段階＝6個（設定差なしは `-1` 埋め可）。例 `363.6,350.4,329.8,289.4,268.5,252.2`。
- **Bayesリンクを含めるか**：既定=含める。`SetteiSaCountApp/<prefix>/<prefix>ViewBayes.swift` が無ければ外す（add-bayes 未実施）。

種類の並び順＝質問で得た順。**先頭種類のタグ = 2**（後述）。

## 2. Class 編集（`<prefix>Class.swift`）
`// 初当り` ヘッダー（`// --------\n    // 初当り\n    // --------`）直下に挿入：
```swift
    let ratioFirstHit<Suffix>: [Double] = [<値>]          // ← 種類ごと1行
    @AppStorage("<prefix>NormalGame") var normalGame: Int = 0        // ← 1回だけ
    @AppStorage("<prefix>FirstHitCount<Suffix>") var firstHitCount<Suffix>: Int = 0   // ← 種類ごと1行
```
`resetFirstHit()` の中に追記（既存 `minusCheck = false` は残す）：
```swift
        normalGame = 0                      // ← 1回だけ
        firstHitCount<Suffix> = 0           // ← 種類ごと1行
```

## 3. ViewFirstHit 編集（`<prefix>ViewFirstHit.swift`）
`var body` の空 `List {\n\n        }` の中身を生成：
```swift
        List {
            // ゲーム数入力
            unitTextFieldNumberInputWithUnit(
                title: "通常ゲーム数",
                inputValue: $<prefix>.normalGame,
                unitText: "Ｇ",
            )
            .focused(self.$isFocused)

            // カウントボタン横並び
            HStack {
                // <label>                              ← 種類ごとに1ブロック
                unitCountButtonVerticalDenominate(
                    title: "<label>",
                    count: $<prefix>.firstHitCount<Suffix>,
                    color: <color>,
                    bigNumber: $<prefix>.normalGame,
                    numberofDicimal: 0,
                    minusBool: $<prefix>.minusCheck
                )
            }

            // 参考情報）初当り確率
            unitLinkButtonViewBuilder(sheetTitle: "初当り確率") {
                HStack(spacing: 0) {
                    unitTableSettingIndex()
                    unitTableDenominate(                  ← 種類ごとに1列
                        columTitle: "<label>",
                        denominateList: <prefix>.ratioFirstHit<Suffix>
                    )
                }
            }

            // //// 95%信頼区間グラフへのリンク
            unitNaviLink95Ci(
                Ci95view: AnyView(
                    <prefix>View95Ci(
                        <prefix>: <prefix>,
                        selection: <FIRST_TAG>,
                    )
                )
            )

            // //// 設定期待値へのリンク       ← Bayes含める場合のみ
            unitNaviLinkBayes {
                <prefix>ViewBayes(
                    <prefix>: <prefix>,
                )
            }
        }
```

### 3b. キーボード完了ボタン（`.toolbar` に追加）
ゲーム数入力（キーボード）を閉じるため、`<prefix>ViewFirstHit.swift` の既存 `.toolbar { … }` ブロック（マイナスチェック／リセットの ToolbarItem がある所）の**末尾に**、キーボード用 ToolbarItem を追加する（`isFocused` は雛形の `@FocusState var isFocused` を使用）：
```swift
            ToolbarItem(placement: .keyboard) {
                HStack {
                    Spacer()
                    Button(action: {
                        isFocused = false
                    }, label: {
                        Text("完了")
                            .fontWeight(.bold)
                    })
                }
            }
```

## 4. View95Ci 編集（`<prefix>View95Ci.swift`）
`TabView(selection: self.$selection) {` 内のコメントアウトされた placeholder セクション群（`// 回数`/`CZ初当り回数`/`AT初当り回数` 等）を**丸ごと削除**し、種類ごとに以下を生成。各セクション間は空行1つ：

### tag の採番（`<FIRST_TAG>` の決め方）
**既に有効化されている（コメントアウトされていない）`.tag(n)` の最大値 ＋1 から連番**にする。`grep -n "\.tag(" <prefix>View95Ci.swift` で確認し、`//` が付いた行は数えない。

- 雛形のまま（有効な tag が無い）＝ **2 から連番**。placeholder の tag 1 は通常時の percent グラフ用に空けておく慣習。
- **通常時の小役グラフ等を先に作っている機種は 2 始まりにならない。** 例：garei は小役5本＋重複2本で tag 1〜7 が埋まっていたため、初当りは **8 から**。既存 tag を上書きすると TabView のページが衝突するので必ず確認する。

`<FIRST_TAG>` ＝ 先頭種類の tag。手順3（ViewFirstHit）と手順5（ViewTop）の `selection:` はこの値に合わせる。
```swift
            // <label>初当り回数
            unitListSection95Ci(
                grafTitle: "<label>初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $<prefix>.firstHitCount<Suffix>,
                        bigNumber: $<prefix>.normalGame,
                        setting1Denominate: <prefix>.ratioFirstHit<Suffix>[0],
                        setting2Denominate: <prefix>.ratioFirstHit<Suffix>[1],
                        setting3Denominate: <prefix>.ratioFirstHit<Suffix>[2],
                        setting4Denominate: <prefix>.ratioFirstHit<Suffix>[3],
                        setting5Denominate: <prefix>.ratioFirstHit<Suffix>[4],
                        setting6Denominate: <prefix>.ratioFirstHit<Suffix>[5]
                    )
                )
            )
            .tag(<n>)
```

## 5. ViewTop 編集（`<prefix>ViewTop.swift`）
「設定推測グラフ」の `NavigationLink(destination: <prefix>View95Ci(... selection: X))` の `selection:` を `<FIRST_TAG>` に更新。

**ただし既存の有効な tag があった機種（＝`<FIRST_TAG>` が 2 でない場合）は、ViewTop を書き換えるかユーザーに確認する。** 先に作った通常時グラフを設定推測グラフの入口にしている可能性があるため、勝手に初当りへ飛ばさない。

## 6. 検証・報告（両方式共通）
- **ビルド検証は行わない**（既存Swiftの編集のみ。フルビルドは add-machine のみ／`xcodebuild` はおよそ10分。方針：`skill-build-verify-policy`）。コンパイル確認はユーザーのコミット前ビルドに委ねる。報告時に「ビルド検証は省略」と一言添える。
- 提案コミットメッセージ：`[機能]<prefix> 初当りページを実装`（末尾に `Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>`）。**コミットはユーザー指示後**。
- 案内：
  - ratio 値・種類名（label）・色は実機仕様に合わせて調整可。
  - **5/4段階設定の機種**は `ratioFirstHit` 配列長と `unitChart95CiDenominate` の setting 引数（雛形は setting1〜6 の6段階前提）を手動調整。
  - ViewBayes 未作成（add-bayes 未実施）なら ViewFirstHit の `unitNaviLinkBayes` ブロックを外す。

## 注意
- `normalGame` と `resetFirstHit()` 内 `normalGame = 0` は**1回だけ**（種類ぶん重複させない）。
- **View95Ci の tag は「既存の有効な tag の最大値＋1」から連番**（雛形のままなら 2 始まり）。着手前に `grep "\.tag("` で必ず確認する。ViewFirstHit の `selection:` は先頭タグに合わせる（ViewTop は手順5の注意を参照）。
- 旧方式の生成コードは sencole6（単一種）/ tekken6（多種）、新方式は seiya の実装と同型。カウント処理・小役確率・レア役停止系（add-koyaku-pattern）・Bayes 本体（add-bayes）はスコープ外。
- ゲーム数入力のキーボードを閉じる `.keyboard` ToolbarItem（「完了」ボタン）を `.toolbar` に必ず追加（step 3b）。

## 7. 新方式（履歴入力／カウント入力の切り替え）
手順0で新方式を選んだ場合。手順1の質問（種類・ratio・Bayes）に加えて、**履歴入力の項目**を確認する（add-history の質問と同じ）：
- 登録項目（例：ゲーム数、CZ種類、AT当否）と各選択肢。項目間の連動（例「AT直撃のときはAT当否＝当選1択」→ピッカーではなく `Color.secondary` の表示のみ、登録時も当選で固定）。
- **ゲーム数の数え方**：初当りごとにリセット（`arrayIntAllDataSum` で単純合計）か、AT当選まで累積（`arraySumPlayGameResetWordOne(resetWord: 当選)`。リセットされない行のゲーム数は `(123)` のグレー表示）か。
- 集計の対象（例：CZ合算＝CZ種類のうち直撃を除く合計、AT＝当否が当選の件数）。
- 区切り線（例：AT区間の先頭行の下を赤線。`atIntervalStartFlagList`）。
- 履歴表示で列幅に収まらない選択肢名は、文字を縮小せず短縮名の配列（`<kind>ShortList`）で表示する。

### 7a. Class
`// 初当り` ブロックに次を入れる（seiyaClass と同型）：
- `ratioFirstHit<Suffix>`、選択肢リスト、`inputGame` と各 `selected*`、履歴の `Data?` 配列（`<name>ArrayKey` とセット）。
- 履歴からの自動算出結果：`playGameSum` と `firstHitCount<Suffix>`。`addHistory()` / `removeLastHistory()` / `addRemoveCommon()`（算出）を実装。
- 入力方式：`let firstHitInputModeList: [String] = ["履歴入力", "カウント入力"]`、`@AppStorage("<prefix>FirstHitInputMode") var firstHitInputMode: String = "履歴入力"`。
- カウント入力用：`manualNormalGame` と `manualFirstHitCount<Suffix>`（履歴側とは別変数。切り替えても両方の値が残る）。
- 計算に使う値（get は方式で切り替え、set は空。`$<prefix>.active...` で Binding として渡すため）：
```swift
    var isHistoryInputMode: Bool {
        firstHitInputMode == firstHitInputModeList[0]
    }
    var activeNormalGame: Int {
        get { isHistoryInputMode ? playGameSum : manualNormalGame }
        set { }
    }
    var activeFirstHitCount<Suffix>: Int {          // ← 種類ごと
        get { isHistoryInputMode ? firstHitCount<Suffix> : manualFirstHitCount<Suffix> }
        set { }
    }
```
- `resetFirstHit()`：履歴配列の全削除＋`addRemoveCommon()`、`inputGame = 0`、`manualNormalGame = 0`、`manualFirstHitCount<Suffix> = 0`、`minusCheck = false`。**`firstHitInputMode` はリセットしない**（ユーザーの好みの設定）。

### 7b. ViewFirstHit
```
List {
    // 入力方式（セクションに入れず、ヘッダーなし・行背景を透明にして上部に置く）
    Picker("", selection: $<prefix>.firstHitInputMode) { ForEach(...) { Text($0) } }
        .pickerStyle(.segmented)
        .listRowBackground(Color.clear)

    if <prefix>.isHistoryInputMode {
        Section 履歴登録（ゲーム数・各ピッカー・登録ボタン、ヘッダーに ? ヘルプ）
        Section 履歴表示（新しい順、unitHeaderHistoryColumns、区切り線）
        Section 集計結果（通常ゲーム数の表示行 → unitResultRatioDenomination2Line を HStack で横並び → 参考情報 → 95Ci → 設定期待値）
    } else {
        Section カウント（通常ゲーム数の入力 → unitCountButtonVerticalDenominate を HStack で横並び → 参考情報 → 95Ci → 設定期待値）
    }

    unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
}
```
- カウント入力は**1セクションだけ**。確率はボタン上に出るので結果行は置かない。
- 履歴入力の集計結果の確率表示は、履歴側の変数（`firstHitCount<Suffix>` / `playGameSum`）をそのまま使う。
- ゲーム数入力は両方式とも `.focused($isFocused)`（同時に表示されないので Bool 1本でよい）。ツールバーに `.keyboard` の「完了」を追加（手順3b）。
- ツールバーのリセットは `resetFirstHit`。

### 7c. View95Ci・ViewBayes
- 95Ci の `currentCount` / `bigNumber` は **`$<prefix>.activeFirstHitCount<Suffix>` / `$<prefix>.activeNormalGame`**。tag の採番は手順4と同じ。
- ベイズは `logPostDenoBino(ratio: <prefix>.ratioFirstHit<Suffix>, Count: <prefix>.activeFirstHitCount<Suffix>, bigNumber: <prefix>.activeNormalGame)`。トグルの位置は CLAUDE.md の並び順ルール（初当りの位置。トロフィーは最下部）。
- ViewTop の設定推測グラフ `selection:` は手順5と同じ扱い。

### 7d. 報告で添えること
- 提案コミットメッセージ：`[機能]<prefix> 初当りページを実装（履歴入力／カウント入力）`。
- メモリー同期（`/sync-memory`）の対象：履歴の `Data?` 配列、`playGameSum` と `firstHitCount<Suffix>`（読み込み後も集計がずれないよう一緒に同期）、`firstHitInputMode`、`manualNormalGame`、`manualFirstHitCount<Suffix>`。`inputGame` と各 `selected*` は対象外。
