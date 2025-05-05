//
//  goJug3ViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/11/10.
//

import SwiftUI
import TipKit

// ////////////////////////////
// 変数
// ////////////////////////////
class goJug3: ObservableObject {
    @AppStorage("goJug3BellCount") var bellCount: Int = 0
    @AppStorage("goJug3BigCount") var bigCount: Int = 0 {
        didSet {
            bonusCountSum = countSum(bigCount, regCount)
        }
    }
        @AppStorage("goJug3RegCount") var regCount: Int = 0 {
            didSet {
                bonusCountSum = countSum(bigCount, regCount)
            }
        }
    @AppStorage("goJug3BonusCountSum") var bonusCountSum: Int = 0
    @AppStorage("goJug3StartGame") var startGame = 0 {
        didSet {
            let games = currentGame - startGame
            playGame = games > 0 ? games : 0
        }
    }
        @AppStorage("goJug3CurrentGame") var currentGame = 0 {
            didSet {
                let games = currentGame - startGame
                playGame = games > 0 ? games : 0
            }
        }
    @AppStorage("goJug3PlayGame") var playGame = 0
    @AppStorage("goJug3MinusCheck") var minusCheck: Bool = false
    @AppStorage("goJug3SelectedMemory") var selectedMemory = "メモリー1"
    
    func reset() {
        bellCount = 0
        bigCount = 0
        regCount = 0
        startGame = 0
        currentGame = 0
        minusCheck = false
    }
}


// //// メモリー1
class goJug3Memory1: ObservableObject {
    @AppStorage("goJug3BellCountMemory1") var bellCount: Int = 0
    @AppStorage("goJug3BigCountMemory1") var bigCount: Int = 0
    @AppStorage("goJug3RegCountAloneMemory1") var regCount = 0
    @AppStorage("goJug3BonusCountSumMemory1") var bonusCountSum: Int = 0
    @AppStorage("goJug3StartGameMemory1") var startGame = 0
    @AppStorage("goJug3CurrentGameMemory1") var currentGame = 0
    @AppStorage("goJug3PlayGameMemory1") var playGame = 0
    @AppStorage("goJug3MemoMemory1") var memo = ""
    @AppStorage("goJug3DateMemory1") var dateDouble = 0.0
}

// //// メモリー2
class goJug3Memory2: ObservableObject {
    @AppStorage("goJug3BellCountMemory2") var bellCount: Int = 0
    @AppStorage("goJug3BigCountMemory2") var bigCount: Int = 0
    @AppStorage("goJug3RegCountAloneMemory2") var regCount = 0
    @AppStorage("goJug3BonusCountSumMemory2") var bonusCountSum: Int = 0
    @AppStorage("goJug3StartGameMemory2") var startGame = 0
    @AppStorage("goJug3CurrentGameMemory2") var currentGame = 0
    @AppStorage("goJug3PlayGameMemory2") var playGame = 0
    @AppStorage("goJug3MemoMemory2") var memo = ""
    @AppStorage("goJug3DateMemory2") var dateDouble = 0.0
}

// //// メモリー3
class goJug3Memory3: ObservableObject {
    @AppStorage("goJug3BellCountMemory3") var bellCount: Int = 0
    @AppStorage("goJug3BigCountMemory3") var bigCount: Int = 0
    @AppStorage("goJug3RegCountAloneMemory3") var regCount = 0
    @AppStorage("goJug3BonusCountSumMemory3") var bonusCountSum: Int = 0
    @AppStorage("goJug3StartGameMemory3") var startGame = 0
    @AppStorage("goJug3CurrentGameMemory3") var currentGame = 0
    @AppStorage("goJug3PlayGameMemory3") var playGame = 0
    @AppStorage("goJug3MemoMemory3") var memo = ""
    @AppStorage("goJug3DateMemory3") var dateDouble = 0.0
}


struct goJug3ViewTop: View {
    @ObservedObject var jug = goJug3()
    @ObservedObject var jugMemory1 = goJug3Memory1()
    @ObservedObject var jugMemory2 = goJug3Memory2()
    @ObservedObject var jugMemory3 = goJug3Memory3()
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
                        // REG
                        unitCountButtonVerticalDenominate(title: "REG", count: $jug.regCount, color: .personalSummerLightBlue, bigNumber: $jug.playGame, numberofDicimal: 0, minusBool: $jug.minusCheck)
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
                        // REG
                        unitCountButtonVerticalDenominate(title: "REG", count: $jug.regCount, color: .personalSummerLightBlue, bigNumber: $jug.playGame, numberofDicimal: 0, minusBool: $jug.minusCheck)
                        
                    }
                    // //// 確率結果横並び
                    HStack {
                        // ボーナス合算
                        unitResultRatioDenomination2Line(title: "ボーナス合算", color: .grayBack, count: $jug.bonusCountSum, bigNumber: $jug.playGame, numberofDicimal: 0)
                    }
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "設定差情報",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "ゴーゴージャグラー3設定差",
                            textBody1: "・REGは単独、チェリー重複ともに均一の設定差と思われるので分けてカウントしなくてもいいらしい",
                            image1: Image("goJug3Ratio")
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(goJug3View95Ci()))
                    .popoverTip(tipUnitButtonLink95Ci())
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
        .navigationTitle("ゴーゴージャグラー3")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    HStack {
                        // //// データ読み出し
                        unitButtonLoadMemory(
                            loadView: AnyView(
                                goJug3ViewLoadMemory(
                                    jug: jug,
                                    jugMemory1: jugMemory1,
                                    jugMemory2: jugMemory2,
                                    jugMemory3: jugMemory3
                                )
                            )
                        )
                        // //// データ保存
                        unitButtonSaveMemory(
                            saveView: AnyView(
                                goJug3ViewSaveMemory(
                                    jug: jug,
                                    jugMemory1: jugMemory1,
                                    jugMemory2: jugMemory2,
                                    jugMemory3: jugMemory3
                                )
                            )
                        )
                    }
                    .popoverTip(tipUnitButtonMemory())
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
struct goJug3ViewSaveMemory: View {
    @ObservedObject var jug: goJug3
    @ObservedObject var jugMemory1: goJug3Memory1
    @ObservedObject var jugMemory2: goJug3Memory2
    @ObservedObject var jugMemory3: goJug3Memory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "ゴーゴージャグラー3",
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
        jugMemory1.regCount = jug.regCount
        jugMemory1.bonusCountSum = jug.bonusCountSum
        jugMemory1.startGame = jug.startGame
        jugMemory1.currentGame = jug.currentGame
        jugMemory1.playGame = jug.playGame
    }
    func saveMemory2() {
        jugMemory2.bellCount = jug.bellCount
        jugMemory2.bigCount = jug.bigCount
        jugMemory2.regCount = jug.regCount
        jugMemory2.bonusCountSum = jug.bonusCountSum
        jugMemory2.startGame = jug.startGame
        jugMemory2.currentGame = jug.currentGame
        jugMemory2.playGame = jug.playGame
    }
    func saveMemory3() {
        jugMemory3.bellCount = jug.bellCount
        jugMemory3.bigCount = jug.bigCount
        jugMemory3.regCount = jug.regCount
        jugMemory3.bonusCountSum = jug.bonusCountSum
        jugMemory3.startGame = jug.startGame
        jugMemory3.currentGame = jug.currentGame
        jugMemory3.playGame = jug.playGame
    }
}

// /////////////////////////////
// メモリーロード画面
// /////////////////////////////
struct goJug3ViewLoadMemory: View {
    @ObservedObject var jug: goJug3
    @ObservedObject var jugMemory1: goJug3Memory1
    @ObservedObject var jugMemory2: goJug3Memory2
    @ObservedObject var jugMemory3: goJug3Memory3
    @State var isShowLoadAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: "ゴーゴージャグラー3",
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
        jug.regCount = jugMemory1.regCount
        jug.bonusCountSum = jugMemory1.bonusCountSum
        jug.startGame = jugMemory1.startGame
        jug.currentGame = jugMemory1.currentGame
        jug.playGame = jugMemory1.playGame
    }
    func loadMemory2() {
        jug.bellCount = jugMemory2.bellCount
        jug.bigCount = jugMemory2.bigCount
        jug.regCount = jugMemory2.regCount
        jug.bonusCountSum = jugMemory2.bonusCountSum
        jug.startGame = jugMemory2.startGame
        jug.currentGame = jugMemory2.currentGame
        jug.playGame = jugMemory2.playGame
    }
    func loadMemory3() {
        jug.bellCount = jugMemory3.bellCount
        jug.bigCount = jugMemory3.bigCount
        jug.regCount = jugMemory3.regCount
        jug.bonusCountSum = jugMemory3.bonusCountSum
        jug.startGame = jugMemory3.startGame
        jug.currentGame = jugMemory3.currentGame
        jug.playGame = jugMemory3.playGame
    }
}


#Preview {
    goJug3ViewTop()
}
