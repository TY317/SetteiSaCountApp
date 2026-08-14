//
//  streetFighter6TableFbTenjo.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/08/13.
//

import SwiftUI

struct streetFighter6TableFbTenjo: View {
    @ObservedObject var streetFighter6: StreetFighter6
    var body: some View {
        VStack(spacing: 20) {
//            VStack {
//                Text("[振分け累積確率]")
//                    .font(.title2)
//                HStack(spacing: 0) {
//                    unitTableSettingIndex()
//                    unitTablePercent(
//                        columTitle: "2回以上",
//                        percentList: ratioOver2(),
//                        numberofDicimal: 1,
//                    )
//                    unitTablePercent(
//                        columTitle: "3回以上",
//                        percentList: ratioOver3(),
//                        numberofDicimal: 1,
//                    )
//                    unitTablePercent(
//                        columTitle: "4回",
//                        percentList: streetFighter6.ratioFbTenjo4,
//                        numberofDicimal: 1,
//                    )
//                }
//            }
            VStack {
//                Text("[振分け詳細]")
//                    .font(.title2)
                HStack(spacing: 0) {
                    unitTableSettingIndex()
                    unitTablePercent(
                        columTitle: "1回",
                        percentList: streetFighter6.ratioFbTenjo1,
                        numberofDicimal: 1,
                    )
                    unitTablePercent(
                        columTitle: "2回",
                        percentList: streetFighter6.ratioFbTenjo2,
                        numberofDicimal: 1,
                    )
                    unitTablePercent(
                        columTitle: "3回",
                        percentList: streetFighter6.ratioFbTenjo3,
                        numberofDicimal: 1,
                    )
                    unitTablePercent(
                        columTitle: "4回",
                        percentList: streetFighter6.ratioFbTenjo4,
                        numberofDicimal: 1,
                    )
                }
            }
        }
    }
    
//    private func ratioOver3() -> [Double] {
//        var over3: [Double] = [0,0,0,0,0,0,]
//        for (index, ratio) in over3.enumerated() {
//            over3[index] = streetFighter6.ratioFbTenjo4[index] + streetFighter6.ratioFbTenjo3[index]
//        }
//        
//        return over3
//    }
//    
//    private func ratioOver2() -> [Double] {
//        var over2: [Double] = [0,0,0,0,0,0,]
//        for (index, ratio) in over2.enumerated() {
//            over2[index] = streetFighter6.ratioFbTenjo4[index] + streetFighter6.ratioFbTenjo3[index] + streetFighter6.ratioFbTenjo2[index]
//        }
//        
//        return over2
//    }
}

#Preview {
    streetFighter6TableFbTenjo(
        streetFighter6: StreetFighter6(),
    )
    .padding(.horizontal)
}
