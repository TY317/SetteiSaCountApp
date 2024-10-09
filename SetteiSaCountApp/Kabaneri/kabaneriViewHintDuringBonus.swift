//
//  kabaneriViewHintDuringBonus.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/31.
//

import SwiftUI

struct kabaneriViewHintDuringBonus: View {
    @ObservedObject var kabaneri = Kabaneri()
    @State var isShowAlert = false
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    
    var body: some View {
//        NavigationView {
            List {
                // //// キャラによる示唆
                Section {
                    // 縦画面
                    if orientation.isPortrait || (orientation.isFlat && lastOrientation.isPortrait) {
                        HStack {
                            // 男性カウント
                            unitCountButtonVerticalWithoutRatio(title: "男性キャラ", count: $kabaneri.sexMaleCount, color: .personalSummerLightBlue, minusBool: $kabaneri.minusCheck)
                            // 女性カウント
                            unitCountButtonVerticalWithoutRatio(title: "女性キャラ", count: $kabaneri.sexFemaleCount, color: .personalSummerLightRed, minusBool: $kabaneri.minusCheck)
                        }
                        // //// 結果の表示
                        HStack {
                            // 奇数割合
                            unitResultRatioPercent2Line(title: "奇数示唆", color: .grayBack, count: $kabaneri.sexMaleCount, bigNumber: $kabaneri.sexCountSum, numberofDicimal: 0)
                            // 偶数割合
                            unitResultRatioPercent2Line(title: "偶数示唆", color: .grayBack, count: $kabaneri.sexFemaleCount, bigNumber: $kabaneri.sexCountSum, numberofDicimal: 0)
                        }
                    }
                    // 横画面
//                    else if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
                    else {
                        // カウント＆結果
                        HStack {
                            // 男性カウント
                            unitCountButtonVerticalWithoutRatio(title: "男性キャラ", count: $kabaneri.sexMaleCount, color: .personalSummerLightBlue, minusBool: $kabaneri.minusCheck)
                            // 女性カウント
                            unitCountButtonVerticalWithoutRatio(title: "女性キャラ", count: $kabaneri.sexFemaleCount, color: .personalSummerLightRed, minusBool: $kabaneri.minusCheck)
                            // 奇数割合
                            unitResultRatioPercent2Line(title: "奇数示唆", color: .grayBack, count: $kabaneri.sexMaleCount, bigNumber: $kabaneri.sexCountSum, numberofDicimal: 0)
                                .padding(.vertical)
                            // 偶数割合
                            unitResultRatioPercent2Line(title: "偶数示唆", color: .grayBack, count: $kabaneri.sexFemaleCount, bigNumber: $kabaneri.sexCountSum, numberofDicimal: 0)
                                .padding(.vertical)
                        }
                    }
                    // 参考情報へのリンク
                    unitLinkButton(title: "キャラ紹介での示唆について", exview: AnyView(unitExView5body2image(title: "キャラ紹介での示唆", textBody1: "・ボーナス中のキャラ紹介のキャラによって設定を示唆", textBody2: "・男性キャラが奇数示唆、女性キャラが偶数示唆", image1: Image("kabaneriCharacterIntroduce"))))
                } header: {
                    Text("キャラ紹介による示唆")
                }
                // ストーリー話数による示唆
                Section {
                    unitLinkButton(title: "エピソード話数での示唆について", exview: AnyView(unitExView5body2image(title: "エピソード話数での示唆", textBody1: "・1〜12話は後半の話数ほど高設定で出やすくなっている", textBody2: "・第7話が出れば設定4以上が濃厚")))
                } header: {
                    Text("エピソード話数での示唆")
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
            .navigationTitle("カバネリボーナス中の示唆")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    HStack {
                        unitButtonMinusCheck(minusCheck: $kabaneri.minusCheck)
                        unitButtonReset(isShowAlert: $isShowAlert, action: kabaneri.resetHintDuringBonus)
                            .popoverTip(tipUnitButtonReset())
                    }
                }
            }
//        }
//        .navigationTitle("カバネリボーナス中の示唆")
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItem(placement: .automatic) {
//                HStack {
//                    unitButtonMinusCheck(minusCheck: $kabaneri.minusCheck)
//                    unitButtonReset(isShowAlert: $isShowAlert, action: kabaneri.resetHintDuringBonus)
//                        .popoverTip(tipUnitButtonReset())
//                }
//            }
//        }
    }
}

#Preview {
    kabaneriViewHintDuringBonus()
}
