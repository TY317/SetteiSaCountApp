//
//  rslViewVoice.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/24.
//

import SwiftUI

struct rslViewVoice: View {
    @ObservedObject var rsl = Rsl()
    @State var isShowAlert = false
    let voiceList: [String] = [
        "オーディション終了します",
        "そこまでキラメキが残るなんて予測できませんでした",
        "トップスタァになったあなたが望む「運命の舞台」とは？",
        "あなたにもあるでしょう？眩しい舞台が",
        "運命の二人・・ですか。わかります",
        "これこそ私が観たかった舞台！わかります！"
    ]
    @State var selectedVoice: String = "オーディション終了します"
    
    var body: some View {
        List {
            Section {
                // //// 説明
                Text("AT終了画面で上部センサーをタッチするとボイスが発生")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // //// サークルピッカー
                Picker(selection: self.$selectedVoice) {
                    ForEach(self.voiceList, id: \.self) { voice in
                        Text(voice)
                    }
                } label: {
                    
                }
                .pickerStyle(.wheel)
                .frame(height: 120)
                
                // //// 選択されているボイスのカウント表示
                // デフォルト
                if self.selectedVoice == self.voiceList[0] {
                    unitResultCountListPercent(
                        title: "デフォルト",
                        count: $rsl.voiceCountDefault,
                        flashColor: .gray,
                        bigNumber: $rsl.voiceCountSum
                    )
                }
                // 高設定示唆 弱
                else if self.selectedVoice == self.voiceList[1] {
                    unitResultCountListPercent(
                        title: "高設定示唆 弱",
                        count: $rsl.voiceCountHighJaku,
                        flashColor: .blue,
                        bigNumber: $rsl.voiceCountSum
                    )
                }
                // 高設定示唆 強
                else if self.selectedVoice == self.voiceList[2] {
                    unitResultCountListPercent(
                        title: "高設定示唆 強",
                        count: $rsl.voiceCountHighKyo,
                        flashColor: .yellow,
                        bigNumber: $rsl.voiceCountSum
                    )
                }
                // 設定２以上濃厚
                else if self.selectedVoice == self.voiceList[3] {
                    unitResultCountListPercent(
                        title: "設定2 以上濃厚",
                        count: $rsl.voiceCountOver2,
                        flashColor: .green,
                        bigNumber: $rsl.voiceCountSum
                    )
                }
                // 設定4以上濃厚
                else if self.selectedVoice == self.voiceList[4] {
                    unitResultCountListPercent(
                        title: "設定4 以上濃厚",
                        count: $rsl.voiceCountOver4,
                        flashColor: .red,
                        bigNumber: $rsl.voiceCountSum
                    )
                }
                // 設定6濃厚
                else {
                    unitResultCountListPercent(
                        title: "設定6 濃厚",
                        count: $rsl.voiceCountOver6,
                        flashColor: .purple,
                        bigNumber: $rsl.voiceCountSum
                    )
                }
                
                // //// 登録ボタン
                Button {
                    // デフォルト
                    if self.selectedVoice == self.voiceList[0] {
                        rsl.voiceCountDefault = countUpDown(minusCheck: rsl.minusCheck, count: rsl.voiceCountDefault)
                    }
                    // 高設定示唆 弱
                    else if self.selectedVoice == self.voiceList[1] {
                        rsl.voiceCountHighJaku = countUpDown(minusCheck: rsl.minusCheck, count: rsl.voiceCountHighJaku)
                    }
                    // 高設定示唆 強
                    else if self.selectedVoice == self.voiceList[2] {
                        rsl.voiceCountHighKyo = countUpDown(minusCheck: rsl.minusCheck, count: rsl.voiceCountHighKyo)
                    }
                    // 設定２以上濃厚
                    else if self.selectedVoice == self.voiceList[3] {
                        rsl.voiceCountOver2 = countUpDown(minusCheck: rsl.minusCheck, count: rsl.voiceCountOver2)
                    }
                    // 設定4以上濃厚
                    else if self.selectedVoice == self.voiceList[4] {
                        rsl.voiceCountOver4 = countUpDown(minusCheck: rsl.minusCheck, count: rsl.voiceCountOver4)
                    }
                    // 設定6濃厚
                    else {
                        rsl.voiceCountOver6 = countUpDown(minusCheck: rsl.minusCheck, count: rsl.voiceCountOver6)
                    }
                } label: {
                    HStack {
                        Spacer()
                        if rsl.minusCheck == false {
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
            
            // //// カウント結果
            Section {
                // デフォルト
                unitResultCountListPercent(
                    title: "デフォルト",
                    count: $rsl.voiceCountDefault,
                    flashColor: .gray,
                    bigNumber: $rsl.voiceCountSum
                )
                // 高設定示唆 弱
                unitResultCountListPercent(
                    title: "高設定示唆 弱",
                    count: $rsl.voiceCountHighJaku,
                    flashColor: .blue,
                    bigNumber: $rsl.voiceCountSum
                )
                // 高設定示唆 強
                unitResultCountListPercent(
                    title: "高設定示唆 強",
                    count: $rsl.voiceCountHighKyo,
                    flashColor: .yellow,
                    bigNumber: $rsl.voiceCountSum
                )
                // 設定２以上濃厚
                unitResultCountListPercent(
                    title: "設定2 以上濃厚",
                    count: $rsl.voiceCountOver2,
                    flashColor: .green,
                    bigNumber: $rsl.voiceCountSum
                )
                // 設定4以上濃厚
                unitResultCountListPercent(
                    title: "設定4 以上濃厚",
                    count: $rsl.voiceCountOver4,
                    flashColor: .red,
                    bigNumber: $rsl.voiceCountSum
                )
                // 設定6濃厚
                unitResultCountListPercent(
                    title: "設定6 濃厚",
                    count: $rsl.voiceCountOver6,
                    flashColor: .purple,
                    bigNumber: $rsl.voiceCountSum
                )
            } header: {
                Text("カウント結果")
            }
        }
        .navigationTitle("AT終了後ボイス")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $rsl.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: rsl.resetVoice)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    rslViewVoice()
}
