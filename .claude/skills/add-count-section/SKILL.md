---
name: add-count-section
description: 既存ページに判別要素のカウントセクションを1つ追加する。Class に ratio<Element>/カウント変数/SumFunc/reset を追加し、View に「確率結果＋参考情報テーブルを常時表示、カウントボタンと95Ci・設定期待値リンクは DisclosureGroup に格納」の定型セクションを生成、View95Ci にグラフを追加する。要素名・カウント方式（率／確率）・ratio値・ボタンのラベルと色は都度ユーザー入力。「カウント機能を追加」「カウントセクションを追加」「〇〇率のカウントを付けて」等で起動。SetteiSaCountApp 専用。
---

# カウントセクションの追加

既存ページ（`<prefix>View<Page>.swift`）に、**判別要素のカウント機能を1セクション**追加する定番作業。Class の変数追加から View のセクション生成、95Ci グラフまでを一連で行う。

終了画面・キャラ選択のような「N択の画像/選択肢を数える」ものは対象外（→ `add-screen` / `add-circle-count`）。本スキルは**成功率・出現率・確率といった 1〜2 個のカウンタで表す判別要素**が対象。

参照実装：`gareiViewCz`（乱撃突入率）、`karakuri2ViewNormal`（通常 強🍒からの当選）。

## 1. 質問（都度）

- **prefix** と **対象ページ**（`SetteiSaCountApp/<prefix>/<prefix>View<Page>.swift`）。既存セクションを読んで**挿入位置を確認**する。
- **要素名 `<Element>`**（PascalCase。例 `CzRangeki` / `KyoCherryHit`）→ 変数名は `ratio<Element>` / `<element>Count*`。
- **セクション名**（日本語。ヘッダー・参考情報シートのタイトル・95Ci のグラフ名に使う。例「乱撃突入率」）。
- **カウント方式**（→ 手順2・3で分岐）：

  | 方式 | 内容 | 変数 | 結果表示 | 95Ciグラフ |
  |---|---|---|---|---|
  | **A. 率（2ボタン）** | 成功と失敗を別々に数え、合計を分母にする | `<element>CountHit` / `<element>CountMiss` / `<element>CountSum` ＋ `<element>SumFunc()` | `unitResultRatioPercent2Line` | `unitChart95CiPercent` |
  | **B. 率（1ボタン）** | 分母が**既存の別カウント**（小役回数など） | `<element>Count` のみ | `unitResultRatioPercent2Line` | `unitChart95CiPercent` |
  | **C. 確率（1ボタン）** | 分母がゲーム数（`gameNumberPlay` / `normalGame`） | `<element>Count` のみ | `unitResultRatioDenomination2Line` | `unitChart95CiDenominate` |

- **ratio 値**：設定1〜6（機種の `settingList` に合わせる）。**判明していない設定は `-1`**（テーブルは「?」表示、グラフ側も崩れない作りになっている）。
  - 方式A・B は**パーセント**、方式C は**分母**。`1.6` のような値はどちらにも読めるので、**曖昧なら必ずユーザーに確認する**。
- **ボタンのラベルと色**（方式Aは2個）。色は `.personalSummerLightRed` / `Blue` / `Green` / `Purple` / `.personalSpringLightYellow` / `Brown` / `.personalAutumLightOrange` のパレットから。
- **参考情報シートの注意書き**（1行。例「・超自然災害モード突入時の乱撃突入率に設定差あり」）。不要なら省略可。
- **リセット関数**：そのページ用の `reset<Page>()` が既にあるか確認。無ければ新設し、`resetAll()` にも追加する。
- **設定期待値（ベイズ）リンクを DisclosureGroup に入れるか**：**全設定の ratio が判明している場合のみ**入れる。`-1` が混じっている要素はベイズに載せられないので**リンクも置かない**（あっても計算に反映されず混乱するため）。

## 2. Class 編集（`<prefix>Class.swift`）

そのページ用の区切りブロックに追加する。無ければブロックごと新設（`resetNormal()` の後など、ページの並び順に合わせた位置）：

```swift

    // -------
    // <ページ名>
    // -------
    let ratio<Element>: [Double] = [<値>]
    @AppStorage("<prefix><Element>CountMiss") var <element>CountMiss: Int = 0
    @AppStorage("<prefix><Element>CountHit") var <element>CountHit: Int = 0
    @AppStorage("<prefix><Element>CountSum") var <element>CountSum: Int = 0

    func <element>SumFunc() {
        <element>CountSum = <element>CountHit + <element>CountMiss
    }

    func reset<Page>() {
        <element>CountMiss = 0
        <element>CountHit = 0
        <element>CountSum = 0
        minusCheck = false
    }
```

- **方式B・C は `CountMiss` / `CountSum` / `SumFunc()` を作らない**（分母が既存変数なので不要）。カウント変数は `<element>Count` 1本。
- `reset<Page>()` を新設したら **`resetAll()` への追加を忘れない**。
- 既存の `reset<Page>()` に足す場合は、カウント変数の 0 クリア行だけ追記する（`minusCheck = false` は既存のものを使う）。

## 3. View セクションの生成（定型レイアウト）

**この並び順が現行の既定。** 確率結果と参考情報は常時表示、操作系は畳む：

```swift
            // ---- <セクション名>
            Section {
                // <結果のタイトル>
                unitResultRatioPercent2Line(
                    title: "<結果のタイトル>",
                    count: $<prefix>.<element>CountHit,
                    bigNumber: $<prefix>.<element>CountSum,
                    numberofDicimal: 1
                )

                // 参考情報）<セクション名>
                unitLinkButtonViewBuilder(sheetTitle: "<セクション名>") {
                    Text("・<注意書き>")
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "<セクション名>",
                            percentList: <prefix>.ratio<Element>,
                            numberofDicimal: 1,
                        )
                    }
                }

                // カウント
                DisclosureGroup {
                    // カウントボタン横並び
                    HStack {
                        // <ラベル1>
                        unitCountButtonWithoutRatioWithFunc(
                            title: "<ラベル1>",
                            count: $<prefix>.<element>CountMiss,
                            color: <色1>,
                            minusBool: $<prefix>.minusCheck) {
                                <prefix>.<element>SumFunc()
                            }
                        // <ラベル2>
                        unitCountButtonWithoutRatioWithFunc(
                            title: "<ラベル2>",
                            count: $<prefix>.<element>CountHit,
                            color: <色2>,
                            minusBool: $<prefix>.minusCheck) {
                                <prefix>.<element>SumFunc()
                            }
                    }

                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            <prefix>View95Ci(
                                <prefix>: <prefix>,
                                selection: <TAG>,
                            )
                        )
                    )

                    // //// 設定期待値へのリンク       ← 全設定判明時のみ
                    unitNaviLinkBayes {
                        <prefix>ViewBayes(
                            <prefix>: <prefix>,
                        )
                    }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("<セクション名>")
            }
```

**方式による差し替え**：
- **方式C**：結果表示を `unitResultRatioDenomination2Line(title:count:bigNumber:numberofDicimal:)`、参考情報を `unitTableDenominate(columTitle:denominateList:numberofDicimal:)` に。
- **方式B・C**：`HStack` 内のボタンは1個、クロージャは空 `{ }`（`SumFunc` が無いので呼ばない）。
- **ボタンのクロージャで `SumFunc()` を呼ぶのは方式Aだけ。** ここを忘れると `CountSum` が更新されず、結果表示も 95Ci も常に 0 のままになる。

### 3b. 超高頻度で成立する要素は DisclosureGroup を使わない（例外レイアウト）

**方式C（分母がゲーム数）で、確率の分母が 1/10 前後以下の超高頻度の小役**（例：ベル・プラム・ぶどう等。同じセクションに並べる他の小役も含めてまとめて）は、1ゲームごとに押すことになるので、毎回 DisclosureGroup を開く手間が大きい。この場合は次の形にする。参考実装：`takosloViewNormal`（小役・小役詳細）。

- **DisclosureGroup を使わない**。カウントボタンをセクション内に常時表示する。
- ボタンは `unitCountButtonDenominateWithFunc`（ボタン上に確率を表示する版。`bigNumber:` にゲーム数、`numberofDicimal:` を渡す）。確率はボタン上に出るので、**`unitResultRatioDenomination2Line` の結果行は置かない**。
- 並び順：カウントボタン（HStack）→ 参考情報（`unitLinkButtonViewBuilder`）→ 95Ci リンク → 設定期待値リンク。
- **ゲーム数入力（打ち始め／現在／プレイ数）はカウントセクションから外し、独立した「ゲーム数入力」セクションにする**（複数のカウントセクションで共有するため）。このときキーボードを閉じる `ToolbarItem(placement: .keyboard)` の「完了」ボタンをツールバーに入れる（add-firsthit の手順3b と同じ）。

```swift
            // ---- <セクション名>
            Section {
                // カウントボタン横並び（常時表示）
                HStack {
                    // <ラベル>
                    unitCountButtonDenominateWithFunc(
                        title: "<ラベル>",
                        count: $<prefix>.<element>Count,
                        color: <色>,
                        bigNumber: $<prefix>.gameNumberPlay,
                        numberofDicimal: <桁数>,
                        minusBool: $<prefix>.minusCheck) {
                        }
                }

                // 参考情報）<セクション名>
                unitLinkButtonViewBuilder(sheetTitle: "<セクション名>") { … }

                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci( … )

                // //// 設定期待値へのリンク（全設定判明時のみ）
                unitNaviLinkBayes { … }
            } header: {
                Text("<セクション名>")
            }
```

判断に迷う頻度（1/10〜1/20 程度）の場合はユーザーに確認する。それより低頻度の要素（レア役・CZ・初当り等）は通常どおり手順3の DisclosureGroup レイアウト。

**ページのツールバー**：そのページに `unitButtonMinusCheck` / `unitButtonReset` がまだ無ければ追加する（`add-page` のスケルトンはツールバー無しで生成される）：

```swift
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $<prefix>.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: <prefix>.reset<Page>)
            }
        }
```

## 4. View95Ci にグラフを追加（`<prefix>View95Ci.swift`）

**tag は既存の有効な（コメントアウトされていない）`.tag(n)` の最大値＋1**。`grep -n "\.tag(" <prefix>View95Ci.swift` で確認し、`//` 付きの行は数えない。この `<TAG>` を手順3の `selection:` に入れる。

```swift

            // <セクション名>
            unitListSection95Ci(
                grafTitle: "<セクション名>",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $<prefix>.<element>CountHit,
                        bigNumber: $<prefix>.<element>CountSum,
                        setting1Percent: <prefix>.ratio<Element>[0],
                        …
                        setting6Percent: <prefix>.ratio<Element>[5]
                    )
                )
            )
            .tag(<TAG>)
```

方式C は `unitChart95CiDenominate` ＋ `setting1Denominate:` 系、分母はゲーム数変数。

## 5. ベイズ（全設定判明時のみ）

`ratio<Element>` に `-1` が無い場合だけ、`add-bayes-element` の手順で判別要素を追加する。使う関数：

- 方式A・B（率）→ `logPostPercentBino(ratio:Count:bigNumber:)`
- 方式C（確率）→ `logPostDenoBino(ratio:Count:bigNumber:)`

`-1` が1つでもあれば**ベイズには追加しない**（手順3のリンクも置かない）。

## 6. 検証・報告

- **フルビルドは行わない**（`xcodebuild` はおよそ10分かかるため add-machine のみ。方針：`skill-build-verify-policy`）。`xcrun swiftc -parse` で編集した各ファイルの構文チェックを行う。新規ファイルを作らないので pbxproj は無変更。
- 報告時に「フルビルド検証は省略（構文チェック済み／コミット前ビルドに委ねる）」と一言添える。
- 次を検算して報告する：
  1. 方式Aなら**全カウントボタンのクロージャで `SumFunc()` を呼んでいる**こと
  2. `reset<Page>()` に新しいカウント変数が入っており、`resetAll()` からも呼ばれていること
  3. 95Ci の `<TAG>` が既存 tag と衝突していないこと、`selection:` と一致していること
- 提案コミットメッセージ：`[機能]<prefix> <セクション名>のカウントを実装`（末尾に `Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>`）。**コミットはユーザー指示後**。

## 注意

- **結果表示と参考情報は常時表示、カウントボタン・リンク類は DisclosureGroup に隠す。** これが現行の既定レイアウト。古い機種には全部展開しているものもあるが真似しない。
  - **例外：分母が 1/10 前後以下の超高頻度の小役は DisclosureGroup を使わない**（手順3b）。毎ゲーム押すボタンを畳むと操作が煩わしいため。
- **`-1` は「非公開」の意味**で、テーブルでは「?」と表示される（`unitTableDenominate` / `unitTablePercent` が対応済み）。0 は「-」表示なので混同しない。
- 変数名は `ratio<Element>` / `<element>Count*` / `<element>SumFunc()` で統一する。同一機種内で `<Element>` が衝突しないよう、ページ名を含めた名前にする（例 `CzRangeki`）。
- メモリー同期（Memory1/2/3 への反映）は本スキルのスコープ外＝別途 `sync-memory`。
