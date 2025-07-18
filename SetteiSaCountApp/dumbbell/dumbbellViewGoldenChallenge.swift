//
//  dumbbellViewGoldenChallenge.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/02.
//

import SwiftUI
import TipKit

// //////////////////
// Tip：履歴入力の説明
// //////////////////
struct dumbbellTipGoldenChallengeBonusTimes: Tip {
    var title: Text {
        Text("ボーナス回数")
    }
    
    var message: Text? {
        Text("履歴ページのボーナス回数を参照します")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}


struct dumbbellViewGoldenChallenge: View {
//    @ObservedObject var dumbbell = Dumbbell()
    @ObservedObject var dumbbell: Dumbbell
    @State var isShowAlert = false
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    @FocusState var isFocused: Bool
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 250.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 250.0
    
    var body: some View {
        List {
            Section {
                // ボーナス回数
                Text("ボーナス回数 : \(dumbbell.bonusCountSum)")
                    .foregroundStyle(Color.secondary)
                    .popoverTip(dumbbellTipGoldenChallengeBonusTimes())
                // //// ボタン横並び
                HStack {
                    // 失敗
                    unitCountButtonVerticalWithoutRatio(
                        title: "失敗",
                        count: $dumbbell.goldenChallengeCountFailed,
                        color: .personalSummerLightBlue,
                        minusBool: $dumbbell.minusCheck
                    )
                    // 成功
                    unitCountButtonVerticalWithoutRatio(
                        title: "成功",
                        count: $dumbbell.goldenChallengeCountSuccess,
                        color: .personalSummerLightRed,
                        minusBool: $dumbbell.minusCheck
                    )
                }
                // //// 結果
                HStack {
                    // 当選率
                    unitResultRatioPercent2Line(
                        title: "当選率",
                        count: $dumbbell.goldenChallengeCountSum,
                        bigNumber: $dumbbell.bonusCountSum,
                        numberofDicimal: 0
                    )
                    // 成功率
                    unitResultRatioPercent2Line(
                        title: "成功率",
                        count: $dumbbell.goldenChallengeCountSuccess,
                        bigNumber: $dumbbell.goldenChallengeCountSum,
                        numberofDicimal: 0
                    )
                }
                // //// 参考情報
                unitLinkButton(
                    title: "当選率、成功率について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "ゴールデンチャレンジ",
                            textBody1: "・高設定ほどチャレンジ当選、成功率が優遇",
                            tableView: AnyView(dumbbellTableGoldenChallenge())
//                            textBody2: "・成功率は公表値で約56%。これは低設定または全設定平均値と思われる。高設定はこれより優遇？",
//                            image1: Image("dumbellGoldenChallengeRatio")
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(dumbbellView95Ci(dumbbell: dumbbell, selection: 3)))
//                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("ゴールデンチャレンジ")
            }
            unitClearScrollSectionBinding(spaceHeight: $spaceHeight)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ダンベル何キロ持てる？",
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
        .navigationTitle("ゴールデンチャレンジ")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $dumbbell.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: dumbbell.resetGoldenChallenge)
//                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    dumbbellViewGoldenChallenge(dumbbell: Dumbbell())
}
