//
//  arifureSubViewTableKakuseiSuccess.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/17.
//

import SwiftUI

struct arifureSubViewTableKakuseiSuccess: View {
    @ObservedObject var arifure = Arifure()
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTablePercent(
                columTitle: "成功期待度",
                percentList: arifure.ratioKakuseiSuccess,
                aboutBool: true
            )
        }
    }
}

#Preview {
    arifureSubViewTableKakuseiSuccess()
}
