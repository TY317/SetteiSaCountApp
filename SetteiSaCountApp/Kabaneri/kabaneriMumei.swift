//
//  kabaneriMumei.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/31.
//

import SwiftUI

struct kabaneriMumei: View {
//    @ObservedObject var kabaneri = Kabaneri()
    @ObservedObject var kabaneri: Kabaneri
    @State var isShowAlert = false
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    
    var body: some View {
//        NavigationView {
            List {
                // //// 連撃中のナビ発生率
                Section {
                    HStack {
                        // ナビなし
                        unitCountButtonVerticalWithoutRatio(title: "ベルこぼし目", count: $kabaneri.mumeiNaviNoneCount, color: .personalSummerLightBlue, minusBool: $kabaneri.minusCheck)
                        // ナビあり
                        unitCountButtonVerticalWithoutRatio(title: "ナビあり", count: $kabaneri.mumeiNaviCount, color: .personalSpringLightYellow, minusBool: $kabaneri.minusCheck, flushColor: Color.yellow)
                        // 結果表示
                        unitResultRatioPercent2Line(title: "ナビ発生率", color: .grayBack, count: $kabaneri.mumeiNaviCount, bigNumber: $kabaneri.mumeiNaviCountSum, numberofDicimal: 0)
                            .padding(.vertical)
                    }
                    // 参考情報
                    unitLinkButton(title: "ナビ発生率について", exview: AnyView(unitExView5body2image(title: "ナビ発生率について", textBody1: "・連撃演出中のナビ発生率に設定差", textBody2: "・ナビなしはベルこぼし目の回数をカウント", textBody3: "　（ベルこぼし目は下記画像を参照）", image1: Image("kabaneriMumeiNavi"), image2: Image("kabaneriMumeiBellKoboshi"))))
                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(Ci95view: AnyView(kabaneriView95Ci(kabaneri: kabaneri, selection: 4)))
//                        .popoverTip(tipUnitButtonLink95Ci())
                } header: {
                    Text("連撃中のナビ発生率")
                }
                // //// ３連撃時の当選率
                Section {
                    HStack {
                        // 非当選
                        unitCountButtonVerticalWithoutRatio(title: "非当選", count: $kabaneri.mumei3renLoseCount, color: .personalSummerLightGreen, minusBool: $kabaneri.minusCheck)
                        // 当選
                        unitCountButtonVerticalWithoutRatio(title: "当選", count: $kabaneri.mumei3renWinCount, color: .personalSummerLightPurple, minusBool: $kabaneri.minusCheck)
                        // 当選率
                        unitResultRatioPercent2Line(title: "当選率", color: .grayBack, count: $kabaneri.mumei3renWinCount, bigNumber: $kabaneri.mumei3renCountSum, numberofDicimal: 0)
                            .padding(.vertical)
                    }
                    // 参考情報リンク
                    unitLinkButton(title: "3連撃時の当選について", exview: AnyView(unitExView5body2image(title: "3連撃時の当選率", textBody1: "・3連撃でジャッジ演出に移行した際の当選率", image1: Image("kabaneriMumei3Hit"))))
                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(Ci95view: AnyView(kabaneriView95Ci(kabaneri: kabaneri, selection: 5)))
//                        .popoverTip(tipUnitButtonLink95Ci())
                } header: {
                    Text("3連撃時の当選率")
                }
                
                // //// 画面下の余白
                if orientation.isPortrait || (orientation.isFlat && lastOrientation.isPortrait) {
                    unitClearScrollSection(spaceHeight: 250)
                } else {
                    
                }
            }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "甲鉄城のカバネリ",
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
            .navigationTitle("無名CZ")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    HStack {
                        unitButtonMinusCheck(minusCheck: $kabaneri.minusCheck)
                        unitButtonReset(isShowAlert: $isShowAlert, action: kabaneri.resetMumei)
                            .popoverTip(tipUnitButtonReset())
                    }
                }
            }
//        }
//        .navigationTitle("無名CZ")
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItem(placement: .automatic) {
//                HStack {
//                    unitButtonMinusCheck(minusCheck: $kabaneri.minusCheck)
//                    unitButtonReset(isShowAlert: $isShowAlert, action: kabaneri.resetMumei)
//                        .popoverTip(tipUnitButtonReset())
//                }
//            }
//        }
    }
}

#Preview {
    kabaneriMumei(kabaneri: Kabaneri())
}
