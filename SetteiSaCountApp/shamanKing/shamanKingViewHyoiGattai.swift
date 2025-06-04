//
//  shamanKingViewHyoiGattai.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/26.
//

import SwiftUI

struct shamanKingViewHyoiGattai: View {
//    @ObservedObject var shamanKing = ShamanKing()
    @ObservedObject var shamanKing: ShamanKing
    let selectListHp: [String] = [
        "残7−8",
        "残5−6",
        "残4",
        "残3"
    ]
    @State var selectedHp: String = "残7−8"
    @State var isShowAlert = false
    
    var body: some View {
        List {
            Section {
                // //// 残りHPの選択
                Picker("", selection: self.$selectedHp) {
                    ForEach(self.selectListHp, id: \.self) { hp in
                        Text(hp)
                    }
                }
                .pickerStyle(.segmented)
                // //// カウントボタン
                // 残5−6
                if self.selectedHp == self.selectListHp[1] {
                    HStack {
                        unitCountButtonVerticalPercent(
                            title: "失敗",
                            count: $shamanKing.hyoiCount56Lose,
                            color: .personalSummerLightBlue,
                            bigNumber: $shamanKing.hyoiCount56Sum,
                            numberofDicimal: 1,
                            minusBool: $shamanKing.minusCheck
                        )
                        unitCountButtonVerticalPercent(
                            title: "勝利",
                            count: $shamanKing.hyoiCount56Win,
                            color: .personalSummerLightRed,
                            bigNumber: $shamanKing.hyoiCount56Sum,
                            numberofDicimal: 1,
                            minusBool: $shamanKing.minusCheck
                        )
                    }
                }
                // 残4
                else if self.selectedHp == self.selectListHp[2] {
                    HStack {
                        unitCountButtonVerticalPercent(
                            title: "失敗",
                            count: $shamanKing.hyoiCount4Lose,
                            color: .personalSummerLightBlue,
                            bigNumber: $shamanKing.hyoiCount4Sum,
                            numberofDicimal: 1,
                            minusBool: $shamanKing.minusCheck
                        )
                        unitCountButtonVerticalPercent(
                            title: "勝利",
                            count: $shamanKing.hyoiCount4Win,
                            color: .personalSummerLightRed,
                            bigNumber: $shamanKing.hyoiCount4Sum,
                            numberofDicimal: 1,
                            minusBool: $shamanKing.minusCheck
                        )
                    }
                }
                // 残3
                else if self.selectedHp == self.selectListHp[3] {
                    HStack {
                        unitCountButtonVerticalPercent(
                            title: "失敗",
                            count: $shamanKing.hyoiCount3Lose,
                            color: .personalSummerLightBlue,
                            bigNumber: $shamanKing.hyoiCount3Sum,
                            numberofDicimal: 1,
                            minusBool: $shamanKing.minusCheck
                        )
                        unitCountButtonVerticalPercent(
                            title: "勝利",
                            count: $shamanKing.hyoiCount3Win,
                            color: .personalSummerLightRed,
                            bigNumber: $shamanKing.hyoiCount3Sum,
                            numberofDicimal: 1,
                            minusBool: $shamanKing.minusCheck
                        )
                    }
                }
                // 残7−8
                else {
                    HStack {
                        unitCountButtonVerticalPercent(
                            title: "失敗",
                            count: $shamanKing.hyoiCount78Lose,
                            color: .personalSummerLightBlue,
                            bigNumber: $shamanKing.hyoiCount78Sum,
                            numberofDicimal: 1,
                            minusBool: $shamanKing.minusCheck
                        )
                        unitCountButtonVerticalPercent(
                            title: "勝利",
                            count: $shamanKing.hyoiCount78Win,
                            color: .personalSummerLightRed,
                            bigNumber: $shamanKing.hyoiCount78Sum,
                            numberofDicimal: 1,
                            minusBool: $shamanKing.minusCheck
                        )
                    }
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "残HPごとの勝率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "残HPごとの勝率",
                            tableView: AnyView(shamanKingTableHyoiGattai())
//                            image1: Image("shamanKingHyoiGattai")
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(shamanKingView95Ci(shamanKing: shamanKing, selection: 1)))
//                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("残りHPごとの勝率")
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "シャーマンキング",
                screenClass: screenClass
            )
        }
        .navigationTitle("憑依合体バトル")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $shamanKing.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: shamanKing.resetHyoiGattai)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    shamanKingViewHyoiGattai(shamanKing: ShamanKing())
}
