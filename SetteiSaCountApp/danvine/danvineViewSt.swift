//
//  danvineViewSt.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/12/31.
//

import SwiftUI

struct danvineViewSt: View {
//    @ObservedObject var danvine = Danvine()
    @ObservedObject var danvine: Danvine
    @State var isShowAlert = false
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
            // //// ST中ボーナス 狙え演出時のランプ色
            Section {
                // //// カウントボタン
                HStack {
                    // 白・青
                    unitCountButtonVerticalPercent(
                        title: "白・青",
                        count: $danvine.chamLampCountWhitBlue,
                        color: .personalSummerLightBlue,
                        bigNumber: $danvine.chamLampCountSum,
                        numberofDicimal: 0,
                        minusBool: $danvine.minusCheck
                    )
                    // 黄
                    unitCountButtonVerticalPercent(
                        title: "黄",
                        count: $danvine.chamLampCountYellow,
                        color: .personalSpringLightYellow,
                        bigNumber: $danvine.chamLampCountSum,
                        numberofDicimal: 1,
                        minusBool: $danvine.minusCheck,
                        flushColor: .yellow
                    )
                    // 緑
                    unitCountButtonVerticalPercent(
                        title: "緑",
                        count: $danvine.chamLampCountGreen,
                        color: .personalSummerLightGreen,
                        bigNumber: $danvine.chamLampCountSum,
                        numberofDicimal: 1,
                        minusBool: $danvine.minusCheck
                    )
                    // 赤
                    unitCountButtonVerticalPercent(
                        title: "赤",
                        count: $danvine.chamLampCountRed,
                        color: .personalSummerLightRed,
                        bigNumber: $danvine.chamLampCountSum,
                        numberofDicimal: 1,
                        minusBool: $danvine.minusCheck
                    )
                }
                // //// 参考情報
                unitLinkButton(
                    title: "狙え演出時のランプ色について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "狙え演出時のランプ色",
                            textBody1: "・ST中ボーナスで発生する中リール狙え演出時のチャムランプ色で設定を示唆",
                            textBody2: "・チャムランプは台枠左にあり。数回点滅したら消えるため見逃さないよう注意",
                            image1: Image("danvineChamLamp"),
                            image2: Image("danvineChamLampRatio")
                        )
                    )
                )
                unitNaviLink95Ci(Ci95view: AnyView(danvineView95Ci(danvine: danvine, selection: 5)))
                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("ST中ボーナス 狙え演出時のランプ色")
            }
            
            // //// オーラアタック
            Section {
                // カウントボタン、結果表示
                HStack {
                    // アタックなし
                    unitCountButtonVerticalWithoutRatio(
                        title: "アタックなし",
                        count: $danvine.auraAttackCountNone,
                        color: .personalSummerLightBlue,
                        minusBool: $danvine.minusCheck
                    )
                    // アタックあり
                    unitCountButtonVerticalWithoutRatio(
                        title: "アタックあり",
                        count: $danvine.auraAttackCountWin,
                        color: .personalSummerLightRed,
                        minusBool: $danvine.minusCheck
                    )
                    // アタック確率
                    unitResultRatioDenomination2Line(
                        title: "アタック率",
                        count: $danvine.auraAttackCountWin,
                        bigNumber: $danvine.auraAttackCountSum,
                        numberofDicimal: 1,
                        spacerBool: false
                    )
                    .padding(.vertical)
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "オーラアタックについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "オーラアタック",
                            textBody1: "・上位ST中のオーラアタックに設定差があると言われている",
                            textBody2: "・高設定は1/4以上との噂あり"
                        )
                    )
                )
            } header: {
                Text("上位ST中のオーラアタック")
            }
            
            // //// 聖戦士への道
            Section {
                unitLinkButton(
                    title: "聖戦士への道 初期ゲーム数について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "聖戦士への道",
                            textBody1: "・継続ゲーム数は10・20・30Gのいずれか",
                            textBody2: "・20、30Gの場合も基本はLAST 10Gから始まり、消化後に継続する形で進行",
                            textBody3: "・初期表示の段階でLAST 20、30Gから始まった場合は設定示唆となる",
                            image1: Image("danvineSeisenshi")
                        )
                    )
                )
            } header: {
                Text("聖戦士への道 初期ゲーム数")
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
        .navigationTitle("ST中")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $danvine.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: danvine.resetSt)
                }
            }
        }
    }
}

#Preview {
    danvineViewSt(danvine: Danvine())
}
