---
name: ad-mode
description: AdMob広告をテスト/本番で一括切替する。バナー/インタースティシャル/リワードの広告ユニットID、Info.plistのGADApplicationIdentifier、LINEメディエーションのtestModeをまとめて test または prod に切替。引数 test|prod。「広告をテストにして」「本番広告に戻して」「リリース前に広告を本番へ」等で起動。SetteiSaCountApp 専用。
---

# 広告のテスト/本番 一括切替

開発中はテスト広告、リリース前は本番広告に戻す作業を一括で行う。引数 `test`（テスト）/ `prod`（本番）。無ければ尋ねる。

## 対象と値（本番=`2339669527176370` / テスト=`3940256099942544`＝Googleサンプル）
| 箇所 | ファイル | テスト | 本番 |
|---|---|---|---|
| バナー adUnitID | `SetteiSaCountApp/ContentView.swift` | `ca-app-pub-3940256099942544/2435281174` | `ca-app-pub-2339669527176370/9695161925` |
| インタースティシャル | `SetteiSaCountApp/InterstitialViewModelClass.swift` | `ca-app-pub-3940256099942544/4411468910` | `ca-app-pub-2339669527176370/6732998451` |
| リワード | `SetteiSaCountApp/rewardViewModelClass.swift` | `ca-app-pub-3940256099942544/1712485313` | `ca-app-pub-2339669527176370/8540059247` |
| アプリID `GADApplicationIdentifier` | `SetteiSaCountApp/Info.plist` | `ca-app-pub-3940256099942544~1458002511` | `ca-app-pub-2339669527176370~9351077809` |
| LINEメディエーション testMode | `SetteiSaCountApp/SetteiSaCountAppApp.swift` | `GADMediationAdapterLine.testMode = true`（有効） | 同行をコメントアウト |

## 手順
1. 引数 `test` / `prod` を確認。
2. **banner / interstitial / reward の3 .swift**：各ファイルに「テスト用」「本番用」の2行ペアがあり、`//` の付け替えで切替。対象モードの行を有効（先頭の `//` を外す）、もう一方をコメントアウトする。**有効行は必ず1本だけ**にする。
3. **Info.plist**：`GADApplicationIdentifier` の `<string>` を対象モードのアプリIDに置換。
4. **SetteiSaCountAppApp.swift**：
   - `test` → `GADMediationAdapterLine.testMode = true` を有効化（行頭 `//` を外す）。
   - `prod` → 同行をコメントアウト（`//        GADMediationAdapterLine.testMode = true`）。
5. **検証**：
   - `grep -rn "ca-app-pub" SetteiSaCountApp --include="*.swift"` で**有効行（先頭が `//` でない行）のIDが全てモード一致**（test=`3940256099942544`、prod=`2339669527176370`）であること。コメント行の逆IDは残ってよい。
   - Info.plist の `GADApplicationIdentifier` もモード一致。
   - ビルド成功（`xcodebuild -scheme SetteiSaCountApp -destination 'generic/platform=iOS Simulator' -configuration Debug build`）。
6. **報告**（コミットはユーザー指示後）。提案コミットメッセージ：`[調整]広告をテストに切替` / `[調整]広告を本番に戻す`。

## 注意
- **prod に戻し忘れるとテスト広告で出荷＝無収益**。リリース（審査提出）前は必ず `prod` に切替えて実機確認すること。prod 切替時はその旨を強調して報告。
- 既存の2行ペア/コメント形式は維持（行の追加削除ではなく `//` の付け替えで切替）。
