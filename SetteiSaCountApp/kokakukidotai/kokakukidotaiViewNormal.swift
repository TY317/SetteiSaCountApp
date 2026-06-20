//
//  kokakukidotaiViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/13.
//

import SwiftUI

struct kokakukidotaiViewNormal: View {
    @ObservedObject var kokakukidotai: Kokakukidotai
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    
    let itemList: [String] = ["青", "緑",]
    @State var selectedItem: String = "青"
    
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
            // タチコマの家出
            Section {
                // 確率結果
                unitResultRatioPercent2Line(
                    title: "200,400GでのCZ",
                    count: $kokakukidotai.iedeCountSuccess,
                    bigNumber: $kokakukidotai.iedeCountSum,
                    numberofDicimal: 0
                )
                
                // 参考情報）200or400GでのCZ当選率
                unitLinkButtonViewBuilder(sheetTitle: "200or400GでのCZ期待度") {
                    VStack {
                        VStack(alignment: .leading) {
                            Text("・AT終了時の200or400G時にタチコマの家出を抽選")
                            Text("・CZ合算の期待度に設定差")
                        }
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTablePercent(
                                columTitle: "合算期待度",
                                percentList: kokakukidotai.ratioIede
                            )
                        }
                    }
                }
                
                DisclosureGroup {
                    // 注意書き
                    HStack {
                        Text("⚠️")
                        VStack(alignment: .leading) {
                            Text("・AT終了時200or400Gでの当否がカウント対象")
                            Text("・リセット時、CZ終了時の200or400Gは対象外")
                        }
                        .foregroundStyle(Color.secondary)
                        .font(.caption)
                    }
                    
                    // カウントボタン横並び
                    HStack {
                        // ハズレ
                        unitCountButtonWithoutRatioWithFunc(
                            title: "ハズレ",
                            count: $kokakukidotai.iedeCountMiss,
                            color: .personalSummerLightBlue,
                            minusBool: $kokakukidotai.minusCheck) {
                                kokakukidotai.iedeSumFunc()
                            }
//                        unitCountButtonPercentWithFunc(
//                            title: "ハズレ",
//                            count: $kokakukidotai.iedeCountMiss,
//                            color: .personalSummerLightBlue,
//                            bigNumber: $kokakukidotai.iedeCountSum,
//                            numberofDicimal: 0,
//                            minusBool: $kokakukidotai.minusCheck) {
//                                kokakukidotai.iedeSumFunc()
//                            }
                        // 当選
                        unitCountButtonWithoutRatioWithFunc(
                            title: "当選",
                            count: $kokakukidotai.iedeCountSuccess,
                            color: .personalSummerLightRed,
                            minusBool: $kokakukidotai.minusCheck) {
                                kokakukidotai.iedeSumFunc()
                            }
//                        unitCountButtonPercentWithFunc(
//                            title: "当選",
//                            count: $kokakukidotai.iedeCountSuccess,
//                            color: .personalSummerLightRed,
//                            bigNumber: $kokakukidotai.iedeCountSum,
//                            numberofDicimal: 0,
//                            minusBool: $kokakukidotai.minusCheck) {
//                                kokakukidotai.iedeSumFunc()
//                            }
                    }
                    
                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            kokakukidotaiView95Ci(
                                kokakukidotai: kokakukidotai,
                                selection: 3,
                            )
                        )
                    )
                    
                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        kokakukidotaiViewBayes(
                            kokakukidotai: kokakukidotai,
                            bayes: bayes,
                            viewModel: viewModel,
                        )
                    }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("AT終了時200or400GでのCZ当選")
            }
            
            // ---- 発展色ごとの成功率
            Section {
                // 確率結果
                HStack {
                    // 青
                    unitResultRatioPercent2Line(
                        title: "青",
                        count: $kokakukidotai.czColorCountBlueHit,
                        bigNumber: $kokakukidotai.czColorCountBlueSum,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    
                    // 緑
                    unitResultRatioPercent2Line(
                        title: "緑",
                        count: $kokakukidotai.czColorCountGreenHit,
                        bigNumber: $kokakukidotai.czColorCountGreenSum,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                // 参考情報）発展色ごとの
                unitLinkButtonViewBuilder(sheetTitle: "発展色ごとのCZ以上当選率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "青",
                            percentList: kokakukidotai.ratioCzColorBlue,
                            numberofDicimal: 1,
                        )
                        unitTablePercent(
                            columTitle: "緑",
                            percentList: kokakukidotai.ratioCzColorGreen,
//                            numberofDicimal: 1,
                        )
                    }
                }
//                .popoverTip(tipVer3270KokakukidotaiCz())
                
                DisclosureGroup {
                    // セグメントピッカー
                    Picker("", selection: self.$selectedItem) {
                        ForEach(self.itemList, id: \.self) { item in
                            Text(item)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    // カウントボタン横並び
                    HStack {
                        // 青
                        if self.selectedItem == self.itemList[0] {
                            // ハズレ
                            unitCountButtonWithoutRatioWithFunc(
                                title: "ハズレ",
                                count: $kokakukidotai.czColorCountBlueMiss,
                                color: .personalSummerLightBlue,
                                minusBool: $kokakukidotai.minusCheck) {
                                    kokakukidotai.czColorSumFunc()
                                }
                            // CZ以上当選
                            unitCountButtonWithoutRatioWithFunc(
                                title: "CZ以上当選",
                                count: $kokakukidotai.czColorCountBlueHit,
                                color: .blue,
                                minusBool: $kokakukidotai.minusCheck) {
                                    kokakukidotai.czColorSumFunc()
                                }
                        }
                        // 緑
                        else {
                            // ハズレ
                            unitCountButtonWithoutRatioWithFunc(
                                title: "ハズレ",
                                count: $kokakukidotai.czColorCountGreenMiss,
                                color: .personalSummerLightGreen,
                                minusBool: $kokakukidotai.minusCheck) {
                                    kokakukidotai.czColorSumFunc()
                                }
                            // CZ以上当選
                            unitCountButtonWithoutRatioWithFunc(
                                title: "CZ以上当選",
                                count: $kokakukidotai.czColorCountGreenHit,
                                color: .green,
                                minusBool: $kokakukidotai.minusCheck) {
                                    kokakukidotai.czColorSumFunc()
                                }
                        }
                    }
                    
                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            kokakukidotaiView95Ci(
                                kokakukidotai: kokakukidotai,
                                selection: 6,
                            )
                        )
                    )
                    
                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        kokakukidotaiViewBayes(
                            kokakukidotai: kokakukidotai,
                            bayes: bayes,
                            viewModel: viewModel,
                        )
                    }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("殲滅ゾーン 発展色ごとの成功率")
            }
            
            // モード
            Section {
                // 確率結果
                HStack {
                    // 通常A
                    unitResultRatioPercent2Line(
                        title: "通常A",
                        count: $kokakukidotai.modeCountA,
                        bigNumber: $kokakukidotai.modeCountSum,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // 通常B
                    unitResultRatioPercent2Line(
                        title: "通常B",
                        count: $kokakukidotai.modeCountB,
                        bigNumber: $kokakukidotai.modeCountSum,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // 通常C
                    unitResultRatioPercent2Line(
                        title: "通常C",
                        count: $kokakukidotai.modeCountC,
                        bigNumber: $kokakukidotai.modeCountSum,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // 通常D
                    unitResultRatioPercent2Line(
                        title: "通常D",
                        count: $kokakukidotai.modeCountD,
                        bigNumber: $kokakukidotai.modeCountSum,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                }
                unitLinkButtonViewBuilder(sheetTitle: "CZ失敗後のモード移行率") {
                    kokakukidotaiTableModeMoveRatio(kokakukidotai: kokakukidotai)
                }
                .popoverTip(tipVer400KokakukidotaiSenmetuMode())
                DisclosureGroup {
                    // 注意
                    unitLabelCautionText {
                        Text("AT後の移行は設定差ないためカウント除外")
                    }
                    
                    // カウントボタン横並び
                    HStack {
                        // 通常A
                        unitCountButtonWithoutRatioWithFunc(
                            title: "通常A",
                            count: $kokakukidotai.modeCountA,
                            color: .personalSummerLightBlue,
                            minusBool: $kokakukidotai.minusCheck) {
                                kokakukidotai.modeSumFunc()
                            }
                        // 通常B
                        unitCountButtonWithoutRatioWithFunc(
                            title: "通常B",
                            count: $kokakukidotai.modeCountB,
                            color: .personalSpringLightYellow,
                            minusBool: $kokakukidotai.minusCheck) {
                                kokakukidotai.modeSumFunc()
                            }
                        // 通常C
                        unitCountButtonWithoutRatioWithFunc(
                            title: "通常C",
                            count: $kokakukidotai.modeCountC,
                            color: .personalSummerLightGreen,
                            minusBool: $kokakukidotai.minusCheck) {
                                kokakukidotai.modeSumFunc()
                            }
                        // 通常D
                        unitCountButtonWithoutRatioWithFunc(
                            title: "通常D",
                            count: $kokakukidotai.modeCountD,
                            color: .personalSummerLightRed,
                            minusBool: $kokakukidotai.minusCheck) {
                                kokakukidotai.modeSumFunc()
                            }
                    }
                    unitLinkButtonViewBuilder(sheetTitle: "モードについて") {
                        kokakukidotaiTableMode()
                    }
                    unitLinkButtonViewBuilder(sheetTitle: "前兆有無での示唆") {
                        Text("・100Gで4G以上のロング前兆無ければ通常B or 通常D")
                        Text("・300Gで4G以上のロング前兆あれば通常B濃厚")
                    }
                    unitLinkButtonViewBuilder(sheetTitle: "リプレイフラッシュでの示唆") {
                        kokakukidotaiTableReplayFlush()
                    }
                    unitLinkButtonViewBuilder(sheetTitle: "アイキャッチでの示唆") {
                        kokakukidotaiTableEyechatch()
                    }
                    
                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            kokakukidotaiView95Ci(
                                kokakukidotai: kokakukidotai,
                                selection: 8,
                            )
                        )
                    )
                    
                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        kokakukidotaiViewBayes(
                            kokakukidotai: kokakukidotai,
                            bayes: bayes,
                            viewModel: viewModel,
                        )
                    }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("通常時のモード")
            }
            
            // レア役
            Section {
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止形") {
                    kokakukidotaiTableKoyakuPattern()
                }
            } header: {
                Text("レア役")
            }
            
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.kokakukidotaiMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: kokakukidotai.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
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
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $kokakukidotai.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: kokakukidotai.resetNormal)
            }
        }
    }
}

#Preview {
    kokakukidotaiViewNormal(
        kokakukidotai: Kokakukidotai(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
