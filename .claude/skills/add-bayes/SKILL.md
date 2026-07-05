---
name: add-bayes
description: 機種に設定期待値(ベイズ設定判別)ページを追加する。<prefix>ViewBayes.swift を雛形から生成しpbxproj登録、<prefix>ViewTop のコメントアウト済み「設定期待値計算」リンクを有効化する。settingList/payoutList は都度ユーザー入力。設定6/5/4段階に対応。新機種追加時の定番作業。「設定判別ページを追加」「設定期待値を追加」「ベイズ追加」等で起動。SetteiSaCountApp 専用。
---

# 設定期待値（ベイズ判別）ページの追加

新機種に「設定期待値」ページ（`<prefix>ViewBayes.swift`）を追加する定番作業。**トロフィー＋事前確率のみのスケルトン**を生成し、小役確率などの判別要素は後でユーザーが追記する前提。雛形は `.claude/skills/add-bayes/templates/ViewBayes.swift.tmpl`。参考実装：6段階=`karakuri2ViewBayes`、5段階=`mt5ViewBayes`、4段階=`hanabiViewBayes`。

## 1. 質問（都度）
- **prefix**：対象機種（`SetteiSaCountApp/<prefix>/<prefix>ViewTop.swift` 存在前提＝先に add-machine 済み）。`Prefix`＝先頭大文字。
- **settingList**：設定段階（例 `1,2,3,4,5,6` / `1,2,4,5,6` / `1,2,5,6`）。`[Int]` 形に。
- **payoutList**：機種割（例 `97.7,98.8,101.2,104.3,110.5,114.9`）。**settingList と同数**の `[Double]`。

`N = settingList.count`（4/5/6想定）。

## 2. テンプレ生成（トークン置換）
`templates/ViewBayes.swift.tmpl` を以下置換して `SetteiSaCountApp/<prefix>/<prefix>ViewBayes.swift` に生成：
- `__prefix__`→prefix、`__Prefix__`→Prefix
- `__SETTINGLIST__`→ `[1, 2, ...]`、`__PAYOUTLIST__`→ `[97.7, 98.8, ...]`
- `__GUESS_DEFAULT__`→ `bayes.guess<N>Default`
- 以下4ブロックは **settingList から一般則で生成**（references と一致する規則）：

### __TROPHY_STATE__（@State トグル：settingList[1...] の各値 v）
各 `v` に1行（インデント4スペース×2＝8）：
```
        @State var over<v>Check: Bool = false
```

### __TROPHY_TOGGLES__（DisclosureGroup内、インデント20スペース）
各 `v`（settingList[1...]）に1行。title は仮（実トロフィー名に後で編集）：
```
                    unitToggleWithQuestion(enable: self.$over<v>Check, title: "設定<v>以上")
```

### __TROPHY_LOGIC__（bayesRatio内、インデント8スペース）
`k = 1..N-1` について、`v = settingList[k]`：
```
        if self.over<v>Check {
            logPostTrophy[0] = -Double.infinity
            ...（logPostTrophy[k-1] まで）
        }
```
（k番目のトグルは index 0..k-1 を -inf。例：3番目のトグルなら [0],[1],[2] を -inf）

### __SELECTED_GUESS__（switch内 case [0..4]、インデント8スペース）
```
        case bayes.guessPatternList[0]: return bayes.guess<N>Default
        case bayes.guessPatternList[1]: return bayes.guess<N>JugDefault
        case bayes.guessPatternList[2]: return bayes.guess<N>Evenly
        case bayes.guessPatternList[3]: return bayes.guess<N>Half
        case bayes.guessPatternList[4]: return bayes.guess<N>Quater
```
（[5..7] custom と default は雛形に既存）

**一般則の検証例**：6段階[1,2,3,4,5,6]→over2..6（5個）/ 5段階[1,2,4,5,6]→over2,4,5,6（4個）/ 4段階[1,2,5,6]→over2,5,6（3個）。karakuri2/mt5/hanabi と一致。

## 3. pbxproj 登録（1ターゲット）
`<prefix>ViewBayes.swift` は通常ビュー＝**1ターゲット**登録（koyakuPattern の様な2ターゲットにはしない）。
- `cp ...project.pbxproj /tmp/pbxproj_<prefix>bayes.bak`。
- 同じ `<prefix>` グループ内の兄弟（例 `<prefix>ViewNormal.swift`）の登録を手本に、GUIDを2つ生成（FR/BF）して：PBXFileReference 1行、PBXBuildFile 1行、`<prefix>`グループの children に1行、メインアプリの PBXSourcesBuildPhase に1行。
- 確認：`grep -c "<prefix>ViewBayes.swift in Sources"` が **2**（定義1＋Sources1）。

## 4. ViewTop 配線
`SetteiSaCountApp/<prefix>/<prefix>ViewTop.swift` の「// 設定期待値計算」のコメントアウトされた `NavigationLink(destination: <prefix>ViewBayes(...))` ブロックを**有効化**（各行頭の `//` を除去）。

## 5. 検証・報告
- ビルド成功（`xcodebuild -scheme SetteiSaCountApp -destination 'generic/platform=iOS Simulator' -configuration Debug build`）。失敗時は pbxproj をバックアップ復元して報告。
- 提案コミットメッセージ：`[機能]<prefix> 設定期待値ページを追加`（末尾に `Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>`）。**コミットはユーザー指示後**。
- ユーザー案内：「**トロフィーの title を実際のトロフィー名（銅/銀/金/虹 等）に編集**してください。小役確率など count ベースの判別要素は STEP2 のトグルと bayesRatio()・logPostSum に機種仕様で追記してください（本スキルはトロフィー＋事前確率のスケルトンのみ）」。

## 注意
- 段数で `bayesRatio` トロフィー部と `selectedGuess`（guess<N>*）が変わる。一般則は references（6=karakuri2 / 5=mt5 / 4=hanabi）と一致。
- 雛形は判別要素＝トロフィー＋事前確率のみ。count ベースの尤度（`logPostDenoBino`/`logPostPercentBino`/`logPostDenoMulti` 等）と Class への counts/ratios 追加は機能実装時に別途。
- pbxproj はバックアップ＋ビルド検証必須。
