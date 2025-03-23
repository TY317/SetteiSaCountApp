//
//  kaijiViewEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/23.
//

import SwiftUI

struct kaijiViewEnding: View {
    @ObservedObject var kaiji = Kaiji()
    @State var isShowAlert = false
    let voiceList: [String] = [
        "救えぬ偽善者・・",
        "甘えを捨てろ",
        "魔力！ 魔力！ 魔力！",
        "こいつ、気づいていない！456賽に！",
        "帝愛は、愛されねばならんのだ！"
    ]
    @State var selectedVoice: String = "救えぬ偽善者・・"
    
    var body: some View {
        List {
            Section {
                // 説明
                Text("レア役成立時にPUSHボタンでボイス発生")
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
                // 奇数示唆
                if self.selectedVoice == self.voiceList[0] {
                    unitResultCountListPercent(
                        title: "奇数示唆",
                        count: $kaiji.endingCountKisu,
                        flashColor: .blue,
                        bigNumber: $kaiji.endingCountSum
                    )
                }
                // 偶数示唆
                else if self.selectedVoice == self.voiceList[1] {
                    unitResultCountListPercent(
                        title: "偶数示唆",
                        count: $kaiji.endingCountGusu,
                        flashColor: .yellow,
                        bigNumber: $kaiji.endingCountSum
                    )
                }
                // 魔力
                else if self.selectedVoice == self.voiceList[2] {
                    unitResultCountListPercent(
                        title: "???",
                        count: $kaiji.endingCountMaryoku,
                        flashColor: .green,
                        bigNumber: $kaiji.endingCountSum
                    )
                }
                // 設定４以上
                else if self.selectedVoice == self.voiceList[3] {
                    unitResultCountListPercent(
                        title: "???(4以上?）",
                        count: $kaiji.endingCountOver4,
                        flashColor: .red,
                        bigNumber: $kaiji.endingCountSum
                    )
                }
                // 帝愛
                else {
                    unitResultCountListPercent(
                        title: "???",
                        count: $kaiji.endingCountTeiai,
                        flashColor: .purple,
                        bigNumber: $kaiji.endingCountSum
                    )
                }
                
                // //// 登録ボタン
                Button {
                    // 奇数示唆
                    if self.selectedVoice == self.voiceList[0] {
                        kaiji.endingCountKisu = countUpDown(minusCheck: kaiji.minusCheck, count: kaiji.endingCountKisu)
                    }
                    // 偶数示唆
                    else if self.selectedVoice == self.voiceList[1] {
                        kaiji.endingCountGusu = countUpDown(minusCheck: kaiji.minusCheck, count: kaiji.endingCountGusu)
                    }
                    // 魔力
                    else if self.selectedVoice == self.voiceList[2] {
                        kaiji.endingCountMaryoku = countUpDown(minusCheck: kaiji.minusCheck, count: kaiji.endingCountMaryoku)
                    }
                    // 設定４以上
                    else if self.selectedVoice == self.voiceList[3] {
                        kaiji.endingCountOver4 = countUpDown(minusCheck: kaiji.minusCheck, count: kaiji.endingCountOver4)
                    }
                    // 帝愛
                    else {
                        kaiji.endingCountTeiai = countUpDown(minusCheck: kaiji.minusCheck, count: kaiji.endingCountTeiai)
                    }
                } label: {
                    HStack {
                        Spacer()
                        if kaiji.minusCheck == false {
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
                Text("レア役成立時のボイス")
            }
            
            // //// カウント結果
            Section {
                // 奇数示唆
                    unitResultCountListPercent(
                        title: "奇数示唆",
                        count: $kaiji.endingCountKisu,
                        flashColor: .blue,
                        bigNumber: $kaiji.endingCountSum
                    )
                // 偶数示唆
                    unitResultCountListPercent(
                        title: "偶数示唆",
                        count: $kaiji.endingCountGusu,
                        flashColor: .yellow,
                        bigNumber: $kaiji.endingCountSum
                    )
                // 魔力
                    unitResultCountListPercent(
                        title: "?(魔力！)",
                        count: $kaiji.endingCountMaryoku,
                        flashColor: .green,
                        bigNumber: $kaiji.endingCountSum
                    )
                // 設定４以上
                    unitResultCountListPercent(
                        title: "?(456賽)",
                        count: $kaiji.endingCountOver4,
                        flashColor: .red,
                        bigNumber: $kaiji.endingCountSum
                    )
                // 帝愛
                    unitResultCountListPercent(
                        title: "?(帝愛は・・)",
                        count: $kaiji.endingCountTeiai,
                        flashColor: .purple,
                        bigNumber: $kaiji.endingCountSum
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
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $kaiji.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: kaiji.resetEnding)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    kaijiViewEnding()
}
