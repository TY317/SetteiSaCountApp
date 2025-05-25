//
//  magiaViewEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/20.
//

import SwiftUI
import TipKit

struct magiaViewEnding: View {
//    @ObservedObject var ver310: Ver310
    @ObservedObject var magia: Magia
    @State var isShowAlert = false
    let selectListCard: [String] = [
        "絶交階段のウワサ",
        "マチビト馬のウワサ",
        "フクロウの幸運水のウワサ",
        "ひとりぼっちの最果てのウワサ",
        "記憶ミュージアムのウワサ",
        "万年桜のウワサ",
        "石中魚の魔女",
        "立ち耳の魔女",
        "振子の魔女",
        "委員長の魔女",
        "ヨダカの魔女",
        "舞台装置の魔女"
    ]
    @State var selectedCard: String = "絶交階段のウワサ"
    
    var body: some View {
//        TipView(tipVer310MagiaEnding())
        List {
            Section {
                // //// サークルピッカー
                Picker(selection: self.$selectedCard) {
                    ForEach(self.selectListCard, id: \.self) { card in
                        Text(card)
                    }
                } label: {
                    
                }
                .pickerStyle(.wheel)
                .frame(height: 120)
                
                // //// 選択されているカードのカウント表示
                // 奇数示唆 弱
                if self.selectedCard == self.selectListCard[0] {
                    unitResultCountListPercent(
                        title: "奇数示唆 弱",
                        count: $magia.endingCountKisu,
                        flashColor: .personalSummerLightBlue,
                        bigNumber: $magia.endingCountSum
                    )
                }
                // 偶数示唆
                else if self.selectedCard == self.selectListCard[1] {
                    unitResultCountListPercent(
                        title: "偶数示唆 弱",
                        count: $magia.endingCountGusu,
                        flashColor: .personalSpringLightYellow,
                        bigNumber: $magia.endingCountSum
                    )
                }
                // 奇数示唆 強
                else if self.selectedCard == self.selectListCard[2] {
                    unitResultCountListPercent(
                        title: "奇数示唆 強",
                        count: $magia.endingCountKisuKyo,
                        flashColor: .blue,
                        bigNumber: $magia.endingCountSum
                    )
                }
                // 偶数示唆 強
                else if self.selectedCard == self.selectListCard[3] {
                    unitResultCountListPercent(
                        title: "偶数示唆 強",
                        count: $magia.endingCountGusuKyo,
                        flashColor: .yellow,
                        bigNumber: $magia.endingCountSum
                    )
                }
                // 高設定示唆 弱
                else if self.selectedCard == self.selectListCard[4] {
                    unitResultCountListPercent(
                        title: "高設定示唆 弱",
                        count: $magia.endingCountHigh,
                        flashColor: .green,
                        bigNumber: $magia.endingCountSum
                    )
                }
                // 高設定示唆 強
                else if self.selectedCard == self.selectListCard[5] {
                    unitResultCountListPercent(
                        title: "高設定示唆 強",
                        count: $magia.endingCountHighKyo,
                        flashColor: .red,
                        bigNumber: $magia.endingCountSum
                    )
                }
                // 設定2 否定
                else if self.selectedCard == self.selectListCard[6] {
                    unitResultCountListPercent(
                        title: "設定2 否定",
                        count: $magia.endingCountNegate2,
                        flashColor: .cyan,
                        bigNumber: $magia.endingCountSum
                    )
                }
                // 設定3 否定
                else if self.selectedCard == self.selectListCard[7] {
                    unitResultCountListPercent(
                        title: "設定3 否定",
                        count: $magia.endingCountNegate3,
                        flashColor: .orange,
                        bigNumber: $magia.endingCountSum
                    )
                }
                // 設定4 否定
                else if self.selectedCard == self.selectListCard[8] {
                    unitResultCountListPercent(
                        title: "設定4 否定",
                        count: $magia.endingCountNegate4,
                        flashColor: .pink,
                        bigNumber: $magia.endingCountSum
                    )
                }
                // 設定1 否定&高設定示唆
                else if self.selectedCard == self.selectListCard[9] {
                    unitResultCountListPercent(
                        title: "設定1否定&高設定示唆",
                        count: $magia.endingCountNegate1High,
                        flashColor: .purple,
                        bigNumber: $magia.endingCountSum
                    )
                }
                // 設定4 否定&高設定示唆
                else if self.selectedCard == self.selectListCard[10] {
                    unitResultCountListPercent(
                        title: "設定4否定&高設定示唆",
                        count: $magia.endingCountNegate4High,
                        flashColor: .gray,
                        bigNumber: $magia.endingCountSum
                    )
                }
                // 設定4 以上
                else {
                    unitResultCountListPercent(
                        title: "設定4 以上濃厚",
                        count: $magia.endingCountOver4,
                        flashColor: .orange,
                        bigNumber: $magia.endingCountSum
                    )
                }
                // //// 登録ボタン
                Button {
                    // 奇数示唆 弱
                    if self.selectedCard == self.selectListCard[0] {
                        magia.endingCountKisu = countUpDown(minusCheck: magia.minusCheck, count: magia.endingCountKisu)
                    }
                    // 偶数示唆
                    else if self.selectedCard == self.selectListCard[1] {
                        magia.endingCountGusu = countUpDown(minusCheck: magia.minusCheck, count: magia.endingCountGusu)
                    }
                    // 奇数示唆 強
                    else if self.selectedCard == self.selectListCard[2] {
                        magia.endingCountKisuKyo = countUpDown(minusCheck: magia.minusCheck, count: magia.endingCountKisuKyo)
                    }
                    // 偶数示唆 強
                    else if self.selectedCard == self.selectListCard[3] {
                        magia.endingCountGusuKyo = countUpDown(minusCheck: magia.minusCheck, count: magia.endingCountGusuKyo)
                    }
                    // 高設定示唆 弱
                    else if self.selectedCard == self.selectListCard[4] {
                        magia.endingCountHigh = countUpDown(minusCheck: magia.minusCheck, count: magia.endingCountHigh)
                    }
                    // 高設定示唆 強
                    else if self.selectedCard == self.selectListCard[5] {
                        magia.endingCountHighKyo = countUpDown(minusCheck: magia.minusCheck, count: magia.endingCountHighKyo)
                    }
                    // 設定2 否定
                    else if self.selectedCard == self.selectListCard[6] {
                        magia.endingCountNegate2 = countUpDown(minusCheck: magia.minusCheck, count: magia.endingCountNegate2)
                    }
                    // 設定3 否定
                    else if self.selectedCard == self.selectListCard[7] {
                        magia.endingCountNegate3 = countUpDown(minusCheck: magia.minusCheck, count: magia.endingCountNegate3)
                    }
                    // 設定4 否定
                    else if self.selectedCard == self.selectListCard[8] {
                        magia.endingCountNegate4 = countUpDown(minusCheck: magia.minusCheck, count: magia.endingCountNegate4)
                    }
                    // 設定1 否定&高設定示唆
                    else if self.selectedCard == self.selectListCard[9] {
                        magia.endingCountNegate1High = countUpDown(minusCheck: magia.minusCheck, count: magia.endingCountNegate1High)
                    }
                    // 設定4 否定&高設定示唆
                    else if self.selectedCard == self.selectListCard[10] {
                        magia.endingCountNegate4High = countUpDown(minusCheck: magia.minusCheck, count: magia.endingCountNegate4High)
                    }
                    // 設定4 以上
                    else {
                        magia.endingCountOver4 = countUpDown(minusCheck: magia.minusCheck, count: magia.endingCountOver4)
                    }
                } label: {
                    HStack {
                        Spacer()
                        if magia.minusCheck == false {
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
                Text("レア役成立時のカード")
            }
            
            // //// カウント結果
            Section {
                // 奇数示唆 弱
                unitResultCountListPercent(
                    title: "奇数示唆 弱",
                    count: $magia.endingCountKisu,
                    flashColor: .personalSummerLightBlue,
                    bigNumber: $magia.endingCountSum
                )
                // 偶数示唆
                unitResultCountListPercent(
                    title: "偶数示唆 弱",
                    count: $magia.endingCountGusu,
                    flashColor: .personalSpringLightYellow,
                    bigNumber: $magia.endingCountSum
                )
                // 奇数示唆 強
                unitResultCountListPercent(
                    title: "奇数示唆 強",
                    count: $magia.endingCountKisuKyo,
                    flashColor: .blue,
                    bigNumber: $magia.endingCountSum
                )
                // 偶数示唆 強
                unitResultCountListPercent(
                    title: "偶数示唆 強",
                    count: $magia.endingCountGusuKyo,
                    flashColor: .yellow,
                    bigNumber: $magia.endingCountSum
                )
                // 高設定示唆 弱
                unitResultCountListPercent(
                    title: "高設定示唆 弱",
                    count: $magia.endingCountHigh,
                    flashColor: .green,
                    bigNumber: $magia.endingCountSum
                )
                // 高設定示唆 強
                unitResultCountListPercent(
                    title: "高設定示唆 強",
                    count: $magia.endingCountHighKyo,
                    flashColor: .red,
                    bigNumber: $magia.endingCountSum
                )
                // 設定2 否定
                unitResultCountListPercent(
                    title: "設定2 否定",
                    count: $magia.endingCountNegate2,
                    flashColor: .cyan,
                    bigNumber: $magia.endingCountSum
                )
                // 設定3 否定
                unitResultCountListPercent(
                    title: "設定3 否定",
                    count: $magia.endingCountNegate3,
                    flashColor: .orange,
                    bigNumber: $magia.endingCountSum
                )
                // 設定4 否定
                unitResultCountListPercent(
                    title: "設定4 否定",
                    count: $magia.endingCountNegate4,
                    flashColor: .pink,
                    bigNumber: $magia.endingCountSum
                )
                // 設定1 否定&高設定示唆
                unitResultCountListPercent(
                    title: "設定1否定&高設定示唆",
                    count: $magia.endingCountNegate1High,
                    flashColor: .purple,
                    bigNumber: $magia.endingCountSum
                )
                // 設定4 否定&高設定示唆
                unitResultCountListPercent(
                    title: "設定4否定&高設定示唆",
                    count: $magia.endingCountNegate4High,
                    flashColor: .gray,
                    bigNumber: $magia.endingCountSum
                )
                // 設定4 以上
                unitResultCountListPercent(
                    title: "設定4 以上濃厚",
                    count: $magia.endingCountOver4,
                    flashColor: .orange,
                    bigNumber: $magia.endingCountSum
                )
            } header: {
                Text("カウント結果")
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "マギアレコード",
                screenClass: screenClass
            )
        }
//        .onAppear {
//            if ver310.magiaMenuEndingBadgeStatus != "none" {
//                ver310.magiaMenuEndingBadgeStatus = "none"
//            }
//        }
        .navigationTitle("エンディング")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $magia.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: magia.resetEnding)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    magiaViewEnding(
//        ver310: Ver310(),
        magia: Magia()
    )
}
