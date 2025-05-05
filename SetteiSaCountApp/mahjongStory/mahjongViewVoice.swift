//
//  mahjongViewVoice.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/19.
//

import SwiftUI

struct mahjongViewVoice: View {
    @ObservedObject var ver300: Ver300
    @ObservedObject var mahjong: Mahjong
    @State var isShowAlert = false
    let selectListVoice: [String] = [
        "こんな所なのだ",
        "見えましたわ",
        "私たちに終わりはない！",
        "上出来！",
        "ミーの出番パトー！"
    ]
    @State var selectedVoice: String = "こんな所なのだ"
    
    var body: some View {
        List {
            Section {
                Text("・AT非当選のボーナス後、AT終了後にPUSHボタンでボイス発生")
                    .foregroundColor(.secondary)
                    .font(.caption)
                //                HStack(spacing: 0) {
                //                    unitTableString(
                //                        columTitle: "",
                //                        stringList: [
                //                            "あやか",
                //                            "まどか",
                //                            "さやか",
                //                            "マシロ",
                //                            "パトランラン"
                //                        ]
                //                    )
                //                    unitTableString(
                //                        columTitle: "示唆",
                //                        stringList: [
                //                            "-",
                //                            "-",
                //                            "チャンス!?",
                //                            "大チャンス!?",
                //                            "引き戻しに期待"
                //                        ],
                //                        maxWidth: 170
                //                    )
                //                }
                // //// サークルピッカー
                Picker(selection: self.$selectedVoice) {
                    ForEach(self.selectListVoice, id: \.self) { voice in
                        Text(voice)
                    }
                } label: {
                    
                }
                .pickerStyle(.wheel)
                .frame(height: 120)
                .popoverTip(tipVer300MahjongVoice())
                
                // //// 選択されているボイスのカウント表示
                // 高設定示唆 弱
                if self.selectedVoice == self.selectListVoice[2] {
                    unitResultCountListPercent(
                        title: "高設定示唆 弱?",
                        count: $mahjong.voiceCountHighJaku,
                        flashColor: .green,
                        bigNumber: $mahjong.voiceCountSum
                    )
                }
                // 高設定示唆 強
                else if self.selectedVoice == self.selectListVoice[3] {
                    unitResultCountListPercent(
                        title: "高設定示唆 強?",
                        count: $mahjong.voiceCountHighKyo,
                        flashColor: .red,
                        bigNumber: $mahjong.voiceCountSum
                    )
                }
                // 引き戻し示唆
                else if self.selectedVoice == self.selectListVoice[4] {
                    unitResultCountListPercent(
                        title: "引き戻し示唆",
                        count: $mahjong.voiceCountHikimodoshi,
                        flashColor: .blue,
                        bigNumber: $mahjong.voiceCountSum
                    )
                }
                // デフォルト
                else {
                    unitResultCountListPercent(
                        title: "デフォルト",
                        count: $mahjong.voiceCountDefault,
                        flashColor: .gray,
                        bigNumber: $mahjong.voiceCountSum
                    )
                }
                
                // //// 登録ボタン
                Button {
                    // 高設定示唆 弱
                    if self.selectedVoice == self.selectListVoice[2] {
                        mahjong.voiceCountHighJaku = countUpDown(
                            minusCheck: mahjong.minusCheck,
                            count: mahjong.voiceCountHighJaku
                        )
                    }
                    // 高設定示唆 強
                    else if self.selectedVoice == self.selectListVoice[3] {
                        mahjong.voiceCountHighKyo = countUpDown(
                            minusCheck: mahjong.minusCheck,
                            count: mahjong.voiceCountHighKyo
                        )
                    }
                    // 引き戻し示唆
                    else if self.selectedVoice == self.selectListVoice[4] {
                        mahjong.voiceCountHikimodoshi = countUpDown(
                            minusCheck: mahjong.minusCheck,
                            count: mahjong.voiceCountHikimodoshi
                        )
                    }
                    // デフォルト
                    else {
                        mahjong.voiceCountDefault = countUpDown(
                            minusCheck: mahjong.minusCheck,
                            count: mahjong.voiceCountDefault
                        )
                    }
                } label: {
                    HStack {
                        Spacer()
                        if mahjong.minusCheck == false {
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
            }
            
            // //// カウント結果
            Section {
                // デフォルト
                unitResultCountListPercent(
                    title: "デフォルト",
                    count: $mahjong.voiceCountDefault,
                    flashColor: .gray,
                    bigNumber: $mahjong.voiceCountSum
                )
                
                // 高設定示唆 弱
                unitResultCountListPercent(
                    title: "高設定示唆 弱?",
                    count: $mahjong.voiceCountHighJaku,
                    flashColor: .green,
                    bigNumber: $mahjong.voiceCountSum
                )
                // 高設定示唆 強
                unitResultCountListPercent(
                    title: "高設定示唆 強?",
                    count: $mahjong.voiceCountHighKyo,
                    flashColor: .red,
                    bigNumber: $mahjong.voiceCountSum
                )
                // 引き戻し示唆
                unitResultCountListPercent(
                    title: "引き戻し示唆",
                    count: $mahjong.voiceCountHikimodoshi,
                    flashColor: .blue,
                    bigNumber: $mahjong.voiceCountSum
                )
            } header: {
                Text("カウント結果")
            }
        }
        .onAppear {
            if ver300.mahjongMenuVoiceBadgeStatus != "none" {
                ver300.mahjongMenuVoiceBadgeStatus = "none"
            }
        }
        .navigationTitle("ボーナス,AT 終了後ボイス")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $mahjong.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: mahjong.resetVoice)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    mahjongViewVoice(
        ver300: Ver300(),
        mahjong: Mahjong()
    )
}
