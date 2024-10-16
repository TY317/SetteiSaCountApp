//
//  kaguyaViewBonus.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/10/12.
//

import SwiftUI
import TipKit


// //////////////////
// Tip：初当たりカウントの説明
// //////////////////
struct kaguyaTipFirstBonus: Tip {
    var title: Text {
        Text("初当たりのB・R比率")
    }
    var message: Text? {
        Text("初当たりボーナスのビッグ・レギュラーの振り分けをカウント\n（ビッグの種類振分けは下部でカウント）")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

// //////////////////
// Tip：初当たりカウントの説明
// //////////////////
struct kaguyaTipBigCount: Tip {
    var title: Text {
        Text("ビッグボーナスの種類振分け")
    }
    var message: Text? {
        Text("ビッグボーナスの種類ごとにカウント。初当たり、1G連、引き戻し全てのビッグが対象")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

struct kaguyaViewBonus: View {
    @ObservedObject var kaguya = KaguyaSama()
    @State var isShowAlert: Bool = false
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    @State var spaceHeight = 250.0
    
    var body: some View {
        List {
            // //// 初当たりのBR比率
            Section {
                // カウントボタン横並び
                HStack {
                    // ビッグ
                    unitCountButtonVerticalPercent(title: "ビッグ", count: $kaguya.firstBonusCountBig, color: .personalSummerLightBlue, bigNumber: $kaguya.firstBonusCountSum, numberofDicimal: 0, minusBool: $kaguya.minusCheck)
                    // レギュラー
                    unitCountButtonVerticalPercent(title: "レギュラー", count: $kaguya.firstBonusCountReg, color: .personalSummerLightRed, bigNumber: $kaguya.firstBonusCountSum, numberofDicimal: 0, minusBool: $kaguya.minusCheck)
                }
                // //// 参考情報
                unitLinkButton(title: "初当たりのB・R比率について", exview: AnyView(unitExView5body2image(title: "初当たりB・R比率", textBody1: "・高設定ほど初当たりのビッグ比率が高いのではと言われている", textBody2: "・高設定ではB:R=55:45程度なのではとの噂も。逆に低設定ではB:R=45:55程度との噂。")))
            } header: {
                Text("初当たりボーナス")
            }
            .popoverTip(kaguyaTipFirstBonus())
            // //// ビッグの種類内訳
            Section {
                // カウントボタン横並び
                HStack {
                    // ノーマルビッグ
                    unitCountButtonVerticalPercent(title: "ノーマル", count: $kaguya.bigCountNormal, color: .personalSummerLightBlue, bigNumber: $kaguya.bigCountSum, numberofDicimal: 0, minusBool: $kaguya.minusCheck)
                    // スーパー
                    unitCountButtonVerticalPercent(title: "スーパー", count: $kaguya.bigCountSuper, color: .personalSummerLightRed, bigNumber: $kaguya.bigCountSum, numberofDicimal: 0, minusBool: $kaguya.minusCheck)
                    // エクストラ
                    unitCountButtonVerticalPercent(title: "エクストラ", count: $kaguya.bigCountExtra, color: .personalSummerLightPurple, bigNumber: $kaguya.bigCountSum, numberofDicimal: 0, minusBool: $kaguya.minusCheck)
                }
                // 参考情報リンク
                unitLinkButton(title: "ビッグの種類内訳について", exview: AnyView(unitExView5body2image(title: "ビッグの種類内訳", textBody1: "・高設定ほどスーパービッグ以上の比率が増えるのではと言われている", textBody2: "・連チャンするほどスーパーの比率が上がる", textBody3: "・下記割合は全設定・全状態での平均値らしいので、高設定はこれより高く、低設定はこれより低くなると思われる", image1: Image("kaguyaBigShurui"))))
            } header: {
                Text("ビッグの種類内訳")
            }
            .popoverTip(kaguyaTipBigCount())
            // //// 空スペース
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
                self.spaceHeight = 0
            } else {
                self.spaceHeight = 250.0
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
                    self.spaceHeight = 0
                } else {
                    self.spaceHeight = 250.0
                }
            }
        }
        .onDisappear {
            // ビューが非表示になるときに監視を解除
            NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
        }
        .navigationTitle("ボーナス種類の振分け")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    unitButtonMinusCheck(minusCheck: $kaguya.minusCheck)
                    unitButtonReset(isShowAlert: $isShowAlert, action: kaguya.resetBonus)
                }
            }
        }
    }
}

#Preview {
    kaguyaViewBonus()
}
