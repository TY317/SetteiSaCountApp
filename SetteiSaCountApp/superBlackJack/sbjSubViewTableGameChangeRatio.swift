//
//  sbjSubViewTableGameChangeRatio.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/08.
//

import SwiftUI

struct sbjSubViewTableGameChangeRatio: View {
    @ObservedObject var sbj = Sbj()
    var body: some View {
        VStack {
            // //// 100Gでの移行率
            VStack {
                Text("[ 100Gでの移行率 ]")
                    .font(.title2)
                    .fontWeight(.bold)
                HStack(spacing: 0) {
                    unitTableSettingIndex()
                    unitTablePercent(
                        columTitle: "チャイナ",
                        percentList: sbj.stageChange100ChinaRatio
                    )
                    unitTablePercent(
                        columTitle: "ボーナス高確",
                        percentList: sbj.stageChange100KokakuRatio
                    )
                }
            }
            
            // //// 百の位 偶数での移行率
            VStack {
                Text("[ 百の位偶数での移行率 ]")
                    .font(.title2)
                    .fontWeight(.bold)
                HStack(spacing: 0) {
                    unitTableSettingIndex()
                    unitTablePercent(
                        columTitle: "チャイナ",
                        percentList: sbj.stageChangeGusuChinaRatio
                    )
                    unitTablePercent(
                        columTitle: "ボーナス高確",
                        percentList: sbj.stageChangeGusuKokakuRatio
                    )
                }
            }
            .padding(.top)
            
            // //// 百の位 奇数での移行率
            VStack {
                Text("[ 百の位奇数での移行率 ]")
                    .font(.title2)
                    .fontWeight(.bold)
                HStack(spacing: 0) {
                    unitTableSettingIndex()
                    unitTablePercent(
                        columTitle: "チャイナ",
                        percentList: sbj.stageChangeKisuChinaRatio
                    )
                    unitTablePercent(
                        columTitle: "ボーナス高確",
                        percentList: sbj.stageChangeKisuKokakuRatio,
                        numberofDicimal: 1
                    )
                }
            }
            .padding(.top)
        }
    }
}

#Preview {
    sbjSubViewTableGameChangeRatio()
}
