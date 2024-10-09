//
//  myModifier.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/13.
//

import SwiftUI

struct myModifier: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}


// /////////////////////////////////////
// モディファイア：ボタンタップ時の背景フラッシュ、レクタングル用
// /////////////////////////////////////
struct backgroundFlashModifier: ViewModifier {
    var color: Color = .yellow
    @State var flashOpacity = 0.0
    var maxOpacity = 0.7
    var minOpacity = 0.0
    var radius = 10.0
    var trigger: Int
    var flashTime = 0.15
    @State var isFlashCompleted = false
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(self.color)
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
    func backgroundFlashModifier(trigger: Int, color: Color = .yellow, maxOpacity: Double = 0.7, minOpacity: Double = 0.0, radius: CGFloat = 10.0, flashTime: Double = 0.15) -> some View {
        self.modifier(SetteiSaCountApp.backgroundFlashModifier(color: color, maxOpacity: maxOpacity, minOpacity: minOpacity, radius: radius, trigger: trigger, flashTime: flashTime))
    }
}


#Preview {
    myModifier()
}
