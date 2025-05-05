//
//  danvineViewVoice.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/12/31.
//

import SwiftUI

struct danvineViewVoice: View {
//    @ObservedObject var danvine = Danvine()
    @ObservedObject var danvine: Danvine
    @State var isShowAlert = false
    
    var body: some View {
        List {
            Section {
                // //// ボイスの説明
                Text("ST終了画面でPUSHボタンを押すとボイス発生")
                    .foregroundStyle(Color.secondary)
                    .font(.footnote)
                // //// サークルピッカー
                Picker(selection: $danvine.selectedVoice) {
                    ForEach(danvine.selectListVoice, id: \.self) { voice in
                        Text(voice)
                    }
                } label: {
                    
                }
                .pickerStyle(.wheel)
                .frame(height: 120)
                // //// 選択されているボイスのカウント表示
                // デフォルト
                if danvine.selectedVoice == danvine.selectListVoice[0] ||
                    danvine.selectedVoice == danvine.selectListVoice[1] ||
                    danvine.selectedVoice == danvine.selectListVoice[2] {
                    unitResultCountListPercent(
                        title: "デフォルト",
                        count: $danvine.voiceCountDefault,
                        flashColor: .gray,
                        bigNumber: $danvine.voiceCountSum
                    )
                }
                // 高設定示唆 弱
                else if danvine.selectedVoice == danvine.selectListVoice[3] {
                    unitResultCountListPercent(
                        title: "高設定示唆 弱",
                        count: $danvine.voiceCountHighJaku,
                        flashColor: .blue,
                        bigNumber: $danvine.voiceCountSum
                    )
                }
                // 高設定示唆 中
                else if danvine.selectedVoice == danvine.selectListVoice[4] {
                    unitResultCountListPercent(
                        title: "高設定示唆 中",
                        count: $danvine.voiceCountHighChu,
                        flashColor: .yellow,
                        bigNumber: $danvine.voiceCountSum
                    )
                }
                // 高設定示唆 強
                else if danvine.selectedVoice == danvine.selectListVoice[5] {
                    unitResultCountListPercent(
                        title: "高設定示唆 強\n設定2 以上濃厚",
                        count: $danvine.voiceCountHighKyo,
                        flashColor: .green,
                        bigNumber: $danvine.voiceCountSum
                    )
                }
                // 設定4 以上濃厚
                else if danvine.selectedVoice == danvine.selectListVoice[6] {
                    unitResultCountListPercent(
                        title: "設定4 以上濃厚",
                        count: $danvine.voiceCountOver4,
                        flashColor: .red,
                        bigNumber: $danvine.voiceCountSum
                    )
                }
                // 設定6 濃厚
                else if danvine.selectedVoice == danvine.selectListVoice[7] {
                    unitResultCountListPercent(
                        title: "設定6 濃厚",
                        count: $danvine.voiceCountOver6,
                        flashColor: .purple,
                        bigNumber: $danvine.voiceCountSum
                    )
                }
                // 引き戻し示唆
                else {
                    unitResultCountListPercent(
                        title: "引き戻し示唆",
                        count: $danvine.voiceCountComeBack,
                        flashColor: .gray,
                        bigNumber: $danvine.voiceCountSum
                    )
                }
                // //// 登録ボタン
                Button {
                    // デフォルト
                    if danvine.selectedVoice == danvine.selectListVoice[0] ||
                        danvine.selectedVoice == danvine.selectListVoice[1] ||
                        danvine.selectedVoice == danvine.selectListVoice[2] {
                        danvine.voiceCountDefault = countUpDown(minusCheck: danvine.minusCheck, count: danvine.voiceCountDefault)
                    }
                    // 高設定示唆 弱
                    else if danvine.selectedVoice == danvine.selectListVoice[3] {
                        danvine.voiceCountHighJaku = countUpDown(minusCheck: danvine.minusCheck, count: danvine.voiceCountHighJaku)
                    }
                    // 高設定示唆 中
                    else if danvine.selectedVoice == danvine.selectListVoice[4] {
                        danvine.voiceCountHighChu = countUpDown(minusCheck: danvine.minusCheck, count: danvine.voiceCountHighChu)
                    }
                    // 高設定示唆 強
                    else if danvine.selectedVoice == danvine.selectListVoice[5] {
                        danvine.voiceCountHighKyo = countUpDown(minusCheck: danvine.minusCheck, count: danvine.voiceCountHighKyo)
                    }
                    // 設定4 以上濃厚
                    else if danvine.selectedVoice == danvine.selectListVoice[6] {
                        danvine.voiceCountOver4 = countUpDown(minusCheck: danvine.minusCheck, count: danvine.voiceCountOver4)
                    }
                    // 設定6 濃厚
                    else if danvine.selectedVoice == danvine.selectListVoice[7] {
                        danvine.voiceCountOver6 = countUpDown(minusCheck: danvine.minusCheck, count: danvine.voiceCountOver6)
                    }
                    // 引き戻し示唆
                    else {
                        danvine.voiceCountComeBack = countUpDown(minusCheck: danvine.minusCheck, count: danvine.voiceCountComeBack)
                    }
                } label: {
                    HStack {
                        Spacer()
                        if danvine.minusCheck == false {
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
                Text("ボイス選択")
            }
            
            // //// カウント結果表示
            Section {
                // デフォルト
                unitResultCountListPercent(
                    title: "デフォルト",
                    count: $danvine.voiceCountDefault,
                    flashColor: .gray,
                    bigNumber: $danvine.voiceCountSum
                )
                // 高設定示唆 弱
                unitResultCountListPercent(
                    title: "高設定示唆 弱",
                    count: $danvine.voiceCountHighJaku,
                    flashColor: .blue,
                    bigNumber: $danvine.voiceCountSum
                )
                // 高設定示唆 中
                unitResultCountListPercent(
                    title: "高設定示唆 中",
                    count: $danvine.voiceCountHighChu,
                    flashColor: .yellow,
                    bigNumber: $danvine.voiceCountSum
                )
                // 高設定示唆 強
                unitResultCountListPercent(
                    title: "高設定示唆 強\n設定2 以上濃厚",
                    count: $danvine.voiceCountHighKyo,
                    flashColor: .green,
                    bigNumber: $danvine.voiceCountSum
                )
                // 設定4 以上濃厚
                unitResultCountListPercent(
                    title: "設定4 以上濃厚",
                    count: $danvine.voiceCountOver4,
                    flashColor: .red,
                    bigNumber: $danvine.voiceCountSum
                )
                // 設定6 濃厚
                unitResultCountListPercent(
                    title: "設定6 濃厚",
                    count: $danvine.voiceCountOver6,
                    flashColor: .purple,
                    bigNumber: $danvine.voiceCountSum
                )
                // 引き戻し示唆
                unitResultCountListPercent(
                    title: "引き戻し示唆",
                    count: $danvine.voiceCountComeBack,
                    flashColor: .gray,
                    bigNumber: $danvine.voiceCountSum
                )
            } header: {
                Text("カウント結果")
            }
        }
        .navigationTitle("ST終了ボイス")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $danvine.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: danvine.resetVoice)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    danvineViewVoice(danvine: Danvine())
}
