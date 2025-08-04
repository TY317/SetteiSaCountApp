//
//  darlingViewEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/03.
//

import SwiftUI

struct darlingViewEnding: View {
    @ObservedObject var darling: Darling
    @State var isShowAlert = false
    let segmentList: [String] = [
        "ストレリチア目以外",
        "ストレリチア目",
    ]
    @State var selectedSegment: String = "ストレリチア目以外"
    let cardList: [String] = [
        "イク(白)",
        "ミク(青)",
        "ココロ(黄)",
        "イチゴ(緑)",
        "ゼロツー(赤)",
        "ストレリチア(虹)",
    ]
    @State var selectedCard: String = "イク(白)"
    let cardSisa: [String] = [
        "デフォルト",
        "1・3 示唆",
        "2・4・5 示唆",
        "5 示唆\n1・6 示唆弱",
        "2 以上濃厚\n4・6 示唆",
        "6 濃厚",
    ]
    let ilustList: [String] = [
        "屋内風景",
        "箱とリボン",
        "集合写真",
        "女子メンバー集合",
        "絵本(魔物)",
        "ゼロツー&ヒロ",
        "ゼロツー",
    ]
    @State var selectedIlust: String = "屋内風景"
    let ilustSisa: [String] = [
        "1示唆 強",
        "2示唆 強",
        "3示唆 強",
        "4示唆 強",
        "5示唆 強",
        "6示唆 強",
        "2 以上濃厚\n4 以上示唆 強",
    ]
    
    var body: some View {
        List {
            // カード選択
            Section {
                // 注意書き
                Text("レア役時のカード・イラストで設定を示唆\nストレリチア目とそれ以外で表示内容が異なる")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // セグメント選択
                Picker("", selection: self.$selectedSegment) {
                    ForEach(self.segmentList, id: \.self) { seg in
                        Text(seg)
                    }
                }
                .pickerStyle(.segmented)
                // ストレリチア目以外
                if self.selectedSegment == self.segmentList[0] {
                    // サークルピッカー
                    Picker("", selection: self.$selectedCard) {
                        ForEach(self.cardList, id: \.self) { card in
                            Text(card)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 150)
                    // 示唆&登録ボタン
                    unitCountSubmitWithResult(
                        title: cardSisaText(card: self.selectedCard),
                        count: bindingForCard(card: self.selectedCard),
                        bigNumber: $darling.endingCountSum,
                        flushColor: flushColor(card: self.selectedCard),
                        minusCheck: $darling.minusCheck) {
                            darling.eindingSumFunc()
                        }
                }
                // ストレリチア目
                else {
                    // サークルピッカー
                    Picker("", selection: self.$selectedIlust) {
                        ForEach(self.ilustList, id: \.self) { ilust in
                            Text(ilust)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 150)
                    // 示唆
                    Text(ilustSisaText(ilust: self.selectedIlust))
                    // ダミーボタン
                    if darling.minusCheck {
                        Text("マイナス")
                            .foregroundStyle(Color.secondary)
                            .frame(maxWidth: .infinity, alignment: .center)
                    } else {
                        Text("登録")
                            .foregroundStyle(Color.secondary)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            } header: {
                Text("カード・イラスト選択")
            }
            
            // //// カウント結果
            Section {
                ForEach(self.cardList, id: \.self) { card in
                    unitResultCountListPercent(
                        title: cardSisaText(card: card),
                        count: bindingForCard(card: card),
                        flashColor: flushColor(card: card),
                        bigNumber: $darling.endingCountSum
                    )
                }
            } header: {
                Text("カウント結果(ストレリチア目以外)")
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: darling.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("エンディング")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $darling.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: darling.resetEnding)
                }
            }
        }
    }
    
    private func cardSisaText(card: String) -> String {
        switch card {
        case self.cardList[0]: return self.cardSisa[0]
        case self.cardList[1]: return self.cardSisa[1]
        case self.cardList[2]: return self.cardSisa[2]
        case self.cardList[3]: return self.cardSisa[3]
        case self.cardList[4]: return self.cardSisa[4]
        case self.cardList[5]: return self.cardSisa[5]
        default: return self.cardSisa[0]
        }
    }
    private func bindingForCard(card: String) -> Binding<Int> {
        switch card {
        case self.cardList[0]: return darling.$endingCountDefault
        case self.cardList[1]: return darling.$endingCount13sisa
        case self.cardList[2]: return darling.$endingCount245sisa
        case self.cardList[3]: return darling.$endingCount5sisa
        case self.cardList[4]: return darling.$endingCountOver2
        case self.cardList[5]: return darling.$endingCountOver6
        default: return .constant(0)
        }
    }
    private func flushColor(card: String) -> Color {
        switch card {
        case self.cardList[0]: return .gray
        case self.cardList[1]: return .blue
        case self.cardList[2]: return .yellow
        case self.cardList[3]: return .green
        case self.cardList[4]: return .red
        case self.cardList[5]: return .orange
        default: return .gray
        }
    }
    private func ilustSisaText(ilust: String) -> String {
        switch ilust {
        case self.ilustList[0]: return self.ilustSisa[0]
        case self.ilustList[1]: return self.ilustSisa[1]
        case self.ilustList[2]: return self.ilustSisa[2]
        case self.ilustList[3]: return self.ilustSisa[3]
        case self.ilustList[4]: return self.ilustSisa[4]
        case self.ilustList[5]: return self.ilustSisa[5]
        case self.ilustList[6]: return self.ilustSisa[6]
        default: return "???"
        }
    }
}

#Preview {
    darlingViewEnding(
        darling: Darling(),
    )
}
