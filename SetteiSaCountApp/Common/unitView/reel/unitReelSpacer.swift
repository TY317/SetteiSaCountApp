//
//  unitReelSpacer.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/04.
//

import SwiftUI

struct unitReelSpacer: View {
    var spaceHeight: CGFloat = 157
    var spaceMaxWidth: CGFloat = 180
    var body: some View {
        Rectangle()
            .foregroundStyle(Color.clear)
            .frame(height: self.spaceHeight)
            .frame(maxWidth: self.spaceMaxWidth)
    }
}

#Preview {
    unitReelSpacer()
}
