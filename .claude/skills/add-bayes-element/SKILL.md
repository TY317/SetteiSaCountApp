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

### 対数尤度関数（`SetteiSaCountApp/Common/bayes/func/`）
| func | 引数 | 用途 |
|---|---|---|
| `logPostDenoBino` | `ratio: [Double], Count: Int, bigNumber: Int` | 分母表記・二項（単一事象） |
| `logPostPercentBino` | `ratio: [Double], Count: Int, bigNumber: Int` | %表記・二項 |
| `logPostDenoMulti` | `countList: [Int], denoList: [[Double]], bigNumber: Int` | 分母表記・多項（複数カテゴリ） |
| `logPostPercentMulti` | `countList: [Int], ratioList: [[Double]], bigNumber: Int` | %表記・多項 |

## 2. 4箇所へ挿入（アンカーコメント基準・字下げ厳守）

**(A) @State**：`let payoutList …` 行の直後（字下げ4スペース）
```swift
    @State var <suffix>Enable: Bool = true
```

**(B) STEP2 トグル**：アンカー `// ここに小役確率など機種固有の判別要素トグルを後で追加する` の直後（字下げ16スペース）
```swift
                // <title>
                unitToggleWithQuestion(enable: self.$<suffix>Enable, title: "<title>")
```

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

## 3. 検証・報告
- `xcodebuild -scheme SetteiSaCountApp -destination 'generic/platform=iOS Simulator' -configuration Debug build` で `** BUILD SUCCEEDED **`。
- 提案コミットメッセージ：`[機能]<prefix> 設定期待値ページに判別要素を追加`（末尾に `Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>`）。**コミットはユーザー指示後**。
- 案内：引数に使うカウント変数（`firstHitCount*` / `normalGame` 等）・ratio 配列は Class 側に存在が前提。無ければ先に用意（add-firsthit 等）。

## 注意
- 4箇所すべてに挿入しないと動かない（トグルだけ／尤度だけの片手落ちに注意）。特に **(D) logPostSum への追加を忘れない**（忘れると計算に反映されない）。
- アンカーコメントは add-bayes 生成の全 ViewBayes に必ず存在。字下げは既存トロフィーブロックに合わせる。
- 本スキルは判別要素の配線のみ。Class 側のカウント変数・ratio 配列、トロフィー/事前確率（add-bayes）はスコープ外。
