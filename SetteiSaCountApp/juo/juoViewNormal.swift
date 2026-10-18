//
//  juoViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct juoViewNormal: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var juo: Juo
    @State var isShowDestination: Bool = false
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
    // レア役の選択
    let koyakuSegmentList: [String] = ["🍒", "レアリプレイ"]
    @State var koyakuSelected: String = "🍒"
    var body: some View {
        List {
            
            // ---- レア役成立時のSC高確移行率
            Section {
                // 確率横並び
                HStack {
                    // チェリー
                    unitResultRatioPercent2Line(
                        title: "🍒",
                        count: $juo.cherryCountScHigh,
                        bigNumber: $juo.cherryCount,
                        numberofDicimal: 1,
                        spacerBool: false,
                    )
                    // レアリプレイ
                    unitResultRatioPercent2Line(
                        title: "レアリプレイ",
                        count: $juo.rareReplayCountScHigh,
                        bigNumber: $juo.rareReplayCount,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .popoverTip(tipVer491JuoScHigh())

                // 参考情報）レア役成立時のSC高確移行率
                unitLinkButtonViewBuilder(sheetTitle: "レア役成立時のSC高確移行率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex(settingList: [1,2,4,5,6])
                        unitTablePercent(
                            columTitle: "🍒",
                            percentList: juo.ratioCherryScHigh,
                            numberofDicimal: 1,
                        )
                        unitTablePercent(
                            columTitle: "レアリプレイ",
                            percentList: juo.ratioRareReplayScHigh,
                            numberofDicimal: 0,
                        )
                    }
                }

                // カウント
                DisclosureGroup {
                    // セグメントピッカー
                    Picker("", selection: self.$koyakuSelected) {
                        ForEach(self.koyakuSegmentList, id: \.self) { item in
                            Text(item)
                        }
                    }
                    .pickerStyle(.segmented)

                    // カウントボタン横並び
                    HStack {
                        if self.koyakuSelected == self.koyakuSegmentList[0] {
                            // チェリー
                            unitCountButtonWithoutRatioWithFunc(
                                title: "小役成立",
                                count: $juo.cherryCount,
                                color: .personalSummerLightRed,
                                minusBool: $juo.minusCheck) {
                                }
                            // SC高確移行
                            unitCountButtonWithoutRatioWithFunc(
                                title: "SC高確移行",
                                count: $juo.cherryCountScHigh,
                                color: .red,
                                minusBool: $juo.minusCheck) {
                                }
                        }
                        else if self.koyakuSelected == self.koyakuSegmentList[1] {
                            // レアリプレイ
                            unitCountButtonWithoutRatioWithFunc(
                                title: "小役成立",
                                count: $juo.rareReplayCount,
                                color: .personalSummerLightBlue,
                                minusBool: $juo.minusCheck) {
                                }
                            // SC高確移行
                            unitCountButtonWithoutRatioWithFunc(
                                title: "SC高確移行",
                                count: $juo.rareReplayCountScHigh,
                                color: .blue,
                                minusBool: $juo.minusCheck) {
                                }
                        }
                    }

                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            juoView95Ci(
                                juo: juo,
                                selection: 3 + (self.koyakuSegmentList.firstIndex(of: self.koyakuSelected) ?? 0),
                            )
                        )
                    )

                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        juoViewBayes(
                            juo: juo,
                        )
                    }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("レア役からのSC高確移行率")
            }
            // レア役
            Section {
                // レア役停止系
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止系") {
                    juoTableKoyakuPattern()
                }
            } header: {
                Text("小役")
            }
            
            // SC高確
            Section {
                // 謎高確
                unitLinkButtonViewBuilder(sheetTitle: "謎高確") {
                    Text("・レア役やゲーム数のゾーン（100の倍数）以外からの高確移行（＝謎高確）に設定差あり")
                    HStack(spacing: 0) {
                        unitTableSettingIndex(settingList: [1,2,4,5,6])
                        unitTableString(
                            columTitle: "謎高確",
                            stringList: [
                                "約1/1000",
                                "?",
                                "?",
                                "?",
                                "設定1の倍以上"
                            ],
                        )
                    }
                    .padding(.bottom)
                    VStack(alignment: .leading) {
                        Text("・レア役からの移行、ゲーム数ゾーンと異なり謎高確に対応する「フェイク」は存在しない")
                        Text("・下記ポイントを満たせば謎高確と考えてOK")
                    }
                    unitTableString(
                        columTitle: "謎高確の見極めポイント",
                        stringList: [
                            "①レア役を引いていない",
                            "②ゲーム数のゾーンをまたいでいない",
                            "③演出がざわついている",
                        ],
                        maxWidth: 300,
                    )
                }
                
                // ゲーム数での移行
                unitLinkButtonViewBuilder(sheetTitle: "ゲーム数での移行") {
                    Text("・百の位が偶数のゲーム数は高設定ほどSC高確への移行が優遇")
                }
            } header: {
                Text("SC高確 移行")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.juoMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: juo.machineName,
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
                unitButtonMinusCheck(minusCheck: $juo.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: juo.resetNormal)
            }
        }
    }
}

#Preview {
    juoViewNormal(
        juo: Juo(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
