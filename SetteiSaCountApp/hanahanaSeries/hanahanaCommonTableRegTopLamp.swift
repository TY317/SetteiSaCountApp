//
//  hanahanaCommonTableRegTopLamp.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/05.
//

import SwiftUI

struct hanahanaCommonTableRegTopLamp: View {
    @ObservedObject var hanahanaCommon = HanahanaCommon()
    
    var body: some View {
        VStack {
            Text("[参考] 過去のハナハナシリーズ数値")
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "青",
                    percentList: hanahanaCommon.ratioRegTopLampBlue,
                    numberofDicimal: 1
                )
                unitTablePercent(
                    columTitle: "黄",
                    percentList: hanahanaCommon.ratioRegTopLampYellow,
                    numberofDicimal: 1
                )
                unitTablePercent(
                    columTitle: "緑",
                    percentList: hanahanaCommon.ratioRegTopLampGreen,
                    numberofDicimal: 1
                )
                unitTablePercent(
                    columTitle: "赤",
                    percentList: hanahanaCommon.ratioRegTopLampRed,
                    numberofDicimal: 1
                )
                unitTablePercent(
                    columTitle: "虹",
                    percentList: hanahanaCommon.ratioRegTopLampRainbow,
                    numberofDicimal: 1
                )
            }
//            .padding(.horizontal)
        }
    }
}

#Preview {
    hanahanaCommonTableRegTopLamp()
}
