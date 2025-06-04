//
//  godzillaViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/13.
//

import SwiftUI

struct godzillaViewFirstHit: View {
    @ObservedObject var godzilla: Godzilla
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
                // 通常ゲーム数入力
                unitTextFieldNumberInputWithUnit(
                    title: "通常ゲーム数",
                    inputValue: $godzilla.normalGame,
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
                // 襲来CZ
                unitTextFieldNumberInputWithUnit(
                    title: "襲来CZ",
                    inputValue: $godzilla.czCountShurai
                )
                .focused($isFocused)
                // BreakDown
                unitTextFieldNumberInputWithUnit(
                    title: "BREAKDOWN",
                    inputValue: $godzilla.czCountBreakDown
                )
                .focused($isFocused)
                // G-RUSH
                unitTextFieldNumberInputWithUnit(
                    title: "G-RUSH",
                    inputValue: $godzilla.atCount
                )
                .focused($isFocused)
                // 確率
                HStack {
                    // CZ
                    unitResultRatioDenomination2Line(
                        title: "CZ",
                        count: $godzilla.czCountSum,
                        bigNumber: $godzilla.normalGame,
                        numberofDicimal: 0
                    )
                    // AT
                    unitResultRatioDenomination2Line(
                        title: "AT",
                        count: $godzilla.atCount,
                        bigNumber: $godzilla.normalGame,
                        numberofDicimal: 0
                    )
                }
                // 参考情報）初当り確率
                unitLinkButton(
                    title: "初当り確率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "初当り確率",
                            tableView: AnyView(godzillaTableFirstHit(godzilla: godzilla))
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(godzillaView95Ci(godzilla: godzilla, selection: 6)))
//                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("初当り")
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ゴジラ",
                screenClass: screenClass
            )
        }
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
        .navigationTitle("CZ,AT 初当り")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $godzilla.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: godzilla.resetFirstHit)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    godzillaViewFirstHit(godzilla: Godzilla())
}
