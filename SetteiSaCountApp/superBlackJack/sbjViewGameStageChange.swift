//
//  sbjViewGameStageChange.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/08.
//

import SwiftUI

struct sbjViewGameStageChange: View {
//    @ObservedObject var sbj = Sbj()
    @ObservedObject var sbj: Sbj
    @State var isShowAlert: Bool = false
//    @ObservedObject var ver240 = Ver240()
    let selectListSegment: [String] = [
        "100G",
        "百の位 偶数",
        "百の位 奇数"
    ]
    @State var selectedSegment: String = "100G"
    
    var body: some View {
        List {
            Section {
                // //// 規定ゲームの選択
                Picker("", selection: self.$selectedSegment) {
                    ForEach(self.selectListSegment, id: \.self) { segment in
                        Text(segment)
                    }
                }
                .pickerStyle(.segmented)
                // //// カウントボタン
                // 100G
                if self.selectedSegment == self.selectListSegment[0] {
                    HStack {
                        // 移行なし
                        unitCountButtonVerticalPercent(
                            title: "移行なし",
                            count: $sbj.gameChangeCount100Miss,
                            color: .gray,
                            bigNumber: $sbj.gameChangeCount100Sum,
                            numberofDicimal: 0,
                            minusBool: $sbj.minusCheck
                        )
                        // チャイナ移行
                        unitCountButtonVerticalPercent(
                            title: "チャイナ移行",
                            count: $sbj.gameChangeCount100China,
                            color: .personalSummerLightBlue,
                            bigNumber: $sbj.gameChangeCount100Sum,
                            numberofDicimal: 0,
                            minusBool: $sbj.minusCheck
                        )
                        // 高確移行
                        unitCountButtonVerticalPercent(
                            title: "高確移行",
                            count: $sbj.gameChangeCount100Kokaku,
                            color: .blue,
                            bigNumber: $sbj.gameChangeCount100Sum,
                            numberofDicimal: 0,
                            minusBool: $sbj.minusCheck
                        )
                    }
                }
                // 百の位偶数
                else if self.selectedSegment == self.selectListSegment[1] {
                    HStack {
                        // 移行なし
                        unitCountButtonVerticalPercent(
                            title: "移行なし",
                            count: $sbj.gameChangeCountGusuMiss,
                            color: .gray,
                            bigNumber: $sbj.gameChangeCountGusuSum,
                            numberofDicimal: 0,
                            minusBool: $sbj.minusCheck
                        )
                        // チャイナ移行
                        unitCountButtonVerticalPercent(
                            title: "チャイナ移行",
                            count: $sbj.gameChangeCountGusuChina,
                            color: .personalSummerLightGreen,
                            bigNumber: $sbj.gameChangeCountGusuSum,
                            numberofDicimal: 0,
                            minusBool: $sbj.minusCheck
                        )
                        // 高確移行
                        unitCountButtonVerticalPercent(
                            title: "高確移行",
                            count: $sbj.gameChangeCountGusuKokaku,
                            color: .green,
                            bigNumber: $sbj.gameChangeCountGusuSum,
                            numberofDicimal: 0,
                            minusBool: $sbj.minusCheck
                        )
                    }
                }
                // 百の位奇数
                else {
                    HStack {
                        // 移行なし
                        unitCountButtonVerticalPercent(
                            title: "移行なし",
                            count: $sbj.gameChangeCountKisuMiss,
                            color: .gray,
                            bigNumber: $sbj.gameChangeCountKisuSum,
                            numberofDicimal: 0,
                            minusBool: $sbj.minusCheck
                        )
                        // チャイナ移行
                        unitCountButtonVerticalPercent(
                            title: "チャイナ移行",
                            count: $sbj.gameChangeCountKisuChina,
                            color: .personalSummerLightRed,
                            bigNumber: $sbj.gameChangeCountKisuSum,
                            numberofDicimal: 0,
                            minusBool: $sbj.minusCheck
                        )
                        // 高確移行
                        unitCountButtonVerticalPercent(
                            title: "高確移行",
                            count: $sbj.gameChangeCountKisuKokaku,
                            color: .red,
                            bigNumber: $sbj.gameChangeCountKisuSum,
                            numberofDicimal: 0,
                            minusBool: $sbj.minusCheck
                        )
                    }
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "規定ゲーム数での移行について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "規定ゲーム数での移行",
                            textBody1: "・100G消化ごとにチャイナorボーナス高確移行の抽選が行われる",
                            textBody2: "・移行は高設定ほど優遇されており、特にボーナス高確は差が大きい",
                            tableView: AnyView(sbjSubViewTableGameChangeRatio(sbj: sbj))
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(sbjView95Ci(sbj: sbj, selection: 4)))
                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("規定ゲーム数での移行カウント")
            }
        }
//        .onAppear {
//            if ver240.sbjMenuGameStageChangeBadgeStatus != "none" {
//                ver240.sbjMenuGameStageChangeBadgeStatus = "none"
//            }
//        }
        .navigationTitle("規定ゲーム数での移行")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $sbj.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: sbj.resetGameChange)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    sbjViewGameStageChange(sbj: Sbj())
}
