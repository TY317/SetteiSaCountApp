//
//  akudamaViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/05.
//

import SwiftUI

struct akudamaViewNormal: View {
    @ObservedObject var akudama: Akudama
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
            // ---- CZ アナライズチャレンジ当選率
            Section {
                // カウントボタン横並び
                HStack {
                    // pt減算到達
                    unitCountButtonVerticalWithoutRatio(
                        title: "pt減算到達",
                        count: $akudama.ptCountFull,
                        color: .personalSummerLightBlue,
                        minusBool: $akudama.minusCheck
                    )
                    // CZ当選
                    unitCountButtonVerticalWithoutRatio(
                        title: "CZ当選",
                        count: $akudama.ptCountCzHit,
                        color: .personalSummerLightPurple,
                        minusBool: $akudama.minusCheck
                    )
                }
                
                // 確率結果
                unitResultRatioPercent2Line(
                    title: "CZ当選",
                    count: $akudama.ptCountCzHit,
                    bigNumber: $akudama.ptCountFull,
                    numberofDicimal: 0
                )
                
                // 参考情報）ptからのCZ当選率
                unitLinkButtonViewBuilder(sheetTitle: "ptからのCZ当選率") {
                    VStack(alignment: .leading) {
                        Text("・シンテツドウptが累計20pt減算されるとCZ アナライズチャレンジ当選を抽選")
                        Text("・ptはベルで減算される")
                    }
                        .padding(.bottom)
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "CZ当選",
                            percentList: akudama.ratioPtCzHit
                        )
                    }
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        akudamaView95Ci(
                            akudama: akudama,
                            selection: 1,
                        )
                    )
                )
                
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    akudamaViewBayes(
                        akudama: akudama,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("CZ アナライズチャレンジ当選率")
            }
            // ---- レア役停止系
            Section {
                // 参考情報）レア役停止形
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止形") {
                    akudamaTableKoyakuPattern()
                }
            } header: {
                Text("小役")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.akudamaMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: akudama.machineName,
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
                unitButtonMinusCheck(minusCheck: $akudama.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: akudama.resetNormal)
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
    akudamaViewNormal(
        akudama: Akudama(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
