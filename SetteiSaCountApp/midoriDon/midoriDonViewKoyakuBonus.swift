//
//  midoriDonViewKoyakuBonus.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/24.
//

import SwiftUI


struct midoriDonViewKoyakuBonus: View {
//    @ObservedObject var ver320: Ver320
    @ObservedObject var midoriDon: MidoriDon
    @State var isShowAlert = false
    let selectListKoyakuKind: [String] = [
        "弱🍒",
        "弱🍉",
        "ﾁｬﾝｽ目",
        "強🍒",
        "強🍉"
    ]
    @State var selectedKoyakuKind: String = "弱🍒"
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 250.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 250.0
    let lazyVGridCountPortrait: Int = 3
    let lazyVGridCountLandscape: Int = 5
    @State var lazyVGridCount: Int = 3
    
    var body: some View {
        List {
            Section {
                // 小役種類の選択
                Picker("", selection: self.$selectedKoyakuKind) {
                    ForEach(self.selectListKoyakuKind, id: \.self) { koyaku in
                        Text(koyaku)
                    }
                }
                .pickerStyle(.segmented)
                
                // //// カウントボタン
                // 弱チェリー
                if self.selectedKoyakuKind == self.selectListKoyakuKind[0] {
                    HStack {
                        // 弱チェカウント
                        unitCountButtonVerticalWithoutRatio(
                            title: "弱🍒回数",
                            count: $midoriDon.normalRareCountJakuCherry,
                            color: .personalSummerLightRed,
                            minusBool: $midoriDon.minusCheck
                        )
                        // ボーナス当選
                        unitCountButtonVerticalWithoutRatio(
                            title: "ボーナス当選",
                            count: $midoriDon.normalRareHitCountJakuCherry,
                            color: .red,
                            minusBool: $midoriDon.minusCheck
                        )
                    }
                }
                // 弱スイカ
                else if self.selectedKoyakuKind == self.selectListKoyakuKind[1] {
                    HStack {
                        // 弱スイカカウント
                        unitCountButtonVerticalWithoutRatio(
                            title: "弱🍉回数",
                            count: $midoriDon.normalRareCountJakuSuika,
                            color: .personalSummerLightGreen,
                            minusBool: $midoriDon.minusCheck
                        )
                        // ボーナス当選
                        unitCountButtonVerticalWithoutRatio(
                            title: "ボーナス当選",
                            count: $midoriDon.normalRareHitCountJakuSuika,
                            color: .green,
                            minusBool: $midoriDon.minusCheck
                        )
                    }
                }
                // チャンス目
                else if self.selectedKoyakuKind == self.selectListKoyakuKind[2] {
                    HStack {
                        // チャンス目カウント
                        unitCountButtonVerticalWithoutRatio(
                            title: "チャンス目回数",
                            count: $midoriDon.normalRareCountChance,
                            color: .personalSummerLightPurple,
                            minusBool: $midoriDon.minusCheck
                        )
                        // ボーナス当選
                        unitCountButtonVerticalWithoutRatio(
                            title: "ボーナス当選",
                            count: $midoriDon.normalRareHitCountChance,
                            color: .purple,
                            minusBool: $midoriDon.minusCheck
                        )
                    }
                }
                // 強チェリー
                else if self.selectedKoyakuKind == self.selectListKoyakuKind[3] {
                    HStack {
                        // 強チェリーカウント
                        unitCountButtonVerticalWithoutRatio(
                            title: "強🍒回数",
                            count: $midoriDon.normalRareCountKyoCherry,
                            color: .red,
                            minusBool: $midoriDon.minusCheck
                        )
                        // ボーナス当選
                        unitCountButtonVerticalWithoutRatio(
                            title: "ボーナス当選",
                            count: $midoriDon.normalRareHitCountKyoCherry,
                            color: .personalSummerLightRed,
                            minusBool: $midoriDon.minusCheck
                        )
                    }
                }
                // 強スイカ
                else {
                    HStack {
                        // 強スイカカウント
                        unitCountButtonVerticalWithoutRatio(
                            title: "強🍉回数",
                            count: $midoriDon.normalRareCountKyoSuika,
                            color: .green,
                            minusBool: $midoriDon.minusCheck
                        )
                        // ボーナス当選
                        unitCountButtonVerticalWithoutRatio(
                            title: "ボーナス当選",
                            count: $midoriDon.normalRareHitCountKyoSuika,
                            color: .personalSummerLightGreen,
                            minusBool: $midoriDon.minusCheck
                        )
                    }
                }
                
                // //// 確率横並び
                let gridItem = Array(
                    repeating: GridItem(
                        .flexible(minimum: 80, maximum: 150),
                        spacing: 5
                    ),
                    count: self.lazyVGridCount
                )
                LazyVGrid(columns: gridItem) {
                    unitResultRatioPercent2Line(
                        title: "弱🍒",
                        count: $midoriDon.normalRareHitCountJakuCherry,
                        bigNumber: $midoriDon.normalRareCountJakuCherry,
                        numberofDicimal: 1,
                        spacerBool: false
                    )
                    .frame(height: 60)
                    unitResultRatioPercent2Line(
                        title: "弱🍉",
                        count: $midoriDon.normalRareHitCountJakuSuika,
                        bigNumber: $midoriDon.normalRareCountJakuSuika,
                        numberofDicimal: 1,
                        spacerBool: false
                    )
                    .frame(height: 60)
                    unitResultRatioPercent2Line(
                        title: "チャンス目",
                        count: $midoriDon.normalRareHitCountChance,
                        bigNumber: $midoriDon.normalRareCountChance,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                    .frame(height: 60)
                    unitResultRatioPercent2Line(
                        title: "強🍒",
                        count: $midoriDon.normalRareHitCountKyoCherry,
                        bigNumber: $midoriDon.normalRareCountKyoCherry,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                    .frame(height: 60)
                    unitResultRatioPercent2Line(
                        title: "強🍉",
                        count: $midoriDon.normalRareHitCountKyoSuika,
                        bigNumber: $midoriDon.normalRareCountKyoSuika,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                    .frame(height: 60)
                }
                
                // //// 参考情報）レア役からのボーナス当選
                unitLinkButton(
                    title: "レア役からのボーナス当選について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "レア役からのボーナス当選",
                            textBody1: "・通常滞在時のレア役からのボーナス当選に設定差",
                            textBody2: "・高確滞在時は弱波のみわずかな設定差があり、それ以外は設定差なし",
                            tableView: AnyView(midoriDonTableKoyakuBonus(midoriDon: midoriDon))
                        )
                    )
                )
                // //// 小役停止形
                Section {
                    unitLinkButton(
                        title: "小役停止形",
                        exview: AnyView(
                            unitExView5body2image(
                                title: "小役停止形",
                                tableView: AnyView(midoriDonTableKoyakuPattern())
                            )
                        )
                    )
                }
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(midoriDonView95Ci(
                    midoriDon: midoriDon,
                    selection: 4
                )))
            } header: {
                Text("通常時レア役からのボーナス当選")
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// バッジのリセット
//        .resetBadgeOnAppear($ver320.midoriDonMenuKoyakuBonusBadgeStatus)
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
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "緑ドン",
                screenClass: screenClass
            )
        }
//        .logFirebaseScreenView(screenName: "緑ドン")
//        .onAppear {
//            // ビューが表示されるときにデバイスの向きを取得
//            self.orientation = UIDevice.current.orientation
//            // 向きがフラットでなければlastOrientationの値を更新
//            if self.orientation.isFlat {
//                
//            }
//            else {
//                self.lastOrientation = self.orientation
//            }
//            if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
//                self.scrollViewHeight = self.scrollViewHeightLandscape
//                self.spaceHeight = self.spaceHeightLandscape
//                self.lazyVGridCount = self.lazyVGridCountLandscape
//            } else {
//                self.scrollViewHeight = self.scrollViewHeightPortrait
//                self.spaceHeight = self.spaceHeightPortrait
//                self.lazyVGridCount = self.lazyVGridCountPortrait
//            }
//            // デバイスの向きの変更を監視する
//            NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: .main) { _ in
//                self.orientation = UIDevice.current.orientation
//                // 向きがフラットでなければlastOrientationの値を更新
//                if self.orientation.isFlat {
//                    
//                }
//                else {
//                    self.lastOrientation = self.orientation
//                }
//                if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
//                    self.scrollViewHeight = self.scrollViewHeightLandscape
//                    self.spaceHeight = self.spaceHeightLandscape
//                    self.lazyVGridCount = self.lazyVGridCountLandscape
//                } else {
//                    self.scrollViewHeight = self.scrollViewHeightPortrait
//                    self.spaceHeight = self.spaceHeightPortrait
//                    self.lazyVGridCount = self.lazyVGridCountPortrait
//                }
//            }
//        }
//        .onDisappear {
//            // ビューが非表示になるときに監視を解除
//            NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
//        }
        .navigationTitle("通常時レア役からの当選")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $midoriDon.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: midoriDon.resetKoyakuBonus)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    midoriDonViewKoyakuBonus(
//        ver320: Ver320(),
        midoriDon: MidoriDon()
    )
}
