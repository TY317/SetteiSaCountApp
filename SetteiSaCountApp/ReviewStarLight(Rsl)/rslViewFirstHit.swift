//
//  rslViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/29.
//

import SwiftUI

struct rslViewFirstHit: View {
//    @ObservedObject var rsl = Rsl()
    @ObservedObject var rsl: Rsl
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
            // //// 注意書き
            Section {
                Text("・ゲーム数、初当り回数はメニュー画面で確認できます")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
            }
            
            // //// 初当り確率
            Section {
                // 総ゲーム数
                unitTextFieldNumberInputWithUnit(
                    title: "総ゲーム数",
                    inputValue: $rsl.totalGame,
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
                // 通常ゲーム数
                unitTextFieldNumberInputWithUnit(
                    title: "通常ゲーム数",
                    inputValue: $rsl.normalGame,
                    unitText: "Ｇ"
                )
                .focused($isFocused)
                // ビッグ回数
                unitTextFieldNumberInputWithUnit(
                    title: "BIG BONUS",
                    inputValue: $rsl.bigCount
                )
                .focused($isFocused)
                // REG回数
                unitTextFieldNumberInputWithUnit(
                    title: "REG BONUS",
                    inputValue: $rsl.regCount
                )
                .focused($isFocused)
                // CZ回数
                unitTextFieldNumberInputWithUnit(
                    title: "Challenge Revue",
                    inputValue: $rsl.czCount
                )
                .focused($isFocused)
                // AT回数
                unitTextFieldNumberInputWithUnit(
                    title: "STAR LIGHT",
                    inputValue: $rsl.atCount
                )
                .focused($isFocused)
                // //// 確率結果
                HStack(spacing: 3) {
                    // BIG
                    unitResultRatioDenomination2Line(
                        title: "BIG",
                        count: $rsl.bigCount,
                        bigNumber: $rsl.totalGame,
                        numberofDicimal: 0,
                        spacerBool: false,
                        fontResult: .title2,
                        fontBunshi: .caption
                    )
                    // REG
                    unitResultRatioDenomination2Line(
                        title: "REG",
                        count: $rsl.regCount,
                        bigNumber: $rsl.totalGame,
                        numberofDicimal: 0,
                        spacerBool: false,
                        fontResult: .title2,
                        fontBunshi: .caption
                    )
                    // CZ
                    unitResultRatioDenomination2Line(
                        title: "CZ",
                        count: $rsl.czCount,
                        bigNumber: $rsl.normalGame,
                        numberofDicimal: 0,
                        spacerBool: false,
                        fontResult: .title2,
                        fontBunshi: .caption
                    )
                    // AT
                    unitResultRatioDenomination2Line(
                        title: "AT",
                        count: $rsl.atCount,
                        bigNumber: $rsl.normalGame,
                        numberofDicimal: 0,
                        spacerBool: false,
                        fontResult: .title2,
                        fontBunshi: .caption
                    )
                }
                // //// 参考情報）初当り確率
                unitLinkButton(
                    title: "初当り確率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "初当り確率",
                            textBody1: "・本機はリアルボーナスのため、ボーナス確率は総ゲーム数から算出しています",
                            textBody2: "・BIGは青7に若干の設定差あり",
                            tableView: AnyView(rslTableFirstHit(rsl: rsl))
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(rslView95Ci(rsl: rsl, selection: 1)))
                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("初当り確率")
            }
            
            // //// REG当選契機別カウント
            Section {
                HStack {
                    // キラめき目
                    unitCountButtonVerticalDenominate(
                        title: "キラめき目",
                        count: $rsl.regCountKirameki,
                        color: .personalSummerLightBlue,
                        bigNumber: $rsl.totalGame,
                        numberofDicimal: 0,
                        minusBool: $rsl.minusCheck
                    )
                    // スイカ
                    unitCountButtonVerticalDenominate(
                        title: "スイカ",
                        count: $rsl.regCountSuika,
                        color: .personalSummerLightGreen,
                        bigNumber: $rsl.totalGame,
                        numberofDicimal: 0,
                        minusBool: $rsl.minusCheck
                    )
                    // チャンス目
                    unitCountButtonVerticalDenominate(
                        title: "チャンス目",
                        count: $rsl.regCountChance,
                        color: .personalSummerLightRed,
                        bigNumber: $rsl.totalGame,
                        numberofDicimal: 0,
                        minusBool: $rsl.minusCheck
                    )
                }
                // 合算確率
                unitResultRatioDenomination2Line(
                    title: "合算",
                    count: $rsl.regCount3YakuSum,
                    bigNumber: $rsl.totalGame,
                    numberofDicimal: 0
                )
                // //// 参考情報）設定差の大きいREG当選契機について
                unitLinkButton(
                    title: "設定差の大きいREG当選契機について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "設定差の大きいREG当選契機",
                            tableView: AnyView(rslTableReg3Yaku(rsl: rsl))
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(rslView95Ci(rsl: rsl, selection: 5)))
                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("REG当選契機別カウント")
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
            // //// ボーナス確率
//            Section {
//                // 総ゲーム数打ち始め
//                unitTextFieldNumberInputWithUnit(
//                    title: "総ゲーム数(打始め)",
//                    inputValue: $rsl.totalGameStart,
//                    unitText: "Ｇ"
//                )
//                // 総ゲーム数現在
//                unitTextFieldNumberInputWithUnit(
//                    title: "総ゲーム数(現在)",
//                    inputValue: $rsl.totalGameCurrent,
//                    unitText: "Ｇ"
//                )
//                // 総ゲーム数(消化)
//                HStack {
//                    Text("総ゲーム数(プレイ)")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                    HStack {
//                        Spacer()
//                        Text("\(rsl.totalGamePlay)")
//                            .foregroundStyle(Color.secondary)
////                            .frame(maxWidth: .infinity, alignment: .center)
//                        Spacer()
//                        Text("Ｇ")
//                            .font(.footnote)
//                            .foregroundStyle(Color.secondary)
//                    }
//                }
//                .frame(maxWidth: .infinity)
                // //// カウントボタン横並び
                
//            } header: {
//                Text("ボーナス確率")
//            }
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
        .navigationTitle("CZ,ボーナス,AT 初当り")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $rsl.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: rsl.resetFirstHit)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    rslViewFirstHit(rsl: Rsl())
}
