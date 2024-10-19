//
//  imJugExViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/10/16.
//

import SwiftUI
import TipKit

// ////////////////////////////
// 変数
// ////////////////////////////
class imJugEx: ObservableObject {
    @AppStorage("imJugExBellCount") var bellCount: Int = 0
    @AppStorage("imJugExBigCount") var bigCount: Int = 0 {
        didSet {
            bonusCountSum = countSum(bigCount, regCountAlone, regCountCherry)
        }
    }
    @AppStorage("imJugExRegCountAlone") var regCountAlone = 0 {
        didSet {
            regCountSum = countSum(regCountAlone, regCountCherry)
            bonusCountSum = countSum(bigCount, regCountAlone, regCountCherry)
        }
    }
        @AppStorage("imJugExRegCountCherry") var regCountCherry = 0 {
            didSet {
                regCountSum = countSum(regCountAlone, regCountCherry)
                bonusCountSum = countSum(bigCount, regCountAlone, regCountCherry)
            }
        }
    @AppStorage("imJugExRegCountSum") var regCountSum: Int = 0
    @AppStorage("imJugExBonusCountSum") var bonusCountSum: Int = 0
    @AppStorage("imJugExStartGame") var startGame = 0 {
        didSet {
            let games = currentGame - startGame
            playGame = games > 0 ? games : 0
        }
    }
        @AppStorage("imJugExCurrentGame") var currentGame = 0 {
            didSet {
                let games = currentGame - startGame
                playGame = games > 0 ? games : 0
            }
        }
    @AppStorage("imJugExPlayGame") var playGame = 0
    @AppStorage("imJugExMinusCheck") var minusCheck: Bool = false
    
    func reset() {
        bellCount = 0
        bigCount = 0
        regCountAlone = 0
        regCountCherry = 0
        startGame = 0
        currentGame = 0
        minusCheck = false
    }
 }

struct imJugExViewTop: View {
    @ObservedObject var jug = imJugEx()
    @FocusState private var isFocused: Bool
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    @State var isShowAlert = false
    
    var body: some View {
        List {
            Section {
                // //// 横画面
                if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
                    // //// ボタン＆結果横並び
                    HStack {
                        // ブドウ
                        unitCountButtonVerticalDenominate(title: "ぶどう", count: $jug.bellCount, color: .personalSummerLightGreen, bigNumber: $jug.playGame, numberofDicimal: 2, minusBool: $jug.minusCheck)
                        // ビッグ
                        unitCountButtonVerticalDenominate(title: "ビッグ", count: $jug.bigCount, color: .personalSummerLightRed, bigNumber: $jug.playGame, numberofDicimal: 0, minusBool: $jug.minusCheck)
                        // 単独REG
                        unitCountButtonVerticalDenominate(title: "単独REG", count: $jug.regCountAlone, color: .personalSummerLightBlue, bigNumber: $jug.playGame, numberofDicimal: 0, minusBool: $jug.minusCheck)
                        // チェリーREG
                        unitCountButtonVerticalDenominate(title: "🍒REG", count: $jug.regCountCherry, color: .personalSummerLightPurple, bigNumber: $jug.playGame, numberofDicimal: 0, minusBool: $jug.minusCheck)
                        // REG合算
                        unitResultRatioDenomination2Line(title: "REG合算", color: .grayBack, count: $jug.regCountSum, bigNumber: $jug.playGame, numberofDicimal: 0)
                            .padding(.vertical)
                        // ボーナス合算
                        unitResultRatioDenomination2Line(title: "ボーナス合算", color: .grayBack, count: $jug.bonusCountSum, bigNumber: $jug.playGame, numberofDicimal: 0)
                            .padding(.vertical)
                    }
                }
                // //// 縦画面
                else {
                    // //// ボタン横並び
                    HStack {
                        // ブドウ
                        unitCountButtonVerticalDenominate(title: "ぶどう", count: $jug.bellCount, color: .personalSummerLightGreen, bigNumber: $jug.playGame, numberofDicimal: 2, minusBool: $jug.minusCheck)
                        // ビッグ
                        unitCountButtonVerticalDenominate(title: "ビッグ", count: $jug.bigCount, color: .personalSummerLightRed, bigNumber: $jug.playGame, numberofDicimal: 0, minusBool: $jug.minusCheck)
                        // 単独REG
                        unitCountButtonVerticalDenominate(title: "単独REG", count: $jug.regCountAlone, color: .personalSummerLightBlue, bigNumber: $jug.playGame, numberofDicimal: 0, minusBool: $jug.minusCheck)
                        // チェリーREG
                        unitCountButtonVerticalDenominate(title: "🍒REG", count: $jug.regCountCherry, color: .personalSummerLightPurple, bigNumber: $jug.playGame, numberofDicimal: 0, minusBool: $jug.minusCheck)
                    }
                    // //// 確率結果横並び
                    HStack {
                        // ボーナス合算
                        unitResultRatioDenomination2Line(title: "ボーナス合算", color: .grayBack, count: $jug.bonusCountSum, bigNumber: $jug.playGame, numberofDicimal: 0)
                        // REG合算
                        unitResultRatioDenomination2Line(title: "REG合算", color: .grayBack, count: $jug.regCountSum, bigNumber: $jug.playGame, numberofDicimal: 0)
                    }
                    // //// 参考情報リンク
                    unitLinkButton(title: "設定差情報", exview: AnyView(unitExView5body2image(title: "アイムジャグラーEX設定差", image1: Image("imJugExRatio"))))
                }
            }
            // //// ゲーム数入力部分
            Section {
                // 打ち始め
                unitTextFieldGamesInput(title: "打ち始め", inputValue: $jug.startGame)
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
                unitTextFieldGamesInput(title: "現在", inputValue: $jug.currentGame)
                    .focused($isFocused)
                // 消化ゲーム数
                HStack {
                    Text("消化ゲーム数")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("\(jug.playGame)")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            } header: {
                Text("ゲーム数入力")
            }
            unitClearScrollSection(spaceHeight: 0.0)
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
            // デバイスの向きの変更を監視する
            NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: .main) { _ in
                self.orientation = UIDevice.current.orientation
                // 向きがフラットでなければlastOrientationの値を更新
                if self.orientation.isFlat {
                    
                }
                else {
                    self.lastOrientation = self.orientation
                }
            }
        }
        .onDisappear {
            // ビューが非表示になるときに監視を解除
            NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
        }
        .navigationTitle("アイムジャグラーEX")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    unitButtonMinusCheck(minusCheck: $jug.minusCheck)
                    unitButtonReset(isShowAlert: $isShowAlert, action: jug.reset)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    imJugExViewTop()
}
