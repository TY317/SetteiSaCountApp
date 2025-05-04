//
//  midoriDonViewKoyaku.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/04.
//

import SwiftUI

struct midoriDonViewKoyaku: View {
    @ObservedObject var midoriDon: MidoriDon
    @State var isShowAlert = false
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 250.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 250.0
    @FocusState var isFocused: Bool
    
    var body: some View {
        List {
            // //// 小役停止形
            Section {
                unitLinkButton(
                    title: "小役停止形",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "小役停止形",
                            tableView: AnyView(midoriDonTableKoyakuPattern())
                        )
                    )
                )
            }
            
            // //// 小役確率
            Section {
                // 総ゲーム数
                unitTextFieldNumberInputWithUnit(
                    title: "総ゲーム数",
                    inputValue: $midoriDon.totalGame,
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
                // 弱チェリー
                unitTextFieldNumberInputWithUnit(
                    title: "弱🍒",
                    inputValue: $midoriDon.jakuRareCountCherry
                )
                .focused($isFocused)
                // 弱🍉
                unitTextFieldNumberInputWithUnit(
                    title: "弱🍉",
                    inputValue: $midoriDon.jakuRareCountSuika
                )
                .focused($isFocused)
                
                // //// 確率横並び
                HStack {
                    // 弱チェリー
                    unitResultRatioDenomination2Line(
                        title: "弱🍒",
                        count: $midoriDon.jakuRareCountCherry,
                        bigNumber: $midoriDon.totalGame,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                    // 弱スイカ
                    unitResultRatioDenomination2Line(
                        title: "弱🍉",
                        count: $midoriDon.jakuRareCountSuika,
                        bigNumber: $midoriDon.totalGame,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                    // 合算
                    unitResultRatioDenomination2Line(
                        title: "合算",
                        count: $midoriDon.jakuRareCountSum,
                        bigNumber: $midoriDon.totalGame,
                        numberofDicimal: 1,
                        spacerBool: false
                    )
                }
                
                // //// 参考情報）小役確率
                unitLinkButton(
                    title: "弱レア役の小役確率について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "弱レア役の小役確率",
                            tableView: AnyView(midoriDonTableJakuRareRatio(midoriDon: midoriDon))
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(midoriDonView95Ci(
                    midoriDon: midoriDon,
                    selection: 1
                )))
                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("小役確率")
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
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
        .navigationTitle("小役確率")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $midoriDon.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: midoriDon.resetKoyaku)
                }
            }
        }
    }
}

#Preview {
    midoriDonViewKoyaku(
        midoriDon: MidoriDon()
    )
}
