//
//  tokyoGhoulViewTsukiyama.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/22.
//

import SwiftUI

struct tokyoGhoulViewTsukiyama: View {
    @ObservedObject var ver352: Ver352
//    @ObservedObject var tokyoGhoul = TokyoGhoul()
    @ObservedObject var tokyoGhoul: TokyoGhoul
    @State var isShowAlert = false
    
    var body: some View {
        List {
            Section {
                // //// サークルピッカー
                Picker(selection: $tokyoGhoul.selectedTsukiyama) {
                    ForEach(tokyoGhoul.selectListTsukiyama, id: \.self) { tsukiyama in
                        Text(tsukiyama)
                    }
                } label: {
                    
                }
                .pickerStyle(.wheel)
                .frame(height: 120)
                // //// 選択されているボイスのカウント表示
                // 残りゲーム数示唆
                if tokyoGhoul.selectedTsukiyama == tokyoGhoul.selectListTsukiyama[2] {
                    unitResultCountListPercent(
                        title: "残りG数示唆",
                        count: $tokyoGhoul.tsukiyamaCountRemainGame,
                        flashColor: .blue,
                        bigNumber: $tokyoGhoul.tsukiyamaCountSum
                    )
                }
                // 偶数示唆
                else if tokyoGhoul.selectedTsukiyama == tokyoGhoul.selectListTsukiyama[3] {
                    unitResultCountListPercent(
                        title: "偶数示唆",
                        count: $tokyoGhoul.tsukiyamaCountGusu,
                        flashColor: .yellow,
                        bigNumber: $tokyoGhoul.tsukiyamaCountSum
                    )
                }
                // 設定1否定
                else if tokyoGhoul.selectedTsukiyama == tokyoGhoul.selectListTsukiyama[4] {
                    unitResultCountListPercent(
                        title: "設定1否定",
                        count: $tokyoGhoul.tsukiyamaCountNot1,
                        flashColor: .cyan,
                        bigNumber: $tokyoGhoul.tsukiyamaCountSum
                    )
                }
                // 設定2否定
                else if tokyoGhoul.selectedTsukiyama == tokyoGhoul.selectListTsukiyama[5] {
                    unitResultCountListPercent(
                        title: "設定2否定",
                        count: $tokyoGhoul.tsukiyamaCountNot2,
                        flashColor: .orange,
                        bigNumber: $tokyoGhoul.tsukiyamaCountSum
                    )
                }
                // 設定3否定
                else if tokyoGhoul.selectedTsukiyama == tokyoGhoul.selectListTsukiyama[6] {
                    unitResultCountListPercent(
                        title: "設定3否定",
                        count: $tokyoGhoul.tsukiyamaCountNot3,
                        flashColor: .green,
                        bigNumber: $tokyoGhoul.tsukiyamaCountSum
                    )
                }
                // 設定4否定
                else if tokyoGhoul.selectedTsukiyama == tokyoGhoul.selectListTsukiyama[7] {
                    unitResultCountListPercent(
                        title: "設定4否定",
                        count: $tokyoGhoul.tsukiyamaCountNot4,
                        flashColor: .pink,
                        bigNumber: $tokyoGhoul.tsukiyamaCountSum
                    )
                }
                // 設定4以上濃厚
                else if tokyoGhoul.selectedTsukiyama == tokyoGhoul.selectListTsukiyama[8] {
                    unitResultCountListPercent(
                        title: "設定4 以上濃厚",
                        count: $tokyoGhoul.tsukiyamaCountOver4,
                        flashColor: .red,
                        bigNumber: $tokyoGhoul.tsukiyamaCountSum
                    )
                }
                // 設定6濃厚
                else if tokyoGhoul.selectedTsukiyama == tokyoGhoul.selectListTsukiyama[9] {
                    unitResultCountListPercent(
                        title: "設定6 濃厚",
                        count: $tokyoGhoul.tsukiyamaCountOver6,
                        flashColor: .purple,
                        bigNumber: $tokyoGhoul.tsukiyamaCountSum
                    )
                }
                // デフォルト
                else {
                    unitResultCountListPercent(
                        title: "デフォルト",
                        count: $tokyoGhoul.tsukiyamaCountDefault,
                        flashColor: .gray,
                        bigNumber: $tokyoGhoul.tsukiyamaCountSum
                    )
                }
                
                // //// 登録ボタン
                Button {
                    // 残りゲーム数示唆
                    if tokyoGhoul.selectedTsukiyama == tokyoGhoul.selectListTsukiyama[2] {
                        tokyoGhoul.tsukiyamaCountRemainGame = countUpDown(minusCheck: tokyoGhoul.minusCheck, count: tokyoGhoul.tsukiyamaCountRemainGame)
                    }
                    // 偶数示唆
                    else if tokyoGhoul.selectedTsukiyama == tokyoGhoul.selectListTsukiyama[3] {
                        tokyoGhoul.tsukiyamaCountGusu = countUpDown(minusCheck: tokyoGhoul.minusCheck, count: tokyoGhoul.tsukiyamaCountGusu)
                    }
                    // 設定1否定
                    else if tokyoGhoul.selectedTsukiyama == tokyoGhoul.selectListTsukiyama[4] {
                        tokyoGhoul.tsukiyamaCountNot1 = countUpDown(minusCheck: tokyoGhoul.minusCheck, count: tokyoGhoul.tsukiyamaCountNot1)
                    }
                    // 設定2否定
                    else if tokyoGhoul.selectedTsukiyama == tokyoGhoul.selectListTsukiyama[5] {
                        tokyoGhoul.tsukiyamaCountNot2 = countUpDown(minusCheck: tokyoGhoul.minusCheck, count: tokyoGhoul.tsukiyamaCountNot2)
                    }
                    // 設定3否定
                    else if tokyoGhoul.selectedTsukiyama == tokyoGhoul.selectListTsukiyama[6] {
                        tokyoGhoul.tsukiyamaCountNot3 = countUpDown(minusCheck: tokyoGhoul.minusCheck, count: tokyoGhoul.tsukiyamaCountNot3)
                    }
                    // 設定4否定
                    else if tokyoGhoul.selectedTsukiyama == tokyoGhoul.selectListTsukiyama[7] {
                        tokyoGhoul.tsukiyamaCountNot4 = countUpDown(minusCheck: tokyoGhoul.minusCheck, count: tokyoGhoul.tsukiyamaCountNot4)
                    }
                    // 設定4以上濃厚
                    else if tokyoGhoul.selectedTsukiyama == tokyoGhoul.selectListTsukiyama[8] {
                        tokyoGhoul.tsukiyamaCountOver4 = countUpDown(minusCheck: tokyoGhoul.minusCheck, count: tokyoGhoul.tsukiyamaCountOver4)
                    }
                    // 設定6濃厚
                    else if tokyoGhoul.selectedTsukiyama == tokyoGhoul.selectListTsukiyama[9] {
                        tokyoGhoul.tsukiyamaCountOver6 = countUpDown(minusCheck: tokyoGhoul.minusCheck, count: tokyoGhoul.tsukiyamaCountOver6)
                    }
                    // デフォルト
                    else {
                        tokyoGhoul.tsukiyamaCountDefault = countUpDown(minusCheck: tokyoGhoul.minusCheck, count: tokyoGhoul.tsukiyamaCountDefault)
                    }
                } label: {
                    HStack {
                        Spacer()
                        if tokyoGhoul.minusCheck == false {
                            Text("登録")
                                .fontWeight(.bold)
                                .foregroundStyle(Color.blue)
                        } else {
                            Text("マイナス")
                                .fontWeight(.bold)
                                .foregroundStyle(Color.red)
                        }
                        Spacer()
                    }
                }
            } header: {
                Text("文章選択")
            }
            
            // //// 参考情報セクション
            Section {
                // //// 参考情報リンク
                unitLinkButton(
                    title: "月山招待状での示唆について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "月山招待状",
                            textBody1: "・通常時50G消化毎に発生する演出",
                            textBody2: "・液晶左下に表示される",
                            textBody3: "・青、緑、赤文字はCZまでの残りゲーム数を示唆",
                            textBody4: "・一部のパターンで設定を示唆する",
                            tableView: AnyView(tokyoGhoulTableTsukiyama())
                        )
                    )
                )
                .popoverTip(tipVer352GhoulTsukiyama())
                unitLinkButton(
                    title: "通常時のモードについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "通常時のモード",
                            textBody1: "・6種類のモードで規定ゲーム数の抽選テーブルを管理",
                            textBody2: "・モード移行契機はCZ失敗時",
                            textBody3: "・天国以外は転落なし",
                            tableView: AnyView(tokyoGhoulTableModeTable())
                        )
                    )
                )
            }
            // //// カウント結果表示
            Section {
                // デフォルト
                unitResultCountListPercent(
                    title: "デフォルト",
                    count: $tokyoGhoul.tsukiyamaCountDefault,
                    flashColor: .gray,
                    bigNumber: $tokyoGhoul.tsukiyamaCountSum
                )
                // 残りゲーム数示唆
                unitResultCountListPercent(
                    title: "残りG数示唆",
                    count: $tokyoGhoul.tsukiyamaCountRemainGame,
                    flashColor: .blue,
                    bigNumber: $tokyoGhoul.tsukiyamaCountSum
                )
                // 偶数示唆
                unitResultCountListPercent(
                    title: "偶数示唆",
                    count: $tokyoGhoul.tsukiyamaCountGusu,
                    flashColor: .yellow,
                    bigNumber: $tokyoGhoul.tsukiyamaCountSum
                )
                // 設定1否定
                unitResultCountListPercent(
                    title: "設定1否定",
                    count: $tokyoGhoul.tsukiyamaCountNot1,
                    flashColor: .cyan,
                    bigNumber: $tokyoGhoul.tsukiyamaCountSum
                )
                // 設定2否定
                unitResultCountListPercent(
                    title: "設定2否定",
                    count: $tokyoGhoul.tsukiyamaCountNot2,
                    flashColor: .orange,
                    bigNumber: $tokyoGhoul.tsukiyamaCountSum
                )
                // 設定3否定
                unitResultCountListPercent(
                    title: "設定3否定",
                    count: $tokyoGhoul.tsukiyamaCountNot3,
                    flashColor: .green,
                    bigNumber: $tokyoGhoul.tsukiyamaCountSum
                )
                // 設定4否定
                unitResultCountListPercent(
                    title: "設定4否定",
                    count: $tokyoGhoul.tsukiyamaCountNot4,
                    flashColor: .pink,
                    bigNumber: $tokyoGhoul.tsukiyamaCountSum
                )
                // 設定4以上濃厚
                unitResultCountListPercent(
                    title: "設定4 以上濃厚",
                    count: $tokyoGhoul.tsukiyamaCountOver4,
                    flashColor: .red,
                    bigNumber: $tokyoGhoul.tsukiyamaCountSum
                )
                // 設定6濃厚
                unitResultCountListPercent(
                    title: "設定6 濃厚",
                    count: $tokyoGhoul.tsukiyamaCountOver6,
                    flashColor: .purple,
                    bigNumber: $tokyoGhoul.tsukiyamaCountSum
                )
            } header: {
                Text("カウント結果")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($ver352.tokyoGhoulMenuTsukiyamaBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "東京喰種",
                screenClass: screenClass
            )
        }
        .navigationTitle("月山招待状での示唆")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $tokyoGhoul.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: tokyoGhoul.resetTsukiyama)
//                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    tokyoGhoulViewTsukiyama(
        ver352: Ver352(),
        tokyoGhoul: TokyoGhoul()
    )
}
