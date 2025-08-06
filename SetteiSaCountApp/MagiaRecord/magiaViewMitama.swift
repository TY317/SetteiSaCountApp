//
//  magiaViewMitama.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/23.
//

import SwiftUI

struct magiaViewMitama: View {
//    @ObservedObject var ver352: Ver352
    @ObservedObject var magia: Magia
    @State var isShowAlert = false
    
    var body: some View {
        List {
            Section {
                // //// カウントボタン横並び
                HStack {
                    // AT非当選
                    unitCountButtonPercentWithFunc(
                        title: "ハズレ",
                        count: $magia.mitamaAtCountMiss,
                        color: .personalSummerLightBlue,
                        bigNumber: $magia.mitamaAtCountSum,
                        numberofDicimal: 0,
                        minusBool: $magia.minusCheck,
                        action: magia.mitamaSumFunc
                    )
                    // AT非当選
                    unitCountButtonPercentWithFunc(
                        title: "当選",
                        count: $magia.mitamaAtCountHit,
                        color: .personalSummerLightRed,
                        bigNumber: $magia.mitamaAtCountSum,
                        numberofDicimal: 0,
                        minusBool: $magia.minusCheck,
                        action: magia.mitamaSumFunc
                    )
                }
                // //// 参考情報）ウワサバトル発展時のAT当選
                unitLinkButtonViewBuilder(sheetTitle: "発展時のAT当選率") {
                    VStack {
                        Text("・ウワサバトル発展時のAT当選率に設定差あり")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("・報酬レベル2or3＆最終ゲームレア役非成立でウワサバトルへ発展する")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("・強レア役1回または弱レア役2回以上引いた場合は内部的に報酬レベル3以上が濃厚となる")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("・報酬レベル2の可能性高い状況でAT当選するほど高設定に期待できる")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom)
                        Text("[AT当選率]")
                            .font(.title2)
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTablePercent(
                                columTitle: "報酬レベル2",
                                percentList: magia.ratioMitamaLevel2,
                                numberofDicimal: 1,
                            )
                            unitTablePercent(
                                columTitle: "報酬レベル3",
                                percentList: magia.ratioMitamaLevel3,
                                numberofDicimal: 1,
                            )
                        }
                    }
                }
            } header: {
                Text("ウワサバトル発展時のAT当選")
            }
//            unitAdBannerMediumRectangle()
        }
        // //// バッジのリセット
//        .resetBadgeOnAppear($ver352.magiaMenuMitamaBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "マギアレコード",
                screenClass: screenClass
            )
        }
        .navigationTitle("みたまボーナス")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $magia.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: magia.resetMitama)
                }
            }
        }
    }
}

#Preview {
    magiaViewMitama(
//        ver352: Ver352(),
        magia: Magia(),
    )
}
