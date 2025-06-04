//
//  bangdreamViewPicoAttack.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/11/09.
//

import SwiftUI

struct bangdreamViewPicoAttack: View {
//    @ObservedObject var bangdream = Bangdream()
    @ObservedObject var bangdream: Bangdream
    @State var isShowAlert: Bool = false
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
            // //// 駆け抜けST後のピコアタック
            Section {
                Text("レア役当選時はカウントしないこと")
                    .foregroundStyle(.secondary)
                HStack {
                    // 非当選カウントボタン
                    unitCountButtonVerticalWithoutRatio(title: "ハズレ", count: $bangdream.picoAttackCountSingleLose, color: .personalSummerLightBlue, minusBool: $bangdream.minusCheck)
                    // 当選カウントボタン
                    unitCountButtonVerticalWithoutRatio(title: "当選", count: $bangdream.picoAttackCountSingleWin, color: .personalSummerLightRed, minusBool: $bangdream.minusCheck)
                    // 当選確率
                    unitResultRatioPercent2Line(title: "当選確率", color: .grayBack, count: $bangdream.picoAttackCountSingleWin, bigNumber: $bangdream.picoAttackCountSingleSum, numberofDicimal: 0)
                        .padding(.vertical)
                }
            } header: {
                Text("駆け抜けST後のピコアタック")
            }
            
            // //// ボーナス当選ST後
            Section {
                Text("レア役当選時はカウントしないこと")
                    .foregroundStyle(.secondary)
                HStack {
                    // 非当選カウントボタン
                    unitCountButtonVerticalWithoutRatio(
                        title: "ハズレ",
                        count: $bangdream.picoAttackCountMultiLose,
                        color: .personalSummerLightGreen,
                        minusBool: $bangdream.minusCheck
                    )
                    // 当選カウントボタン
                    unitCountButtonVerticalWithoutRatio(
                        title: "当選",
                        count: $bangdream.picoAttackCountMultiWin,
                        color: .personalSummerLightPurple,
                        minusBool: $bangdream.minusCheck
                    )
                    // 当選確率
                    unitResultRatioPercent2Line(
                        title: "当選確率",
                        color: .grayBack,
                        count: $bangdream.picoAttackCountMultiWin,
                        bigNumber: $bangdream.picoAttackCountMultiSum,
                        numberofDicimal: 0
                    )
                    .padding(.vertical)
                }
            } header: {
                Text("非駆け抜けST後のピコアタック")
            }
            
            // //// トータル結果
            Section {
                HStack {
                    // ハズレトータル回数
                    unitResultCount2Line(
                        title: "ハズレ合計",
                        color: .grayBack,
                        count: $bangdream.picoAttackCountLoseSum,
                        spacerBool: false
                    )
                    // 当選トータル回数
                    unitResultCount2Line(
                        title: "当選合計",
                        color: .grayBack,
                        count: $bangdream.picoAttackCountWinSum,
                        spacerBool: false
                    )
                    // トータル確率
                    unitResultRatioPercent2Line(
                        title: "トータル確率",
                        color: .grayBack,
                        count: $bangdream.picoAttackCountWinSum,
                        bigNumber: $bangdream.picoAttackCountAllSum,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "ピコアタック当選率について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "ピコアタック当選率",
                            textBody1: "・ピコアタックの当選率に設定差あり",
                            textBody2: "・レア役当選時は設定関係なく当選（バンドリンク役のみ25%）するためカウントから除外",
                            textBody3: "・駆け抜け後は当選率が上がるらしい",
                            textBody4: "・下表の確率が非駆け抜け時のものなのか？それとも駆け抜け後も含めたものなのか？は現状不明なため分けてカウントすることを推奨\n（All設定バトルでは非駆け抜け時の当選が重要なのでは といったニュアンスの発言あり）",
//                            image1: Image("bangdreamPicoAttack")
                            tableView: AnyView(bangdreamTablePicoAttack())
                        )
                    )
                )
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(Ci95view: AnyView(bangdreamView95Ci(bangdream: bangdream, selection: 2)))
//                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("トータル結果")
            }
            unitClearScrollSectionBinding(spaceHeight: $spaceHeight)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "バンドリ!",
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
        .navigationTitle("ピコアタック")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $bangdream.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: bangdream.resetPicoAttack)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    bangdreamViewPicoAttack(bangdream: Bangdream())
}
