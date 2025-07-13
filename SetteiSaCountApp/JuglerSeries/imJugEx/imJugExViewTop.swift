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
    @AppStorage("imJugExSelectedMemory") var selectedMemory = "メモリー1"
    
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

// //// メモリー1
class imJugExMemory1: ObservableObject {
    @AppStorage("imJugExBellCountMemory1") var bellCount: Int = 0
    @AppStorage("imJugExBigCountMemory1") var bigCount: Int = 0
    @AppStorage("imJugExRegCountAloneMemory1") var regCountAlone = 0
    @AppStorage("imJugExRegCountCherryMemory1") var regCountCherry = 0
    @AppStorage("imJugExRegCountSumMemory1") var regCountSum: Int = 0
    @AppStorage("imJugExBonusCountSumMemory1") var bonusCountSum: Int = 0
    @AppStorage("imJugExStartGameMemory1") var startGame = 0
    @AppStorage("imJugExCurrentGameMemory1") var currentGame = 0
    @AppStorage("imJugExPlayGameMemory1") var playGame = 0
    @AppStorage("imJugExMemoMemory1") var memo = ""
    @AppStorage("imJugExDateMemory1") var dateDouble = 0.0
}

// //// メモリー2
class imJugExMemory2: ObservableObject {
    @AppStorage("imJugExBellCountMemory2") var bellCount: Int = 0
    @AppStorage("imJugExBigCountMemory2") var bigCount: Int = 0
    @AppStorage("imJugExRegCountAloneMemory2") var regCountAlone = 0
    @AppStorage("imJugExRegCountCherryMemory2") var regCountCherry = 0
    @AppStorage("imJugExRegCountSumMemory2") var regCountSum: Int = 0
    @AppStorage("imJugExBonusCountSumMemory2") var bonusCountSum: Int = 0
    @AppStorage("imJugExStartGameMemory2") var startGame = 0
    @AppStorage("imJugExCurrentGameMemory2") var currentGame = 0
    @AppStorage("imJugExPlayGameMemory2") var playGame = 0
    @AppStorage("imJugExMemoMemory2") var memo = ""
    @AppStorage("imJugExDateMemory2") var dateDouble = 0.0
}

// //// メモリー3
class imJugExMemory3: ObservableObject {
    @AppStorage("imJugExBellCountMemory3") var bellCount: Int = 0
    @AppStorage("imJugExBigCountMemory3") var bigCount: Int = 0
    @AppStorage("imJugExRegCountAloneMemory3") var regCountAlone = 0
    @AppStorage("imJugExRegCountCherryMemory3") var regCountCherry = 0
    @AppStorage("imJugExRegCountSumMemory3") var regCountSum: Int = 0
    @AppStorage("imJugExBonusCountSumMemory3") var bonusCountSum: Int = 0
    @AppStorage("imJugExStartGameMemory3") var startGame = 0
    @AppStorage("imJugExCurrentGameMemory3") var currentGame = 0
    @AppStorage("imJugExPlayGameMemory3") var playGame = 0
    @AppStorage("imJugExMemoMemory3") var memo = ""
    @AppStorage("imJugExDateMemory3") var dateDouble = 0.0
}


struct imJugExViewTop: View {
    @ObservedObject var jug = imJugEx()
    @ObservedObject var jugMemory1 = imJugExMemory1()
    @ObservedObject var jugMemory2 = imJugExMemory2()
    @ObservedObject var jugMemory3 = imJugExMemory3()
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
                }
                // //// 参考情報リンク
                unitLinkButton(title: "設定差情報", exview: AnyView(unitExView5body2image(title: "アイムジャグラーEX設定差", image1: Image("imJugExRatio"))))
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(imJugExView95Ci()))
//                    .popoverTip(tipUnitButtonLink95Ci())
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
                    HStack {
                        // //// データ読み出し
                        unitButtonLoadMemory(loadView: AnyView(imJugExViewLoadMemory(jug: jug, jugMemory1: jugMemory1, jugMemory2: jugMemory2, jugMemory3: jugMemory3)))
                        // //// データ保存
                        unitButtonSaveMemory(saveView: AnyView(imJugExViewSaveMemory(jug: jug, jugMemory1: jugMemory1, jugMemory2: jugMemory2, jugMemory3: jugMemory3)))
                    }
//                    .popoverTip(tipUnitButtonMemory())
                    unitButtonMinusCheck(minusCheck: $jug.minusCheck)
                    unitButtonReset(isShowAlert: $isShowAlert, action: jug.reset)
//                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}


// /////////////////////////////
// メモリーセーブ画面
// /////////////////////////////
struct imJugExViewSaveMemory: View {
    @ObservedObject var jug: imJugEx
    @ObservedObject var jugMemory1: imJugExMemory1
    @ObservedObject var jugMemory2: imJugExMemory2
    @ObservedObject var jugMemory3: imJugExMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "アイムジャグラーEX",
            selectedMemory: $jug.selectedMemory,
            memoMemory1: $jugMemory1.memo,
            dateDoubleMemory1: $jugMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $jugMemory2.memo,
            dateDoubleMemory2: $jugMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $jugMemory3.memo,
            dateDoubleMemory3: $jugMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        jugMemory1.bellCount = jug.bellCount
        jugMemory1.bigCount = jug.bigCount
        jugMemory1.regCountAlone = jug.regCountAlone
        jugMemory1.regCountCherry = jug.regCountCherry
        jugMemory1.regCountSum = jug.regCountSum
        jugMemory1.bonusCountSum = jug.bonusCountSum
        jugMemory1.startGame = jug.startGame
        jugMemory1.currentGame = jug.currentGame
        jugMemory1.playGame = jug.playGame
    }
    func saveMemory2() {
        jugMemory2.bellCount = jug.bellCount
        jugMemory2.bigCount = jug.bigCount
        jugMemory2.regCountAlone = jug.regCountAlone
        jugMemory2.regCountCherry = jug.regCountCherry
        jugMemory2.regCountSum = jug.regCountSum
        jugMemory2.bonusCountSum = jug.bonusCountSum
        jugMemory2.startGame = jug.startGame
        jugMemory2.currentGame = jug.currentGame
        jugMemory2.playGame = jug.playGame
    }
    func saveMemory3() {
        jugMemory3.bellCount = jug.bellCount
        jugMemory3.bigCount = jug.bigCount
        jugMemory3.regCountAlone = jug.regCountAlone
        jugMemory3.regCountCherry = jug.regCountCherry
        jugMemory3.regCountSum = jug.regCountSum
        jugMemory3.bonusCountSum = jug.bonusCountSum
        jugMemory3.startGame = jug.startGame
        jugMemory3.currentGame = jug.currentGame
        jugMemory3.playGame = jug.playGame
    }
}


// /////////////////////////////
// メモリーロード画面
// /////////////////////////////
struct imJugExViewLoadMemory: View {
    @ObservedObject var jug: imJugEx
    @ObservedObject var jugMemory1: imJugExMemory1
    @ObservedObject var jugMemory2: imJugExMemory2
    @ObservedObject var jugMemory3: imJugExMemory3
    @State var isShowLoadAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: "アイムジャグラーEX",
            selectedMemory: $jug.selectedMemory,
            memoMemory1: jugMemory1.memo,
            dateDoubleMemory1: jugMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: jugMemory2.memo,
            dateDoubleMemory2: jugMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: jugMemory3.memo,
            dateDoubleMemory3: jugMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowLoadAlert
        )
    }
    func loadMemory1() {
        jug.bellCount = jugMemory1.bellCount
        jug.bigCount = jugMemory1.bigCount
        jug.regCountAlone = jugMemory1.regCountAlone
        jug.regCountCherry = jugMemory1.regCountCherry
        jug.regCountSum = jugMemory1.regCountSum
        jug.bonusCountSum = jugMemory1.bonusCountSum
        jug.startGame = jugMemory1.startGame
        jug.currentGame = jugMemory1.currentGame
        jug.playGame = jugMemory1.playGame
    }
    func loadMemory2() {
        jug.bellCount = jugMemory2.bellCount
        jug.bigCount = jugMemory2.bigCount
        jug.regCountAlone = jugMemory2.regCountAlone
        jug.regCountCherry = jugMemory2.regCountCherry
        jug.regCountSum = jugMemory2.regCountSum
        jug.bonusCountSum = jugMemory2.bonusCountSum
        jug.startGame = jugMemory2.startGame
        jug.currentGame = jugMemory2.currentGame
        jug.playGame = jugMemory2.playGame
    }
    func loadMemory3() {
        jug.bellCount = jugMemory3.bellCount
        jug.bigCount = jugMemory3.bigCount
        jug.regCountAlone = jugMemory3.regCountAlone
        jug.regCountCherry = jugMemory3.regCountCherry
        jug.regCountSum = jugMemory3.regCountSum
        jug.bonusCountSum = jugMemory3.bonusCountSum
        jug.startGame = jugMemory3.startGame
        jug.currentGame = jugMemory3.currentGame
        jug.playGame = jugMemory3.playGame
    }
}

#Preview {
    imJugExViewTop()
}
