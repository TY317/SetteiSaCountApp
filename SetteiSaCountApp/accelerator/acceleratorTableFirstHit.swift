//
//  acceleratorTableFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/29.
//

import SwiftUI

struct acceleratorTableFirstHit: View {
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTableDenominate(
                    columTitle: "CZ",
                    denominateList: [142.6,139.7,134.1,124.1,115.3,105.9]
                )
                unitTableDenominate(
                    columTitle: "AT",
                    denominateList: [320.7,313.8,300.9,275.2,251.9,231.9]
                )
            }
            .padding(.bottom)
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTableDenominate(
                    columTitle: "一方通行CZ",
                    denominateList: [168.7,165.5,159.6,152.9,145.5,134.1],
                    titleFont: .subheadline
                )
                unitTableDenominate(
                    columTitle: "打ち止めCZ",
                    denominateList: [3244.1,3188.7,2892.9,1838.2,1356.3,1247.1],
                    titleFont: .subheadline
                )
                unitTableDenominate(
                    columTitle: "一通・打止CZ",
                    denominateList: [1290.5,1244.1,1058.9,1058.9,943.6,845.7],
                    titleFont: .subheadline
                )
            }
        }
    }
}

#Preview {
    acceleratorTableFirstHit()
        .padding(.horizontal)
}
