//
//  shamanKingViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/24.
//

import SwiftUI

struct shamanKingViewNormal: View {
//    @ObservedObject var shamanKing = ShamanKing()
    @ObservedObject var shamanKing: ShamanKing
    @State var isShowAlert = false
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 200.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 200.0
    
    var body: some View {
        List {
            Section {
                HStack {
//                    VStack {
//                        Spacer()
                        // 弱チェ、スイカカウント
                        unitCountButtonVerticalWithoutRatio(
                            title: "弱🍒＆スイカ",
                            count: $shamanKing.jakuRareCount,
                            color: .personalSummerLightGreen,
                            minusBool: $shamanKing.minusCheck,
                            vSpaceBool: true
                        )
//                    }
                    // ボーナス高確移行
                    unitCountButtonVerticalPercent(
                        title: "ボーナス高確移行",
                        count: $shamanKing.bonusKokakuCount,
                        color: .personalSummerLightRed,
                        bigNumber: $shamanKing.jakuRareCount,
                        numberofDicimal: 1,
                        minusBool: $shamanKing.minusCheck
                    )
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "弱レア役からのボーナス高確移行",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "弱レア役からの高確移行",
                            textBody1: "・弱🍒、スイカからのシャーマンボーナス高確移行率に設定差あり",
                            tableView: AnyView(shamanKingTableKokakuMove())
//                            image1: Image("shamanKingJakuRareKokaku")
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(shamanKingView95Ci(shamanKing: shamanKing, selection: 7)))
//                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("弱レア役からのボーナス高確移行")
            }
            
            // //// リプレイカウンタ
            Section {
                HStack {
                    // リプレイカウント
                    unitCountButtonVerticalWithoutRatio(
                        title: "10G以内リプレイ",
                        count: $shamanKing.replayCounterReplayCount,
                        color: .personalSummerLightBlue,
                        minusBool: $shamanKing.minusCheck,
                        vSpaceBool: true
                    )
                    // 小鬼レベル昇格
                    unitCountButtonVerticalPercent(
                        title: "小鬼レベル昇格",
                        count: $shamanKing.replayCounterCountSuccesss,
                        color: .personalSummerLightRed,
                        bigNumber: $shamanKing.replayCounterReplayCount,
                        numberofDicimal: 1,
                        minusBool: $shamanKing.minusCheck
                    )
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "カウント方法について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "カウント方法詳細",
                            textBody1: "・前兆終了後\n　アンナの地獄特訓終了後\n　CZ終了後\n　シャーマンファイト予選敗北後\n　の最初のリプレイ成立を起点とする",
                            textBody2: "・起点から10G以内にリプレイ成立したら10G以内リプレイをカウント",
                            textBody3: "・そのリプレイでリプレイ連続なしで小鬼レベル昇格したらカウント"
                        )
                    )
                )
                unitLinkButton(
                    title: "リプレイカウンタについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "リプレイカウンタ",
                            textBody1: "・前兆終了後など特定のタイミング後の最初のリプレイで抽選",
                            textBody2: "・カウンタの告知はされないため見た目には分からない",
                            textBody3: "・カウンタは1Gで1減算されるため、カウンタ1が選ばれたリプレイ連続以外で小鬼レベル昇格はない",
                            textBody4: "・リプレイ連続ではなく1回だけで昇格すればカウンタ10以上が濃厚となる",
                            tableView: AnyView(shamanKingTableReplayCounter())
//                            image1: Image("shamanKingReplayCounter")
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(shamanKingView95Ci(shamanKing: shamanKing, selection: 8)))
//                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("リプレイカウンタ10以上選択率")
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "シャーマンキング",
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
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $shamanKing.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: shamanKing.resetNormal)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    shamanKingViewNormal(shamanKing: ShamanKing())
}
