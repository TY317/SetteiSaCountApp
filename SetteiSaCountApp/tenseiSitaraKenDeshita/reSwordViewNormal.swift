//
//  reSwordViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/31.
//

import SwiftUI

struct reSwordViewNormal: View {
    @ObservedObject var reSword: ReSword
    @State var isShowAlert = false
    let zoneList: [String] = ["350-350G", "600-650G"]
    @State var selectedZone: String = "350-350G"
    let bonusRareList: [String] = ["弱チャンス目", "🍉", "強チャンス目"]
    @State var selectedBonusRare: String = "弱チャンス目"
    let czRareList: [String] = ["弱🍒", "強🍒"]
    @State var selectedCzRare: String = "弱🍒"
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
    let maxWidth2: CGFloat = 60
    let maxWidth3: CGFloat = .infinity
    let maxWidth4: CGFloat = .infinity
    let maxWidth5: CGFloat = 60
    
    var body: some View {
        List {
            // //// 小役関連
            Section {
                // レア役停止系
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止系", linkText: "レア役停止系") {
                    reSwordTableKoyakuPattern()
                }
                // レア役の役割
                unitLinkButtonViewBuilder(sheetTitle: "レア役の役割") {
                    HStack(spacing: 0) {
                        unitTableString(
                            columTitle: "",
                            stringList: [
                                "🍒",
                                "🍉・チャンス目"
                            ],
                            lineList: [1,2],
                            contentFont: .body,
                            colorList: [.white,.white],
                        )
                        unitTableString(
                            columTitle: "",
                            stringList: [
                                "CZ抽選＆CZ高確抽選",
                                "ボーナス抽選＆ボーナス高確抽選"
                            ],
                            maxWidth: 200,
                            lineList: [1,2],
                            contentFont: .body,
                            colorList: [.white,.white],
                        )
                    }
                }
            } header: {
                Text("小役")
            }
            
            // //// モード
            Section {
                // 内部モード
                unitLinkButtonViewBuilder(sheetTitle: "内部モード") {
                    VStack {
                        Text("・5種類の内部モードで各種抽選を管理")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        unitTableString(
                            columTitle: "",
                            stringList: [
                                "通常",
                                "CZ高確",
                                "ボーナス高確",
                                "ダブル高確\n(CZ＆ボーナス高確)",
                                "超高確\n(CZ＆ボーナス超高確)",
                            ],
                            maxWidth: 200,
                            lineList: [1,1,1,2,2]
                        )
                    }
                }
                // 規定ゲーム数モード
                unitLinkButtonViewBuilder(sheetTitle: "規定ゲーム数モード") {
                    VStack {
                        Text("・100Gごとに内部モード移行を抽選")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("・天井到達でAT当選濃厚のCZに当選")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack(spacing: 0) {
                            unitTableString(
                                columTitle: "",
                                stringList: [
                                    "モードA",
                                    "モードB",
                                    "モードC",
                                    "天国",
                                    "超天国",
                                ]
                            )
                            unitTableString(
                                columTitle: "天井",
                                stringList: [
                                    "970G",
                                    "600G",
                                    "300G",
                                    "100G",
                                    "100G",
                                ]
                            )
                        }
                    }
                }
            } header: {
                Text("モード")
            }
            
            // //// G数ゾーン当選率
            Section {
                // //// ゾーン選択
                Picker("", selection: self.$selectedZone) {
                    ForEach(self.zoneList, id: \.self) { zone in
                        Text(zone)
                    }
                }
                .pickerStyle(.segmented)
                
                // //// カウントボタン横並び
                // 300-350
                if self.selectedZone == self.zoneList[0] {
                    HStack {
                        // ハズレ
                        unitCountButtonWithoutRatioWithFunc(
                            title: "ハズレ",
                            count: $reSword.zoneCount350Miss,
                            color: .personalSummerLightBlue,
                            minusBool: $reSword.minusCheck) {
                                reSword.zoneCountSumFunc()
                            }
                        // 当選
                        unitCountButtonWithoutRatioWithFunc(
                            title: "当選",
                            count: $reSword.zoneCount350Hit,
                            color: .personalSummerLightGreen,
                            minusBool: $reSword.minusCheck) {
                                reSword.zoneCountSumFunc()
                            }
                    }
                }
                // 600-650
                else {
                    HStack {
                        // ハズレ
                        unitCountButtonWithoutRatioWithFunc(
                            title: "ハズレ",
                            count: $reSword.zoneCount650Miss,
                            color: .personalSpringLightYellow,
                            minusBool: $reSword.minusCheck) {
                                reSword.zoneCountSumFunc()
                            }
                        // 当選
                        unitCountButtonWithoutRatioWithFunc(
                            title: "当選",
                            count: $reSword.zoneCount650Hit,
                            color: .personalSummerLightRed,
                            minusBool: $reSword.minusCheck) {
                                reSword.zoneCountSumFunc()
                            }
                    }
                }
                
                // //// 当選率結果
                HStack {
                    // 300-350
                    unitResultRatioPercent2Line(
                        title: self.zoneList[0],
                        count: $reSword.zoneCount350Hit,
                        bigNumber: $reSword.zoneCount350Sum,
                        numberofDicimal: 0,
//                        spacerBool: false,
                    )
                    // 600-650
                    unitResultRatioPercent2Line(
                        title: self.zoneList[1],
                        count: $reSword.zoneCount650Hit,
                        bigNumber: $reSword.zoneCount650Sum,
                        numberofDicimal: 0,
//                        spacerBool: false,
                    )
                }
                
                // //// 参考情報）G数ゾーン当選率
                unitLinkButtonViewBuilder(sheetTitle: "G数ゾーン当選率") {
                    VStack {
                        Text("・300,600ゾーンでの当選率に設定差があると思われる")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTablePercent(
                                columTitle: self.zoneList[0],
                                percentList: reSword.ratioZone300,
                            )
                            unitTablePercent(
                                columTitle: self.zoneList[1],
                                percentList: reSword.ratioZone600,
                            )
                        }
                    }
                }
            } header: {
                Text("G数ゾーン当選率")
            }
            
            // ボーナス当選率
            Section {
                // セグメント選択
                Picker("", selection: self.$selectedBonusRare) {
                    ForEach(self.bonusRareList, id: \.self) { rare in
                        Text(rare)
                    }
                }
                .pickerStyle(.segmented)
                
                // カウントボタン横並び
                // 弱チャンス目
                if self.selectedBonusRare == self.bonusRareList[0] {
                    HStack {
                        // ハズレ
                        unitCountButtonWithoutRatioWithFunc(
                            title: "ハズレ",
                            count: $reSword.rareBonusCountJakuChanceMiss,
                            color: .personalSummerLightBlue,
                            minusBool: $reSword.minusCheck) {
                                reSword.rareBonusSumFunc()
                            }
                        // ハズレ
                        unitCountButtonWithoutRatioWithFunc(
                            title: "当選",
                            count: $reSword.rareBonusCountJakuChanceHit,
                            color: .blue,
                            minusBool: $reSword.minusCheck) {
                                reSword.rareBonusSumFunc()
                            }
                    }
                }
                // スイカ
                else if self.selectedBonusRare == self.bonusRareList[1] {
                    HStack {
                        // ハズレ
                        unitCountButtonWithoutRatioWithFunc(
                            title: "ハズレ",
                            count: $reSword.rareBonusCountSuikaMiss,
                            color: .personalSummerLightGreen,
                            minusBool: $reSword.minusCheck) {
                                reSword.rareBonusSumFunc()
                            }
                        // ハズレ
                        unitCountButtonWithoutRatioWithFunc(
                            title: "当選",
                            count: $reSword.rareBonusCountSuikaHit,
                            color: .green,
                            minusBool: $reSword.minusCheck) {
                                reSword.rareBonusSumFunc()
                            }
                    }
                }
                // 強チャンス目
                else {
                    HStack {
                        // ハズレ
                        unitCountButtonWithoutRatioWithFunc(
                            title: "ハズレ",
                            count: $reSword.rareBonusCountKyoChanceMiss,
                            color: .personalSummerLightPurple,
                            minusBool: $reSword.minusCheck) {
                                reSword.rareBonusSumFunc()
                            }
                        // ハズレ
                        unitCountButtonWithoutRatioWithFunc(
                            title: "当選",
                            count: $reSword.rareBonusCountKyoChanceHit,
                            color: .purple,
                            minusBool: $reSword.minusCheck) {
                                reSword.rareBonusSumFunc()
                            }
                    }
                }
                
                // //// 確率横並び
                HStack {
                    // 弱チャンス目
                    unitResultRatioPercent2Line(
                        title: self.bonusRareList[0],
                        count: $reSword.rareBonusCountJakuChanceHit,
                        bigNumber: $reSword.rareBonusCountJakuChanceSum,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // スイカ
                    unitResultRatioPercent2Line(
                        title: self.bonusRareList[1],
                        count: $reSword.rareBonusCountSuikaHit,
                        bigNumber: $reSword.rareBonusCountSuikaSum,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // 強チャンス目
                    unitResultRatioPercent2Line(
                        title: self.bonusRareList[2],
                        count: $reSword.rareBonusCountKyoChanceHit,
                        bigNumber: $reSword.rareBonusCountKyoChanceSum,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                }
                
                // //// 参考情報）レア役からのボーナス当選
                unitLinkButtonViewBuilder(sheetTitle: "レア役からのボーナス当選") {
                    reSwordTableRareBonus(reSword: reSword)
                }
            } header: {
                Text("レア役からのボーナス当選率")
            }
            
            // //// レア役からのCZ当選
            Section {
                // セグメント選択
                Picker("", selection: self.$selectedCzRare) {
                    ForEach(self.czRareList, id: \.self) { rare in
                        Text(rare)
                    }
                }
                .pickerStyle(.segmented)
                
                // カウントボタン横並び
                // 弱チェリー
                if self.selectedCzRare == self.czRareList[0] {
                    HStack {
                        // ハズレ
                        unitCountButtonWithoutRatioWithFunc(
                            title: "ハズレ",
                            count: $reSword.rareCzCountCherryJakuMiss,
                            color: .personalSummerLightRed,
                            minusBool: $reSword.minusCheck) {
                                reSword.rareCzSumFunc()
                            }
                        // ハズレ
                        unitCountButtonWithoutRatioWithFunc(
                            title: "当選",
                            count: $reSword.rareCzCountCherryJakuHit,
                            color: .red,
                            minusBool: $reSword.minusCheck) {
                                reSword.rareCzSumFunc()
                            }
                    }
                }
                // 強チェリー
                else {
                    HStack {
                        // ハズレ
                        unitCountButtonWithoutRatioWithFunc(
                            title: "ハズレ",
                            count: $reSword.rareCzCountCherryKyoMiss,
                            color: .personalSummerLightPurple,
                            minusBool: $reSword.minusCheck) {
                                reSword.rareCzSumFunc()
                            }
                        // ハズレ
                        unitCountButtonWithoutRatioWithFunc(
                            title: "当選",
                            count: $reSword.rareCzCountCherryKyoHit,
                            color: .purple,
                            minusBool: $reSword.minusCheck) {
                                reSword.rareCzSumFunc()
                            }
                    }
                }
                
                // //// 確率横並び
                HStack {
                    // 弱チェリー
                    unitResultRatioPercent2Line(
                        title: self.czRareList[0],
                        count: $reSword.rareCzCountCherryJakuHit,
                        bigNumber: $reSword.rareCzCountCherryJakuSum,
                        numberofDicimal: 0
                    )
                    // 強チェリー
                    unitResultRatioPercent2Line(
                        title: self.czRareList[1],
                        count: $reSword.rareCzCountCherryKyoHit,
                        bigNumber: $reSword.rareCzCountCherryKyoSum,
                        numberofDicimal: 0
                    )
                }
                // //// 参考情報）レア役からのCZ当選
                unitLinkButtonViewBuilder(sheetTitle: "レア役からのCZ当選") {
                    reSwordTableRareCz(reSword: reSword)
                }
            } header: {
                Text("レア役からのCZ当選")
            }
            
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: reSword.machineName,
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
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $reSword.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: reSword.resetNormal)
                }
            }
        }
    }
}

#Preview {
    reSwordViewNormal(
        reSword: ReSword(),
    )
}
