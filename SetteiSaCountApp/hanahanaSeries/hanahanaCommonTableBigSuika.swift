//
//  hanahanaCommonTableBigSuika.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/05.
//

import SwiftUI

struct hanahanaCommonTableBigSuika: View {
    @ObservedObject var hanahanaCommon = HanahanaCommon()
    var body: some View {
        VStack {
            Text("[参考] 過去のハナハナシリーズ数値")
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTableDenominate(
                    columTitle: "ビッグ中スイカ",
                    denominateList: hanahanaCommon.ratioBigSuika
                )
            }
        }
    }
}

#Preview {
    hanahanaCommonTableBigSuika()
}
