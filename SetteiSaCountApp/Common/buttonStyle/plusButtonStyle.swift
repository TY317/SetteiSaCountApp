//
//  plusButtonStyle.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/21.
//

import SwiftUI

struct PlusButtonStyle: View {
    
    var body: some View {
        Button {
            
        } label: {
            Text("+10")
        }
        .buttonStyle(plusButtonStyle(
            buttonColor: .personalSummerLightRed
        ))
    }
}


// //////////////
// ボタンスタイル
// //////////////
struct plusButtonStyle: ButtonStyle {
    var buttonColor: Color = .blue
    var maxWidth: CGFloat? = 150
    var height: CGFloat = 50
    var cornerRadius: CGFloat = 10
    var textFont: Font = .title3
    var minusCheck: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: self.maxWidth)
            .frame(height: self.height)
            .background(self.buttonColor)
            .cornerRadius(self.cornerRadius)
            .font(self.textFont)
            .fontWeight(.bold)
            .foregroundStyle(textColor())
            .scaleEffect(configuration.isPressed ? 1.2 : 1.0)
            .shadow(color: buttonColor.opacity(configuration.isPressed ? 4.0 : 0.0), radius: 30, x: 0, y: 0)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
    
    private func textColor() -> Color {
        // マイナスチェックが入ったら基本赤色、背景が赤色の場合のみ黒
        if self.minusCheck {
            if self.buttonColor == Color.red ||
                self.buttonColor == Color.pink {
                return .black
            } else {
                return .red
            }
        }
        // マイナスチェックがなければ基本黒色
        else {
            return .black
        }
    }
}


#Preview {
    PlusButtonStyle()
}
