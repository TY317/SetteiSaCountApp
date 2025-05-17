//
//  gundamSeedTableUnder99Ratio.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/17.
//

import SwiftUI

struct gundamSeedTableUnder99Ratio: View {
    @ObservedObject var gundamSeed: GundamSeed
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTablePercent(
                columTitle: "0〜49",
                percentList: gundamSeed.ratio0to49,
                numberofDicimal: 1
            )
            unitTablePercent(
                columTitle: "50〜99",
                percentList: gundamSeed.ratio50to99,
                numberofDicimal: 0
            )
            unitTablePercent(
                columTitle: "合算",
                percentList: gundamSeed.ratio0to99,
                numberofDicimal: 0
            )
        }
    }
}

#Preview {
    gundamSeedTableUnder99Ratio(
        gundamSeed: GundamSeed()
    )
    .padding(.horizontal)
}
