---
name: add-bayes-element
description: 既存の設定期待値(ベイズ)ページ <prefix>ViewBayes.swift に、カウントベースの判別要素(小役確率・初当り確率など)を1つ以上追加する。@Stateトグル・STEP2トグル・bayesRatioの対数尤度・logPostSum合算の4箇所へ生成する。対数尤度関数(logPostDenoBino/logPostDenoMulti/logPostPercentBino/logPostPercentMulti)と引数は都度ユーザー入力。add-bayes 後の高頻度な定番作業。「ベイズに判別要素を追加」「設定判別に小役確率を追加」等で起動。SetteiSaCountApp 専用。
---

# ベイズ判別要素の追加

`add-bayes` 生成の設定期待値ページ（`<prefix>ViewBayes.swift`＝トロフィー＋事前確率のスケルトン）に、カウントベースの**判別要素**（小役確率・初当り確率・終了画面など）を1つずつ足していく高頻度作業。1要素につき **4箇所**へ挿入する。参照実装：単一事象=`sencole6ViewBayes`（AT初当り＝`logPostDenoBino`）、多項=`vvv2ViewBayes`（終了画面＝`logPostPercentMulti`）。

## 1. 質問（都度・1要素ごと。複数要素は繰り返し）
- **prefix**：対象機種（`SetteiSaCountApp/<prefix>/<prefix>ViewBayes.swift` 存在前提＝add-bayes 済み）。
- **title**：トグル表示名＝コメント文言（例 `AT初当り確率`）。
- **suffix**：var 識別子（camelCase、例 `firstHitAt`）。→ Enable変数 `<suffix>Enable`、対数尤度変数 `logPost<Suffix>`（`<Suffix>`＝suffix先頭大文字）。
- **func**：対数尤度関数を選択（下表）。
- **引数**：選んだ関数のシグネチャに沿って各引数の式を入力（例 `ratio: <prefix>.ratioFirstHitAt` の右辺）。カウント/ratio 変数は Class 側に存在する前提（無ければ add-firsthit 等で先に用意）。
- **説明ボタンの有無**：トグルに注意書きシート（`unitExView5body2image`）を付けるか。付ける場合は文言（textBody…）を確認。→ (B') 参照。終了画面など「確定系のみ反映」系で多用。
- **トグルの挿入位置**：まず対象 ViewBayes の `bayesSubStep2Section { … }` を読み、**既存トグルを上から順に一覧提示**（`// <title>` コメント／`unitToggleWithQuestion(enable: self.$<suffix>Enable, …)` で識別）。そのうえでユーザーに位置を確認する。指定形式：
  - 「〈既存トグル〉の**直後**」／「〈既存トグル〉の**直前**」
  - 「**先頭**」（STEP2 の最初のトグルの前＝アンカーコメント直後）
  - 「**末尾**」（トロフィー DisclosureGroup の直前。トロフィーが無ければ Section 末尾）
  - **既定は設けない。毎回必ずユーザーに確認する**（未指定のまま挿入しない）。判別要素は表示順が使い勝手に直結するため。
  - **トロフィー DisclosureGroup は常に最下部を維持**（その後ろには挿入しない）。

### 対数尤度関数（`SetteiSaCountApp/Common/bayes/func/`）
| func | 引数 | 用途 |
|---|---|---|
| `logPostDenoBino` | `ratio: [Double], Count: Int, bigNumber: Int` | 分母表記・二項（単一事象） |
| `logPostPercentBino` | `ratio: [Double], Count: Int, bigNumber: Int` | %表記・二項 |
| `logPostDenoMulti` | `countList: [Int], denoList: [[Double]], bigNumber: Int` | 分母表記・多項（複数カテゴリ） |
| `logPostPercentMulti` | `countList: [Int], ratioList: [[Double]], bigNumber: Int` | %表記・多項 |

### 1.5 多項（Multi）を使うときの必須ルール：必ず1カテゴリ除外する

`logPostDenoMulti` / `logPostPercentMulti` は「渡していないカテゴリ」を残余バケット（`pOther = 1 − Σ渡した確率` / `otherCount = bigNumber − Σ渡したカウント`）として自動で扱う。**この仕組みを必ず使う。**

1. **全カテゴリを渡してはいけない。必ず1つ（以上）を除外する。**
   - 除外する優先順位：
     1. **全設定で同値のカテゴリ**（設定判別情報を持たないので、何個落としても損失ゼロ）
     2. 全設定同値が無ければ、**デフォルト（先頭）のカテゴリを1つ**（多項分布の標準的な再パラメータ化。1つだけなら残余バケットが完全に再現するので損失ゼロ）
   - **2つ以上の「設定によって変動する」カテゴリをまとめて落とすと情報が失われる**ので不可。
2. **設定別の合計を検算する。** 全カテゴリの振分け率を設定ごとに足し、報告に含める。
   - **合計が100%ちょうどでも除外する**（この運用に統一）。理由は下記。
   - 100%ちょうどにならない表（1/256系を小数1桁に丸めたもの。例：99.6〜100.5%）は、除外しないと**丸め誤差がそのまま設定間のバイアスになる**。
3. **除外後、各設定で `1 − Σ残り` が十分な正値であること**を確認する（0以下だと `max(_, 0.0)` に落ちて壊れる）。
4. **`bigNumber` は全カテゴリの合計（`<element>CountSum`）のまま維持する。** ここが残余カウントの供給源。除外に合わせて減らしてはいけない。
5. 除外した行にはコメントを残す：`// 新月（デフォルト）は残余バケットに吸収させるため除外`

**なぜ「100%ちょうどでも除外」に統一するのか**：
- 合計が s_i（設定i）のとき対数尤度に実質 `n · log(s_i)` が乗る。s=1.005 と s=0.996 ならカウント100回で約2.5倍の根拠のない差がつき、カウントが増えるほど指数的に悪化する（参照：`bioRe3ViewBayes` 規定ネメシスポイント）。
- 100%ちょうどなら `pOther = 0` / `otherCount = 0` となりバイアスは出ないが、**「毎回合計を検算して分岐する」運用は丸めの見落としで事故る**。常に1つ除外しておけば、合計がいくつでも正規化が定義上ちょうど1になり、この事故が構造的に起きない。
- 1カテゴリの除外は情報損失ゼロなので、除外して困ることはない。

**`countList` と `ratioList` のインデックス対応**：除外するとカテゴリ番号が飛ぶ（例 `pointNormalCount7` ↔ `ratioPointNormal350`）。両配列の要素数と並び順が一致しているか必ず検算する。

## 2. 4箇所へ挿入（アンカーコメント基準・字下げ厳守）

**(A) @State**：`let payoutList …` 行の直後（字下げ4スペース）
```swift
    @State var <suffix>Enable: Bool = true
```

**(B) STEP2 トグル**：**手順1で確定した挿入位置**に入れる（字下げ16スペース）
```swift
                // <title>
                unitToggleWithQuestion(enable: self.$<suffix>Enable, title: "<title>")
```
**アンカーの決め方**（手順1の指定に応じて）：
- 「〈既存トグル〉の**直後**」→ 対象トグルの行（`unitToggleWithQuestion(...)`。説明ボタン付きなら閉じ `}` まで）の直後に挿入。
- 「〈既存トグル〉の**直前**」→ 対象トグルの `// <title>` コメントの直前に挿入。
- 「**先頭**」→ アンカーコメント `// ここに小役確率など機種固有の判別要素トグルを後で追加する` の直後に挿入。
- 「**末尾**」→ トロフィー `DisclosureGroup` の直前（トロフィーが無ければ `bayesSubStep2Section` の閉じ `}` の直前）に挿入。
- アンカーコメント行自体は**残す**（次回以降の目印）。add-bayes 以前の手書き ViewBayes にはアンカーが無い場合があり、その時は既存トグルの並びを基準にする。

**(B') 説明ボタン付きトグル（任意・要素ごとに確認）**：終了画面など「確定系のみ反映」等の注意書きを付けたい要素では、`unitToggleWithQuestion` に末尾クロージャで説明シート `unitExView5body2image` を付ける。付けるか・文言（textBody1…）は都度ユーザーに確認。
```swift
                // <title>
                unitToggleWithQuestion(enable: self.$<suffix>Enable, title: "<title>") {
                    unitExView5body2image(
                        title: "<title>",
                        textBody1: "<説明文1>",
                    )
                }
```
- `unitExView5body2image`（`SetteiSaCountApp/Common/unitView/myViewUnit.swift`）：`title` 必須、`textBody1`〜`textBody5`／`image1Title`/`image1`/`image2Title`/`image2`/`tableView` は任意。行数・画像は要素に応じて増やす。定番文言：`・確定系のみ反映させます`。
- 参考実装：`karakuri2ViewBayes`（AT終了画面）、`kerottoViewBayes`（BIG終了画面）。

**(C) bayesRatio 対数尤度**：アンカー `// ここに小役確率など機種固有の対数尤度を後で追加し、下の logPostSum に足す` の直後（字下げ8スペース）
```swift
        // <title>
        var logPost<Suffix>: [Double] = [Double](repeating: 0, count: self.settingList.count)
        if self.<suffix>Enable {
            logPost<Suffix> = <func>(
                <引数を1行ずつ・字下げ16>
            )
        }
```
引数の並び（func別）：
- Bino：`ratio: …,` / `Count: …,` / `bigNumber: …`
- DenoMulti：`countList: …,` / `denoList: …,` / `bigNumber: …`
- PercentMulti：`countList: …,` / `ratioList: …,` / `bigNumber: …`

**(D) logPostSum 合算**：アンカー `let logPostSum: [Double] = arraySumDouble([` の直後（字下げ12スペース）
```swift
            logPost<Suffix>,
```

複数要素の場合は各要素について (A)〜(D) を順に挿入する。

**(A)(C)(D) の順序について**：ユーザーに確認するのは **(B) のトグル位置だけ**（画面の表示順＝使い勝手に直結するため）。(A) @State・(C) 対数尤度・(D) 合算は**順序が挙動に影響しない**ので確認不要。ただし読みやすさのため、可能なら (B) で決めた並びに合わせる。

## 3. 検証・報告
- **ビルド検証は行わない**（既存Swiftの編集のみ。フルビルドは add-machine のみ／`xcodebuild` はおよそ10分。方針：`skill-build-verify-policy`）。コンパイル確認はユーザーのコミット前ビルドに委ねる。報告時に「ビルド検証は省略」と一言添える。
- 提案コミットメッセージ：`[機能]<prefix> 設定期待値ページに判別要素を追加`（末尾に `Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>`）。**コミットはユーザー指示後**。
- 案内：引数に使うカウント変数（`firstHitCount*` / `normalGame` 等）・ratio 配列は Class 側に存在が前提。無ければ先に用意（add-firsthit 等）。

## 注意
- 4箇所すべてに挿入しないと動かない（トグルだけ／尤度だけの片手落ちに注意）。特に **(D) logPostSum への追加を忘れない**（忘れると計算に反映されない）。
- アンカーコメントは add-bayes 生成の ViewBayes には存在する（add-bayes 以前の手書き実装＝karakuri2/shinYoshi 等には無いので、既存要素の並びを基準に挿入する）。字下げは既存トロフィーブロックに合わせる。
- **(B) のトグル挿入位置は毎回ユーザーに確認する**（手順1）。既存トグルの一覧を提示してから聞くこと。
- 本スキルは判別要素の配線のみ。Class 側のカウント変数・ratio 配列、トロフィー/事前確率（add-bayes）はスコープ外。
- **終了画面・キャラ・ボイス・枠などの「確定系（濃厚／否定）」を反映する場合は `add-bayes-confirmed` を使う。** 示唆ラベルから `ratio<Element>Over<N>` / `Negate<N>` を生成する前段込みで一連に処理する。本スキルは ratio 配列が既にある前提の汎用配線。
