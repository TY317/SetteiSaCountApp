//
//  mt5ViewAoshimaSG.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/24.
//

import SwiftUI
import TipKit

struct mt5ViewAoshimaSG: View {
    @ObservedObject var mt5 = Mt5()
    @State var isShowAlert = false
    @State var tips = tipUnitButtonScreenChoice()
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    
    var body: some View {
//        NavigationView {
            List {
                // //// 青島SPフリーズ
                Section {
                    unitLinkButton(title: "青島SPフリーズについて", exview: AnyView(mt5ExViewAoshimaSpFreeze()))
                } header: {
                    Text("青島SPフリーズ")
                }
                
                // //// ラウンド開始画面
                Section {
                    // 画面選択ボタン
                    ScrollView(.horizontal) {
                        HStack(spacing: 20) {
                            // 私服
                            unitButtonScreenChoice(image: Image("mt5AoshimaSGShifuku"), keyword: mt5.AoshimaSGShifukuKeyword, currentKeyword: $mt5.AoshimaSGCurrentKeyword, count: $mt5.AoshimaSGShifukuCount, minusCheck: $mt5.minusCheck)
                                .popoverTip(tips)
                            // レース服
                            unitButtonScreenChoice(image: Image("mt5AoshimaSGRace"), keyword: mt5.AoshimaSGRaceKeyword, currentKeyword: $mt5.AoshimaSGCurrentKeyword, count: $mt5.AoshimaSGRaceCount, minusCheck: $mt5.minusCheck)
                            // ドレス
                            unitButtonScreenChoice(image: Image("mt5AoshimaSGDress"), keyword: mt5.AoshimaSGDressKeyword, currentKeyword: $mt5.AoshimaSGCurrentKeyword, count: $mt5.AoshimaSGDressCount, minusCheck: $mt5.minusCheck)
                            // 波多野
                            unitButtonScreenChoice(image: Image("mt5AoshimaSGHatano"), keyword: mt5.AoshimaSGHatanoKeyword, currentKeyword: $mt5.AoshimaSGCurrentKeyword, count: $mt5.AoshimaSGHatanoCount, minusCheck: $mt5.minusCheck)
                            
                        }
                    }
                    .frame(height: 120)
                    // カウント結果表示
                    // 私服
                    unitResultCountListPercent(title: "デフォルト", count: $mt5.AoshimaSGShifukuCount, flashColor: .blue, bigNumber: $mt5.AoshimaSGCountSum)
                    // レース服
                    unitResultCountListPercent(title: "偶数設定示唆", count: $mt5.AoshimaSGRaceCount, flashColor: .yellow, bigNumber: $mt5.AoshimaSGCountSum)
                    // ドレス
                    unitResultCountListPercent(title: "高設定示唆", count: $mt5.AoshimaSGDressCount, flashColor: .green, bigNumber: $mt5.AoshimaSGCountSum)
                    // 波多野
                    unitResultCountListPercent(title: "設定5以上", count: $mt5.AoshimaSGHatanoCount, flashColor: .red, bigNumber: $mt5.AoshimaSGCountSum)
                    // 参考情報
                    unitLinkButton(title: "出現確率", exview: AnyView(mt5ExViewAoshimaScreenAnalysis()))
                } header: {
                    Text("ラウンド開始画面")
                }
                if orientation.isPortrait || (orientation.isFlat && lastOrientation.isPortrait) {
                    unitClearScrollSection(spaceHeight: 240)
                } else {
                    
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
            .navigationTitle("青島SG")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    HStack {
                        unitButtonToolbarScreenSelectReset(currentKeyword: $mt5.AoshimaSGCurrentKeyword)
                            .popoverTip(tipUnitButtonScreenChoiceClear())
                        unitButtonMinusCheck(minusCheck: $mt5.minusCheck)
                        unitButtonReset(isShowAlert: $isShowAlert, action: mt5.resetAoshima, message: "このページのデータをリセットします")
                    }
                }
            }
//        }
//        .navigationTitle("青島SG")
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItem(placement: .automatic) {
//                HStack {
//                    unitButtonToolbarScreenSelectReset(currentKeyword: $mt5.AoshimaSGCurrentKeyword)
//                        .popoverTip(tipUnitButtonScreenChoiceClear())
//                    unitButtonMinusCheck(minusCheck: $mt5.minusCheck)
//                    unitButtonReset(isShowAlert: $isShowAlert, action: mt5.resetAoshima, message: "このページのデータをリセットします")
//                }
//            }
//        }
    }
}


// //////////////////////////////////
// ビュー：参考情報：青島SPフリーズについて
// //////////////////////////////////
struct mt5ExViewAoshimaSpFreeze: View {
    var body: some View {
        unitExView5body2image(title: "青島SPフリーズについて", textBody1: "・SPフリーズの発生に設定差があるのは間違いないらしい", textBody2: "・1回でも確認できれば高設定期待度アップか", textBody3: "・1ラウンド目からの発生は無さそう。2ラウンド目から期待")
    }
}


// ///////////////////////////////
// ビュー：参考情報：ラウンド開始画面の確率
// ///////////////////////////////
struct mt5ExViewAoshimaScreenAnalysis: View {
    var body: some View {
        unitExView5body2image(title: "出現確率", image1: Image("mt5AoshimaSGScreenAnalysis"))
    }
}

#Preview {
    mt5ViewAoshimaSG()
}
