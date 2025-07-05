//
//  unitReelGrayMark.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/02.
//

import SwiftUI

struct unitReelGrayMark: View {
    let ellipsePadding: CGFloat = 10
    var xmarkBool: Bool = false
    var xmarkColor: Color = .red
    var body: some View {
        unitReelDefault()
            .overlay {
                Ellipse()
                    .padding(self.ellipsePadding)
                    .foregroundStyle(Color.gray)
//                Text("R")
//                    .foregroundStyle(Color.white)
//                    .fontWeight(.bold)
//                    .font(.title2)
                if self.xmarkBool {
                    Image(systemName: "xmark")
                        .resizable()
                        .padding(5)
                        .foregroundStyle(self.xmarkColor)
                }
            }
    }
}

#Preview {
    unitReelGrayMark()
}
