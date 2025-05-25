//
//  kaijiViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/23.
//

import SwiftUI

struct kaijiViewFirstHit: View {
//    @ObservedObject var ver280 = Ver280()
//    @ObservedObject var kaiji = Kaiji()
    @ObservedObject var kaiji: Kaiji
    @State var isShowAlert = false
    @FocusState var isFocused: Bool
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 150.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 150.0
    
    var body: some View {
        List {
            Section {
                // 通常ゲーム数入力
                unitTextFieldNumberInputWithUnit(
                    title: "通常ゲーム数",
                    inputValue: $kaiji.playNormalGame,
                    unitText: "Ｇ"
                )
                .focused($isFocused)
                .toolbar {
                    ToolbarItem(placement: .keyboard) {
                        HStack {
                            Spacer()
                            Button(action: {
                                isFocused = false
                            }, label: {
                                Text("完了")
                                    .fontWeight(.bold)
                            })
                        }
                    }
                }
                // //// カウントボタン横並び
                HStack {
                    // CZ初当り
                    unitCountButtonVerticalWithoutRatio(
                        title: "CZ初当り",
                        count: $kaiji.czCount,
                        color: .personalSummerLightGreen,
                        minusBool: $kaiji.minusCheck
                    )
                    // ボーナス初当り
                    unitCountButtonVerticalWithoutRatio(
                        title: "ボーナス初当り",
                        count: $kaiji.atCount,
                        color: .personalSummerLightRed,
                        minusBool: $kaiji.minusCheck
                    )
                }
                // //// 確率横並び
                HStack {
                    // CZ初当り
                    unitResultRatioDenomination2Line(
                        title: "CZ初当り",
                        count: $kaiji.czCount,
                        bigNumber: $kaiji.playNormalGame,
                        numberofDicimal: 0
                    )
                    // ボーナス初当り
                    unitResultRatioDenomination2Line(
                        title: "ボーナス初当り",
                        count: $kaiji.atCount,
                        bigNumber: $kaiji.playNormalGame,
                        numberofDicimal: 0
                    )
                }
                // //// 参考情報）初当り
                unitLinkButton(
                    title: "初当り確率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "初当り確率",
                            tableView: AnyView(kaijiTableFirstHit(kaiji: kaiji))
                        )
                    )
                )
//                .popoverTip(tipVer280KaijiCzRatio())
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(kaijiView95Ci(kaiji: kaiji, selection: 2)))
                    .popoverTip(tipUnitButtonLink95Ci())
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "回胴黙示録カイジ 狂宴",
                screenClass: screenClass
            )
        }
//        .onAppear {
//            if ver280.kaijiMenuFirstHitBadgeStatus != "none" {
//                ver280.kaijiMenuFirstHitBadgeStatus = "none"
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
        .navigationTitle("CZ,ボーナス 初当り")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $kaiji.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: kaiji.resetFirstHit)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    kaijiViewFirstHit(kaiji: Kaiji())
}
