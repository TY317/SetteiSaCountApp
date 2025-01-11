//
//  kaguyaViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/10/14.
//

import SwiftUI

struct kaguyaViewScreen: View {
    @ObservedObject var kaguya = KaguyaSama()
    @State var isShowAlert: Bool = false
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let spaceHeightPortrait = 250.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 250.0
    
    var body: some View {
        List {
            Section {
                // //// 画面選択ボタン
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        // デフォルト
                        unitButtonScreenChoice(image: Image(kaguya.screenKeywordList[0]), keyword: kaguya.screenKeywordList[0], currentKeyword: $kaguya.screenCurrentKeyword, count: $kaguya.screenCountDefault, minusCheck: $kaguya.minusCheck)
                            .popoverTip(tipUnitButtonScreenChoice())
                        // 赤枠猫耳
                        unitButtonScreenChoice(image: Image(kaguya.screenKeywordList[1]), keyword: kaguya.screenKeywordList[1], currentKeyword: $kaguya.screenCurrentKeyword, count: $kaguya.screenCountRedNekomimi, minusCheck: $kaguya.minusCheck)
                        // 紫枠男2人
                        unitButtonScreenChoice(image: Image(kaguya.screenKeywordList[2]), keyword: kaguya.screenKeywordList[2], currentKeyword: $kaguya.screenCurrentKeyword, count: $kaguya.screenCountPurple2Men, minusCheck: $kaguya.minusCheck)
                        // 劇画調
                        unitButtonScreenChoice(image: Image(kaguya.screenKeywordList[3]), keyword: kaguya.screenKeywordList[3], currentKeyword: $kaguya.screenCurrentKeyword, count: $kaguya.screenCountGekiga, minusCheck: $kaguya.minusCheck)
                        // かぐや＆藤原
                        unitButtonScreenChoice(image: Image(kaguya.screenKeywordList[4]), keyword: kaguya.screenKeywordList[4], currentKeyword: $kaguya.screenCurrentKeyword, count: $kaguya.screenCountKaguyaFujiwara, minusCheck: $kaguya.minusCheck)
                        // 白銀＆かぐや
                        unitButtonScreenChoice(image: Image(kaguya.screenKeywordList[5]), keyword: kaguya.screenKeywordList[5], currentKeyword: $kaguya.screenCurrentKeyword, count: $kaguya.screenCountShiroganeKaguya, minusCheck: $kaguya.minusCheck)
                        // 銀枠大人
                        unitButtonScreenChoice(image: Image(kaguya.screenKeywordList[6]), keyword: kaguya.screenKeywordList[6], currentKeyword: $kaguya.screenCurrentKeyword, count: $kaguya.screenCountSilverAdult, minusCheck: $kaguya.minusCheck)
                        // 銀枠デフォルメ
                        unitButtonScreenChoice(image: Image(kaguya.screenKeywordList[7]), keyword: kaguya.screenKeywordList[7], currentKeyword: $kaguya.screenCurrentKeyword, count: $kaguya.screenCountSilverDeformed, minusCheck: $kaguya.minusCheck)
                        // 金枠ウェディング
                        unitButtonScreenChoice(image: Image(kaguya.screenKeywordList[8]), keyword: kaguya.screenKeywordList[8], currentKeyword: $kaguya.screenCurrentKeyword, count: $kaguya.screenCountGoldWedding, minusCheck: $kaguya.minusCheck)
                    }
                    .frame(height: 120)
                }
                // //// 結果表示
                // デフォルト
                unitResultCountListPercent(title: "デフォルト", count: $kaguya.screenCountDefault, flashColor: .gray, bigNumber: $kaguya.screenCountSum)
                // 高設定示唆
                unitResultCountListPercent(title: "設定2以上示唆", count: $kaguya.screenCountRedNekomimi, flashColor: .red, bigNumber: $kaguya.screenCountSum)
                // 設定2以上濃厚
                unitResultCountListPercent(title: "設定2 以上濃厚", count: $kaguya.screenCountPurple2Men, flashColor: .purple, bigNumber: $kaguya.screenCountSum)
                // 引き戻し期待度60%
                unitResultCountListPercent(title: "引戻し期待度60%", count: $kaguya.screenCountGekiga, flashColor: .blue, bigNumber: $kaguya.screenCountSum)
                // 1G連・引戻し濃厚
                unitResultCountListPercent(title: "1G連or引戻し濃厚", count: $kaguya.screenCountKaguyaFujiwara, flashColor: .yellow, bigNumber: $kaguya.screenCountSum)
                // 1G連・引戻し(否定で4)
                unitResultCountListPercent(title: "1G連or引戻し\n(否定で4)", count: $kaguya.screenCountShiroganeKaguya, flashColor: .green, bigNumber: $kaguya.screenCountSum)
                // 設定4以上
                unitResultCountListPercent(title: "設定4 以上濃厚", count: $kaguya.screenCountSilverAdult, flashColor: .brown, bigNumber: $kaguya.screenCountSum)
                // 設定4以上＆引戻し70%
                unitResultCountListPercent(title: "設定4＆引戻し70%", count: $kaguya.screenCountSilverDeformed, flashColor: .pink, bigNumber: $kaguya.screenCountSum)
                // 設定6
                unitResultCountListPercent(title: "設定6 濃厚", count: $kaguya.screenCountGoldWedding, flashColor: .orange, bigNumber: $kaguya.screenCountSum)
                // //// 参考情報リンク
                unitLinkButton(title: "ボーナス終了画面について", exview: AnyView(unitExView5body2image(title: "ボーナス終了画面", image1: Image("kaguyaScreenRatio"))))
                // //// 参考情報リンク　アイキャッチ
                unitLinkButton(title: "ボーナス終了直後のアイキャッチ", exview: AnyView(unitExView5body2image(title: "ボーナス終了直後アイキャッチ", textBody1: "・ボーナス終了直後のアイキャッチでは引戻し期待度を示唆", textBody2: "・通常時のステージチェンジなどで出るアイキャッチとは示唆が異なるので注意", image1: Image("kaguyaScreenEyecatch"))))
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(Ci95view: AnyView(kaguyaView95Ci(selection: 2)))
                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("ボーナス終了画面")
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
                self.spaceHeight = self.spaceHeight
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
        .onDisappear {
            // ビューが非表示になるときに監視を解除
            NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
        }
        .navigationTitle("ボーナス終了画面")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    if kaguya.screenCurrentKeyword != "" {
                        unitButtonToolbarScreenSelectReset(currentKeyword: $kaguya.screenCurrentKeyword)
                            .popoverTip(tipUnitButtonScreenChoiceClear())
                    } else {
                        unitButtonToolbarScreenSelectReset(currentKeyword: $kaguya.screenCurrentKeyword)
                    }
                    unitButtonMinusCheck(minusCheck: $kaguya.minusCheck)
                    unitButtonReset(isShowAlert: $isShowAlert, action: kaguya.resetScreen)
                }
            }
        }
    }
}

#Preview {
    kaguyaViewScreen()
}
