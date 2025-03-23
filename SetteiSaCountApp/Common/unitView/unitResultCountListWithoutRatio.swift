//
//  unitResultCountListWithoutRatio.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/19.
//

import SwiftUI

struct unitResultCountListWithoutRatio: View {
    let title: String
    @Binding var count: Int
    let titleColor: Color = .primary
    let numberColor: Color = .secondary
    var flashColor: Color = .clear
    
    var body: some View {
        ZStack {
            Rectangle()
                .backgroundFlashModifier(trigger: self.count, color: flashColor)
            HStack {
                Text(self.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(self.titleColor)
                Text("\(self.count)")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundStyle(self.numberColor)
            }
        }
    }
}

//#Preview {
//    unitResultCountListWithoutRatio()
//}
