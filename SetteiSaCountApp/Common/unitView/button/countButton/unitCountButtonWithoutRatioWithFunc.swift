//
//  unitCountButtonWithoutRatioWithFunc.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/05.
//

import SwiftUI

struct unitCountButtonWithoutRatioWithFunc: View {
    @State var title: String
    @Binding var count: Int
    @State var color: Color
    @Binding var minusBool: Bool
    @State var flushColor: Color?
    @State var flushBool: Bool?
    var vSpaceBool: Bool = false
    let action: () -> Void
    var vstackSpacing: CGFloat = 2
    
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
                if self.vSpaceBool {
                    Text("100")
                        .font(.title3)
                        .foregroundStyle(Color.clear)
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
    @Previewable @State var minusCheck: Bool = false
    unitCountButtonWithoutRatioWithFunc(
        title: "test",
        count: $buttonCount,
        color: .green,
        minusBool: $minusCheck,
        action: testFunc,
    )
}
