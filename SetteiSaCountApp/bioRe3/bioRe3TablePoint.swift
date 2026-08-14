//
//  bioRe3TablePoint.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/08/14.
//

import SwiftUI

struct bioRe3TablePoint: View {
    @ObservedObject var bioRe3: BioRe3
    @State var selectedMode: String = "通常時"
    let modeList: [String] = [
        "通常時",
        "AT中",
        "上位AT中",
    ]
    var body: some View {
        VStack(spacing: 20){
            // セグメントピッカー（滞在状態）
            Picker("", selection: self.$selectedMode) {
                ForEach(self.modeList, id: \.self) { mode in
                    Text(mode)
                }
            }
            .pickerStyle(.segmented)
            
            HStack(spacing: 0) {
                unitTablePointIndex(pointList: [50,100,150,200,250,300,350,400,450,500,])
                // 通常時
                if self.selectedMode == self.modeList[0] {
                    unitTablePercent(
                        columTitle: "設定1",
                        percentList: [
                            bioRe3.ratioPointNormal50[0],
                            bioRe3.ratioPointNormal100[0],
                            bioRe3.ratioPointNormal150[0],
                            bioRe3.ratioPointNormal200[0],
                            bioRe3.ratioPointNormal250[0],
                            bioRe3.ratioPointNormal300[0],
                            bioRe3.ratioPointNormal350[0],
                            bioRe3.ratioPointNormal400[0],
                            bioRe3.ratioPointNormal450[0],
                            bioRe3.ratioPointNormal500[0],
                        ],
                        numberofDicimal: 1,
                    )
                    unitTablePercent(
                        columTitle: "設定2",
                        percentList: [
                            bioRe3.ratioPointNormal50[1],
                            bioRe3.ratioPointNormal100[1],
                            bioRe3.ratioPointNormal150[1],
                            bioRe3.ratioPointNormal200[1],
                            bioRe3.ratioPointNormal250[1],
                            bioRe3.ratioPointNormal300[1],
                            bioRe3.ratioPointNormal350[1],
                            bioRe3.ratioPointNormal400[1],
                            bioRe3.ratioPointNormal450[1],
                            bioRe3.ratioPointNormal500[1],
                        ],
                        numberofDicimal: 1,
                    )
                    unitTablePercent(
                        columTitle: "設定3",
                        percentList: [
                            bioRe3.ratioPointNormal50[2],
                            bioRe3.ratioPointNormal100[2],
                            bioRe3.ratioPointNormal150[2],
                            bioRe3.ratioPointNormal200[2],
                            bioRe3.ratioPointNormal250[2],
                            bioRe3.ratioPointNormal300[2],
                            bioRe3.ratioPointNormal350[2],
                            bioRe3.ratioPointNormal400[2],
                            bioRe3.ratioPointNormal450[2],
                            bioRe3.ratioPointNormal500[2],
                        ],
                        numberofDicimal: 1,
                    )
                }
                // AT中
                else if self.selectedMode == self.modeList[1] {
                    unitTablePercent(
                        columTitle: "設定1",
                        percentList: [
                            bioRe3.ratioPointAt50[0],
                            bioRe3.ratioPointAt100[0],
                            bioRe3.ratioPointAt150[0],
                            bioRe3.ratioPointAt200[0],
                            bioRe3.ratioPointAt250[0],
                            bioRe3.ratioPointAt300[0],
                            bioRe3.ratioPointAt350[0],
                            bioRe3.ratioPointAt400[0],
                            bioRe3.ratioPointAt450[0],
                            bioRe3.ratioPointAt500[0],
                        ],
                        numberofDicimal: 1,
                    )
                    unitTablePercent(
                        columTitle: "設定2",
                        percentList: [
                            bioRe3.ratioPointAt50[1],
                            bioRe3.ratioPointAt100[1],
                            bioRe3.ratioPointAt150[1],
                            bioRe3.ratioPointAt200[1],
                            bioRe3.ratioPointAt250[1],
                            bioRe3.ratioPointAt300[1],
                            bioRe3.ratioPointAt350[1],
                            bioRe3.ratioPointAt400[1],
                            bioRe3.ratioPointAt450[1],
                            bioRe3.ratioPointAt500[1],
                        ],
                        numberofDicimal: 1,
                    )
                    unitTablePercent(
                        columTitle: "設定3",
                        percentList: [
                            bioRe3.ratioPointAt50[2],
                            bioRe3.ratioPointAt100[2],
                            bioRe3.ratioPointAt150[2],
                            bioRe3.ratioPointAt200[2],
                            bioRe3.ratioPointAt250[2],
                            bioRe3.ratioPointAt300[2],
                            bioRe3.ratioPointAt350[2],
                            bioRe3.ratioPointAt400[2],
                            bioRe3.ratioPointAt450[2],
                            bioRe3.ratioPointAt500[2],
                        ],
                        numberofDicimal: 1,
                    )
                }
                // 上位AT中
                else {
                    unitTablePercent(
                        columTitle: "設定1",
                        percentList: [
                            bioRe3.ratioPointHighAt50[0],
                            bioRe3.ratioPointHighAt100[0],
                            bioRe3.ratioPointHighAt150[0],
                            bioRe3.ratioPointHighAt200[0],
                            bioRe3.ratioPointHighAt250[0],
                            bioRe3.ratioPointHighAt300[0],
                            bioRe3.ratioPointHighAt350[0],
                            bioRe3.ratioPointHighAt400[0],
                            bioRe3.ratioPointHighAt450[0],
                            bioRe3.ratioPointHighAt500[0],
                        ],
                        numberofDicimal: 1,
                    )
                    unitTablePercent(
                        columTitle: "設定2",
                        percentList: [
                            bioRe3.ratioPointHighAt50[1],
                            bioRe3.ratioPointHighAt100[1],
                            bioRe3.ratioPointHighAt150[1],
                            bioRe3.ratioPointHighAt200[1],
                            bioRe3.ratioPointHighAt250[1],
                            bioRe3.ratioPointHighAt300[1],
                            bioRe3.ratioPointHighAt350[1],
                            bioRe3.ratioPointHighAt400[1],
                            bioRe3.ratioPointHighAt450[1],
                            bioRe3.ratioPointHighAt500[1],
                        ],
                        numberofDicimal: 1,
                    )
                    unitTablePercent(
                        columTitle: "設定3",
                        percentList: [
                            bioRe3.ratioPointHighAt50[2],
                            bioRe3.ratioPointHighAt100[2],
                            bioRe3.ratioPointHighAt150[2],
                            bioRe3.ratioPointHighAt200[2],
                            bioRe3.ratioPointHighAt250[2],
                            bioRe3.ratioPointHighAt300[2],
                            bioRe3.ratioPointHighAt350[2],
                            bioRe3.ratioPointHighAt400[2],
                            bioRe3.ratioPointHighAt450[2],
                            bioRe3.ratioPointHighAt500[2],
                        ],
                        numberofDicimal: 1,
                    )
                }
            }
            
            HStack(spacing: 0) {
                unitTablePointIndex(pointList: [50,100,150,200,250,300,350,400,450,500,])
                // 通常時
                if self.selectedMode == self.modeList[0] {
                    unitTablePercent(
                        columTitle: "設定4",
                        percentList: [
                            bioRe3.ratioPointNormal50[3],
                            bioRe3.ratioPointNormal100[3],
                            bioRe3.ratioPointNormal150[3],
                            bioRe3.ratioPointNormal200[3],
                            bioRe3.ratioPointNormal250[3],
                            bioRe3.ratioPointNormal300[3],
                            bioRe3.ratioPointNormal350[3],
                            bioRe3.ratioPointNormal400[3],
                            bioRe3.ratioPointNormal450[3],
                            bioRe3.ratioPointNormal500[3],
                        ],
                        numberofDicimal: 1,
                    )
                    unitTablePercent(
                        columTitle: "設定5",
                        percentList: [
                            bioRe3.ratioPointNormal50[4],
                            bioRe3.ratioPointNormal100[4],
                            bioRe3.ratioPointNormal150[4],
                            bioRe3.ratioPointNormal200[4],
                            bioRe3.ratioPointNormal250[4],
                            bioRe3.ratioPointNormal300[4],
                            bioRe3.ratioPointNormal350[4],
                            bioRe3.ratioPointNormal400[4],
                            bioRe3.ratioPointNormal450[4],
                            bioRe3.ratioPointNormal500[4],
                        ],
                        numberofDicimal: 1,
                    )
                    unitTablePercent(
                        columTitle: "設定6",
                        percentList: [
                            bioRe3.ratioPointNormal50[5],
                            bioRe3.ratioPointNormal100[5],
                            bioRe3.ratioPointNormal150[5],
                            bioRe3.ratioPointNormal200[5],
                            bioRe3.ratioPointNormal250[5],
                            bioRe3.ratioPointNormal300[5],
                            bioRe3.ratioPointNormal350[5],
                            bioRe3.ratioPointNormal400[5],
                            bioRe3.ratioPointNormal450[5],
                            bioRe3.ratioPointNormal500[5],
                        ],
                        numberofDicimal: 1,
                    )
                }
                // AT中
                else if self.selectedMode == self.modeList[1] {
                    unitTablePercent(
                        columTitle: "設定4",
                        percentList: [
                            bioRe3.ratioPointAt50[3],
                            bioRe3.ratioPointAt100[3],
                            bioRe3.ratioPointAt150[3],
                            bioRe3.ratioPointAt200[3],
                            bioRe3.ratioPointAt250[3],
                            bioRe3.ratioPointAt300[3],
                            bioRe3.ratioPointAt350[3],
                            bioRe3.ratioPointAt400[3],
                            bioRe3.ratioPointAt450[3],
                            bioRe3.ratioPointAt500[3],
                        ],
                        numberofDicimal: 1,
                    )
                    unitTablePercent(
                        columTitle: "設定5",
                        percentList: [
                            bioRe3.ratioPointAt50[4],
                            bioRe3.ratioPointAt100[4],
                            bioRe3.ratioPointAt150[4],
                            bioRe3.ratioPointAt200[4],
                            bioRe3.ratioPointAt250[4],
                            bioRe3.ratioPointAt300[4],
                            bioRe3.ratioPointAt350[4],
                            bioRe3.ratioPointAt400[4],
                            bioRe3.ratioPointAt450[4],
                            bioRe3.ratioPointAt500[4],
                        ],
                        numberofDicimal: 1,
                    )
                    unitTablePercent(
                        columTitle: "設定6",
                        percentList: [
                            bioRe3.ratioPointAt50[5],
                            bioRe3.ratioPointAt100[5],
                            bioRe3.ratioPointAt150[5],
                            bioRe3.ratioPointAt200[5],
                            bioRe3.ratioPointAt250[5],
                            bioRe3.ratioPointAt300[5],
                            bioRe3.ratioPointAt350[5],
                            bioRe3.ratioPointAt400[5],
                            bioRe3.ratioPointAt450[5],
                            bioRe3.ratioPointAt500[5],
                        ],
                        numberofDicimal: 1,
                    )
                }
                // 上位AT
                else {
                    unitTablePercent(
                        columTitle: "設定4",
                        percentList: [
                            bioRe3.ratioPointHighAt50[3],
                            bioRe3.ratioPointHighAt100[3],
                            bioRe3.ratioPointHighAt150[3],
                            bioRe3.ratioPointHighAt200[3],
                            bioRe3.ratioPointHighAt250[3],
                            bioRe3.ratioPointHighAt300[3],
                            bioRe3.ratioPointHighAt350[3],
                            bioRe3.ratioPointHighAt400[3],
                            bioRe3.ratioPointHighAt450[3],
                            bioRe3.ratioPointHighAt500[3],
                        ],
                        numberofDicimal: 1,
                    )
                    unitTablePercent(
                        columTitle: "設定5",
                        percentList: [
                            bioRe3.ratioPointHighAt50[4],
                            bioRe3.ratioPointHighAt100[4],
                            bioRe3.ratioPointHighAt150[4],
                            bioRe3.ratioPointHighAt200[4],
                            bioRe3.ratioPointHighAt250[4],
                            bioRe3.ratioPointHighAt300[4],
                            bioRe3.ratioPointHighAt350[4],
                            bioRe3.ratioPointHighAt400[4],
                            bioRe3.ratioPointHighAt450[4],
                            bioRe3.ratioPointHighAt500[4],
                        ],
                        numberofDicimal: 1,
                    )
                    unitTablePercent(
                        columTitle: "設定6",
                        percentList: [
                            bioRe3.ratioPointHighAt50[5],
                            bioRe3.ratioPointHighAt100[5],
                            bioRe3.ratioPointHighAt150[5],
                            bioRe3.ratioPointHighAt200[5],
                            bioRe3.ratioPointHighAt250[5],
                            bioRe3.ratioPointHighAt300[5],
                            bioRe3.ratioPointHighAt350[5],
                            bioRe3.ratioPointHighAt400[5],
                            bioRe3.ratioPointHighAt450[5],
                            bioRe3.ratioPointHighAt500[5],
                        ],
                        numberofDicimal: 1,
                    )
                }
            }
        }
    }
}

#Preview {
    bioRe3TablePoint(
        bioRe3: BioRe3(),
    )
    .padding(.horizontal)
}
