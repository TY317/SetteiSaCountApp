//
//  karakuriViewEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/10/06.
//

import SwiftUI

struct karakuriViewEnding: View {
    @ObservedObject var karakuri = Karakuri()
    @State var isShowAlert: Bool = false
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let spaceHeightPortrait = 250.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 250.0
    
    var body: some View {
        List {
            Section {
                // //// 横画面
                if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
                    HStack {
                        // 白
                        unitCountButtonVerticalPercent(title: "白", count: $karakuri.endingCountWhite, color: .gray, bigNumber: $karakuri.endingCountSum, numberofDicimal: 0, minusBool: $karakuri.minusCheck)
                        // 青
                        unitCountButtonVerticalPercent(title: "青", count: $karakuri.endingCountBlue, color: .personalSummerLightBlue, bigNumber: $karakuri.endingCountSum, numberofDicimal: 0, minusBool: $karakuri.minusCheck)
                        // 黄色
                        unitCountButtonVerticalPercent(title: "黄", count: $karakuri.endingCountYellow, color: .personalSpringLightYellow, bigNumber: $karakuri.endingCountSum, numberofDicimal: 0, minusBool: $karakuri.minusCheck)
                        // 緑
                        unitCountButtonVerticalPercent(title: "緑", count: $karakuri.endingCountGreen, color: .personalSummerLightGreen, bigNumber: $karakuri.endingCountSum, numberofDicimal: 0, minusBool: $karakuri.minusCheck)
                        // 赤
                        unitCountButtonVerticalPercent(title: "赤", count: $karakuri.endingCountRed, color: .personalSummerLightRed, bigNumber: $karakuri.endingCountSum, numberofDicimal: 0, minusBool: $karakuri.minusCheck)
                        // 紫
                        unitCountButtonVerticalPercent(title: "紫", count: $karakuri.endingCountPurple, color: .personalSummerLightPurple, bigNumber: $karakuri.endingCountSum, numberofDicimal: 0, minusBool: $karakuri.minusCheck)
                        // 虹
                        unitCountButtonVerticalPercent(title: "虹", count: $karakuri.endingCountRainbow, color: .orange, bigNumber: $karakuri.endingCountSum, numberofDicimal: 0, minusBool: $karakuri.minusCheck)
                    }
                }
                // //// 縦画面
                else {
                    HStack {
                        // 白
                        unitCountButtonVerticalPercent(title: "白", count: $karakuri.endingCountWhite, color: .gray, bigNumber: $karakuri.endingCountSum, numberofDicimal: 0, minusBool: $karakuri.minusCheck)
                        // 青
                        unitCountButtonVerticalPercent(title: "青", count: $karakuri.endingCountBlue, color: .personalSummerLightBlue, bigNumber: $karakuri.endingCountSum, numberofDicimal: 0, minusBool: $karakuri.minusCheck)
                        // 黄色
                        unitCountButtonVerticalPercent(title: "黄", count: $karakuri.endingCountYellow, color: .personalSpringLightYellow, bigNumber: $karakuri.endingCountSum, numberofDicimal: 0, minusBool: $karakuri.minusCheck)
                        // 緑
                        unitCountButtonVerticalPercent(title: "緑", count: $karakuri.endingCountGreen, color: .personalSummerLightGreen, bigNumber: $karakuri.endingCountSum, numberofDicimal: 0, minusBool: $karakuri.minusCheck)
                    }
                    HStack {
                        // 赤
                        unitCountButtonVerticalPercent(title: "赤", count: $karakuri.endingCountRed, color: .personalSummerLightRed, bigNumber: $karakuri.endingCountSum, numberofDicimal: 0, minusBool: $karakuri.minusCheck)
                        // 紫
                        unitCountButtonVerticalPercent(title: "紫", count: $karakuri.endingCountPurple, color: .personalSummerLightPurple, bigNumber: $karakuri.endingCountSum, numberofDicimal: 0, minusBool: $karakuri.minusCheck)
                        // 虹
                        unitCountButtonVerticalPercent(title: "虹", count: $karakuri.endingCountRainbow, color: .orange, bigNumber: $karakuri.endingCountSum, numberofDicimal: 0, minusBool: $karakuri.minusCheck)
                    }
                }
                // //// 参考情報リンク
                unitLinkButton(title: "エンディング中の示唆について", exview: AnyView(unitExView5body2image(title: "エンディング中 レア役時のランプ色", textBody1: "・エンディング中のレア役成立時に上部ランプの色で設定を示唆", textBody2: "※ 弱レア役と強レア役で振分けに差があるが、微差のため分けてカウントする機能は設けていません", image1Title: "[弱レア役成立時]", image1: Image("karakuriEndingJaku"), image2Title: "[強レア役成立時]", image2: Image("karakuriEndingKyou"))))
            } header: {
                Text("レア役時のランプ色")
            }
            unitClearScrollSectionBinding(spaceHeight: $spaceHeight)
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
                self.spaceHeight = self.spaceHeightLandscape
            } else {
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
                    self.spaceHeight = self.spaceHeightLandscape
                } else {
                    self.spaceHeight = self.spaceHeightPortrait
                }
            }
        }
        .navigationBarTitle("エンディング中の示唆")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    unitButtonMinusCheck(minusCheck: $karakuri.minusCheck)
                    unitButtonReset(isShowAlert: $isShowAlert, action: karakuri.resetEnding)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    karakuriViewEnding()
}
