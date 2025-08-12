//
//  bayesResultView.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/11.
//

import SwiftUI
import Charts

struct bayesResultView: View {
    var settingList: [Int] = [1,2,3,4,5,6]
    let resultGuess: [Double]
    let payoutList: [Double]
    let xAxisTitle: String = "設定"
    let yAxisTitle: String = "期待確率"
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List {
                // //// 事後確率とグラフの表示
                Section {
                    // 設定ごとの確率テーベル
                    HStack(spacing: 0) {
                        ForEach(self.settingList.indices, id: \.self) { index in
                            if self.resultGuess.indices.contains(index) {
                                unitTablePercent(
                                    columTitle: "設定\(self.settingList[index])",
                                    percentList: [self.resultGuess[index]],
                                    titleFont: .body,
                                    colorList: [.white]
                                )
                            }
                        }
                    }
                    // 棒グラフの表示
                    Chart {
                        ForEach(self.settingList.indices, id: \.self) { index in
                            BarMark(
                                x: .value(
                                    self.xAxisTitle,
                                    "設定\(self.settingList[index])"
                                         ),
                                y: .value(
                                    self.yAxisTitle,
                                    self.resultGuess[index],
                                )
                            )
                            .foregroundStyle(barMarkColor(setting: self.settingList[index]))
                            .opacity(0.7)
                        }
                    }
                    .frame(height: 200)
                }
                
                // //// 期待値
                Section {
                    HStack {
                        // 設定
                        VStack {
                            Text("設定")
                                .font(.title3)
                                .fontWeight(.bold)
                            let setting = averageSetting()
                            Text("\(setting, specifier: "%.1f")")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        Rectangle()
                            .frame(width: 1)
                        // 機械割
                        VStack {
                            Text("機械割")
                                .font(.title3)
                                .fontWeight(.bold)
                            let payout = averagePayout()
                            HStack(spacing: 3) {
                                Text("\(payout, specifier: "%.1f")")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                Text("%")
                            }
                            .offset(x: 11)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                    unitLinkButtonViewBuilder(sheetTitle: "機械割", linkText: "機械割") {
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTablePercent(
                                columTitle: "機械割",
                                percentList: self.payoutList,
                                numberofDicimal: 1,
                            )
                        }
                    }
                } header: {
                    Text("期待値")
                }
            }
            .navigationTitle("計算結果")
            .navigationBarTitleDisplayMode(.inline)
            // //// ツールバー閉じるボタン
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("閉じる")
                            .fontWeight(.bold)
                    })
                }
            }
        }
    }
    func barMarkColor(setting: Int) -> Color {
        switch setting {
        case 1: return .gray
        case 2: return .blue
        case 3: return .yellow
        case 4: return .green
        case 5: return .purple
        case 6: return .red
        default: return .gray
        }
    }
    
    func averageSetting() -> Double {
        var ave: Double = 0
        for (i, res) in resultGuess.enumerated() {
            ave += Double(i+1) * res/100
        }
        return ave
    }
    func averagePayout() -> Double {
        var ave: Double = 0
        for (i, res) in resultGuess.enumerated() {
            ave += res/100 * payoutList[i]
        }
        return ave
    }
}

#Preview {
    bayesResultView(
        settingList: [1,2,4,5,6],
        resultGuess: [72,21,2,3,1,1],
        payoutList: [97,98,99.9,102.8,105.3,109.4]
//        resultGuess: [72,21,3,1,1],
    )
}
