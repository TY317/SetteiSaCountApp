//
//  arifureViewEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/06.
//

import SwiftUI

struct arifureViewEnding: View {
    @ObservedObject var ver250 = Ver250()
    @ObservedObject var arifure = Arifure()
    @State var isShowAlert: Bool = false
    @State var selectedImageName: String = ""
    let imageNameList: [String] = [
        "arifureEndingScreenKisu",
        "arifureEndingScreenGusu",
        "arifureEndingScreenHighJaku",
        "arifureEndingScreenHighKyo",
        "arifureEndScreenOver4",
        "arifureEndScreenOver5",
        "arifureEndScreenOver6"
    ]
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 250.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 250.0
    
    var body: some View {
        List {
            Section {
                // //// 画面選択ボタン
                ScrollView(.horizontal) {
                    HStack(spacing: 20.0) {
                        // 奇数示唆
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[0]),
                            keyword: self.imageNameList[0],
                            currentKeyword: self.$selectedImageName,
                            count: $arifure.endingCountKisu,
                            minusCheck: $arifure.minusCheck
                        )
                        // 偶数示唆
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[1]),
                            keyword: self.imageNameList[1],
                            currentKeyword: self.$selectedImageName,
                            count: $arifure.endingCountGusu,
                            minusCheck: $arifure.minusCheck
                        )
                        // 高設定示唆 弱
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[2]),
                            keyword: self.imageNameList[2],
                            currentKeyword: self.$selectedImageName,
                            count: $arifure.endingCountHighJaku,
                            minusCheck: $arifure.minusCheck
                        )
                        // 高設定示唆 強
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[3]),
                            keyword: self.imageNameList[3],
                            currentKeyword: self.$selectedImageName,
                            count: $arifure.endingCountHighKyo,
                            minusCheck: $arifure.minusCheck
                        )
                        // 設定4 以上示唆
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[4]),
                            keyword: self.imageNameList[4],
                            currentKeyword: self.$selectedImageName,
                            count: $arifure.endingCountOver4,
                            minusCheck: $arifure.minusCheck
                        )
                        // 設定5 以上示唆
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[5]),
                            keyword: self.imageNameList[5],
                            currentKeyword: self.$selectedImageName,
                            count: $arifure.endingCountOver5,
                            minusCheck: $arifure.minusCheck
                        )
                        // 設定6 示唆
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[6]),
                            keyword: self.imageNameList[6],
                            currentKeyword: self.$selectedImageName,
                            count: $arifure.endingCountOver6,
                            minusCheck: $arifure.minusCheck
                        )
                    }
                }
                .frame(height: 120)
                
                // //// カウント結果
                // 奇数示唆
                unitResultCountListPercent(
                    title: "奇数示唆",
                    count: $arifure.endingCountKisu,
                    flashColor: .blue,
                    bigNumber: $arifure.endingCountSum
                )
                // 偶数示唆
                unitResultCountListPercent(
                    title: "偶数示唆",
                    count: $arifure.endingCountGusu,
                    flashColor: .yellow,
                    bigNumber: $arifure.endingCountSum
                )
                // 高設定示唆 弱
                unitResultCountListPercent(
                    title: "高設定示唆 弱",
                    count: $arifure.endingCountHighJaku,
                    flashColor: .green,
                    bigNumber: $arifure.endingCountSum
                )
                // 高設定示唆 強
                unitResultCountListPercent(
                    title: "高設定示唆 強",
                    count: $arifure.endingCountHighKyo,
                    flashColor: .red,
                    bigNumber: $arifure.endingCountSum
                )
                // 設定4 以上濃厚
                unitResultCountListPercent(
                    title: "設定4 以上濃厚",
                    count: $arifure.endingCountOver4,
                    flashColor: .purple,
                    bigNumber: $arifure.endingCountSum
                )
                // 設定5 以上濃厚
                unitResultCountListPercent(
                    title: "設定5 以上濃厚",
                    count: $arifure.endingCountOver5,
                    flashColor: .brown,
                    bigNumber: $arifure.endingCountSum
                )
                // 設定6 濃厚
                unitResultCountListPercent(
                    title: "設定6 濃厚",
                    count: $arifure.endingCountOver6,
                    flashColor: .brown,
                    bigNumber: $arifure.endingCountSum
                )
                // //// 参考情報）画面振り分け
                unitLinkButton(
                    title: "画面振り分け",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "画面振り分け",
                            textBody1: "・強レア役時は確定画面の振り分けが若干増える。確率詳細は解析サイトを参照下さい",
                            tableView: AnyView(arifureSubViewTableEnding())
                        )
                    )
                )
                .popoverTip(tipVer250ArifureEndingRatio())
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(arifureView95Ci(selection: 15)))
                    .popoverTip(tipUnitButtonLink95Ci())
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        .onAppear {
            if ver250.arifureMenuEndingBadgeStatus != "none" {
                ver250.arifureMenuEndingBadgeStatus = "none"
            }
        }
        // //// 画面の向き情報の取得部分
        .onAppear {
            // ビューが表示されるときにデバイスの向きを取得
            self.orientation = UIDevice.current.orientation
            // 向きがフラットでなければlastOrientationの値を更新
            if self.orientation.isFlat {
                
            }
            else {
                self.lastOrientation = self.orientation
            }
            if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
                self.scrollViewHeight = self.scrollViewHeightLandscape
                self.spaceHeight = self.spaceHeightLandscape
            } else {
                self.scrollViewHeight = self.scrollViewHeightPortrait
                self.spaceHeight = self.spaceHeightPortrait
            }
            // デバイスの向きの変更を監視する
            NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: .main) { _ in
                self.orientation = UIDevice.current.orientation
                // 向きがフラットでなければlastOrientationの値を更新
                if self.orientation.isFlat {
                    
                }
                else {
                    self.lastOrientation = self.orientation
                }
                if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
                    self.scrollViewHeight = self.scrollViewHeightLandscape
                    self.spaceHeight = self.spaceHeightLandscape
                } else {
                    self.scrollViewHeight = self.scrollViewHeightPortrait
                    self.spaceHeight = self.spaceHeightPortrait
                }
            }
        }
        .onDisappear {
            // ビューが非表示になるときに監視を解除
            NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
        }
        .navigationTitle("エンディング")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// 画面選択解除
                    unitButtonToolbarScreenSelectReset(currentKeyword: self.$selectedImageName)
                        .popoverTip(tipUnitButtonScreenChoiceClear())
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $arifure.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: arifure.resetEnding)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    arifureViewEnding()
}
