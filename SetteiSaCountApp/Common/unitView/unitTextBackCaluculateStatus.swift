//
//  unitTextBackCaluculateStatus.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/25.
//

import SwiftUI

struct unitTextBackCaluculateStatus: View {
    let enableStatus: Bool
    let textColor: Color = .secondary
    let textAlignment: Alignment = .center
    
    var body: some View {
        if self.enableStatus {
            Text("※ 逆算有効化 ON")
                .foregroundStyle(self.textColor)
                .frame(maxWidth: .infinity, alignment: self.textAlignment)
        } else {
            Text("※ 逆算有効化 OFF")
                .foregroundStyle(self.textColor)
                .frame(maxWidth: .infinity, alignment: self.textAlignment)
        }
    }
}

//#Preview {
//    unitTextBackCaluculateStatus()
//}
