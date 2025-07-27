//
//  unitCountButtonPercentWithFunc.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/20.
//

import SwiftUI

struct unitCountButtonPercentWithFunc: View {
    @State var title: String
    @Binding var count: Int
    @State var color: Color
    @Binding var bigNumber: Int
    @State var numberofDicimal: Int
    @Binding var minusBool: Bool
    @State var flushColor: Color?
    @State var flushBool: Bool?
    var ratio: Double {
        let rat = Double(count) / Double(bigNumber) * 100
        return bigNumber > 0 ? rat : 0.0
    }
    var vstackSpacing: CGFloat = 2
    let action: () -> Void
    
    var body: some View {
        ZStack {
            // 背景フラッシュ部分
            if let flushBool = self.flushBool {
                if flushBool {
                    // 背景フラッシュ部分
                    if let flushColor = self.flushColor {
                        Rectangle()
                            .backgroundFlashModifier(trigger: self.count, color: flushColor)
                    } else {
                        Rectangle()
                            .backgroundFlashModifier(trigger: self.count, color: self.color)
                    }
                }
                else {
                    Rectangle()
//                        .foregroundColor(Color.clear)
                        .foregroundStyle(Color.clear)
                }
            }
            else {
                // 背景フラッシュ部分
                if let flushColor = self.flushColor {
                    Rectangle()
                        .backgroundFlashModifier(trigger: self.count, color: flushColor)
                } else {
                    Rectangle()
                        .backgroundFlashModifier(trigger: self.count, color: self.color)
                }
            }
            // //// ボタンと表示部分
            VStack(spacing: self.vstackSpacing) {
                // タイトル
                Text(self.title)
                    .multilineTextAlignment(.center)
                // 確率
                HStack(spacing: 0) {
                    Text("\(String(format:"%.\(self.numberofDicimal)f",self.ratio))")
                        .font(.title3)
                        .fontWeight(.bold)
                        .lineLimit(1)
                    Text("%")
                        .font(.footnote)
                        .lineLimit(1)
                }
                // 回数
                if self.count < 1000{
                    Text("\(self.count)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .lineLimit(1)
                }
                else {
                    Text("\(self.count)")
                        .font(.title3)
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .padding(.vertical, 8.0)
                }
                // カウントボタン
                Button(action: {
                    self.count = countUpDown(minusCheck: minusBool, count: self.count)
                    self.action()
                }, label: {
                    Text("")
                })
                .buttonStyle(CountButtonStyle(color: self.color, MinusBool: minusBool))
            }
        }
    }
}

#Preview {
    @Previewable @State var buttonCount: Int = 0
    @Previewable @State var buttonCountSum: Int = 1000
    @Previewable @State var minusCheck: Bool = false
    @Previewable @State var sumNumber: Int = 0
    unitCountButtonPercentWithFunc(
        title: "test",
        count: $buttonCount,
        color: .blue,
        bigNumber: $buttonCountSum,
        numberofDicimal: 0,
        minusBool: $minusCheck,
        action: testFunc,
    )
}
