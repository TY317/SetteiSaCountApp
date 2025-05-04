//
//  unitReelReplay.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/03.
//

import SwiftUI

struct unitReelReplay: View {
    let ellipsePadding: CGFloat = 7
    var body: some View {
        unitReelDefault()
            .overlay {
                Ellipse()
                    .padding(self.ellipsePadding)
//                    .foregroundStyle(Color.personalSummerLightBlue)
                    .foregroundStyle(Color.cyan)
                Text("R")
                    .foregroundStyle(Color.white)
                    .fontWeight(.bold)
                    .font(.title2)
            }
    }
}

#Preview {
    unitReelReplay()
}
