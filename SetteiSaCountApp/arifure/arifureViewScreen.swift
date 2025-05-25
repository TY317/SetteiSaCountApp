//
//  arifureViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/05.
//

import SwiftUI

struct arifureViewScreen: View {
//    @ObservedObject var ver250 = Ver250()
//    @ObservedObject var arifure = Arifure()
    @ObservedObject var arifure: Arifure
    @State var isShowAlert: Bool = false
    let imageNameList: [String] = [
        "arifureEndScreenDefault",
        "arifureEndScreenHigh",
        "arifureEndScreenOver4",
        "arifureEndScreenOver5",
        "arifureEndScreenOver6"
    ]
    @State var selectedImageName: String = ""
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
                        // デフォルト
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[0]),
                            keyword: self.imageNameList[0],
                            currentKeyword: self.$selectedImageName,
                            count: $arifure.endScreenCountDefault,
                            minusCheck: $arifure.minusCheck
                        )
                        .popoverTip(tipUnitButtonScreenChoice())
                        // 高設定示唆
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[1]),
                            keyword: self.imageNameList[1],
                            currentKeyword: self.$selectedImageName,
                            count: $arifure.endScreenCountHigh,
                            minusCheck: $arifure.minusCheck
                        )
                        // 設定4 以上濃厚
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[2]),
                            keyword: self.imageNameList[2],
                            currentKeyword: self.$selectedImageName,
                            count: $arifure.endScreenCountOver4,
                            minusCheck: $arifure.minusCheck
                        )
                        // 設定5 以上濃厚
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[3]),
                            keyword: self.imageNameList[3],
                            currentKeyword: self.$selectedImageName,
                            count: $arifure.endScreenCountOver5,
                            minusCheck: $arifure.minusCheck
                        )
                        // 設定6 濃厚
                        unitButtonScreenChoice(
                            image: Image(self.imageNameList[4]),
                            keyword: self.imageNameList[4],
                            currentKeyword: self.$selectedImageName,
                            count: $arifure.endScreenCountOver6,
                            minusCheck: $arifure.minusCheck
                        )
                    }
                }
                .frame(height: 120)
                
                // //// カウント結果
                // デフォルト
                unitResultCountListPercent(
                    title: "デフォルト",
                    count: $arifure.endScreenCountDefault,
                    flashColor: .gray,
                    bigNumber: $arifure.endScreenCountSum
                )
                // 高設定示唆
                unitResultCountListPercent(
                    title: "高設定示唆",
                    count: $arifure.endScreenCountHigh,
                    flashColor: .blue,
                    bigNumber: $arifure.endScreenCountSum
                )
                // 設定4 以上濃厚
                unitResultCountListPercent(
                    title: "設定4 以上濃厚",
                    count: $arifure.endScreenCountOver4,
                    flashColor: .green,
                    bigNumber: $arifure.endScreenCountSum
                )
                // 設定5 以上濃厚
                unitResultCountListPercent(
                    title: "設定5 以上濃厚",
                    count: $arifure.endScreenCountOver5,
                    flashColor: .red,
                    bigNumber: $arifure.endScreenCountSum
                )
                // 設定6 濃厚
                unitResultCountListPercent(
                    title: "設定6 濃厚",
                    count: $arifure.endScreenCountOver6,
                    flashColor: .purple,
                    bigNumber: $arifure.endScreenCountSum
                )
                // //// 参考情報）振り分け
                unitLinkButton(
                    title: "AT終了画面の振り分け",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "AT終了画面の振り分け",
                            textBody1: "・トータルG数によって確定画面の出現割合が変化",
                            textBody2: "　2000G以降の数値は解析サイトで確認下さい",
                            tableView: AnyView(arifureSubViewTableAtEndScreen(arifure: arifure))
                        )
                    )
                )
//                .popoverTip(tipVer250ArifureAtScreenRatio())
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(arifureView95Ci(arifure: arifure, selection: 14)))
                    .popoverTip(tipUnitButtonLink95Ci())
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ありふれた職業で世界最強",
                screenClass: screenClass
            )
        }
//        .onAppear {
//            if ver250.arifureMenuAtScreenBadgeStatus != "none" {
//                ver250.arifureMenuAtScreenBadgeStatus = "none"
//            }
//        }
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
        .navigationTitle("AT終了画面")
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
                    unitButtonReset(isShowAlert: $isShowAlert, action: arifure.resetScreen)
//                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    arifureViewScreen(arifure: Arifure())
}
