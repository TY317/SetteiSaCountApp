//
//  unitPlusButton.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/21.
//

import SwiftUI

struct unitPlusButton: View {
    @Binding var count: Int
    var plusNumber: Int
    var buttonColor: Color
    var minusCheck: Bool
    var maxWidth: CGFloat = 150
    var height: CGFloat = 40
    @State var flashBool: Bool = false
    
    var body: some View {
        ZStack {
            // 背景フラッシュ部分
            Rectangle()
                .modifierBackGroundFlashBool(
                    trigger: self.flashBool,
                    color: self.buttonColor
                )
            
            // ボタン
            Button {
                self.count = countUpDownFixNumber(
                    count: self.count,
                    plusNumber: self.plusNumber,
                    minusCheck: self.minusCheck
                )
                self.flashBool.toggle()
            } label: {
                Text("\(plusOrMinusText())\(self.plusNumber)")
            }
            .buttonStyle(plusButtonStyle(
                buttonColor: self.buttonColor,
                maxWidth: self.maxWidth,
                height: self.height,
                minusCheck: self.minusCheck
            ))
            .padding(5)
        }
    }
    
    private func plusOrMinusText() -> String {
        return self.minusCheck ? "-" : "+"
    }
}

#Preview {
    @Previewable @State var count1: Int = 0
    @Previewable @State var count2: Int = 0
    @Previewable @State var count3: Int = 0
    @Previewable @State var minusCheck: Bool = true
    List {
        HStack {
            unitPlusButton(
                count: $count1,
                plusNumber: 10,
                buttonColor: Color.personalSummerLightRed,
//                buttonColor: Color("personalSummerLightRed"),
                minusCheck: minusCheck
            )
//            unitPlusButton(
//                count: $count2,
//                plusNumber: 1,
//                buttonColor: Color.personalSummerLightBlue,
//                minusCheck: minusCheck
//            )
//            unitPlusButton(
//                count: $count3,
//                plusNumber: 5,
//                buttonColor: Color.personalSummerLightPurple,
//                minusCheck: minusCheck
//            )
        }
        Text("\(count1)")
        Text("\(count2)")
        Text("\(count3)")
    }
}
