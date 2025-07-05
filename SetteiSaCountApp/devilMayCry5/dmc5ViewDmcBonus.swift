//
//  dmc5ViewDmcBonus.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/28.
//

import SwiftUI

struct dmc5ViewDmcBonus: View {
    @ObservedObject var ver350: Ver350
    @ObservedObject var dmc5: Dmc5
    @State var isShowAlert: Bool = false
    @FocusState var isFocused: Bool
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 300.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 300.0
    let lazyVGridCountPortrait: Int = 3
    let lazyVGridCountLandscape: Int = 5
    @State var lazyVGridCount: Int = 3
    
    var body: some View {
        List {
            Section {
                // //// カウントボタン横並び
                HStack {
                    // シングルチャンス目
                    unitCountButtonVerticalWithoutRatio(
                        title: "シングルチャンス目",
                        count: $dmc5.dmcBonusCountChance,
                        color: .personalSummerLightBlue,
                        minusBool: $dmc5.minusCheck,
                        vSpaceBool: true,
                    )
                    // ブラッディバトル
                    unitCountButtonVerticalPercent(
                        title: "ブラッディバトル",
                        count: $dmc5.dmcBonusCountBattle,
                        color: .personalSummerLightRed,
                        bigNumber: $dmc5.dmcBonusCountChance,
                        numberofDicimal: 0,
                        minusBool: $dmc5.minusCheck
                    )
                }
                
                // //// 参考情報）ブラッディバトル当選について
                unitLinkButton(
                    title: "ブラッディバトル当選について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "ブラッディバトル当選",
                            textBody1: "・DMCボーナス中のブラッディバトル当選に設定差あり",
                            textBody2: "・ダブルチャンス目、トリプルチャンス目はバトル当選濃厚",
                            tableView: AnyView(dmc5TableDmcBonus(dmc5: dmc5))
                        )
                    )
                )
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        dmc5View95Ci(
                            dmc5: dmc5,
                            selection: 3
                        )
                    )
                )
            } header: {
                Text("シングルチャンス目からのブラッディバトル当選")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($ver350.dmc5MenuDMCBonusBadgeStaus)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: dmc5.machineName,
                screenClass: screenClass
            )
        }
        // //// 画面の向き情報の取得部分
        .applyOrientationHandling(
            orientation: self.$orientation,
            lastOrientation: self.$lastOrientation,
            scrollViewHeight: self.$scrollViewHeight,
            spaceHeight: self.$spaceHeight,
            lazyVGridCount: self.$lazyVGridCount,
            scrollViewHeightPortrait: self.scrollViewHeightPortrait,
            scrollViewHeightLandscape: self.scrollViewHeightLandscape,
            spaceHeightPortrait: self.spaceHeightPortrait,
            spaceHeightLandscape: self.spaceHeightLandscape,
            lazyVGridCountPortrait: self.lazyVGridCountPortrait,
            lazyVGridCountLandscape: self.lazyVGridCountLandscape
        )
        .navigationTitle("初当り")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $dmc5.minusCheck)
                    // /// リセット
                    unitButtonReset(
                        isShowAlert: $isShowAlert,
                        action: dmc5.resetDmcBonus,
                    )
                    .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    dmc5ViewDmcBonus(
        ver350: Ver350(),
        dmc5: Dmc5(),
    )
}
