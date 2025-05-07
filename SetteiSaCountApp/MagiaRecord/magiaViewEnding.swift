//
//  magiaViewEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/20.
//

import SwiftUI

struct magiaViewEnding: View {
//    @ObservedObject var ver280 = Ver280()
//    @ObservedObject var magia = Magia()
    @ObservedObject var magia: Magia
    @State var isShowAlert = false
    let selectListCard: [String] = [
        "絶交階段のウワサ",
        "マチビト馬のウワサ",
        "フクロウの幸運水のウワサ",
        "ひとりぼっちの最果てのウワサ",
        "記憶ミュージアムのウワサ",
        "万年桜のウワサ"
    ]
    @State var selectedCard: String = "絶交階段のウワサ"
    
    var body: some View {
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
                // 奇数示唆
                if self.selectedCard == self.selectListCard[0] || self.selectedCard == self.selectListCard[2] {
                    unitResultCountListPercent(
                        title: "奇数示唆",
                        count: $magia.endingCountKisu,
                        flashColor: .blue,
                        bigNumber: $magia.endingCountSum
                    )
                }
                // 偶数示唆
                else if self.selectedCard == self.selectListCard[1] || self.selectedCard == self.selectListCard[3] {
                    unitResultCountListPercent(
                        title: "偶数示唆",
                        count: $magia.endingCountGusu,
                        flashColor: .yellow,
                        bigNumber: $magia.endingCountSum
                    )
                }
                // 高設定示唆
                else {
                    unitResultCountListPercent(
                        title: "高設定示唆",
                        count: $magia.endingCountHigh,
                        flashColor: .red,
                        bigNumber: $magia.endingCountSum
                    )
                }
                
                // //// 登録ボタン
                Button {
                    // 奇数示唆
                    if self.selectedCard == self.selectListCard[0] || self.selectedCard == self.selectListCard[2] {
                        magia.endingCountKisu = countUpDown(minusCheck: magia.minusCheck, count: magia.endingCountKisu)
                    }
                    // 偶数示唆
                    else if self.selectedCard == self.selectListCard[1] || self.selectedCard == self.selectListCard[3] {
                        magia.endingCountGusu = countUpDown(minusCheck: magia.minusCheck, count: magia.endingCountGusu)
                    }
                    // 高設定示唆
                    else {
                        magia.endingCountHigh = countUpDown(minusCheck: magia.minusCheck, count: magia.endingCountHigh)
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
                // 奇数示唆
                unitResultCountListPercent(
                    title: "奇数示唆",
                    count: $magia.endingCountKisu,
                    flashColor: .blue,
                    bigNumber: $magia.endingCountSum
                )
                // 偶数示唆
                unitResultCountListPercent(
                    title: "偶数示唆",
                    count: $magia.endingCountGusu,
                    flashColor: .yellow,
                    bigNumber: $magia.endingCountSum
                )
                // 高設定示唆
                unitResultCountListPercent(
                    title: "高設定示唆",
                    count: $magia.endingCountHigh,
                    flashColor: .red,
                    bigNumber: $magia.endingCountSum
                )
            } header: {
                Text("カウント結果")
            }
        }
//        .onAppear {
//            if ver280.magiaMenuEndingBadgeStatus != "none" {
//                ver280.magiaMenuEndingBadgeStatus = "none"
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
    magiaViewEnding(magia: Magia())
}
