//
//  shamanKingViewEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/01.
//

import SwiftUI

struct shamanKingViewEnding: View {
    @ObservedObject var shamanKing = ShamanKing()
    @State var isShowAlert = false
    
    var body: some View {
        List {
            // //// エンディング開始時の文字色
            Section {
                unitLinkButton(
                    title: "Congratulationsの文字色について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "Congratulationsの文字色",
                            textBody1: "エンディング開始時のCongratulationsの文字色で設定を示唆",
                            image1: Image("shamanKingCongratulations")
                        )
                    )
                )
            } header: {
                Text("Congratulationsの文字色")
            }
            
            // //// レア子役成立時のキャラ
            Section {
                // //// サークルピッカー
                Picker(selection: $shamanKing.selectedEnding) {
                    ForEach(shamanKing.selectListEnding, id: \.self) { chara in
                        Text(chara)
                    }
                } label: {
                    
                }
                .pickerStyle(.wheel)
                .frame(height: 120)
                // //// 選択されているキャラのカウント表示
                // 偶数示唆　弱
                if shamanKing.selectedEnding == shamanKing.selectListEnding[1] {
                    unitResultCountListPercent(
                        title: "偶数示唆 弱",
                        count: $shamanKing.endingCountGusuJaku,
                        flashColor: .personalSpringLightYellow,
                        bigNumber: $shamanKing.endingCountSum
                    )
                }
                // 偶数示唆　強
                else if shamanKing.selectedEnding == shamanKing.selectListEnding[2] {
                    unitResultCountListPercent(
                        title: "偶数示唆 強",
                        count: $shamanKing.endingCountGusuKyo,
                        flashColor: .yellow,
                        bigNumber: $shamanKing.endingCountSum
                    )
                }
                // 奇数示唆　弱
                else if shamanKing.selectedEnding == shamanKing.selectListEnding[3] {
                    unitResultCountListPercent(
                        title: "奇数示唆 弱",
                        count: $shamanKing.endingCountKisuJaku,
                        flashColor: .personalSummerLightBlue,
                        bigNumber: $shamanKing.endingCountSum
                    )
                }
                // 奇数示唆　強
                else if shamanKing.selectedEnding == shamanKing.selectListEnding[4] {
                    unitResultCountListPercent(
                        title: "奇数示唆 強",
                        count: $shamanKing.endingCountKisuKyo,
                        flashColor: .blue,
                        bigNumber: $shamanKing.endingCountSum
                    )
                }
                // 設定２以上示唆
                else if shamanKing.selectedEnding == shamanKing.selectListEnding[5] {
                    unitResultCountListPercent(
                        title: "設定2 以上示唆",
                        count: $shamanKing.endingCountOver2Sisa,
                        flashColor: .cyan,
                        bigNumber: $shamanKing.endingCountSum
                    )
                }
                // 設定４以上示唆
                else if shamanKing.selectedEnding == shamanKing.selectListEnding[6] {
                    unitResultCountListPercent(
                        title: "設定4 以上示唆",
                        count: $shamanKing.endingCountOver4Sisa,
                        flashColor: .personalSummerLightGreen,
                        bigNumber: $shamanKing.endingCountSum
                    )
                }
                // 設定２以上
                else if shamanKing.selectedEnding == shamanKing.selectListEnding[7] {
                    unitResultCountListPercent(
                        title: "設定2 以上濃厚",
                        count: $shamanKing.endingCountOver2,
                        flashColor: .yellow,
                        bigNumber: $shamanKing.endingCountSum
                    )
                }
                // 設定4以上
                else if shamanKing.selectedEnding == shamanKing.selectListEnding[8] {
                    unitResultCountListPercent(
                        title: "設定4 以上濃厚",
                        count: $shamanKing.endingCountOver4,
                        flashColor: .green,
                        bigNumber: $shamanKing.endingCountSum
                    )
                }
                // 設定5以上
                else if shamanKing.selectedEnding == shamanKing.selectListEnding[9] {
                    unitResultCountListPercent(
                        title: "設定5 以上濃厚",
                        count: $shamanKing.endingCountOver5,
                        flashColor: .red,
                        bigNumber: $shamanKing.endingCountSum
                    )
                }
                // 設定6以上
                else if shamanKing.selectedEnding == shamanKing.selectListEnding[10] {
                    unitResultCountListPercent(
                        title: "設定6 濃厚",
                        count: $shamanKing.endingCountOver6,
                        flashColor: .purple,
                        bigNumber: $shamanKing.endingCountSum
                    )
                }
                // デフォルト
                else {
                    unitResultCountListPercent(
                        title: "デフォルト",
                        count: $shamanKing.endingCountDefault,
                        flashColor: .gray,
                        bigNumber: $shamanKing.endingCountSum
                    )
                }
                
                // //// 登録ボタン
                Button {
                    // 偶数示唆　弱
                    if shamanKing.selectedEnding == shamanKing.selectListEnding[1] {
                        shamanKing.endingCountGusuJaku = countUpDown(minusCheck: shamanKing.minusCheck, count: shamanKing.endingCountGusuJaku)
                    }
                    // 偶数示唆　強
                    else if shamanKing.selectedEnding == shamanKing.selectListEnding[2] {
                        shamanKing.endingCountGusuKyo = countUpDown(minusCheck: shamanKing.minusCheck, count: shamanKing.endingCountGusuKyo)
                    }
                    // 奇数示唆　弱
                    else if shamanKing.selectedEnding == shamanKing.selectListEnding[3] {
                        shamanKing.endingCountKisuJaku = countUpDown(minusCheck: shamanKing.minusCheck, count: shamanKing.endingCountKisuJaku)
                    }
                    // 奇数示唆　強
                    else if shamanKing.selectedEnding == shamanKing.selectListEnding[4] {
                        shamanKing.endingCountKisuKyo = countUpDown(minusCheck: shamanKing.minusCheck, count: shamanKing.endingCountKisuKyo)
                    }
                    // 設定２以上示唆
                    else if shamanKing.selectedEnding == shamanKing.selectListEnding[5] {
                        shamanKing.endingCountOver2Sisa = countUpDown(minusCheck: shamanKing.minusCheck, count: shamanKing.endingCountOver2Sisa)
                    }
                    // 設定４以上示唆
                    else if shamanKing.selectedEnding == shamanKing.selectListEnding[6] {
                        shamanKing.endingCountOver4Sisa = countUpDown(minusCheck: shamanKing.minusCheck, count: shamanKing.endingCountOver4Sisa)
                    }
                    // 設定２以上
                    else if shamanKing.selectedEnding == shamanKing.selectListEnding[7] {
                        shamanKing.endingCountOver2 = countUpDown(minusCheck: shamanKing.minusCheck, count: shamanKing.endingCountOver2)
                    }
                    // 設定4以上
                    else if shamanKing.selectedEnding == shamanKing.selectListEnding[8] {
                        shamanKing.endingCountOver4 = countUpDown(minusCheck: shamanKing.minusCheck, count: shamanKing.endingCountOver4)
                    }
                    // 設定5以上
                    else if shamanKing.selectedEnding == shamanKing.selectListEnding[9] {
                        shamanKing.endingCountOver5 = countUpDown(minusCheck: shamanKing.minusCheck, count: shamanKing.endingCountOver5)
                    }
                    // 設定6以上
                    else if shamanKing.selectedEnding == shamanKing.selectListEnding[10] {
                        shamanKing.endingCountOver6 = countUpDown(minusCheck: shamanKing.minusCheck, count: shamanKing.endingCountOver6)
                    }
                    // デフォルト
                    else {
                        shamanKing.endingCountDefault = countUpDown(minusCheck: shamanKing.minusCheck, count: shamanKing.endingCountDefault)
                    }
                } label: {
                    HStack {
                        Spacer()
                        if shamanKing.minusCheck == false {
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
                Text("レア役成立時のキャラ選択")
            }
            
            // //// キャラでの示唆カウント結果
            Section {
                // デフォルト
                unitResultCountListPercent(
                    title: "デフォルト",
                    count: $shamanKing.endingCountDefault,
                    flashColor: .gray,
                    bigNumber: $shamanKing.endingCountSum
                )
                
                // 偶数示唆　弱
                unitResultCountListPercent(
                    title: "偶数示唆 弱",
                    count: $shamanKing.endingCountGusuJaku,
                    flashColor: .personalSpringLightYellow,
                    bigNumber: $shamanKing.endingCountSum
                )
                // 偶数示唆　強
                unitResultCountListPercent(
                    title: "偶数示唆 強",
                    count: $shamanKing.endingCountGusuKyo,
                    flashColor: .yellow,
                    bigNumber: $shamanKing.endingCountSum
                )
                // 奇数示唆　弱
                unitResultCountListPercent(
                    title: "奇数示唆 弱",
                    count: $shamanKing.endingCountKisuJaku,
                    flashColor: .personalSummerLightBlue,
                    bigNumber: $shamanKing.endingCountSum
                )
                // 奇数示唆　強
                unitResultCountListPercent(
                    title: "奇数示唆 強",
                    count: $shamanKing.endingCountKisuKyo,
                    flashColor: .blue,
                    bigNumber: $shamanKing.endingCountSum
                )
                // 設定２以上示唆
                unitResultCountListPercent(
                    title: "設定2 以上示唆",
                    count: $shamanKing.endingCountOver2Sisa,
                    flashColor: .cyan,
                    bigNumber: $shamanKing.endingCountSum
                )
                // 設定４以上示唆
                unitResultCountListPercent(
                    title: "設定4 以上示唆",
                    count: $shamanKing.endingCountOver4Sisa,
                    flashColor: .personalSummerLightGreen,
                    bigNumber: $shamanKing.endingCountSum
                )
                // 設定２以上
                unitResultCountListPercent(
                    title: "設定2 以上濃厚",
                    count: $shamanKing.endingCountOver2,
                    flashColor: .yellow,
                    bigNumber: $shamanKing.endingCountSum
                )
                // 設定4以上
                unitResultCountListPercent(
                    title: "設定4 以上濃厚",
                    count: $shamanKing.endingCountOver4,
                    flashColor: .green,
                    bigNumber: $shamanKing.endingCountSum
                )
                // 設定5以上
                unitResultCountListPercent(
                    title: "設定5 以上濃厚",
                    count: $shamanKing.endingCountOver5,
                    flashColor: .red,
                    bigNumber: $shamanKing.endingCountSum
                )
                // 設定6以上
                unitResultCountListPercent(
                    title: "設定6 濃厚",
                    count: $shamanKing.endingCountOver6,
                    flashColor: .purple,
                    bigNumber: $shamanKing.endingCountSum
                )
            } header: {
                Text("カウント結果")
            }
        }
        .navigationTitle("エンディング")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $shamanKing.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: shamanKing.resetEnding)
                }
            }
        }
    }
}

#Preview {
    shamanKingViewEnding()
}
