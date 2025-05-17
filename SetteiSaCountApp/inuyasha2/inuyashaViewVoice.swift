//
//  inuyashaViewVoice.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/12/21.
//

import SwiftUI

struct inuyashaViewVoice: View {
//    @ObservedObject var inuyasha = Inuyasha()
    @ObservedObject var inuyasha: Inuyasha
    @State var isShowAlert = false
    
    var body: some View {
        List {
            Section {
                // //// サークルピッカー
                Picker(selection: $inuyasha.selectedVoice) {
                    ForEach(inuyasha.selectListVoice, id: \.self) { voice in
                        Text(voice)
                    }
                } label: {
                    
                }
                .pickerStyle(.wheel)
                .frame(height: 120)
                // //// 選択されているボイスのカウント表示
                // デフォルト
                if inuyasha.selectedVoice == inuyasha.selectListVoice[0] ||
                    inuyasha.selectedVoice == inuyasha.selectListVoice[1] {
                    unitResultCountListPercent(
                        title: "デフォルト",
                        count: $inuyasha.voiceCountDefault,
                        flashColor: .gray,
                        bigNumber: $inuyasha.voiceCountSum
                    )
                }
                // 高設定示唆 弱
                else if inuyasha.selectedVoice == inuyasha.selectListVoice[2] ||
                            inuyasha.selectedVoice == inuyasha.selectListVoice[3] {
                    unitResultCountListPercent(
                        title: "高設定示唆 弱",
                        count: $inuyasha.voiceCountHighSisaJaku,
                        flashColor: .blue,
                        bigNumber: $inuyasha.voiceCountSum
                    )
                }
                // 高設定示唆 中
                else if inuyasha.selectedVoice == inuyasha.selectListVoice[4] ||
                            inuyasha.selectedVoice == inuyasha.selectListVoice[5] {
                    unitResultCountListPercent(
                        title: "高設定示唆 中",
                        count: $inuyasha.voiceCountHighSisaChu,
                        flashColor: .yellow,
                        bigNumber: $inuyasha.voiceCountSum
                    )
                }
                // 高設定示唆 強
                else if inuyasha.selectedVoice == inuyasha.selectListVoice[6] {
                    unitResultCountListPercent(
                        title: "高設定示唆 強",
                        count: $inuyasha.voiceCountHighSisaKyo,
                        flashColor: .red,
                        bigNumber: $inuyasha.voiceCountSum
                    )
                }
                // //// 登録ボタン
                Button {
                    // デフォルト
                    if inuyasha.selectedVoice == inuyasha.selectListVoice[0] ||
                        inuyasha.selectedVoice == inuyasha.selectListVoice[1] {
                        inuyasha.voiceCountDefault = countUpDown(minusCheck: inuyasha.minusCheck, count: inuyasha.voiceCountDefault)
                    }
                    // 高設定示唆 弱
                    else if inuyasha.selectedVoice == inuyasha.selectListVoice[2] ||
                                inuyasha.selectedVoice == inuyasha.selectListVoice[3] {
                        inuyasha.voiceCountHighSisaJaku = countUpDown(minusCheck: inuyasha.minusCheck, count: inuyasha.voiceCountHighSisaJaku)
                    }
                    // 高設定示唆 中
                    else if inuyasha.selectedVoice == inuyasha.selectListVoice[4] ||
                                inuyasha.selectedVoice == inuyasha.selectListVoice[5] {
                        inuyasha.voiceCountHighSisaChu = countUpDown(minusCheck: inuyasha.minusCheck, count: inuyasha.voiceCountHighSisaChu)
                    }
                    // 高設定示唆 強
                    else if inuyasha.selectedVoice == inuyasha.selectListVoice[6] {
                        inuyasha.voiceCountHighSisaKyo = countUpDown(minusCheck: inuyasha.minusCheck, count: inuyasha.voiceCountHighSisaKyo)
                    }
                } label: {
                    HStack {
                        Spacer()
                        if inuyasha.minusCheck == false {
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
                    count: $inuyasha.voiceCountDefault,
                    flashColor: .gray,
                    bigNumber: $inuyasha.voiceCountSum
                )
                // 高設定示唆 弱
                unitResultCountListPercent(
                    title: "高設定示唆 弱",
                    count: $inuyasha.voiceCountHighSisaJaku,
                    flashColor: .blue,
                    bigNumber: $inuyasha.voiceCountSum
                )
                // 高設定示唆 中
                unitResultCountListPercent(
                    title: "高設定示唆 中",
                    count: $inuyasha.voiceCountHighSisaChu,
                    flashColor: .yellow,
                    bigNumber: $inuyasha.voiceCountSum
                )
                // 高設定示唆 強
                unitResultCountListPercent(
                    title: "高設定示唆 強",
                    count: $inuyasha.voiceCountHighSisaKyo,
                    flashColor: .red,
                    bigNumber: $inuyasha.voiceCountSum
                )
                // //// 参考情報リンク
                unitLinkButton(
                    title: "目押しボイスについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "目押しボイス",
                            textBody1: "・BIG入賞時にビタ押しor2コマ目押しでテンパイさせるとボイスが発生",
                            textBody2: "・ボイスの種類によって設定を示唆",
//                            image1: Image("inuyashaVoice")
                            tableView: AnyView(inuyashaTableMeoshiVoice())
                        )
                    )
                )
            } header: {
                Text("カウント結果")
            }
        }
        .navigationTitle("目押しボイス")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    unitButtonMinusCheck(minusCheck: inuyasha.$minusCheck)
                    unitButtonReset(isShowAlert: $isShowAlert, action: inuyasha.resetVoice)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    inuyashaViewVoice(inuyasha: Inuyasha())
}
