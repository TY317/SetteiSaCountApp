//
//  kerottoView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct kerottoView95Ci: View {
    @ObservedObject var kerotto: Kerotto
    @State var selection = 1
    @State var isShow95CiExplain = false

    var body: some View {
        TabView(selection: self.$selection) {
            // ベル回数
            unitListSection95Ci(
                grafTitle: "🔔回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $kerotto.koyakuCountBell,
                        bigNumber: $kerotto.gameNumberPlay,
                        setting1Denominate: kerotto.ratioBell[0],
                        setting2Denominate: kerotto.ratioBell[1],
                        setting3Denominate: kerotto.ratioBell[2],
                        setting4Denominate: kerotto.ratioBell[3],
                        setting5Denominate: kerotto.ratioBell[4],
                        setting6Denominate: kerotto.ratioBell[5]
                    )
                )
            )
            .tag(5)
            
            // チェリー回数
            unitListSection95Ci(
                grafTitle: "🍒回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $kerotto.koyakuCountCherry,
                        bigNumber: $kerotto.gameNumberPlay,
                        setting1Denominate: kerotto.ratioCherry[0],
                        setting2Denominate: kerotto.ratioCherry[1],
                        setting3Denominate: kerotto.ratioCherry[2],
                        setting4Denominate: kerotto.ratioCherry[3],
                        setting5Denominate: kerotto.ratioCherry[4],
                        setting6Denominate: kerotto.ratioCherry[5]
                    )
                )
            )
            .tag(6)
            
            // 平行オレンジ回数
            unitListSection95Ci(
                grafTitle: "平行🍊回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $kerotto.koyakuCountHeikoOrange,
                        bigNumber: $kerotto.gameNumberPlay,
                        setting1Denominate: kerotto.ratioHeikoOrange[0],
                        setting2Denominate: kerotto.ratioHeikoOrange[1],
                        setting3Denominate: kerotto.ratioHeikoOrange[2],
                        setting4Denominate: kerotto.ratioHeikoOrange[3],
                        setting5Denominate: kerotto.ratioHeikoOrange[4],
                        setting6Denominate: kerotto.ratioHeikoOrange[5]
                    )
                )
            )
            .tag(7)
            
            // 斜めオレンジ
            unitListSection95Ci(
                grafTitle: "斜め🍊回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $kerotto.koyakuCountNanameOrange,
                        bigNumber: $kerotto.gameNumberPlay,
                        setting1Denominate: kerotto.ratioNanameOrange[0],
                        setting2Denominate: kerotto.ratioNanameOrange[1],
                        setting3Denominate: kerotto.ratioNanameOrange[2],
                        setting4Denominate: kerotto.ratioNanameOrange[3],
                        setting5Denominate: kerotto.ratioNanameOrange[4],
                        setting6Denominate: kerotto.ratioNanameOrange[5]
                    )
                )
            )
            .tag(8)
            
            // 確定役回数
            unitListSection95Ci(
                grafTitle: "確定役回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $kerotto.koyakuCountKakuteiyaku,
                        bigNumber: $kerotto.gameNumberPlay,
                        setting1Denominate: kerotto.ratioKakuteiyaku[0],
                        setting2Denominate: kerotto.ratioKakuteiyaku[1],
                        setting3Denominate: kerotto.ratioKakuteiyaku[2],
                        setting4Denominate: kerotto.ratioKakuteiyaku[3],
                        setting5Denominate: kerotto.ratioKakuteiyaku[4],
                        setting6Denominate: kerotto.ratioKakuteiyaku[5]
                    )
                )
            )
            .tag(9)
            
            // チェリー重複回数
            unitListSection95Ci(
                grafTitle: "🍒重複回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $kerotto.chofukuCountCherry,
                        bigNumber: $kerotto.koyakuCountCherry,
                        setting1Percent: kerotto.ratioChofukuCherry[0],
                        setting2Percent: kerotto.ratioChofukuCherry[1],
                        setting3Percent: kerotto.ratioChofukuCherry[2],
                        setting4Percent: kerotto.ratioChofukuCherry[3],
                        setting5Percent: kerotto.ratioChofukuCherry[4],
                        setting6Percent: kerotto.ratioChofukuCherry[5]
                    )
                )
            )
            .tag(10)
            
            // 平行オレンジ重複回数
            unitListSection95Ci(
                grafTitle: "平行🍊重複回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $kerotto.chofukuCountHeikoOrange,
                        bigNumber: $kerotto.koyakuCountHeikoOrange,
                        setting1Percent: kerotto.ratioChofukuHeikoOrange[0],
                        setting2Percent: kerotto.ratioChofukuHeikoOrange[1],
                        setting3Percent: kerotto.ratioChofukuHeikoOrange[2],
                        setting4Percent: kerotto.ratioChofukuHeikoOrange[3],
                        setting5Percent: kerotto.ratioChofukuHeikoOrange[4],
                        setting6Percent: kerotto.ratioChofukuHeikoOrange[5]
                    )
                )
            )
            .tag(11)
            
            // 斜めオレンジ重複回数
            unitListSection95Ci(
                grafTitle: "斜め🍊重複回数",
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $kerotto.chofukuCountNanameOrange,
                        bigNumber: $kerotto.koyakuCountNanameOrange,
                        setting1Percent: kerotto.ratioChofukuNanameOrange[0],
                        setting2Percent: kerotto.ratioChofukuNanameOrange[1],
                        setting3Percent: kerotto.ratioChofukuNanameOrange[2],
                        setting4Percent: kerotto.ratioChofukuNanameOrange[3],
                        setting5Percent: kerotto.ratioChofukuNanameOrange[4],
                        setting6Percent: kerotto.ratioChofukuNanameOrange[5]
                    )
                )
            )
            .tag(12)
            
            // SBB初当り回数
            unitListSection95Ci(
                grafTitle: "SBB初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $kerotto.firstHitCountSBBSum,
                        bigNumber: $kerotto.gameNumberPlay,
                        setting1Denominate: kerotto.ratioFirstHitSbb[0],
                        setting2Denominate: kerotto.ratioFirstHitSbb[1],
                        setting3Denominate: kerotto.ratioFirstHitSbb[2],
                        setting4Denominate: kerotto.ratioFirstHitSbb[3],
                        setting5Denominate: kerotto.ratioFirstHitSbb[4],
                        setting6Denominate: kerotto.ratioFirstHitSbb[5]
                    )
                )
            )
            .tag(1)
            
            // BB初当り回数
            unitListSection95Ci(
                grafTitle: "BB初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $kerotto.firstHitCountBBSum,
                        bigNumber: $kerotto.gameNumberPlay,
                        setting1Denominate: kerotto.ratioFirstHitBb[0],
                        setting2Denominate: kerotto.ratioFirstHitBb[1],
                        setting3Denominate: kerotto.ratioFirstHitBb[2],
                        setting4Denominate: kerotto.ratioFirstHitBb[3],
                        setting5Denominate: kerotto.ratioFirstHitBb[4],
                        setting6Denominate: kerotto.ratioFirstHitBb[5]
                    )
                )
            )
            .tag(2)
            
            // REG初当り回数
            unitListSection95Ci(
                grafTitle: "REG初当り回数",
                grafView: AnyView(
                    unitChart95CiDenominate(
                        currentCount: $kerotto.firstHitCountREGSum,
                        bigNumber: $kerotto.gameNumberPlay,
                        setting1Denominate: kerotto.ratioFirstHitReg[0],
                        setting2Denominate: kerotto.ratioFirstHitReg[1],
                        setting3Denominate: kerotto.ratioFirstHitReg[2],
                        setting4Denominate: kerotto.ratioFirstHitReg[3],
                        setting5Denominate: kerotto.ratioFirstHitReg[4],
                        setting6Denominate: kerotto.ratioFirstHitReg[5]
                    )
                )
            )
            .tag(3)
            
            // 赤頭回数
            unitListSection95Ci(
                grafTitle: "赤頭回数",
//                titleFont: .title2,
                grafView: AnyView(
                    unitChart95CiPercent(
                        currentCount: $kerotto.firstHitCountRSum,
                        bigNumber: $kerotto.firstHitCountAllSum,
                        setting1Percent: kerotto.ratioFirstHitRed[0],
                        setting2Percent: kerotto.ratioFirstHitRed[1],
                        setting3Percent: kerotto.ratioFirstHitRed[2],
                        setting4Percent: kerotto.ratioFirstHitRed[3],
                        setting5Percent: kerotto.ratioFirstHitRed[4],
                        setting6Percent: kerotto.ratioFirstHitRed[5]
                    )
                )
            )
            .tag(4)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: kerotto.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("95%信頼区間グラフ")
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                unitButton95CiExplain(isShow95CiExplain: isShow95CiExplain)
            }
        }
        .tabViewStyle(.page)
    }
}

#Preview {
    kerottoView95Ci(
        kerotto: Kerotto(),
    )
}
