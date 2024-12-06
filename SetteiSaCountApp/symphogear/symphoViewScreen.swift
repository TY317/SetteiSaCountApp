//
//  symphoViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/09/17.
//

import SwiftUI

struct symphoViewScreen: View {
    @ObservedObject var sympho = Symphogear()
    @State var isShowAlert = false
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    
    var body: some View {
        //        NavigationView {
        List {
            Section {
                // //// 画面選択ボタン
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        // 枠なし
                        unitButtonScreenChoice(image: Image("symphoScreenNone"), keyword: sympho.screenKeywordList[0], currentKeyword: $sympho.screenCurrentKeyword, count: $sympho.screenCountNone, minusCheck: $sympho.minusCheck)
                        // 白枠A
                        unitButtonScreenChoice(image: Image("symphoScreenWhiteA"), keyword: sympho.screenKeywordList[1], currentKeyword: $sympho.screenCurrentKeyword, count: $sympho.screenCountWhiteA, minusCheck: $sympho.minusCheck)
                        // 白枠B
                        unitButtonScreenChoice(image: Image("symphoScreenWhiteB"), keyword: sympho.screenKeywordList[2], currentKeyword: $sympho.screenCurrentKeyword, count: $sympho.screenCountWhiteB, minusCheck: $sympho.minusCheck)
                        // 赤枠A
                        unitButtonScreenChoice(image: Image("symphoScreenRedA"), keyword: sympho.screenKeywordList[3], currentKeyword: $sympho.screenCurrentKeyword, count: $sympho.screenCountRedA, minusCheck: $sympho.minusCheck)
                        // 赤枠B
                        unitButtonScreenChoice(image: Image("symphoScreenRedB"), keyword: sympho.screenKeywordList[4], currentKeyword: $sympho.screenCurrentKeyword, count: $sympho.screenCountRedB, minusCheck: $sympho.minusCheck)
                        // 紫枠A
                        unitButtonScreenChoice(image: Image("symphoScreenPurpleA"), keyword: sympho.screenKeywordList[5], currentKeyword: $sympho.screenCurrentKeyword, count: $sympho.screenCountPurpleAB, minusCheck: $sympho.minusCheck)
                        // 紫枠B
                        unitButtonScreenChoice(image: Image("symphoScreenPurpleB"), keyword: sympho.screenKeywordList[6], currentKeyword: $sympho.screenCurrentKeyword, count: $sympho.screenCountPurpleAB, minusCheck: $sympho.minusCheck)
                        // 紫枠C
                        unitButtonScreenChoice(image: Image("symphoScreenPurpleC"), keyword: sympho.screenKeywordList[7], currentKeyword: $sympho.screenCurrentKeyword, count: $sympho.screenCountPurpleC, minusCheck: $sympho.minusCheck)
                        // 紫枠D
                        unitButtonScreenChoice(image: Image("symphoScreenPurpleD"), keyword: sympho.screenKeywordList[8], currentKeyword: $sympho.screenCurrentKeyword, count: $sympho.screenCountPurpleD, minusCheck: $sympho.minusCheck)
                        // 紫枠E
                        unitButtonScreenChoice(image: Image("symphoScreenPurpleE"), keyword: sympho.screenKeywordList[9], currentKeyword: $sympho.screenCurrentKeyword, count: $sympho.screenCountPurpleE, minusCheck: $sympho.minusCheck)
                        // 銀枠
                        unitButtonScreenChoice(image: Image("symphoScreenSilver"), keyword: sympho.screenKeywordList[10], currentKeyword: $sympho.screenCurrentKeyword, count: $sympho.screenCountSilver, minusCheck: $sympho.minusCheck)
                        // 金枠
                        unitButtonScreenChoice(image: Image("symphoScreenGold"), keyword: sympho.screenKeywordList[11], currentKeyword: $sympho.screenCurrentKeyword, count: $sympho.screenCountGold, minusCheck: $sympho.minusCheck)
                    }
                }
                .frame(height: 120)
                
                // //// カウント結果
                // 枠なし
                unitResultCountListPercent(title: "デフォルト", count: $sympho.screenCountNone, flashColor: .gray, bigNumber: $sympho.screenCountSum)
                // 白枠A
                unitResultCountListPercent(title: "奇数示唆", count: $sympho.screenCountWhiteA, flashColor: .blue, bigNumber: $sympho.screenCountSum)
                // 白枠B
                unitResultCountListPercent(title: "偶数示唆", count: $sympho.screenCountWhiteB, flashColor: .yellow, bigNumber: $sympho.screenCountSum)
                // 赤枠A
                unitResultCountListPercent(title: "高設定示唆 弱", count: $sympho.screenCountRedA, flashColor: .green, bigNumber: $sympho.screenCountSum)
                // 赤枠B
                unitResultCountListPercent(title: "高設定示唆 強", count: $sympho.screenCountRedB, flashColor: .red, bigNumber: $sympho.screenCountSum)
                // 紫枠AB
                unitResultCountListPercent(title: "設定1 否定", count: $sympho.screenCountPurpleAB, flashColor: .purple, bigNumber: $sympho.screenCountSum)
                // 紫枠C
                unitResultCountListPercent(title: "設定2 否定", count: $sympho.screenCountPurpleC, flashColor: .cyan, bigNumber: $sympho.screenCountSum)
                // 紫枠D
                unitResultCountListPercent(title: "設定4 否定", count: $sympho.screenCountPurpleD, flashColor: .mint, bigNumber: $sympho.screenCountSum)
                // 紫枠E
                unitResultCountListPercent(title: "偶数濃厚", count: $sympho.screenCountPurpleE, flashColor: .orange, bigNumber: $sympho.screenCountSum)
                // 銀枠
                unitResultCountListPercent(title: "設定4 以上濃厚", count: $sympho.screenCountSilver, flashColor: .pink, bigNumber: $sympho.screenCountSum)
                // 金枠
                unitResultCountListPercent(title: "設定6", count: $sympho.screenCountGold, flashColor: .brown, bigNumber: $sympho.screenCountSum)
                // //// 参考情報リンク
                unitLinkButton(title: "AT終了画面について", exview: AnyView(unitExView5body2image(title: "AT終了画面", image1: Image("symphoScreenRatio"))))
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(Ci95view: AnyView(symphoView95Ci(selection: 3)))
                    .popoverTip(tipUnitButtonLink95Ci())
            }
            
            if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
                
            }
            else {
                unitClearScrollSection(spaceHeight: 220)
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
            // デバイスの向きの変更を監視する
            NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: .main) { _ in
                self.orientation = UIDevice.current.orientation
                // 向きがフラットでなければlastOrientationの値を更新
                if self.orientation.isFlat {
                    
                }
                else {
                    self.lastOrientation = self.orientation
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
                    if sympho.screenCurrentKeyword != "" {
                        unitButtonToolbarScreenSelectReset(currentKeyword: $sympho.screenCurrentKeyword)
                            .popoverTip(tipUnitButtonScreenChoiceClear())
                    } else {
                        unitButtonToolbarScreenSelectReset(currentKeyword: $sympho.screenCurrentKeyword)
                    }
                    unitButtonMinusCheck(minusCheck: $sympho.minusCheck)
                    unitButtonReset(isShowAlert: $isShowAlert, action: sympho.resetScreen)
                }
            }
        }
        //        }
    }
}

#Preview {
    symphoViewScreen()
}
