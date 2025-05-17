//
//  midoriDonViewVoice.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/04.
//

import SwiftUI

struct midoriDonViewVoice: View {
//    @ObservedObject var ver301: Ver301
    @ObservedObject var midoriDon: MidoriDon
    @State var isShowAlert = false
    let selectListVoice: [String] = [
        "た〜まや〜",
        "どうでい！このバランス感覚",
        "ウラウラウラウラウラー！",
        "なんてステキなの〜",
        "ドンちゃん、ステキよ",
        "ニヤついてんじゃねー",
        "おにいちゃん だ〜いすき",
        "ぽぽぽぽ〜ん(葉月ちゃん)",
        "オイラが世界一の花火師でい"
    ]
    @State var selectedVoice: String = "た〜まや〜"
    
    var body: some View {
        List {
            Section {
                Text("X-RUSHチャレンジ終了画面でサブ液晶をタッチするとボイス発生します")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
//                Text("参考）下のボイスほど強い示唆と予想")
//                    .foregroundStyle(Color.secondary)
//                    .font(.caption)
                // //// サークルピッカー
                Picker(selection: self.$selectedVoice) {
                    ForEach(self.selectListVoice, id: \.self) { voice in
                        Text(voice)
                    }
                } label: {
                    
                }
                .pickerStyle(.wheel)
                .frame(height: 120)
//                .popoverTip(tipVer301MidoriDonVoice())
                
                // //// 選択されているボイスのカウント表示
                // デフォルト
                if self.selectedVoice == self.selectListVoice[0] {
                    unitResultCountListPercent(
                        title: "デフォルト",
                        count: $midoriDon.voiceCount1,
                        flashColor: .gray,
                        bigNumber: $midoriDon.voiceCountSum
                    )
                }
                // ボイス2
                else if self.selectedVoice == self.selectListVoice[1] {
                    unitResultCountListPercent(
                        title: "偶数示唆",
                        count: $midoriDon.voiceCount2,
                        flashColor: .blue,
                        bigNumber: $midoriDon.voiceCountSum
                    )
                }
                // ボイス3
                else if self.selectedVoice == self.selectListVoice[2] {
                    unitResultCountListPercent(
                        title: "奇数示唆",
                        count: $midoriDon.voiceCount3,
                        flashColor: .yellow,
                        bigNumber: $midoriDon.voiceCountSum
                    )
                }
                // ボイス4
                else if self.selectedVoice == self.selectListVoice[3] ||
                            self.selectedVoice == self.selectListVoice[4] {
                    unitResultCountListPercent(
                        title: "高設定示唆",
                        count: $midoriDon.voiceCount4,
                        flashColor: .green,
                        bigNumber: $midoriDon.voiceCountSum
                    )
                }
                // ボイス5
//                else if self.selectedVoice == self.selectListVoice[4] {
//                    unitResultCountListPercent(
//                        title: "??? ボイス5",
//                        count: $midoriDon.voiceCount5,
//                        flashColor: .red,
//                        bigNumber: $midoriDon.voiceCountSum
//                    )
//                }
                // ボイス6
                else if self.selectedVoice == self.selectListVoice[5] {
                    unitResultCountListPercent(
                        title: "設定2 以上示唆",
                        count: $midoriDon.voiceCount6,
                        flashColor: .purple,
                        bigNumber: $midoriDon.voiceCountSum
                    )
                }
                // ボイス7
                else if self.selectedVoice == self.selectListVoice[6] {
                    unitResultCountListPercent(
                        title: "設定4 以上示唆",
                        count: $midoriDon.voiceCount7,
                        flashColor: .brown,
                        bigNumber: $midoriDon.voiceCountSum
                    )
                }
                // ボイス8
                else if self.selectedVoice == self.selectListVoice[7] {
                    unitResultCountListPercent(
                        title: "設定5 以上示唆",
                        count: $midoriDon.voiceCount8,
                        flashColor: .gray,
                        bigNumber: $midoriDon.voiceCountSum
                    )
                }
                // ボイス9
                else {
                    unitResultCountListPercent(
                        title: "設定6 濃厚",
                        count: $midoriDon.voiceCount9,
                        flashColor: .orange,
                        bigNumber: $midoriDon.voiceCountSum
                    )
                }
                
                // //// 登録ボタン
                Button {
                    // デフォルト
                    if self.selectedVoice == self.selectListVoice[0] {
                        midoriDon.voiceCount1 = countUpDown(
                            minusCheck: midoriDon.minusCheck,
                            count: midoriDon.voiceCount1
                        )
                    }
                    // ボイス2
                    else if self.selectedVoice == self.selectListVoice[1] {
                        midoriDon.voiceCount2 = countUpDown(
                            minusCheck: midoriDon.minusCheck,
                            count: midoriDon.voiceCount2
                        )
                    }
                    // ボイス3
                    else if self.selectedVoice == self.selectListVoice[2] {
                        midoriDon.voiceCount3 = countUpDown(
                            minusCheck: midoriDon.minusCheck,
                            count: midoriDon.voiceCount3
                        )
                    }
                    // ボイス4
                    else if self.selectedVoice == self.selectListVoice[3] {
                        midoriDon.voiceCount4 = countUpDown(
                            minusCheck: midoriDon.minusCheck,
                            count: midoriDon.voiceCount4
                        )
                    }
                    // ボイス5
                    else if self.selectedVoice == self.selectListVoice[4] {
                        midoriDon.voiceCount4 = countUpDown(
                            minusCheck: midoriDon.minusCheck,
//                            count: midoriDon.voiceCount5
                            count: midoriDon.voiceCount4
                        )
                    }
                    // ボイス6
                    else if self.selectedVoice == self.selectListVoice[5] {
                        midoriDon.voiceCount6 = countUpDown(
                            minusCheck: midoriDon.minusCheck,
                            count: midoriDon.voiceCount6
                        )
                    }
                    // ボイス7
                    else if self.selectedVoice == self.selectListVoice[6] {
                        midoriDon.voiceCount7 = countUpDown(
                            minusCheck: midoriDon.minusCheck,
                            count: midoriDon.voiceCount7
                        )
                    }
                    // ボイス8
                    else if self.selectedVoice == self.selectListVoice[7] {
                        midoriDon.voiceCount8 = countUpDown(
                            minusCheck: midoriDon.minusCheck,
                            count: midoriDon.voiceCount8
                        )
                    }
                    // ボイス9
                    else {
                        midoriDon.voiceCount9 = countUpDown(
                            minusCheck: midoriDon.minusCheck,
                            count: midoriDon.voiceCount9
                        )
                    }
                } label: {
                    HStack {
                        Spacer()
                        if midoriDon.minusCheck == false {
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
                    count: $midoriDon.voiceCount1,
                    flashColor: .gray,
                    bigNumber: $midoriDon.voiceCountSum
                )
                // ボイス2
                unitResultCountListPercent(
                    title: "偶数示唆",
                    count: $midoriDon.voiceCount2,
                    flashColor: .blue,
                    bigNumber: $midoriDon.voiceCountSum
                )
                // ボイス3
                unitResultCountListPercent(
                    title: "奇数示唆",
                    count: $midoriDon.voiceCount3,
                    flashColor: .yellow,
                    bigNumber: $midoriDon.voiceCountSum
                )
                // ボイス4,5
                unitResultCountListPercent(
                    title: "高設定示唆",
                    count: $midoriDon.voiceCount4,
                    flashColor: .green,
                    bigNumber: $midoriDon.voiceCountSum
                )
                // ボイス5
//                unitResultCountListPercent(
//                    title: "??? ボイス5",
//                    count: $midoriDon.voiceCount5,
//                    flashColor: .red,
//                    bigNumber: $midoriDon.voiceCountSum
//                )
                // ボイス6
                unitResultCountListPercent(
                    title: "設定2 以上示唆",
                    count: $midoriDon.voiceCount6,
                    flashColor: .purple,
                    bigNumber: $midoriDon.voiceCountSum
                )
                // ボイス7
                unitResultCountListPercent(
                    title: "設定4 以上示唆",
                    count: $midoriDon.voiceCount7,
                    flashColor: .brown,
                    bigNumber: $midoriDon.voiceCountSum
                )
                // ボイス8
                unitResultCountListPercent(
                    title: "設定5 以上示唆",
                    count: $midoriDon.voiceCount8,
                    flashColor: .gray,
                    bigNumber: $midoriDon.voiceCountSum
                )
                // ボイス9
                unitResultCountListPercent(
                    title: "設定6 濃厚",
                    count: $midoriDon.voiceCount9,
                    flashColor: .orange,
                    bigNumber: $midoriDon.voiceCountSum
                )
            } header: {
                Text("カウント結果")
            }
        }
//        .onAppear {
//            if ver301.midoriDonMenuVoiceBadgeStatus != "none" {
//                ver301.midoriDonMenuVoiceBadgeStatus = "none"
//            }
//        }
        .navigationTitle("X-RUSH失敗時のボイス")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $midoriDon.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: midoriDon.resetVoice)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    midoriDonViewVoice(
//        ver301: Ver301(),
        midoriDon: MidoriDon()
    )
}
