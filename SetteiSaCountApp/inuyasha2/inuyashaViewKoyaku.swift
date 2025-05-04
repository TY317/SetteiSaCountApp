//
//  inuyashaViewKoyaku.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/12/29.
//

import SwiftUI

struct inuyashaViewKoyaku: View {
//    @ObservedObject var inuyasha = Inuyasha()
    @ObservedObject var inuyasha: Inuyasha
    @FocusState var isFocused: Bool
    @State var isShowAlert = false
    @Environment(\.dismiss) private var dismiss
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
            // //// 小役カウント
            Section {
                // //// 横画面
                if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
                    HStack {
                        // 弱🍒
                        unitCountButtonVerticalDenominate(
                            title: "弱🍒",
                            count: $inuyasha.koyakuCountJakuCherry,
                            color: .personalSummerLightRed,
                            bigNumber: $inuyasha.koyakuCountPlayGame,
                            numberofDicimal: 1,
                            minusBool: $inuyasha.minusCheck
                        )
                        // 強🍒
                        unitCountButtonVerticalDenominate(
                            title: "強🍒",
                            count: $inuyasha.koyakuCountKyoCherry,
                            color: .red,
                            bigNumber: $inuyasha.koyakuCountPlayGame,
                            numberofDicimal: 0,
                            minusBool: $inuyasha.minusCheck,
                            minusColor: .black
                        )
                        // スイカ
                        unitCountButtonVerticalDenominate(
                            title: "スイカ",
                            count: $inuyasha.koyakuCountSuika,
                            color: .personalSummerLightGreen,
                            bigNumber: $inuyasha.koyakuCountPlayGame,
                            numberofDicimal: 0,
                            minusBool: $inuyasha.minusCheck
                        )
                        // チャンス目A
                        unitCountButtonVerticalDenominate(
                            title: "チャンス目A",
                            count: $inuyasha.koyakuCountChanceA,
                            color: .personalSummerLightBlue,
                            bigNumber: $inuyasha.koyakuCountPlayGame,
                            numberofDicimal: 0,
                            minusBool: $inuyasha.minusCheck
                        )
                        // チャンス目B
                        unitCountButtonVerticalDenominate(
                            title: "チャンス目B",
                            count: $inuyasha.koyakuCountChanceB,
                            color: .personalSummerLightPurple,
                            bigNumber: $inuyasha.koyakuCountPlayGame,
                            numberofDicimal: 0,
                            minusBool: $inuyasha.minusCheck
                        )
                        // 合算確率
                        unitResultRatioDenomination2Line(
                            title: "小役合算",
                            count: $inuyasha.koyakuCountSum,
                            bigNumber: $inuyasha.koyakuCountPlayGame,
                            numberofDicimal: 1,
                            spacerBool: false
                        )
                        .padding(.vertical)
                    }
                }
                // //// 縦画面
                else {
                    HStack {
                        // 弱🍒
                        unitCountButtonVerticalDenominate(
                            title: "弱🍒",
                            count: $inuyasha.koyakuCountJakuCherry,
                            color: .personalSummerLightRed,
                            bigNumber: $inuyasha.koyakuCountPlayGame,
                            numberofDicimal: 1,
                            minusBool: $inuyasha.minusCheck
                        )
                        // 強🍒
                        unitCountButtonVerticalDenominate(
                            title: "強🍒",
                            count: $inuyasha.koyakuCountKyoCherry,
                            color: .red,
                            bigNumber: $inuyasha.koyakuCountPlayGame,
                            numberofDicimal: 0,
                            minusBool: $inuyasha.minusCheck,
                            minusColor: .black
                        )
                        // スイカ
                        unitCountButtonVerticalDenominate(
                            title: "スイカ",
                            count: $inuyasha.koyakuCountSuika,
                            color: .personalSummerLightGreen,
                            bigNumber: $inuyasha.koyakuCountPlayGame,
                            numberofDicimal: 0,
                            minusBool: $inuyasha.minusCheck
                        )
                    }
                    HStack {
                        // チャンス目A
                        unitCountButtonVerticalDenominate(
                            title: "チャンス目A",
                            count: $inuyasha.koyakuCountChanceA,
                            color: .personalSummerLightBlue,
                            bigNumber: $inuyasha.koyakuCountPlayGame,
                            numberofDicimal: 0,
                            minusBool: $inuyasha.minusCheck
                        )
                        // チャンス目B
                        unitCountButtonVerticalDenominate(
                            title: "チャンス目B",
                            count: $inuyasha.koyakuCountChanceB,
                            color: .personalSummerLightPurple,
                            bigNumber: $inuyasha.koyakuCountPlayGame,
                            numberofDicimal: 0,
                            minusBool: $inuyasha.minusCheck
                        )
                        // 合算確率
                        unitResultRatioDenomination2Line(
                            title: "小役合算",
                            count: $inuyasha.koyakuCountSum,
                            bigNumber: $inuyasha.koyakuCountPlayGame,
                            numberofDicimal: 1,
                            spacerBool: false
                        )
                        .padding(.vertical)
                    }
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "小役確率、小役停止形",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "小役確率、停止形",
                            image1: Image("inuyashaKoyaku"),
                            image2: Image("inuyashaKoyakuForm")
                        )
                    )
                )
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(Ci95view: AnyView(inuyashaView95Ci(inuyasha: inuyasha, selection: 4)))
                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("小役カウント")
            }
            
            // //// ゲーム数入力
            Section {
                // 打ち始め
                unitTextFieldGamesInput(title: "打ち始め", inputValue: $inuyasha.koyakuCountStartGame)
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
                // 現在
                unitTextFieldGamesInput(title: "現在", inputValue: $inuyasha.koyakuCountCurrentGame)
                    .focused($isFocused)
                // 消化ゲーム数
                HStack {
                    Text("消化ゲーム数")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("\(inuyasha.koyakuCountPlayGame)")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            } header: {
                Text("ゲーム数入力")
            }
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
        .navigationTitle("設定差のある小役")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $inuyasha.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: inuyasha.resetKoyaku)
                }
            }
        }
    }
}

#Preview {
    inuyashaViewKoyaku(inuyasha: Inuyasha())
}
