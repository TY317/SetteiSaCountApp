---
name: add-firsthit
description: 機種の「初当り」ページを雛形の空Listから実データ入力ページへ実装する。Class に normalGame/ratioFirstHit<Type>/firstHitCount<Type> を追加、ViewFirstHit にゲーム数入力＋カウントボタン＋初当り確率テーブル＋95Ci/設定期待値リンクを生成、View95Ci に種類別グラフセクション、ViewTop の設定推測グラフ selection を配線する。初当りの種類（AT/CZ/ボーナス等）と ratioFirstHit の値は都度ユーザー入力。新機種追加後の定番作業。「初当りページを実装」「初当りを追加」等で起動。SetteiSaCountApp 専用。
---

# 初当りページの実装

新機種の「初当り」ページ（`<prefix>ViewFirstHit.swift`）を、雛形の空 `List{}` から実データ入力ページへ実装する定番作業。4ファイル（Class / ViewFirstHit / View95Ci / ViewTop）を横断編集する。**初当りの種類は機種ごとに様々**（AT のみ／CZ＋AT／CZ＋ボーナス＋ST 等）。追加する種類の構成と各 `ratioFirstHit<Type>` の値は都度ユーザーに質問する。参照実装：`sencole6`（AT のみ）、`tekken6`（CZ/ボーナス/AT の多種）。

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
                        selection: 2,
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

## 4. View95Ci 編集（`<prefix>View95Ci.swift`）
`TabView(selection: self.$selection) {` 内のコメントアウトされた placeholder セクション群（`// 回数`/`CZ初当り回数`/`AT初当り回数` 等）を**丸ごと削除**し、種類ごとに以下を生成。**tag は 2 から連番**（先頭種類=2）。各セクション間は空行1つ：
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
「設定推測グラフ」の `NavigationLink(destination: <prefix>View95Ci(... selection: X))` の `selection:` を **2**（先頭種類のタグ）に更新。

## 6. 検証・報告
- `xcodebuild -scheme SetteiSaCountApp -destination 'generic/platform=iOS Simulator' -configuration Debug build` で `** BUILD SUCCEEDED **`。
- 提案コミットメッセージ：`[機能]<prefix> 初当りページを実装`（末尾に `Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>`）。**コミットはユーザー指示後**。
- 案内：
  - ratio 値・種類名（label）・色は実機仕様に合わせて調整可。
  - **5/4段階設定の機種**は `ratioFirstHit` 配列長と `unitChart95CiDenominate` の setting 引数（雛形は setting1〜6 の6段階前提）を手動調整。
  - ViewBayes 未作成（add-bayes 未実施）なら ViewFirstHit の `unitNaviLinkBayes` ブロックを外す。

## 注意
- `normalGame` と `resetFirstHit()` 内 `normalGame = 0` は**1回だけ**（種類ぶん重複させない）。
- View95Ci の tag は 2 始まり（tag 1 相当の通常時 percent グラフは本スキルでは生成しない）。ViewTop・ViewFirstHit の `selection:` は先頭タグ 2 に合わせる。
- 生成コードは sencole6（単一種）/ tekken6（多種）の実装と同型。カウント処理・小役確率・レア役停止系（add-koyaku-pattern）・Bayes 本体（add-bayes）はスコープ外。
