//
//  magiaViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/06.
//

import SwiftUI

struct magiaViewFirstHit: View {
//    @ObservedObject var ver271 = Ver271()
//    @ObservedObject var magia = Magia()
    @ObservedObject var magia: Magia
    @State var isShowAlert: Bool = false
    @FocusState var isFocused: Bool
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
            Section {
                Text("ユニメモを参考に入力してください")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // 通常プレイ数
                unitTextFieldNumberInputWithUnit(
                    title: "通常プレイ数",
                    inputValue: $magia.normalPlayGame,
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
                // ビッグ
                unitTextFieldNumberInputWithUnit(
                    title: "ビッグボーナス",
                    inputValue: $magia.bonusCountBig
                )
                .focused($isFocused)
                // ミタマ
                unitTextFieldNumberInputWithUnit(
                    title: "みたまボーナス",
                    inputValue: $magia.bonusCountMitama
                )
                .focused($isFocused)
                // エピソード
                unitTextFieldNumberInputWithUnit(
                    title: "エピソードボーナス",
                    inputValue: $magia.bonusCountEpisode
                )
                .focused($isFocused)
                // ビッグ
                unitTextFieldNumberInputWithUnit(
                    title: "マギアラッシュ",
                    inputValue: $magia.atCount
                )
                .focused($isFocused)
                
                // //// 確率
                HStack {
                    // ボーナス合算
                    unitResultRatioDenomination2Line(
                        title: "ボーナス合算",
                        count: $magia.bonusCountSum,
                        bigNumber: $magia.normalPlayGame,
                        numberofDicimal: 0
                    )
                    // ボーナス合算
                    unitResultRatioDenomination2Line(
                        title: "AT",
                        count: $magia.atCount,
                        bigNumber: $magia.normalPlayGame,
                        numberofDicimal: 0
                    )
                }
//                .popoverTip(tipVer271MagiaFirstHit())
                
                // //// 参考情報）初当り確率
                unitLinkButton(
                    title: "初当り確率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "初当り確率",
                            tableView: AnyView(magiaTableFirstHit(magia: magia))
                        )
                    )
                )
                // //// 参考情報）直撃の情報
                unitLinkButton(
                    title: "AT直撃について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "AT直撃",
                            textBody1: "・今作もAT直撃は高設定ほど優遇されている"
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(magiaView95Ci(magia: magia, selection: 2)))
                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("初当り")
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
//            // //// 参考情報）初当り確率
//            unitLinkButton(
//                title: "初当り確率",
//                exview: AnyView(
//                    unitExView5body2image(
//                        title: "初当り確率",
//                        tableView: AnyView(magiaTableFirstHit())
//                    )
//                )
//            )
//            // //// 参考情報）直撃の情報
//            unitLinkButton(
//                title: "AT直撃について",
//                exview: AnyView(
//                    unitExView5body2image(
//                        title: "AT直撃",
//                        textBody1: "・今作もAT直撃は高設定ほど優遇されている"
//                    )
//                )
//            )
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "マギアレコード",
                screenClass: screenClass
            )
        }
//        .onAppear {
//            if ver271.magiaMenuFirstHitBadgeStatus != "none" {
//                ver271.magiaMenuFirstHitBadgeStatus = "none"
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
        .navigationTitle("ボーナス,AT 初当り")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
//                    unitButtonMinusCheck(minusCheck: $magia.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: magia.resetFirstHit)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    magiaViewFirstHit(magia: Magia())
}
