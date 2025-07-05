//
//  unitCountButtonDenominateWithFunc.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/28.
//

import SwiftUI

struct unitCountButtonDenominateWithFunc: View {
    @State var title: String
    @Binding var count: Int
    @State var color: Color
    @Binding var bigNumber: Int
    @State var numberofDicimal: Int
    @Binding var minusBool: Bool
    @State var flushColor: Color?
    @State var flushBool: Bool?
    var denominator: Double {
        let deno = Double(bigNumber) / Double(count)
        return count > 0 ? deno : 0.0
    }
    @State var minusColor: Color = .red
    let action: () -> Void
    
    var body: some View {
        ZStack {
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
            VStack(spacing: 5) {
                // タイトル
                Text(self.title)
                // 確率
                HStack(spacing: 0) {
                    Text("\(self.count > 0 ? 1 : 0)/")
                        .font(.footnote)
                        .lineLimit(1)
                    Text("\(String(format:"%.\(self.numberofDicimal)f",self.denominator))")
                        .font(.title3)
                        .fontWeight(.bold)
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
                .buttonStyle(CountButtonStyle(color: self.color, minusColor: self.minusColor, MinusBool: minusBool))
            }
        }
    }
}

#Preview {
    @Previewable @State var buttonCount: Int = 0
    @Previewable @State var buttonCountSum: Int = 1000
    @Previewable @State var minusCheck: Bool = false
    @Previewable @State var sumNumber: Int = 0
    unitCountButtonDenominateWithFunc(
        title: "弱スイカ",
        count: $buttonCount,
        color: .green,
        bigNumber: $buttonCountSum,
        numberofDicimal: 0,
        minusBool: $minusCheck,
        action: testFunc
    )
}


