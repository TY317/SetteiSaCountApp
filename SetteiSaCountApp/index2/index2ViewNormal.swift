//
//  index2ViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct index2ViewNormal: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var index2: Index2
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
    var body: some View {
        List {
            // ---- スイカからの高確移行
            Section {
                // 確率結果
                HStack {
                    // 高確移行
                    unitResultRatioPercent2Line(
                        title: "🍉→高確",
                        count: $index2.suikaCountKokaku,
                        bigNumber: $index2.suikaCountKoyaku,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // 美琴高確移行
                    unitResultRatioPercent2Line(
                        title: "🍉→美琴高確",
                        count: $index2.suikaCountMikoto,
                        bigNumber: $index2.suikaCountKoyaku,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                // 参考情報）移行率
                unitLinkButtonViewBuilder(sheetTitle: "高確移行率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "高確移行",
                            percentList: index2.ratioSuikaKokaku
                        )
                        unitTablePercent(
                            columTitle: "美琴高確移行",
                            percentList: index2.ratioSuikaMikotoKokaku
                        )
                    }
                }
                
                DisclosureGroup {
                    Text("高確は主にロシアステージで示唆される")
                        .foregroundStyle(Color.secondary)
                        .font(.caption)
                    // カウントボタン横並び
                    HStack {
                        // スイカ成立
                        unitCountButtonWithoutRatioWithFunc(
                            title: "🍉",
                            count: $index2.suikaCountKoyaku,
                            color: .personalSummerLightGreen,
                            minusBool: $index2.minusCheck) {
                                
                            }
                        // 高確移行
                        unitCountButtonWithoutRatioWithFunc(
                            title: "高確移行",
                            count: $index2.suikaCountKokaku,
                            color: .personalSummerLightPurple,
                            minusBool: $index2.minusCheck) {
                                
                            }
                        // 美琴高確移行
                        unitCountButtonWithoutRatioWithFunc(
                            title: "美琴高確",
                            count: $index2.suikaCountMikoto,
                            color: .personalSummerLightRed,
                            minusBool: $index2.minusCheck) {
                                
                            }
                    }
                    
                    // 95%信頼区間グラフ
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            index2View95Ci(
                                index2: index2,
                                selection: 1
                            )
                        )
                    )
                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        index2ViewBayes(
                            index2: index2,
                        )
                    }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("🍉からの高確移行")
            }
            // レア役
            Section {
                // レア役停止系
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止系") {
                    index2TableKoyakuPattern()
                }
            } header: {
                Text("小役")
            }
            
            // モード
            Section {
                unitLinkButtonViewBuilder(sheetTitle: "通常時のモード") {
                    index2TableMode()
                }
            } header: {
                Text("モード")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.index2MenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: index2.machineName,
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
                unitButtonMinusCheck(minusCheck: $index2.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: index2.resetNormal)
            }
        }
    }
}

#Preview {
    index2ViewNormal(
        index2: Index2(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
