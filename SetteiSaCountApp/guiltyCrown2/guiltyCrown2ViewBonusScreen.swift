//
//  guiltyCrown2ViewBonusScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/07.
//

import SwiftUI

struct guiltyCrown2ViewBonusScreen: View {
    @ObservedObject var guiltyCrown2: GuiltyCrown2
    @State var isShowAlert: Bool = false
    @State var selectedImageName: String = ""
    let imageNameList: [String] = [
        "guiltyCrown2BonusScreen1",
        "guiltyCrown2BonusScreen2",
        "guiltyCrown2BonusScreen3",
        "guiltyCrown2BonusScreen4",
    ]
    let upperBeltTextList: [String] = [
        "GC 黒文字",
        "GC 白文字",
        "集＆涯",
        "いのり＆真名",
    ]
    let lowerBeltTextList: [String] = [
        "黒・白比率で設定示唆",
        "黒・白比率で設定示唆",
        "設定3 以上濃厚",
        "設定5 以上濃厚",
    ]
    let flashColorList: [Color] = [
        .gray,
        .gray,
        .green,
        .red,
    ]
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
                // //// 注意書き
                Text("BIG終了画面でサブ液晶タッチすると確認できます")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                Text("黒・白以外はカウント機能ありません")
                    .foregroundStyle(Color.secondary)
                // //// 画面カウントボタン
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        ForEach(self.imageNameList.indices, id: \.self) { index in
                            if self.imageNameList.indices.contains(index) &&
                                self.upperBeltTextList.indices.contains(index) &&
                                self.lowerBeltTextList.indices.contains(index) {
                                if index < 2 {
                                    unitButtonScreenChoiceVer3(
                                        screen: unitScreenOnlyDisplay(
                                            image: Image(self.imageNameList[index]),
                                            upperBeltText: self.upperBeltTextList[index],
                                            lowerBeltText: self.lowerBeltTextList[index],
                                            lowerBeltFont: .subheadline,
                                        ),
                                        screenName: self.imageNameList[index],
                                        selectedScreen: self.$selectedImageName,
                                        count: bindingForScreenCount(index: index),
                                        minusCheck: $guiltyCrown2.minusCheck,
                                        action: guiltyCrown2.bonusScreenCountSumFunc
                                    )
                                }
                                else {
                                    unitScreenOnlyDisplay(
                                        image: Image(self.imageNameList[index]),
                                        upperBeltText: self.upperBeltTextList[index],
                                        lowerBeltText: self.lowerBeltTextList[index],
                                    )
                                }
                            }
                        }
                    }
                    .popoverTip(tipUnitButtonScreenChoice())
                }
                .frame(height: 120)
                
                // //// カウント結果
                ForEach(self.lowerBeltTextList.indices, id: \.self) { index in
                    if self.lowerBeltTextList.indices.contains(index) &&
                        self.flashColorList.indices.contains(index) {
                        if index < 2 {
                            unitResultCountListPercent(
                                title: self.upperBeltTextList[index],
                                count: bindingForScreenCount(index: index),
                                flashColor: self.flashColorList[index],
                                bigNumber: $guiltyCrown2.bonusScreenCountSum
                            )
                        }
                        else {
                            
                        }
                    }
                }
                
                // //// 参考情報）黒白比率での示唆
                unitLinkButton(
                    title: "黒白比率での示唆について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "黒白比率での示唆",
                            tableView: AnyView(guiltyCrown2TableBonusScreenSisa())
                        )
                    )
                )
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: guiltyCrown2.machineName,
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
        .navigationTitle("BIG終了後のサブ液晶画面")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// 画面選択解除
                    unitButtonToolbarScreenSelectReset(currentKeyword: self.$selectedImageName)
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $guiltyCrown2.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: guiltyCrown2.resetBonusScreen)
                }
            }
        }
    }
    
    func bindingForScreenCount(index: Int) -> Binding<Int> {
        switch index {
        case 0: return guiltyCrown2.$bonusScreenCountBlack
        case 1: return guiltyCrown2.$bonusScreenCountWhite
        default: return .constant(0)
        }
    }
}

#Preview {
    guiltyCrown2ViewBonusScreen(
        guiltyCrown2: GuiltyCrown2()
    )
}
