//
//  unitCountButtonVerticalDenominateAnotherDisplayNumber.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/19.
//

import SwiftUI


// //////////////////////
// ビュー：縦型カウントボタン、確率分母タイプ
//       ボタンでカウントされる変数と表示する変数が別
// //////////////////////
struct unitCountButtonVerticalDenominateAnotherDisplayNumber: View {
    @State var title: String
    @Binding var count: Int
    @Binding var displayNumber: Int
    @State var color: Color
    @Binding var bigNumber: Int
    @State var numberofDicimal: Int
    @Binding var minusBool: Bool
    @State var flushColor: Color?
    @State var flushBool: Bool?
    var denominator: Double {
        let deno = Double(bigNumber) / Double(displayNumber)
        return displayNumber > 0 ? deno : 0.0
    }
    @State var minusColor: Color = .red
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
                    Text("\(self.displayNumber > 0 ? 1 : 0)/")
                        .font(.footnote)
                        .lineLimit(1)
                    Text("\(String(format:"%.\(self.numberofDicimal)f",self.denominator))")
                        .font(.title3)
                        .fontWeight(.bold)
                        .lineLimit(1)
                }
                // 回数
                if self.displayNumber < 1000{
                    Text("\(self.displayNumber)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .lineLimit(1)
                }
                else {
                    Text("\(self.displayNumber)")
                        .font(.title3)
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .padding(.vertical, 8.0)
                }
                // カウントボタン
                Button(action: {
                    self.count = countUpDown(minusCheck: minusBool, count: self.count)
                }, label: {
                    Text("")
                })
                .buttonStyle(CountButtonStyle(color: self.color, minusColor: self.minusColor, MinusBool: minusBool))
            }
        }
    }
}

//#Preview {
//    unitCountButtonVerticalDenominateAnotherDisplayNumber()
//}
