//
//  unitReelHazure.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/31.
//

import SwiftUI

struct unitReelHazure: View {
    var body: some View {
        VStack(spacing: 0) {
            unitReelDefault()
            unitReelDefault()
            unitReelDefault()
        }
        .overlay {
            Rectangle()
                .foregroundStyle(Color.tableBlue)
                .opacity(0.8)
                .cornerRadius(10)
                .padding(7)
                .overlay {
                    Text("ハ\nズ\nレ")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.black)
                }
        }
    }
}

#Preview {
    unitReelHazure()
}
