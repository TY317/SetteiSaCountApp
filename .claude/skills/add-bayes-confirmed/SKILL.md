---
name: add-bayes-confirmed
description: 終了画面・キャラ・ボイス・枠などのカウント要素について、示唆ラベル（設定N以上濃厚／設定N濃厚／設定N否定）から確定系の振分け配列 ratio<Element>Over<N> / Negate<N> を Class に生成し、ベイズの判別要素（@Stateトグル・STEP2トグル・対数尤度・logPostSum）まで一連で配線する。示唆系（デフォルト/奇数/偶数/高設定示唆）は残余バケットに吸収させる。add-circle-count や add-screen でカウントを作った直後の定番作業。「確定系のベイズを追加」「濃厚系を設定期待値に反映」等で起動。SetteiSaCountApp 専用。
---

# 確定系（濃厚／否定）のベイズ判別要素を追加

`add-screen` / `add-circle-count` などで作ったカウント要素（`<element>Count1..N` ＋ `<element>CountSum`）を、設定期待値の判別要素に落とし込む定番作業。**示唆ラベルから振分け配列を導出する前段**があるのが `add-bayes-element`（汎用・引数を都度指定）との違い。

実績：`dropkick`（終了画面／小悪魔キャラ／TUCシール）、`streetFighter6`（終了画面／エンディング）、`tonskill`（エンディング枠）、`index2`、`otome5`、`kerotto` ほか25機種超。

## 0. 前提
- 対象要素の `<element>Count1..N` / `<element>CountSum` / `<element>SumFunc()` が Class に**既にある**こと（無ければ先に add-screen / add-circle-count）。
- `<prefix>ViewBayes.swift` が存在すること（無ければ先に add-bayes）。

## 1. 質問・情報収集（都度）
- **prefix** ＋ **要素名 `<Element>`**（例 `Screen` / `Chara` / `Ending` / `TucSeal`）。
- **各カウントの示唆ラベル一覧**（`<element>Count1` から順に N 個）。
  - **まず対象 View を読んで自動取得する**：`add-screen` 系なら `lowerBeltTextList`、`add-circle-count` 系なら `sisaList`。順序は `imageNameList` / `selectList` と 1:1 対応。
  - 読めた場合もユーザーに一覧を提示して確認する。
- **振分け率が判明しているか**（→ 手順3）。
- **トグルの表示名**（既定＝要素の日本語名。例「終了画面」「エンディング枠」「小悪魔ボーナス キャラ」）。
- **トグルの挿入位置**：既存トグルを上から一覧提示して**毎回確認**（トロフィー DisclosureGroup は常に最下部）。
- **説明ボタン**：確定系のみ反映するため**既定で付ける**（文言 `・確定系のみ反映させます`）。付けない指定があれば省略。

## 2. 示唆ラベル → 振分け配列の導出規則

`settingList`（通常6段階 `[1,2,3,4,5,6]`、機種により5段階等）の各設定について、**その設定で出現しうるなら埋め値 `f`、出現しないなら `0`**。

| 示唆ラベル | 変数名 | 配列（6段階の例） |
|---|---|---|
| 設定2 以上濃厚 | `ratio<Element>Over2` | `[0,f,f,f,f,f]` |
| 設定3 以上濃厚 | `ratio<Element>Over3` | `[0,0,f,f,f,f]` |
| 設定4 以上濃厚 | `ratio<Element>Over4` | `[0,0,0,f,f,f]` |
| 設定5 以上濃厚 | `ratio<Element>Over5` | `[0,0,0,0,f,f]` |
| 設定6 濃厚 | `ratio<Element>Over6` | `[0,0,0,0,0,f]` |
| 設定1 否定 | `ratio<Element>Negate1` | `[0,f,f,f,f,f]` |
| 設定2 否定 | `ratio<Element>Negate2` | `[f,0,f,f,f,f]` |
| 設定3 否定 | `ratio<Element>Negate3` | `[f,f,0,f,f,f]` |
| 設定1・3 否定 | `ratio<Element>Negate13` | `[0,f,0,f,f,f]` |

- **「設定N 濃厚」＝ N のみ非0**。最上位設定の「設定6 濃厚」は `Over6` と同義になる（既存機種もこの名前で統一）。
- 複数設定の否定は数字を並べる（`Negate13`）。
- **対象外＝示唆系**：`デフォルト` / `奇数示唆` / `偶数示唆` / `高設定示唆 弱・強` など。これらは配列を作らず、**残余バケットに吸収させる**（手順5）。
- 5段階・4段階の機種は `settingList` の要素数に合わせる（例 smasloEnen は5要素）。

## 3. 埋め値 `f` の決め方（重要）

**実際の振分け率が判明していればそれを使う**（最善）。判明していなければ**全カテゴリ共通で `0.1`**（近年の慣例。dropkick / streetFighter6 / tonskill / index2 / otome5 が 0.1）。

**なぜ小さい値にするのか**：`logPostPercentMulti` の残余項 `otherCount * log(pOther)` に効くため、埋め値は「確定系がまだ出ていない」ことをどれだけ高設定否定の証拠として扱うかを決めてしまう。

設定 i の合計を `s_i` とすると `pOther_i = 1 - s_i`。確定系を1回も引いていない状態でカウントが n 回あると、対数尤度の差は概ね `n × (s_6 - s_1)` になる。

| 埋め値 | 例（Over2/4/5/6 の4本＝設定6の合計） | n=100 での設定1 対 設定6 の偏り |
|---|---|---|
| 0.1% | 0.4% | 約1.5倍 |
| 1.0%（古い機種の慣例） | 4.0% | 約55倍 |

**古い機種にある `f = 1` はそのまま真似しない。** モデル上は正しい推論だが、埋め値が実測でない以上、強すぎる証拠を作ってしまう。

**全設定 0 の配列は作らない**（`jormungand` の `ratioCharaOver2/4/6` が該当）。カウントされた瞬間に全設定が同じだけ排除され、判別に寄与しないうえ意図が読めない。

## 4. Class への挿入（`<prefix>Class.swift`）

対象要素の `@AppStorage("<prefix><Element>Count1")` の**直前**に、確定系の配列をまとめて挿入する（区切りコメントの直下）。並び順は `<element>Count` のインデックス昇順に合わせる。

```swift
    // --------
    // <要素の日本語名>
    // --------
    let ratio<Element>Over4: [Double] = [0,0,0,0.1,0.1,0.1,]
    let ratio<Element>Over6: [Double] = [0,0,0,0,0,0.1,]
    @AppStorage("<prefix><Element>Count1") var <element>Count1: Int = 0
    …
```

## 5. 尤度関数の選択

| 確定系の個数 | 使う関数 | 引数 |
|---|---|---|
| **2つ以上** | `logPostPercentMulti` | `countList:` / `ratioList:` / `bigNumber:` |
| **1つだけ** | `logPostPercentBino` | `ratio:` / `Count:` / `bigNumber:` |

- **`countList` / `ratioList` には確定系だけを渡す。** 示唆系は渡さない＝残余バケット（`pOther = 1 − Σ渡した確率`、`otherCount = bigNumber − Σ渡したカウント`）が自動で吸収する。
- **`bigNumber` は必ず `<element>CountSum`（全カテゴリの合計）。** 確定系だけの合計に変えてはいけない。ここが残余カウントの供給源。
- **インデックス対応に注意**：確定系だけを抜き出すとカウント番号が飛ぶ（例 tonskill：`endingCount5` ↔ `ratioEndingOver4`、`endingCount6` ↔ `ratioEndingOver6`）。両配列の要素数と並び順を必ず検算する。
- どちらの関数も `log(p + epsilon)` の形なので、`p = 0` でも NaN にならず「実質排除」として機能する（`log(1e-12) ≒ -27.6` が観測回数ぶん加算される）。

参考：確定系1つだけの実例＝`streetFighter6ViewBayes` のエンディング（`logPostPercentBino`）。

## 6. ベイズ4箇所への配線（`<prefix>ViewBayes.swift`）

挿入の作法（アンカー・字下げ）は `add-bayes-element` の手順2に準じる。**4箇所すべて**に入れること。

**(A) @State**（`let payoutList …` の直後）
```swift
    @State var <element>Enable: Bool = true
```

**(B) STEP2 トグル**（手順1で確定した位置。説明ボタン付きが既定）
```swift
                // <トグル表示名>
                unitToggleWithQuestion(enable: self.$<element>Enable, title: "<トグル表示名>") {
                    unitExView5body2image(
                        title: "<トグル表示名>",
                        textBody1: "・確定系のみ反映させます"
                    )
                }
```

**(C) 対数尤度**（`bayesRatio()` 内。トロフィーの直前が読みやすい）
```swift
        // <トグル表示名>
        // 確定系（<該当ラベル>）のみ渡し、示唆系は残余バケットに吸収させる
        var logPost<Element>: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.<element>Enable {
            logPost<Element> = logPostPercentMulti(
                countList: [
                    <prefix>.<element>Count<k>,
                    …
                ],
                ratioList: [
                    <prefix>.ratio<Element>Over<N>,
                    …
                ],
                bigNumber: <prefix>.<element>CountSum
            )
        }
```

**(D) logPostSum 合算**
```swift
            logPost<Element>,
```

## 7. 検証・報告
- **ビルド検証は行わない**（既存Swiftの編集のみ。フルビルドは add-machine のみ／`xcodebuild` はおよそ10分。方針：`skill-build-verify-policy`）。報告時に「ビルド検証は省略」と一言添える。
- 次を必ず検算して報告する：
  1. `countList` と `ratioList` の**要素数が一致**し、**対応が正しい**（カウント番号 ↔ 示唆ラベル）
  2. **設定別の合計と `pOther`**（`1 − 合計`）。全設定で `pOther` が十分な正値であること（0以下だと `max(_, 0.0)` に落ちて壊れる）
  3. 4箇所すべてに挿入されている（特に (D) を忘れない）
- 提案コミットメッセージ：`[機能]<prefix> <要素名>を設定期待値に反映`（末尾に `Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>`）。**コミットはユーザー指示後**。

## 注意
- **示唆系（デフォルト／奇数／偶数／高設定示唆）は絶対に `ratioList` に入れない。** 振分け率が判明していない限り推測値を置くことになり、判別を歪める。残余バケットに任せる。
- 示唆系まで含めて全カテゴリを渡す場合は**別の話**（振分け率が全部判明しているケース）。そのときは `add-bayes-element` の「1.5 多項（Multi）を使うときの必須チェック」に従い、設定別合計の検算と全設定同値カテゴリの除外を行う。
- 要素名は Class の変数名（`<element>Count*`）と揃える。`ratio<Element>*` の `<Element>` は先頭大文字。
- 汎用の判別要素（小役確率・初当り確率など、カウントと分母が対になるもの）は本スキルではなく `add-bayes-element`。
