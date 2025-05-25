//
//  godzillaViewCz.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/13.
//

import SwiftUI

struct godzillaViewCz: View {
    @ObservedObject var godzilla: Godzilla
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
    
    var body: some View {
        List {
            Section {
                HStack {
                    // ラドン
                    unitCountButtonVerticalPercent(
                        title: "ラドン",
                        count: $godzilla.czCharaCountRadon,
                        color: .personalSummerLightBlue,
                        bigNumber: $godzilla.czCharaCountSum,
                        numberofDicimal: 0,
                        minusBool: $godzilla.minusCheck
                    )
                    // ラドン
                    unitCountButtonVerticalPercent(
                        title: "ガイガン",
                        count: $godzilla.czCharaCountGaigan,
                        color: .personalSpringLightYellow,
                        bigNumber: $godzilla.czCharaCountSum,
                        numberofDicimal: 0,
                        minusBool: $godzilla.minusCheck
                    )
                    // ビオランテ
                    unitCountButtonVerticalPercent(
                        title: "ﾋﾞｵﾗﾝﾃ",
                        count: $godzilla.czCharaCountBiorante,
                        color: .personalSummerLightGreen,
                        bigNumber: $godzilla.czCharaCountSum,
                        numberofDicimal: 0,
                        minusBool: $godzilla.minusCheck
                    )
                    // デストロイア
                    unitCountButtonVerticalPercent(
                        title: "ﾃﾞｽﾄﾛｲｱ",
                        count: $godzilla.czCharaCountDestoroia,
                        color: .personalSummerLightRed,
                        bigNumber: $godzilla.czCharaCountSum,
                        numberofDicimal: 0,
                        minusBool: $godzilla.minusCheck
                    )
                }
                // //// 参考情報）怪獣振分け
                unitLinkButton(
                    title: "怪獣の振り分けについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "怪獣の振り分け",
                            textBody1: "・高設定ほど勝利期待度の高い怪獣の振り分けが優遇",
                            tableView: AnyView(godzillaTableCzMonster(godzilla: godzilla))
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(godzillaView95Ci(godzilla: godzilla, selection: 1)))
                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("怪獣種類カウント")
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ゴジラ",
                screenClass: screenClass
            )
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
        .navigationTitle("襲来ゾーン")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $godzilla.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: godzilla.resetCz)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    godzillaViewCz(godzilla: Godzilla())
}
