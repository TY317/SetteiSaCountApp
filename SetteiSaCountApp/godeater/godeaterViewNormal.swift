//
//  godeaterViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/03.
//

import SwiftUI

struct godeaterViewNormal: View {
//    @ObservedObject var ver380: Ver380
    @ObservedObject var godeater: Godeater
    @State var isShowAlert = false
    let selectListKoyakuKind: [String] = [
        "チャンス目",
        "弱🍒＆🍉",
    ]
    @State var selectedKoyakuKind: String = "チャンス目"
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 250.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 250.0
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    
    var body: some View {
        List {
            Section {
                // //// 小役停止形
                unitLinkButton(
                    title: "小役停止形",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "小役停止形",
                            tableView: AnyView(godeaterSubViewKoyakuPattern())
                        )
                    )
                )
            }
            
            // CZ当選率カウント
            Section {
                Text("高確中は対象外となるため滞在ステージや演出状態に注意してください")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // //// 小役種類の選択
                Picker("", selection: self.$selectedKoyakuKind) {
                    ForEach(self.selectListKoyakuKind, id: \.self) { koyaku in
                        Text(koyaku)
                    }
                }
                .pickerStyle(.segmented)
                // //// カウントボタン
                // チャンス目
                if self.selectedKoyakuKind == self.selectListKoyakuKind[0] {
                    HStack {
                        // チャンス目カウント
                        unitCountButtonVerticalWithoutRatio(
                            title: "チャンス目",
                            count: $godeater.normalChanceCountSeiritu,
                            color: .personalSummerLightPurple,
                            minusBool: $godeater.minusCheck
                        )
                        // チャンス目カウント
                        unitCountButtonVerticalWithoutRatio(
                            title: "CZ当選",
                            count: $godeater.normalChanceCountCzHit,
                            color: .purple,
                            minusBool: $godeater.minusCheck
                        )
                    }
                }
                
                // 弱チェリー＆スイカ
                else {
                    HStack {
                        // 弱チェリーカウント
                        unitCountButtonVerticalWithoutRatio(
                            title: "弱🍒",
                            count: $godeater.normalCountJakuCherry,
                            color: .personalSummerLightRed,
                            minusBool: $godeater.minusCheck
                        )
                        // スイカ
                        unitCountButtonVerticalWithoutRatio(
                            title: "🍉",
                            count: $godeater.normalCountSuika,
                            color: .personalSummerLightGreen,
                            minusBool: $godeater.minusCheck
                        )
                        // CZ当選
                        unitCountButtonVerticalWithoutRatio(
                            title: "CZ当選",
                            count: $godeater.normalCountCzHit,
                            color: .red,
                            minusBool: $godeater.minusCheck
                        )
                    }
                }
                // //// 確率横並び
                HStack {
                    // チャンス目
                    unitResultRatioPercent2Line(
                        title: "チャンス目",
                        count: $godeater.normalChanceCountCzHit,
                        bigNumber: $godeater.normalChanceCountSeiritu,
                        numberofDicimal: 0
                    )
                    // 弱チェリースイカ
                    unitResultRatioPercent2Line(
                        title: "弱🍒＆🍉",
                        count: $godeater.normalCountCzHit,
                        bigNumber: $godeater.normalCountCherrySuikaSum,
                        numberofDicimal: 1
                    )
                }
                // //// 参考情報）CZ当選率
                unitLinkButton(
                    title: "通常時レア役からのCZ当選について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "通常時レア役からのCZ当選",
                            textBody1: "・高確中レア役でのCZ当選率には設定差無いため、高確示唆ステージ滞在中や熱い演出頻発時はカウント除外を推奨",
                            textBody2: "・弱チェリーとスイカは当選率同じなので、本アプリでは合算の当選率で算出します",
                            tableView: AnyView(godeaterTableCzHit(godeater: godeater))
                        )
                    )
                )
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(Ci95view: AnyView(godeaterView95Ci(godeater: godeater, selection: 3)))
//                    .popoverTip(tipUnitButtonLink95Ci())
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    godeaterViewBayes(
//                        ver380: ver380,
                        godeater: godeater,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("通常時小役からのCZ当選率")
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ゴッドイーター リザレクション",
                screenClass: screenClass
            )
        }
//        .onAppear {
//            if ver300.godeaterMenuNormalBadgeStatus != "none" {
//                ver300.godeaterMenuNormalBadgeStatus = "none"
//            }
//        }
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
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $godeater.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: godeater.resetNormal)
//                        .popoverTip(tipUnitButtonReset())
                    
                }
            }
        }
    }
}

#Preview {
    godeaterViewNormal(
//        ver380: Ver380(),
        godeater: Godeater(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
