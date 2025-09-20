//
//  toreveViewEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/20.
//

import SwiftUI

struct toreveViewEnding: View {
    @ObservedObject var ver391: Ver391
    @ObservedObject var toreve: Toreve
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   //
    @State var isShowAlert = false
    @State var selectedColor: String = "青"
    let colorList: [String] = ["青", "黄", "緑", "赤", "虹"]
    
    var body: some View {
        List {
            Section {
                // サークルピッカー
                Picker("", selection: self.$selectedColor) {
                    ForEach(self.colorList, id: \.self) { lampColor in
                        Text(lampColor)
                    }
                }
                .pickerStyle(.wheel)
                .frame(height: 150)
                // 示唆＆登録ボタン
                unitCountSubmitWithResult(
                    title: sisaText(lamp: self.selectedColor),
                    count: bindingCount(lamp: self.selectedColor),
                    bigNumber: $toreve.endingCountSum,
                    flushColor: flushColor(lamp: self.selectedColor),
                    minusCheck: $toreve.minusCheck) {
                        toreve.endingCountSumFunc()
                    }
            } header: {
                Text("トップランプ色カウント")
            }
            
            // //// カウント結果
            Section {
                ForEach(self.colorList, id: \.self) { lamp in
                    unitResultCountListPercent(
                        title: sisaText(lamp: lamp),
                        count: bindingCount(lamp: lamp),
                        flashColor: flushColor(lamp: lamp),
                        bigNumber: $toreve.endingCountSum,
                        numberofDigit: 0,
                    )
                }
            } header: {
                Text("カウント結果")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($ver391.toreveMenuEndingBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: toreve.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("エンディング")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $toreve.minusCheck)
                    // /// リセット
                    unitButtonReset(
                        isShowAlert: $isShowAlert,
                        action: toreve.resetEnding,
                    )
                }
            }
        }
    }
    private func sisaText(lamp: String) -> String {
        switch lamp {
        case self.colorList[0]: return "奇数示唆"
        case self.colorList[1]: return "偶数示唆"
        case self.colorList[2]: return "奇数＆高設定示唆"
        case self.colorList[3]: return "偶数＆高設定示唆"
        case self.colorList[4]: return "設定6 濃厚"
        default: return "???"
        }
    }
    private func bindingCount(lamp: String) -> Binding<Int> {
        switch lamp {
        case self.colorList[0]: return $toreve.endingCountBlue
        case self.colorList[1]: return $toreve.endingCountYellow
        case self.colorList[2]: return $toreve.endingCountGreen
        case self.colorList[3]: return $toreve.endingCountRed
        case self.colorList[4]: return $toreve.endingCountRainbow
        default: return .constant(0)
        }
    }
    private func flushColor(lamp: String) -> Color {
        switch lamp {
        case self.colorList[0]: return Color.blue
        case self.colorList[1]: return Color.yellow
        case self.colorList[2]: return Color.green
        case self.colorList[3]: return Color.red
        case self.colorList[4]: return Color.purple
        default: return Color.gray
        }
    }
}

#Preview {
    toreveViewEnding(
        ver391: Ver391(),
        toreve: Toreve(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
