//
//  kaijiViewKoyaku.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/12.
//

import SwiftUI

struct kaijiViewKoyaku: View {
//    @ObservedObject var ver271 = Ver271()
//    @ObservedObject var kaiji = Kaiji()
    @ObservedObject var kaiji: Kaiji
    @State var isShowAlert = false
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
                Text("マイスロを参考に入力してください")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // ゲーム数
                unitTextFieldNumberInputWithUnit(
                    title: "ゲーム数",
                    inputValue: $kaiji.totalGame,
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
                // スイカ
                unitTextFieldNumberInputWithUnit(
                    title: "スイカ",
                    inputValue: $kaiji.koyakuCountSuika
                )
                .focused($isFocused)
                // チェリー
                unitTextFieldNumberInputWithUnit(
                    title: "チェリー",
                    inputValue: $kaiji.koyakuCountJakuCherry
                )
                .focused($isFocused)
                // チャンス目
                unitTextFieldNumberInputWithUnit(
                    title: "チャンス目",
                    inputValue: $kaiji.koyakuCountJakuChance
                )
                .focused($isFocused)
                // 強チェリー
                unitTextFieldNumberInputWithUnit(
                    title: "強チェリー",
                    inputValue: $kaiji.koyakuCountKyoCherry
                )
                .focused($isFocused)
                // 合算確率
                unitResultRatioDenomination2Line(
                    title: "合算",
                    count: $kaiji.koyakuCountSum,
                    bigNumber: $kaiji.totalGame,
                    numberofDicimal: 1
                )
//                .popoverTip(tipVer271KaijiKoyaku())
                // //// 参考情報）小役確率
                unitLinkButton(
                    title: "小役確率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "小役確率",
                            tableView: AnyView(kaijiTableKoyaku(kaiji: kaiji))
                        )
                    )
                )
                // //// 参考情報）小役停止形
                unitLinkButton(
                    title: "小役停止形",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "小役停止形",
                            image1: Image("kaijiKoyakuStyle")
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(kaijiView95Ci(kaiji: kaiji, selection: 4)))
//                    .popoverTip(tipUnitButtonLink95Ci())
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
//            if ver271.kaijiMenuKoyakuBadgeStatus != "none" {
//                ver271.kaijiMenuKoyakuBadgeStatus = "none"
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
        .navigationTitle("小役")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
//                    // マイナスチェック
//                    unitButtonMinusCheck(minusCheck: $kaiji.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: kaiji.resetKoyaku)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    kaijiViewKoyaku(kaiji: Kaiji())
}
