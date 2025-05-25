//
//  modifierBackGroundFlashBool.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/21.
//

import SwiftUI

struct ModifierBackGroundFlashBool: View {
    @State var flashBool: Bool = false
    
    var body: some View {
        Rectangle()
            .modifierBackGroundFlashBool(
                trigger: flashBool,
                color: .red
            )
            .frame(width: 100, height: 100)
        Button {
            self.flashBool.toggle()
        } label: {
            Text("test")
        }
    }
}

// /////////////////////////////////////
// モディファイア：ボタンタップ時の背景フラッシュ、レクタングル用、ブールに反応
// /////////////////////////////////////
struct modifierBackGroundFlashBool: ViewModifier {
    var color: Color
    @State var flashOpacity = 0.0
    var maxOpacity = 0.7
    var minOpacity = 0.0
    var radius = 10.0
    var trigger: Bool
    var flashTime = 0.15
    @State var isFlashCompleted = false
    
    func body(content: Content) -> some View {
        content
//            .foregroundColor(self.color)
            .foregroundStyle(self.color)
            .opacity(self.flashOpacity)
            .cornerRadius(self.radius)
            .onChange(of: self.trigger) { //_ in
                withAnimation(.easeInOut(duration: self.flashTime)) {
                    self.flashOpacity = self.maxOpacity
                    self.isFlashCompleted = true
                }
            }
            .onChange(of: self.isFlashCompleted) { //_ in
                withAnimation(.easeInOut(duration: self.flashTime).delay(self.flashTime)) {
                    self.flashOpacity = self.minOpacity
                    self.isFlashCompleted = false
                }
            }
    }
}
extension View {
    func modifierBackGroundFlashBool(trigger: Bool, color: Color = .yellow, maxOpacity: Double = 0.7, minOpacity: Double = 0.0, radius: CGFloat = 10.0, flashTime: Double = 0.15) -> some View {
        self.modifier(SetteiSaCountApp.modifierBackGroundFlashBool(color: color, maxOpacity: maxOpacity, minOpacity: minOpacity, radius: radius, trigger: trigger, flashTime: flashTime))
    }
}


#Preview {
    ModifierBackGroundFlashBool()
}
