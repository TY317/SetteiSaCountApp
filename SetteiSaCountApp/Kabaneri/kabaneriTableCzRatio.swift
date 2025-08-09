//
//  kabaneriTableCzRatio.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/09.
//

import SwiftUI

struct kabaneriTableCzRatio: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "CZ合算",
                denominateList: [179.3,177.9,169.3,158.4,145.6,136.8]
            )
        }
    }
}

#Preview {
    kabaneriTableCzRatio()
}
