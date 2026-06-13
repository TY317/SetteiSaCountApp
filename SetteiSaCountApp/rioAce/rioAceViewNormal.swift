//
//  rioAceViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/05/03.
//

import SwiftUI

struct rioAceViewNormal: View {
    @ObservedObject var rioAce: RioAce
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    @State var isShowAlert: Bool = false
    @FocusState var isFocused: Bool
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
            // ---- 小役関連
            Section {
                // Vベルシステム
                unitLinkButtonViewBuilder(sheetTitle: "Vベルシステムについて") {
                    rioAceTableVBellSystem()
                }
                
                // レア役停止系
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止形") {
                    rioAceTableKoyakuPattern()
                }
            } header: {
                Text("小役")
            }
            // ---- 規定リプレイからの当選
            Section {
                // 確率結果
                unitResultRatioPercent2Line(
                    title: "ハワードゲーム当選",
                    count: $rioAce.kiteiReplayHit,
                    bigNumber: $rioAce.kiteiReplay,
                    numberofDicimal: 0
                )
                
                // 参考情報）ハワードゲーム当選率
                unitLinkButtonViewBuilder(sheetTitle: "ハワードゲーム当選率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "ハワードゲーム当選",
                            percentList: rioAce.ratioKiteiReplayHit
                        )
                    }
                }
                
                // カウントボタン横並び
                DisclosureGroup {
                    HStack {
                        // 規定回数到達
                        unitCountButtonWithoutRatioWithFunc(
                            title: "規定回数到達",
                            count: $rioAce.kiteiReplay,
                            color: .personalSummerLightBlue,
                            minusBool: $rioAce.minusCheck) {
                                
                            }
                        // 当選
                        unitCountButtonWithoutRatioWithFunc(
                            title: "当選",
                            count: $rioAce.kiteiReplayHit,
                            color: .blue,
                            minusBool: $rioAce.minusCheck) {
                                
                            }
                    }
                    
                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            rioAceView95Ci(
                                rioAce: rioAce,
                                selection: 4,
                            )
                        )
                    )
                    
                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        rioAceViewBayes(
                            rioAce: rioAce,
                            bayes: bayes,
                            viewModel: viewModel,
                        )
                    }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("規定リプレイからの当選")
            }
            
            // ---- エースモード
            Section {
                // 確率結果
                unitResultRatioPercent2Line(
                    title: "エースモード突入",
                    count: $rioAce.aceModeCountHit,
                    bigNumber: $rioAce.aceModeCountSum,
                    numberofDicimal: 0
                )
                .popoverTip(tipVer3271RioAceAceMode())
                
                // エースモード突入率
                unitLinkButtonViewBuilder(sheetTitle: "エースモード突入率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "突入率",
                            percentList: rioAce.ratioAceMode
                        )
                    }
                }
                
                // エースモード概要
                unitLinkButtonViewBuilder(sheetTitle: "エースモードについて") {
                    rioAceTableAceMode()
                }
                .popoverTip(tipVer3260RioAceMode())
                
                // アイキャッチでの示唆
                unitLinkButtonViewBuilder(sheetTitle: "アイキャッチでの示唆") {
                    rioAceTableEyeCatch()
                }
                
                // カウントボタン横並び
                DisclosureGroup {
                    // 注意書き
                    unitLabelCautionText {
                        Text("見抜けないことが多いと思います\nメモ代わり程度でご利用ください")
                    }
                    
                    HStack {
                        // 突入なし
                        unitCountButtonWithoutRatioWithFunc(
                            title: "突入なし",
                            count: $rioAce.aceModeCountMiss,
                            color: .personalSummerLightBlue,
                            minusBool: $rioAce.minusCheck) {
                                rioAce.aceModeSumFunc()
                            }
                        // 突入
                        unitCountButtonWithoutRatioWithFunc(
                            title: "突入",
                            count: $rioAce.aceModeCountHit,
                            color: .personalSummerLightRed,
                            minusBool: $rioAce.minusCheck) {
                                rioAce.aceModeSumFunc()
                            }
                    }
                    
                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            rioAceView95Ci(
                                rioAce: rioAce,
                                selection: 5,
                            )
                        )
                    )
                    
                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        rioAceViewBayes(
                            rioAce: rioAce,
                            bayes: bayes,
                            viewModel: viewModel,
                        )
                    }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("エースモード")
            }
            
            // ---- スイカでの成功当選
            Section {
                // 注意書き
                unitLabelCautionText {
                    Text("スイカ成立時の第3停止後、PUSHボタン両サイドのランプに要注目")
                }
                
                // 参考情報）スイカでの次回成功抽選
                unitLinkButtonViewBuilder(sheetTitle: "スイカでの次回成功抽選") {
                    Text("・通常時のスイカで次回ノワールルームの成功抽選")
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "成功当選",
                            percentList: rioAce.ratioSuikaCz
                        )
                    }
                }
                
                // PUSHボタン両サイドのランプ示唆
                unitLinkButtonViewBuilder(sheetTitle: "PUSHボタン両サイドのランプ示唆") {
                    rioAceTablePushSideLamp()
                }
            } header: {
                Text("スイカでの成功当選")
            }
            
            // ---- 演出での示唆
            Section {
                // リール枠エフェクト矛盾
                unitLinkButtonViewBuilder(sheetTitle: "リール枠エフェクト矛盾") {
                    VStack(alignment: .leading) {
                        Text("・リール枠エフェクト色の対応役が外れた場合は本前兆の期待大")
                        Text("・本前兆も外れた場合は高設定のチャンス")
                    }
                    .padding(.bottom)
                    rioAceTableReelEffect()
                }
                
                // アイキャッチ
                unitLinkButtonViewBuilder(sheetTitle: "アイキャッチ法則矛盾") {
                    rioAceTableEyeCatch()
//                    VStack(alignment: .leading) {
//                        Text("・全員集合アイキャッチが出現した場合、次回ノワールルームで")
//                        Text("　　　・のわーるるーむ")
//                        Text("　　　・AT当選")
//                        Text("　　　・ノワールタイム")
//                        Text("　のいずれかに当選")
//                        Text("・どれにも当選しなかった場合は高設定の期待度が大幅アップ")
//                    }
                }
            } header: {
                Text("演出での示唆")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.rioAceMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: rioAce.machineName,
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
                unitButtonMinusCheck(minusCheck: $rioAce.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: rioAce.resetNormal)
            }
            ToolbarItem(placement: .keyboard) {
                HStack {
                    Spacer()
                    Button(action: {
                        isFocused = false
                    }, label: {
                        Text("完了")
                            .fontWeight(.bold)
                    })
                }
            }
        }
    }
}

#Preview {
    rioAceViewNormal(
        rioAce: RioAce(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
