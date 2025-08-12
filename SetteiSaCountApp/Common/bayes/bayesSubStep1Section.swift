//
//  bayesSubStep1Section.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/10.
//

import SwiftUI

struct bayesSubStep1Section: View {
    @ObservedObject var bayes: Bayes
    var settingList: [Int] = [1,2,3,4,5,6]
    @Binding var guessCustom1: [Int]
    @Binding var guessCustom2: [Int]
    @Binding var guessCustom3: [Int]
    
    var body: some View {
        // //// step1)設定配分
        Section {
            // パターン選択
            unitPickerMenuString(
                title: "設定配分パターン",
                selected: bayes.$selectedBeforeGuessPattern,
                selectlist: bayes.guessPatternList,
            )
            // 配分表
            HStack(spacing: 0) {
                let guessArray = selectedBeforeGuess(pattern: bayes.selectedBeforeGuessPattern)
                ForEach(guessArray.indices, id: \.self) { index in
                    let total: Double = Double(guessArray.reduce(0, +))
                    let guess: Double = Double(guessArray[index]) / total * 100
                    unitTablePercent(
                        columTitle: "設定\(self.settingList[index])",
                        percentList: [guess],
                        titleFont: .body,
                        colorList: [.white],
                    )
                }
            }
        } header: {
            HStack {
                Text("STEP1) 設定配分予想")
                unitToolbarButtonQuestion {
                    unitExView5body2image(
                        title: "STEP1)設定配分予想",
                        textBody1: "・店、または島・機種の設定配分予想をセットして下さい",
                        textBody2: "・デフォルトは設定投入率の全国平均値を想定した数値となっています",
                        textBody3: "・カスタムパターンも3種類設定可能です。右上の設定ボタンで詳細の数値を調整して下さい",
                        textBody4: "・強い根拠がない場合はデフォルト設定のままを推奨します",
                        textBody5: "・判別結果に最も影響を与えるSTEPです。デフォルト設定の場合よほどのことがない限り高設定濃厚の数値にはなりませんが、それが現実だと思います。",
                    )
                }
            }
        }
    }
    func selectedBeforeGuess(pattern: String) -> [Int] {
        switch pattern {
        case bayes.guessPatternList[0]: return bayes.guess6Default
        case bayes.guessPatternList[1]: return bayes.guess6JugDefault
        case bayes.guessPatternList[2]: return bayes.guess6Evenly
        case bayes.guessPatternList[3]: return bayes.guess6Half
        case bayes.guessPatternList[4]: return bayes.guess6Quater
        case bayes.guessPatternList[5]: return self.guessCustom1
        case bayes.guessPatternList[6]: return self.guessCustom2
        case bayes.guessPatternList[7]: return self.guessCustom3
        default: return bayes.guess6Default
        }
    }
}

#Preview {
    @Previewable @State var guess1: [Int] = [1,1,1,1,1,1]
    @Previewable @State var guess2: [Int] = [1,1,1,1,1,1]
    @Previewable @State var guess3: [Int] = [1,1,1,1,1,1]
    List {
        bayesSubStep1Section(
            bayes: Bayes(),
            guessCustom1: $guess1,
            guessCustom2: $guess2,
            guessCustom3: $guess3,
        )
    }
}
