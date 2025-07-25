//
//  myJug5Ver2View95CiKen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/18.
//

import SwiftUI

struct myJug5Ver2View95CiKen: View {
//    @ObservedObject var myJug5 = MyJug5()
    @ObservedObject var myJug5: MyJug5
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: $selection) {
            if myJug5.kenBackCalculationEnable {
                // ぶどう回数
                unitListSection95Ci(
                    grafTitle: "見\nぶどう回数",
                    grafView: AnyView(
                        unitChart95CiDenominate(
                            currentCount: $myJug5.kenBellBackCalculationCount,
                            bigNumber: $myJug5.kenGameIput,
                            setting1Denominate: myJug5.denominateListBell[0],
                            setting2Denominate: myJug5.denominateListBell[1],
                            setting3Denominate: myJug5.denominateListBell[2],
                            setting4Denominate: myJug5.denominateListBell[3],
                            setting5Denominate: myJug5.denominateListBell[4],
                            setting6Denominate: myJug5.denominateListBell[5],
                            yScaleKeisu: 0.05
                        )
                    )
                )
                .tag(1)
            }
            // BIG回数
            unitListSection95Ci(
                grafTitle: "見\n BIG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $myJug5.kenBigCountInput,
                        bigNumber: $myJug5.kenGameIput,
                        setting1Denominate: myJug5.denominateListBigSum[0],
                        setting2Denominate: myJug5.denominateListBigSum[1],
                        setting3Denominate: myJug5.denominateListBigSum[2],
                        setting4Denominate: myJug5.denominateListBigSum[3],
                        setting5Denominate: myJug5.denominateListBigSum[4],
                        setting6Denominate: myJug5.denominateListBigSum[5]
                    )
                )
            )
            .tag(2)
            // REG回数
            unitListSection95Ci(
                grafTitle: "見\n REG回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $myJug5.kenRegCountInput,
                        bigNumber: $myJug5.kenGameIput,
                        setting1Denominate: myJug5.denominateListRegSum[0],
                        setting2Denominate: myJug5.denominateListRegSum[1],
                        setting3Denominate: myJug5.denominateListRegSum[2],
                        setting4Denominate: myJug5.denominateListRegSum[3],
                        setting5Denominate: myJug5.denominateListRegSum[4],
                        setting6Denominate: myJug5.denominateListRegSum[5]
                    )
                )
            )
            .tag(3)
            // REG回数
            unitListSection95Ci(
                grafTitle: "見\n ボーナス合算回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $myJug5.kenBonusCountSum,
                        bigNumber: $myJug5.kenGameIput,
                        setting1Denominate: myJug5.denominateListBonusSum[0],
                        setting2Denominate: myJug5.denominateListBonusSum[1],
                        setting3Denominate: myJug5.denominateListBonusSum[2],
                        setting4Denominate: myJug5.denominateListBonusSum[3],
                        setting5Denominate: myJug5.denominateListBonusSum[4],
                        setting6Denominate: myJug5.denominateListBonusSum[5]
                    )
                )
            )
            .tag(4)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "マイジャグラー5",
                screenClass: screenClass
            )
        }
        .navigationTitle("95%信頼区間グラフ")
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                unitButton95CiExplain(isShow95CiExplain: isShow95CiExplain)
//                    .popoverTip(tipUnitButton95CiExplain())
            }
        }
        .tabViewStyle(.page)
    }
}

#Preview {
    myJug5Ver2View95CiKen(myJug5: MyJug5())
}
