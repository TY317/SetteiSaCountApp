//
//  lupinSingleBonusVoice.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/12/12.
//

import SwiftUI

struct lupinSingleBonusVoice: View {
//    @ObservedObject var lupin = Lupin()
    @ObservedObject var lupin: Lupin
    @State var isShowAlert = false
    
    var body: some View {
        List {
            Section {
                // //// ボイスの説明
                Text("AT非当選のボーナス終了時にPUSHを押すと発生")
                    .foregroundStyle(Color.secondary)
                    .font(.footnote)
                // //// サークルピッカー
                Picker(selection: $lupin.selectedBonusVoice) {
                    ForEach(lupin.selectListBonusVoice, id:  \.self) { voice in
                        Text(voice)
                    }
                } label: {
                    
                }
                .pickerStyle(.wheel)
                .frame(height: 120)
                // //// 選択されているボイスのカウント表示
                // デフォルト
                if lupin.selectedBonusVoice == lupin.selectListBonusVoice[0] ||
                    lupin.selectedBonusVoice == lupin.selectListBonusVoice[1] ||
                    lupin.selectedBonusVoice == lupin.selectListBonusVoice[2] {
                    unitResultCountListPercent(
                        title: "デフォルト",
                        count: $lupin.bonusVoiceCountDefault,
                        flashColor: .gray,
                        bigNumber: $lupin.bonusVoiceCountSum
                    )
                }
                // 高設定示唆 弱
                else if lupin.selectedBonusVoice == lupin.selectListBonusVoice[3] ||
                            lupin.selectedBonusVoice == lupin.selectListBonusVoice[4] ||
                            lupin.selectedBonusVoice == lupin.selectListBonusVoice[5] {
                    unitResultCountListPercent(
                        title: "高設定示唆 弱",
                        count: $lupin.bonusVoiceCountHighSisaJaku,
                        flashColor: .blue,
                        bigNumber: $lupin.bonusVoiceCountSum
                    )
                }
                // 高設定示唆 強
                else if lupin.selectedBonusVoice == lupin.selectListBonusVoice[6] ||
                            lupin.selectedBonusVoice == lupin.selectListBonusVoice[7] ||
                            lupin.selectedBonusVoice == lupin.selectListBonusVoice[8] {
                    unitResultCountListPercent(
                        title: "高設定示唆 強",
                        count: $lupin.bonusVoiceCountHighSisaKyo,
                        flashColor: .yellow,
                        bigNumber: $lupin.bonusVoiceCountSum
                    )
                }
                // 設定4 以上濃厚
                else if lupin.selectedBonusVoice == lupin.selectListBonusVoice[9] ||
                            lupin.selectedBonusVoice == lupin.selectListBonusVoice[10] ||
                            lupin.selectedBonusVoice == lupin.selectListBonusVoice[11] {
                    unitResultCountListPercent(
                        title: "設定4 以上濃厚",
                        count: $lupin.bonusVoiceCountOver4,
                        flashColor: .green,
                        bigNumber: $lupin.bonusVoiceCountSum
                    )
                }
                // 設定6 濃厚
                else if lupin.selectedBonusVoice == lupin.selectListBonusVoice[12] ||
                            lupin.selectedBonusVoice == lupin.selectListBonusVoice[13] ||
                            lupin.selectedBonusVoice == lupin.selectListBonusVoice[14] {
                    unitResultCountListPercent(
                        title: "設定6 濃厚",
                        count: $lupin.bonusVoiceCount6kaku,
                        flashColor: .red,
                        bigNumber: $lupin.bonusVoiceCountSum
                    )
                }
                // //// 登録ボタン
                Button {
                    // デフォルト
                    if lupin.selectedBonusVoice == lupin.selectListBonusVoice[0] ||
                        lupin.selectedBonusVoice == lupin.selectListBonusVoice[1] ||
                        lupin.selectedBonusVoice == lupin.selectListBonusVoice[2] {
                        lupin.bonusVoiceCountDefault = countUpDown(minusCheck: lupin.minusCheck, count: lupin.bonusVoiceCountDefault)
                    }
                    // 高設定示唆 弱
                    else if lupin.selectedBonusVoice == lupin.selectListBonusVoice[3] ||
                                lupin.selectedBonusVoice == lupin.selectListBonusVoice[4] ||
                                lupin.selectedBonusVoice == lupin.selectListBonusVoice[5] {
                        lupin.bonusVoiceCountHighSisaJaku = countUpDown(minusCheck: lupin.minusCheck, count: lupin.bonusVoiceCountHighSisaJaku)
                    }
                    // 高設定示唆 強
                    else if lupin.selectedBonusVoice == lupin.selectListBonusVoice[6] ||
                                lupin.selectedBonusVoice == lupin.selectListBonusVoice[7] ||
                                lupin.selectedBonusVoice == lupin.selectListBonusVoice[8] {
                        lupin.bonusVoiceCountHighSisaKyo = countUpDown(minusCheck: lupin.minusCheck, count: lupin.bonusVoiceCountHighSisaKyo)
                    }
                    // 設定4 以上濃厚
                    else if lupin.selectedBonusVoice == lupin.selectListBonusVoice[9] ||
                                lupin.selectedBonusVoice == lupin.selectListBonusVoice[10] ||
                                lupin.selectedBonusVoice == lupin.selectListBonusVoice[11] {
                        lupin.bonusVoiceCountOver4 = countUpDown(minusCheck: lupin.minusCheck, count: lupin.bonusVoiceCountOver4)
                    }
                    // 設定6 濃厚
                    else if lupin.selectedBonusVoice == lupin.selectListBonusVoice[12] ||
                                lupin.selectedBonusVoice == lupin.selectListBonusVoice[13] ||
                                lupin.selectedBonusVoice == lupin.selectListBonusVoice[14] {
                        lupin.bonusVoiceCount6kaku = countUpDown(minusCheck: lupin.minusCheck, count: lupin.bonusVoiceCount6kaku)
                    }
                } label: {
                    HStack {
                        Spacer()
                        if lupin.minusCheck == false {
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
                    count: $lupin.bonusVoiceCountDefault,
                    flashColor: .gray,
                    bigNumber: $lupin.bonusVoiceCountSum
                )
                // 高設定示唆 弱
                unitResultCountListPercent(
                    title: "高設定示唆 弱",
                    count: $lupin.bonusVoiceCountHighSisaJaku,
                    flashColor: .blue,
                    bigNumber: $lupin.bonusVoiceCountSum
                )
                // 高設定示唆 強
                unitResultCountListPercent(
                    title: "高設定示唆 強",
                    count: $lupin.bonusVoiceCountHighSisaKyo,
                    flashColor: .yellow,
                    bigNumber: $lupin.bonusVoiceCountSum
                )
                // 設定4 以上濃厚
                unitResultCountListPercent(
                    title: "設定4 以上濃厚",
                    count: $lupin.bonusVoiceCountOver4,
                    flashColor: .green,
                    bigNumber: $lupin.bonusVoiceCountSum
                )
                // 設定6 濃厚
                unitResultCountListPercent(
                    title: "設定6 濃厚",
                    count: $lupin.bonusVoiceCount6kaku,
                    flashColor: .red,
                    bigNumber: $lupin.bonusVoiceCountSum
                )
                // //// 参考情報
                unitLinkButton(
                    title: "ボイス一覧",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "ボイス一覧",
                            image1: Image("lupinBonusVoice")
                        )
                    )
                )
            } header: {
                Text("カウント結果")
            }
        }
        .navigationTitle("ボーナス終了後のボイス")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    unitButtonMinusCheck(minusCheck: lupin.$minusCheck)
                    unitButtonReset(isShowAlert: $isShowAlert, action: lupin.resetBonusVoice)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    lupinSingleBonusVoice(lupin: Lupin())
}
