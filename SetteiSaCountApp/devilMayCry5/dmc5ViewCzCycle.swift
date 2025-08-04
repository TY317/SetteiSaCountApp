//
//  dmc5ViewCzCycle.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/10.
//

import SwiftUI

struct dmc5ViewCzCycle: View {
//    @ObservedObject var ver351: Ver351
    @ObservedObject var dmc5: Dmc5
    @State var isShowAlert: Bool = false
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 250.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 250.0
    let lazyVGridCountPortrait: Int = 2
    let lazyVGridCountLandscape: Int = 4
    @State var lazyVGridCount: Int = 2
    
    var body: some View {
        List {
            Section {
                Text("CZ当選時の該当する周期をカウントして下さい\n各周期までの当選率を算出します")
                    .font(.caption)
                    .foregroundStyle(Color.secondary)
                HStack {
                    // 1周期
                    unitCountButtonWithoutRatioWithFunc(
                        title: "1周期",
                        count: $dmc5.czCycleCountHit1,
                        color: .personalSummerLightRed,
                        minusBool: $dmc5.minusCheck,
                        action: dmc5.czCycleSumFunc
                    )
                    // 2-4周期
                    unitCountButtonWithoutRatioWithFunc(
                        title: "2-4周期",
                        count: $dmc5.czCycleCountHit2to4,
                        color: .personalSummerLightGreen,
                        minusBool: $dmc5.minusCheck,
                        action: dmc5.czCycleSumFunc
                    )
                    // 5-7周期
                    unitCountButtonWithoutRatioWithFunc(
                        title: "5-7周期",
                        count: $dmc5.czCycleCountHit5to7,
                        color: .personalSpringLightYellow,
                        minusBool: $dmc5.minusCheck,
                        action: dmc5.czCycleSumFunc
                    )
                    // 8-10周期
                    unitCountButtonWithoutRatioWithFunc(
                        title: "8-10周期",
                        count: $dmc5.czCycleCountHit8to10,
                        color: .personalSummerLightBlue,
                        minusBool: $dmc5.minusCheck,
                        action: dmc5.czCycleSumFunc
                    )
                }
                
                // //// 当選率結果
                VStack {
                    Text("[各周期までの当選率]")
                        .frame(maxWidth: .infinity, alignment: .center)
                    HStack {
                        // 1周期
                        unitResultRatioPercent2Line(
                            title: "1周期",
                            count: $dmc5.czCycleCountHit1,
                            bigNumber: $dmc5.czHitCountAll,
                            numberofDicimal: 0,
                            spacerBool: false,
                        )
                        // 4周期まで
                        unitResultRatioPercent2Line(
                            title: "4周期まで",
                            count: $dmc5.czHitCountUpTo4,
                            bigNumber: $dmc5.czHitCountAll,
                            numberofDicimal: 0,
                            spacerBool: false,
                        )
                        // 7周期まで
                        unitResultRatioPercent2Line(
                            title: "7周期まで",
                            count: $dmc5.czHitCountUpTo7,
                            bigNumber: $dmc5.czHitCountAll,
                            numberofDicimal: 0,
                            spacerBool: false,
                        )
                    }
                }
                
                // //// 参考情報）各周期までの当選率について
                unitLinkButton(
                    title: "各周期までの当選率について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "各周期までの当選率",
                            tableView: AnyView(dmc5TableCzCycle(dmc5: dmc5))
                        )
                    )
                )
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        dmc5View95Ci(
                            dmc5: dmc5,
                            selection: 4,
                        )
                    )
                )
            } header: {
                Text("CZ当選時の周期カウント")
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// バッジのリセット
//        .resetBadgeOnAppear($ver351.dmc5MenuCzCycleBadge)
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
        .navigationTitle("CZ当選周期")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $dmc5.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: dmc5.resetCzCycle)
                }
            }
        }
    }
}

#Preview {
    dmc5ViewCzCycle(
//        ver351: Ver351(),
        dmc5: Dmc5(),
    )
}
