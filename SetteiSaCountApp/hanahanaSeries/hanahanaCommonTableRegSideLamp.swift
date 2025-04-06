//
//  hanahanaCommonTableRegSideLamp.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/05.
//

import SwiftUI

struct hanahanaCommonTableRegSideLamp: View {
    @ObservedObject var hanahanaCommon = HanahanaCommon()
    var body: some View {
        VStack {
            Text("[参考] 過去のハナハナシリーズ数値")
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "青",
                    percentList: hanahanaCommon.ratioRegSideLampBlue
                )
                unitTablePercent(
                    columTitle: "黄",
                    percentList: hanahanaCommon.ratioRegSideLampYellow
                )
                unitTablePercent(
                    columTitle: "緑",
                    percentList: hanahanaCommon.ratioRegSideLampGreen
                )
                unitTablePercent(
                    columTitle: "赤",
                    percentList: hanahanaCommon.ratioRegSideLampRed
                )
                unitTablePercent(
                    columTitle: "虹",
                    percentList: hanahanaCommon.ratioRegSideLampRainbow,
                    numberofDicimal: 2,
                    contentFont: .body
                )
            }
//            .padding(.horizontal)
//            HStack(spacing: 0) {
//                unitTableSettingIndex()
//                unitTablePercent(
//                    columTitle: "虹",
//                    percentList: hanahanaCommon.ratioRegSideLampRainbow,
//                    numberofDicimal: 2
//                )
//            }
        }
    }
}

#Preview {
    hanahanaCommonTableRegSideLamp()
}
