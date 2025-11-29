//
//  toreveTableCycleModeHitRatio.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/11/25.
//

import SwiftUI

struct toreveTableCycleModeHitRatio: View {
    let modeList: [String] = ["通常A","通常B","チャンス","特殊",]
    @State var selectedMode: String = "通常A"
    
    var body: some View {
        VStack {
            // ピッカー
            Picker("", selection: self.$selectedMode) {
                ForEach(self.modeList, id: \.self) { mode in
                    Text(mode)
                }
            }
            .pickerStyle(.segmented)
            .padding(.bottom)
            
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "1周期",
                    percentList:cycle1Percent(mode: self.selectedMode),
                    numberofDicimal: 1,
                    lineList: cycle1Line(mode: self.selectedMode),
                )
                unitTablePercent(
                    columTitle: "2周期",
                    percentList:cycle2Percent(mode: self.selectedMode),
                    numberofDicimal: 1,
                    lineList: cycle2Line(mode: self.selectedMode),
                )
                unitTablePercent(
                    columTitle: "3周期",
                    percentList:cycle3Percent(mode: self.selectedMode),
                    numberofDicimal: 1,
                    lineList: cycle3Line(mode: self.selectedMode),
                )
            }
            
            if self.selectedMode != self.modeList[2] {
                HStack(spacing: 0) {
                    unitTableSettingIndex()
                    unitTablePercent(
                        columTitle: "4周期",
                        percentList:cycle4Percent(mode: self.selectedMode),
                        numberofDicimal: 1,
                        lineList: cycle4Line(mode: self.selectedMode),
                    )
                    unitTablePercent(
                        columTitle: "5周期",
                        percentList:cycle5Percent(mode: self.selectedMode),
                        numberofDicimal: 1,
                        lineList: cycle5Line(mode: self.selectedMode),
                    )
                    unitTablePercent(
                        columTitle: "6周期",
                        percentList:[100],
                        numberofDicimal: 0,
                        lineList: [6],
                    )
                }
            }
        }
    }
    
    private func cycle1Percent(mode: String) -> [Double] {
        switch mode {
        case "通常A": return [34.4,34.8,35.2,35.5]
        case "通常B": return [9.8,10.2,10.5]
        case "チャンス": return [7.4,7.8,8.2,9]
        case "特殊": return [25]
        default: return [0,0,0,0,0,0]
        }
    }
    private func cycle1Line(mode: String) -> [Int] {
        switch mode {
        case "通常A": return [3,1,1,1]
        case "通常B": return [1,3,2]
        case "チャンス": return [3,1,1,1]
        case "特殊": return [6]
        default: return [1,1,1,1,1,1]
        }
    }
    
    private func cycle2Percent(mode: String) -> [Double] {
        switch mode {
        case "通常A": return [17.6,18.0,19.1,22.7,25.4,27.3]
        case "通常B": return [20.3]
        case "チャンス": return [34.4,35.5,39.8,42.2,46.1]
        case "特殊": return [17.6,18.4,18.8,19.1,19.5,19.9]
        default: return [0,0,0,0,0,0]
        }
    }
    private func cycle2Line(mode: String) -> [Int] {
        switch mode {
        case "通常A": return [1,1,1,1,1,1]
        case "通常B": return [6]
        case "チャンス": return [2,1,1,1,1]
        case "特殊": return [1,1,1,1,1,1]
        default: return [1,1,1,1,1,1]
        }
    }
    
    private func cycle3Percent(mode: String) -> [Double] {
        switch mode {
        case "通常A": return [29.3,29.7,30.9,37.5,39.8,44.9]
        case "通常B": return [52.3,52.7,53.1,53.5,53.9]
        case "チャンス": return [100]
        case "特殊": return [34.4,35.2,35.5,36.7,37.5,38.3]
        default: return [0,0,0,0,0,0]
        }
    }
    private func cycle3Line(mode: String) -> [Int] {
        switch mode {
        case "通常A": return [1,1,1,1,1,1]
        case "通常B": return [1,2,1,1,1]
        case "チャンス": return [6]
        case "特殊": return [1,1,1,1,1,1]
        default: return [1,1,1,1,1,1]
        }
    }
    
    private func cycle4Percent(mode: String) -> [Double] {
        switch mode {
        case "通常A": return [25,25.4,25.8,27,28.1,29.7]
        case "通常B": return [25,25.8,27,27.7]
        case "特殊": return [25]
        default: return [0,0,0,0,0,0]
        }
    }
    private func cycle4Line(mode: String) -> [Int] {
        switch mode {
        case "通常A": return [1,1,1,1,1,1]
        case "通常B": return [3,1,1,1]
        case "特殊": return [6]
        default: return [1,1,1,1,1,1]
        }
    }
    
    private func cycle5Percent(mode: String) -> [Double] {
        switch mode {
        case "通常A": return [33.2,33.6,34,34.8,35.9]
        case "通常B": return [33.2,33.6,34.4,35.2,35.9]
        case "特殊": return [17.6]
        default: return [0,0,0,0,0,0]
        }
    }
    private func cycle5Line(mode: String) -> [Int] {
        switch mode {
        case "通常A": return [2,1,1,1,1]
        case "通常B": return [2,1,1,1,1]
        case "特殊": return [6]
        default: return [1,1,1,1,1,1]
        }
    }
}

#Preview {
    ScrollView {
        toreveTableCycleModeHitRatio()
    }
    .padding(.horizontal)
}
