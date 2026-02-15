//
//  hanabiTableRtReplay.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/15.
//

import SwiftUI

struct hanabiTableRtReplay: View {
    @ObservedObject var hanabi: Hanabi
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableSettingIndex(settingList: [1,2,5,6], titleLine: 2)
                unitTableDenominate(
                    columTitle: "花火チャレンジ中\n通常リプレイ",
                    denominateList: hanabi.ratioChallengeReplayNormal,
                    numberofDicimal: 1,
                    titleLine: 2,
                )
                unitTableDenominate(
                    columTitle: "花火GAME中\nRTリプレイ",
                    denominateList: hanabi.ratioGameReplayRt,
                    numberofDicimal: 1,
                    titleLine: 2,
                )
            }
            .padding(.bottom)
            
            Text("[花火チャレンジ中 小役確率]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableSettingIndex(settingList: [1,2,5,6])
                unitTableDenominate(
                    columTitle: "はずれ",
                    denominateList: hanabi.ratioHazureChallenge,
                    numberofDicimal: 1,
                )
                unitTableDenominate(
                    columTitle: "通常リプレイ",
                    denominateList: hanabi.ratioChallengeReplayNormal,
                    numberofDicimal: 1,
                )
                unitTableDenominate(
                    columTitle: "移行リプレイ",
                    denominateList: [3.5],
                    numberofDicimal: 1,
                    lineList: [4],
                    colorList: [.white],
                )
            }
            .padding(.bottom)
            
            Text("[花火GAME中 小役確率]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableSettingIndex(settingList: [1,2,5,6])
                unitTableDenominate(
                    columTitle: "はずれ",
                    denominateList: hanabi.ratioHazureGame,
                    numberofDicimal: 1,
                )
                unitTableDenominate(
                    columTitle: "通常リプレイ",
                    denominateList: [7.3],
                    numberofDicimal: 1,
                    lineList: [4],
                    colorList: [.white],
                )
                unitTableDenominate(
                    columTitle: "RTリプレイ",
                    denominateList: hanabi.ratioGameReplayRt,
                    numberofDicimal: 1,
                )
            }
        }
    }
}

#Preview {
    hanabiTableRtReplay(
        hanabi: Hanabi(),
    )
}
