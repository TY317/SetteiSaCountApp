//
//  unitChart95CiPercentNotBinding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/01.
//

import SwiftUI
import Charts

struct unitChart95CiPercentNotBinding: View {
    let currentCount: Int
    let bigNumber: Int
    let setting1Enable: Bool = true
    let setting1Percent: Double
    let setting2Enable: Bool = true
    let setting2Percent: Double
    let setting3Enable: Bool = true
    let setting3Percent: Double
    let setting4Enable: Bool = true
    let setting4Percent: Double
    let setting5Enable: Bool = true
    let setting5Percent: Double
    let setting6Enable: Bool = true
    let setting6Percent: Double
    let xAxisTitle: String = "設定"
    let barOpacity: Double = 0.5
    let chartHeight: CGFloat = 250
    let ruleMarkColor: Color = .red
    @State var yScaleKeisu: Double = 0.2
    
    var body: some View {
        Chart {
            // 設定1
            if self.setting1Enable {
                BarMark(
                    x: .value(self.xAxisTitle, "設定1"),
                    yStart: .value("下限", statistical95LowerPercent(percent: self.setting1Percent, times: self.bigNumber)),
                    yEnd: .value("上限", statistical95UpperPercent(percent: self.setting1Percent, times: self.bigNumber))
                )
                .foregroundStyle(Color.gray)
                .opacity(self.barOpacity)
            }
            
            // 設定2
            if self.setting2Enable {
                BarMark(
                    x: .value(self.xAxisTitle, "設定2"),
                    yStart: .value("下限", statistical95LowerPercent(percent: self.setting2Percent, times: self.bigNumber)),
                    yEnd: .value("上限", statistical95UpperPercent(percent: self.setting2Percent, times: self.bigNumber))
                )
                .foregroundStyle(Color.blue)
                .opacity(self.barOpacity)
            }
            
            // 設定3
            if self.setting3Enable {
                BarMark(
                    x: .value(self.xAxisTitle, "設定3"),
                    yStart: .value("下限", statistical95LowerPercent(percent: self.setting3Percent, times: self.bigNumber)),
                    yEnd: .value("上限", statistical95UpperPercent(percent: self.setting3Percent, times: self.bigNumber))
                )
                .foregroundStyle(Color.yellow)
                .opacity(self.barOpacity)
            }
            
            // 設定4
            if self.setting4Enable {
                BarMark(
                    x: .value(self.xAxisTitle, "設定4"),
                    yStart: .value("下限", statistical95LowerPercent(percent: self.setting4Percent, times: self.bigNumber)),
                    yEnd: .value("上限", statistical95UpperPercent(percent: self.setting4Percent, times: self.bigNumber))
                )
                .foregroundStyle(Color.green)
                .opacity(self.barOpacity)
            }
            
            // 設定5
            if self.setting5Enable {
                BarMark(
                    x: .value(self.xAxisTitle, "設定5"),
                    yStart: .value("下限", statistical95LowerPercent(percent: self.setting5Percent, times: self.bigNumber)),
                    yEnd: .value("上限", statistical95UpperPercent(percent: self.setting5Percent, times: self.bigNumber))
                )
                .foregroundStyle(Color.purple)
                .opacity(self.barOpacity)
            }
            
            // 設定6
            if self.setting6Enable {
                BarMark(
                    x: .value(self.xAxisTitle, "設定6"),
                    yStart: .value("下限", statistical95LowerPercent(percent: self.setting6Percent, times: self.bigNumber)),
                    yEnd: .value("上限", statistical95UpperPercent(percent: self.setting6Percent, times: self.bigNumber))
                )
                .foregroundStyle(Color.red)
                .opacity(self.barOpacity)
            }
            
            // 現在値の赤ライン
            RuleMark(
                y: .value("現状", self.currentCount)
            )
            .foregroundStyle(self.ruleMarkColor)
        }
        .chartYScale(domain: yScaleMin()...yScaleMax())
        .frame(height: self.chartHeight)
    }
    private func minPercent() -> Double {
        var firstInput = false
        var minimumPercent = 0.0
        let currentPercent = bigNumber > 0 ? Double(currentCount / bigNumber * 100) : 0.0
        // 設定1
        if self.setting1Enable && self.setting1Percent >= 0 {
            minimumPercent = self.setting1Percent
            firstInput = true
        } else {
            
        }
        // 設定2
        if self.setting2Enable && self.setting2Percent >= 0 {
            if !firstInput {
                minimumPercent = self.setting2Percent
                firstInput = true
            } else if minimumPercent > self.setting2Percent {
                minimumPercent = self.setting2Percent
            }
        }
        // 設定3
        if self.setting3Enable && self.setting3Percent >= 0 {
            if !firstInput {
                minimumPercent = self.setting3Percent
                firstInput = true
            } else if minimumPercent > self.setting3Percent {
                minimumPercent = self.setting3Percent
            }
        }
        // 設定4
        if self.setting4Enable && self.setting4Percent >= 0 {
            if !firstInput {
                minimumPercent = self.setting4Percent
                firstInput = true
            } else if minimumPercent > self.setting4Percent {
                minimumPercent = self.setting4Percent
            }
        }
        // 設定5
        if self.setting5Enable && self.setting5Percent >= 0 {
            if !firstInput {
                minimumPercent = self.setting5Percent
                firstInput = true
            } else if minimumPercent > self.setting5Percent {
                minimumPercent = self.setting5Percent
            }
        }
        // 設定6
        if self.setting6Enable && self.setting6Percent >= 0 {
            if !firstInput {
                minimumPercent = self.setting6Percent
                firstInput = true
            } else if minimumPercent > self.setting6Percent {
                minimumPercent = self.setting6Percent
            }
        }
        // 現在確率
        if minimumPercent > currentPercent {
            minimumPercent = currentPercent
        }
        return minimumPercent
    }
    
    private func maxPercent() -> Double {
        var maximumPercent = 0.0
        var firstInput = false
        let currentPercent = bigNumber > 0 ? Double(currentCount / bigNumber * 100) : 0.0
        // 設定1
        if self.setting1Enable && self.setting1Percent >= 0 {
            maximumPercent = self.setting1Percent
            firstInput = true
        } else {
            
        }
        // 設定2
        if self.setting2Enable && self.setting2Percent >= 0 {
            if !firstInput {
                maximumPercent = self.setting2Percent
                firstInput = true
            } else if maximumPercent < self.setting2Percent {
                maximumPercent = self.setting2Percent
            }
        }
        // 設定3
        if self.setting3Enable && self.setting3Percent >= 0 {
            if !firstInput {
                maximumPercent = self.setting3Percent
                firstInput = true
            } else if maximumPercent < self.setting3Percent {
                maximumPercent = self.setting3Percent
            }
        }
        // 設定4
        if self.setting4Enable && self.setting4Percent >= 0 {
            if !firstInput {
                maximumPercent = self.setting4Percent
                firstInput = true
            } else if maximumPercent < self.setting4Percent {
                maximumPercent = self.setting4Percent
            }
        }
        // 設定5
        if self.setting5Enable && self.setting5Percent >= 0 {
            if !firstInput {
                maximumPercent = self.setting5Percent
                firstInput = true
            } else if maximumPercent < self.setting5Percent {
                maximumPercent = self.setting5Percent
            }
        }
        // 設定6
        if self.setting6Enable && self.setting6Percent >= 0 {
            if !firstInput {
                maximumPercent = self.setting6Percent
                firstInput = true
            } else if maximumPercent < self.setting6Percent {
                maximumPercent = self.setting6Percent
            }
        }
        // 現在確率
        if maximumPercent < currentPercent {
            maximumPercent = currentPercent
        }
        return maximumPercent
    }
    private func yScaleMax() -> Double {
        var yMax: Double = 0
        var firstInput = false
        // 設定1
        if self.setting1Enable && self.setting1Percent >= 0 {
            let yUpper = statistical95UpperPercent(percent: self.setting1Percent, times: self.bigNumber)
            if !firstInput {
                yMax = yUpper
                firstInput = true
            } else {
                
            }
        }
        // 設定2
        if self.setting2Enable && self.setting2Percent >= 0 {
            let yUpper = statistical95UpperPercent(percent: self.setting2Percent, times: self.bigNumber)
            if !firstInput {
                yMax = yUpper
                firstInput = true
            } else if yMax < yUpper {
                yMax = yUpper
            }
        }
        // 設定3
        if self.setting3Enable && self.setting3Percent >= 0 {
            let yUpper = statistical95UpperPercent(percent: self.setting3Percent, times: self.bigNumber)
            if !firstInput {
                yMax = yUpper
                firstInput = true
            } else if yMax < yUpper {
                yMax = yUpper
            }
        }
        // 設定4
        if self.setting4Enable && self.setting4Percent >= 0 {
            let yUpper = statistical95UpperPercent(percent: self.setting4Percent, times: self.bigNumber)
            if !firstInput {
                yMax = yUpper
                firstInput = true
            } else if yMax < yUpper {
                yMax = yUpper
            }
        }
        // 設定5
        if self.setting5Enable && self.setting5Percent >= 0 {
            let yUpper = statistical95UpperPercent(percent: self.setting5Percent, times: self.bigNumber)
            if !firstInput {
                yMax = yUpper
                firstInput = true
            } else if yMax < yUpper {
                yMax = yUpper
            }
        }
        // 設定6
        if self.setting6Enable && self.setting6Percent >= 0 {
            let yUpper = statistical95UpperPercent(percent: self.setting6Percent, times: self.bigNumber)
            if !firstInput {
                yMax = yUpper
                firstInput = true
            } else if yMax < yUpper {
                yMax = yUpper
            }
        }
        // 現在カウント値
        if yMax < Double(self.currentCount) {
            yMax = Double(self.currentCount)
        }
        return yMax * (1 + self.yScaleKeisu)
    }
    
    private func yScaleMin() -> Double {
        var yMin: Double = 0
        var firstInput = false
        // 設定1
        if self.setting1Enable && self.setting1Percent >= 0 {
            let yLower = statistical95LowerPercent(percent: self.setting1Percent, times: self.bigNumber)
            if !firstInput {
                yMin = yLower
                firstInput = true
            } else {
                
            }
        }
        // 設定2
        if self.setting2Enable && self.setting2Percent >= 0 {
            let yLower = statistical95LowerPercent(percent: self.setting2Percent, times: self.bigNumber)
            if !firstInput {
                yMin = yLower
                firstInput = true
            } else if yMin > yLower {
                yMin = yLower
            }
        }
        // 設定3
        if self.setting3Enable && self.setting3Percent >= 0 {
            let yLower = statistical95LowerPercent(percent: self.setting3Percent, times: self.bigNumber)
            if !firstInput {
                yMin = yLower
                firstInput = true
            } else if yMin > yLower {
                yMin = yLower
            }
        }
        // 設定4
        if self.setting4Enable && self.setting4Percent >= 0 {
            let yLower = statistical95LowerPercent(percent: self.setting4Percent, times: self.bigNumber)
            if !firstInput {
                yMin = yLower
                firstInput = true
            } else if yMin > yLower {
                yMin = yLower
            }
        }
        // 設定5
        if self.setting5Enable && self.setting5Percent >= 0 {
            let yLower = statistical95LowerPercent(percent: self.setting5Percent, times: self.bigNumber)
            if !firstInput {
                yMin = yLower
                firstInput = true
            } else if yMin > yLower {
                yMin = yLower
            }
        }
        // 設定6
        if self.setting6Enable && self.setting6Percent >= 0 {
            let yLower = statistical95LowerPercent(percent: self.setting6Percent, times: self.bigNumber)
            if !firstInput {
                yMin = yLower
                firstInput = true
            } else if yMin > yLower {
                yMin = yLower
            }
        }
        // 現在カウント値
        if yMin > Double(self.currentCount) {
            yMin = Double(self.currentCount)
        }
        return self.currentCount > 0 ? yMin - (yScaleMax() * self.yScaleKeisu) : 0.0
    }
}

//#Preview {
//    unitChart95CiPercentNotBinding()
//}
