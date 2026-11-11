//
//  vivyViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct vivyViewNormal: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var vivy: Vivy
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
            // レア役
            Section {
                // レア役停止系
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止系") {
                    vivyTableKoyakuPattern()
                }
            } header: {
                Text("小役")
            }

            // ---- 周期モード
            Section {
                // 参考情報）周期モードについて
                unitLinkButtonViewBuilder(sheetTitle: "周期モードについて") {
                    VStack(alignment: .leading) {
                        Text("・通常A・通常B・天国の3種類")
                        Text("・設定変更時＆AT終了時にモードを抽選")
                        Text("・天国移行率は約40%（設定1）")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Text("[モードごとの規定周期振り分け]")
                        .font(.title2)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top)
                    HStack(spacing: 0) {
                        unitTableString(
                            columTitle: "規定周期",
                            stringList: ["1周期", "2周期", "3周期", "4周期", "5周期", "6周期"],
                        )
                        unitTablePercent(
                            columTitle: "通常A",
                            percentList: [0, 27.5, 11.3, 18.3, 17.9, 24.9],
                            numberofDicimal: 0,
                        )
                        unitTablePercent(
                            columTitle: "通常B",
                            percentList: [0, 43.6, 56.4, 0, 0, 0],
                            numberofDicimal: 0,
                        )
                        unitTablePercent(
                            columTitle: "天国",
                            percentList: [100, 0, 0, 0, 0, 0],
                            numberofDicimal: 0,
                        )
                    }
                }

                // 参考情報）モードごとの規定ポイント期待度
                unitLinkButtonViewBuilder(sheetTitle: "モードごとの規定ポイント期待度") {
                    vivyTablePointKitai()
                }
            } header: {
                Text("周期モード")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.vivyMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: vivy.machineName,
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
                unitButtonMinusCheck(minusCheck: $vivy.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: vivy.resetNormal)
            }
        }
    }
}

// //// モードごとの規定ポイント期待度（前回の規定ポイントで切り替え）
// kitaiList：0=－　1=△　2=◯　3=◎　11=周期天井
struct vivyTablePointKitai: View {
    let lastPointList: [String] = ["前回555pt以外", "前回555pt"]
    @State var selectedLastPoint: String = "前回555pt以外"
    let pointList: [String] = ["111pt", "222pt", "333pt", "444pt", "555pt"]

    var body: some View {
        VStack {
            Picker("", selection: self.$selectedLastPoint) {
                ForEach(self.lastPointList, id: \.self) { point in
                    Text(point)
                }
            }
            .pickerStyle(.segmented)
            .padding(.bottom)

            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "ポイント",
                    stringList: self.pointList,
                    maxWidth: 100,
                )
                if self.selectedLastPoint == self.lastPointList[0] {
                    unitTableZoneKitai(columTitle: "通常A", kitaiList: [1,2,3,3,11])
                    unitTableZoneKitai(columTitle: "通常B", kitaiList: [1,3,2,3,11])
                    unitTableZoneKitai(columTitle: "天国", kitaiList: [2,11,0,0,0])
                } else {
                    unitTableZoneKitai(columTitle: "通常A", kitaiList: [1,3,11,0,0])
                    unitTableZoneKitai(columTitle: "通常B", kitaiList: [1,3,11,0,0])
                    unitTableZoneKitai(columTitle: "天国", kitaiList: [2,11,0,0,0])
                }
            }
        }
    }
}

#Preview {
    vivyViewNormal(
        vivy: Vivy(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
