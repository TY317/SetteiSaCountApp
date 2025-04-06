//
//  hanahanaCommonTableBigLamp.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/05.
//

import SwiftUI

struct hanahanaCommonTableBigLamp: View {
    @ObservedObject var hanahanaCommon = HanahanaCommon()
    var body: some View {
        VStack {
            Text("[参考] 過去のハナハナシリーズ数値")
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "青",
                    percentList: hanahanaCommon.ratioBigLampBlue,
                    numberofDicimal: 1
                )
                unitTablePercent(
                    columTitle: "黄",
                    percentList: hanahanaCommon.ratioBigLampYellow,
                    numberofDicimal: 1
                )
                unitTablePercent(
                    columTitle: "緑",
                    percentList: hanahanaCommon.ratioBigLampGreen,
                    numberofDicimal: 1
                )
                unitTablePercent(
                    columTitle: "赤",
                    percentList: hanahanaCommon.ratioBigLampRed,
                    numberofDicimal: 1
                )
            }
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "虹",
                    percentList: hanahanaCommon.ratioBigLampRainbow,
                    numberofDicimal: 2
                )
                unitTablePercent(
                    columTitle: "合算",
                    percentList: hanahanaCommon.ratioBigLampSum,
                    numberofDicimal: 1
                )
            }
        }
    }
}

#Preview {
    hanahanaCommonTableBigLamp()
}
