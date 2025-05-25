//
//  bioViewEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/12.
//

import SwiftUI

struct bioViewEnding: View {
//    @ObservedObject var bio = Bio()
    @ObservedObject var bio: Bio
    @State var isShowAlert = false
    let selectListVoice: [String] = [
        "俺にはやるべきことがある",
        "見せてやるわ！",
        "俺の出番だな！",
        "俺はな ビジネスマン なんだよ",
        "お会いできて光栄だわ",
        "新たな時代の幕開けだ",
        "シャーーーーーーーー！",
        "にゃーん！"
    ]
    @State var selectedVoice: String = "俺にはやるべきことがある"
    
    var body: some View {
        List {
            Section {
                // //// サークルピッカー
                Picker(selection: self.$selectedVoice) {
                    ForEach(self.selectListVoice, id: \.self) { voice in
                        Text(voice)
                    }
                } label: {
                    
                }
                .pickerStyle(.wheel)
                .frame(height: 120)
                
                // //// 選択されているボイスのカウント表示
                // 奇数示唆
                if self.selectedVoice == self.selectListVoice[1] {
                    unitResultCountListPercent(
                        title: "奇数示唆",
                        count: $bio.endingCountKisu,
                        flashColor: .blue,
                        bigNumber: $bio.endingCountSum
                    )
                }
                // 偶数示唆
                else if self.selectedVoice == self.selectListVoice[2] {
                    unitResultCountListPercent(
                        title: "偶数示唆",
                        count: $bio.endingCountGusu,
                        flashColor: .yellow,
                        bigNumber: $bio.endingCountSum
                    )
                }
                // 高設定示唆 弱
                else if self.selectedVoice == self.selectListVoice[3] {
                    unitResultCountListPercent(
                        title: "高設定示唆 弱",
                        count: $bio.endingCountHighJaku,
                        flashColor: .green,
                        bigNumber: $bio.endingCountSum
                    )
                }
                // 高設定示唆 強
                else if self.selectedVoice == self.selectListVoice[4] {
                    unitResultCountListPercent(
                        title: "高設定示唆 強",
                        count: $bio.endingCountHighKyo,
                        flashColor: .red,
                        bigNumber: $bio.endingCountSum
                    )
                }
                // ４以上
                else if self.selectedVoice == self.selectListVoice[5] {
                    unitResultCountListPercent(
                        title: "設定4 以上濃厚",
                        count: $bio.endingCountOver4,
                        flashColor: .purple,
                        bigNumber: $bio.endingCountSum
                    )
                }
                // 5以上
                else if self.selectedVoice == self.selectListVoice[6] {
                    unitResultCountListPercent(
                        title: "設定5 以上濃厚",
                        count: $bio.endingCountOver5,
                        flashColor: .cyan,
                        bigNumber: $bio.endingCountSum
                    )
                }
                // 6以上
                else if self.selectedVoice == self.selectListVoice[7] {
                    unitResultCountListPercent(
                        title: "設定6 濃厚",
                        count: $bio.endingCountOver6,
                        flashColor: .orange,
                        bigNumber: $bio.endingCountSum
                    )
                }
                // デフォルト
                else {
                    unitResultCountListPercent(
                        title: "デフォルト",
                        count: $bio.endingCountDefault,
                        flashColor: .gray,
                        bigNumber: $bio.endingCountSum
                    )
                }
                
                // //// 登録ボタン
                Button {
                    // 奇数示唆
                    if self.selectedVoice == self.selectListVoice[1] {
                        bio.endingCountKisu = countUpDown(minusCheck: bio.minusCheck, count: bio.endingCountKisu)
                    }
                    // 偶数示唆
                    else if self.selectedVoice == self.selectListVoice[2] {
                        bio.endingCountGusu = countUpDown(minusCheck: bio.minusCheck, count: bio.endingCountGusu)
                    }
                    // 高設定示唆 弱
                    else if self.selectedVoice == self.selectListVoice[3] {
                        bio.endingCountHighJaku = countUpDown(minusCheck: bio.minusCheck, count: bio.endingCountHighJaku)
                    }
                    // 高設定示唆 強
                    else if self.selectedVoice == self.selectListVoice[4] {
                        bio.endingCountHighKyo = countUpDown(minusCheck: bio.minusCheck, count: bio.endingCountHighKyo)
                    }
                    // ４以上
                    else if self.selectedVoice == self.selectListVoice[5] {
                        bio.endingCountOver4 = countUpDown(minusCheck: bio.minusCheck, count: bio.endingCountOver4)
                    }
                    // 5以上
                    else if self.selectedVoice == self.selectListVoice[6] {
                        bio.endingCountOver5 = countUpDown(minusCheck: bio.minusCheck, count: bio.endingCountOver5)
                    }
                    // 6以上
                    else if self.selectedVoice == self.selectListVoice[7] {
                        bio.endingCountOver6 = countUpDown(minusCheck: bio.minusCheck, count: bio.endingCountOver6)
                    }
                    // デフォルト
                    else {
                        bio.endingCountDefault = countUpDown(minusCheck: bio.minusCheck, count: bio.endingCountDefault)
                    }
                } label: {
                    HStack {
                        Spacer()
                        if bio.minusCheck == false {
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
                Text("レア役成立時のセリフ")
            }
            
            // //// カウント結果
            Section {
                // デフォルト
                unitResultCountListPercent(
                    title: "デフォルト",
                    count: $bio.endingCountDefault,
                    flashColor: .gray,
                    bigNumber: $bio.endingCountSum
                )
                // 奇数示唆
                unitResultCountListPercent(
                    title: "奇数示唆",
                    count: $bio.endingCountKisu,
                    flashColor: .blue,
                    bigNumber: $bio.endingCountSum
                )
                // 偶数示唆
                unitResultCountListPercent(
                    title: "偶数示唆",
                    count: $bio.endingCountGusu,
                    flashColor: .yellow,
                    bigNumber: $bio.endingCountSum
                )
                // 高設定示唆 弱
                unitResultCountListPercent(
                    title: "高設定示唆 弱",
                    count: $bio.endingCountHighJaku,
                    flashColor: .green,
                    bigNumber: $bio.endingCountSum
                )
                // 高設定示唆 強
                unitResultCountListPercent(
                    title: "高設定示唆 強",
                    count: $bio.endingCountHighKyo,
                    flashColor: .red,
                    bigNumber: $bio.endingCountSum
                )
                // ４以上
                unitResultCountListPercent(
                    title: "設定4 以上濃厚",
                    count: $bio.endingCountOver4,
                    flashColor: .purple,
                    bigNumber: $bio.endingCountSum
                )
                // 5以上
                unitResultCountListPercent(
                    title: "設定5 以上濃厚",
                    count: $bio.endingCountOver5,
                    flashColor: .cyan,
                    bigNumber: $bio.endingCountSum
                )
                // 6以上
                unitResultCountListPercent(
                    title: "設定6 濃厚",
                    count: $bio.endingCountOver6,
                    flashColor: .orange,
                    bigNumber: $bio.endingCountSum
                )
            } header: {
                Text("カウント結果")
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "バイオハザード5",
                screenClass: screenClass
            )
        }
        .navigationTitle("エンディング")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $bio.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: bio.resetEnding)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    bioViewEnding(bio: Bio())
}
