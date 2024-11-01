//
//  kingHanaViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/17.
//

import SwiftUI


// /////////////////////
// 変数
// /////////////////////
protocol hanaVar {
    var bellCount: Int { get set }
    var bigCount: Int { get set }
    var regCount: Int {get set }
    var bbSuikaCount: Int {get set }
    var bbLampBCount: Int { get set }
    var bbLampYCount: Int { get set }
    var bbLampGCount: Int { get set }
    var bbLampRCount: Int { get set }
    var bbLampRainbowCount: Int { get set }
    var rbLampBCount: Int { get set }
    var rbLampYCount: Int { get set }
    var rbLampGCount: Int { get set }
    var rbLampRCount: Int { get set }
    var rbLampRainbowCount: Int { get set }
    
    func hanaReset()
}

class kingHanaVar: ObservableObject, hanaVar {
    @AppStorage("kingHanaBellCount") var bellCount = 0
    @AppStorage("kingHanaBigCount") var bigCount = 0 {
        didSet {
            totalBonus = TotalBonus(big: bigCount, reg: regCount)
            bigPlayGames = BigPlayGames(big: bigCount)
        }
    }
    @AppStorage("kingHanaRegCount") var regCount = 0 {
        didSet {
            totalBonus = TotalBonus(big: bigCount, reg: regCount)
        }
    }
    @AppStorage("kingHanaBBSuikaCount") var bbSuikaCount = 0
    @AppStorage("kingHanaBBLampBCount") var bbLampBCount = 0 {
        didSet {
            bbLampCountSum = BbLampCountSum(bCount: bbLampBCount, yCount: bbLampYCount, gCount: bbLampGCount, rCount: bbLampRCount)
        }
    }
    @AppStorage("kingHanaBBLampYCount") var bbLampYCount = 0 {
        didSet {
            bbLampCountSum = BbLampCountSum(bCount: bbLampBCount, yCount: bbLampYCount, gCount: bbLampGCount, rCount: bbLampRCount)
        }
    }
    @AppStorage("kingHanaBBLampGCount") var bbLampGCount = 0 {
        didSet {
            bbLampCountSum = BbLampCountSum(bCount: bbLampBCount, yCount: bbLampYCount, gCount: bbLampGCount, rCount: bbLampRCount)
        }
    }
    @AppStorage("kingHanaBBLampRCount") var bbLampRCount = 0 {
        didSet {
            bbLampCountSum = BbLampCountSum(bCount: bbLampBCount, yCount: bbLampYCount, gCount: bbLampGCount, rCount: bbLampRCount)
        }
    }
    @AppStorage("kingHanaBBLampRainbowCount") var bbLampRainbowCount = 0
    @AppStorage("kingHanaRbLampBCount") var rbLampBCount = 0 {
        didSet {
            rbLampCountSum = RbLampCountSum(bCount: rbLampBCount, yCount: rbLampYCount, gCount: rbLampGCount, rCount: rbLampRCount)
            rbLampKisuCountSum = RbLampKisuCountSum(bCount: rbLampBCount, gCount: rbLampGCount)
        }
    }
    @AppStorage("kingHanaRbLampYCount") var rbLampYCount = 0 {
        didSet {
            rbLampCountSum = RbLampCountSum(bCount: rbLampBCount, yCount: rbLampYCount, gCount: rbLampGCount, rCount: rbLampRCount)
            rbLampGusuCountSum = RbLampGusuCountSum(yCount: rbLampYCount, rCount: rbLampRCount)
        }
    }
    @AppStorage("kingHanaRbLampGCount") var rbLampGCount = 0 {
        didSet {
            rbLampCountSum = RbLampCountSum(bCount: rbLampBCount, yCount: rbLampYCount, gCount: rbLampGCount, rCount: rbLampRCount)
            rbLampKisuCountSum = RbLampKisuCountSum(bCount: rbLampBCount, gCount: rbLampGCount)
        }
    }
    @AppStorage("kingHanaRbLampRCount") var rbLampRCount = 0 {
        didSet {
            rbLampCountSum = RbLampCountSum(bCount: rbLampBCount, yCount: rbLampYCount, gCount: rbLampGCount, rCount: rbLampRCount)
            rbLampGusuCountSum = RbLampGusuCountSum(yCount: rbLampYCount, rCount: rbLampRCount)
        }
    }
    @AppStorage("kingHanaRbLampRainbowCount") var rbLampRainbowCount = 0
    @AppStorage("kingHanaStartGames") var startGames = 0 {
        didSet {
            playGames = PlayGames(start: startGames, current: currentGames)
        }
    }
    @AppStorage("kingHanaCurrentGames") var currentGames = 0 {
        didSet {
            playGames = PlayGames(start: startGames, current: currentGames)
        }
    }
    @Published var minusCheck = false
    
    // ボーナス合算カウント
    private func TotalBonus(big:Int,reg:Int) -> Int {
        return big + reg
    }
    @AppStorage("kingHanaTotalBonus") var totalBonus = 0
    
    // 消化ゲーム数算出
    private func PlayGames(start:Int,current:Int) -> Int {
        let games = current - start
        return games > 0 ? games : 0
    }
    @AppStorage("kingHanaPlayGames") var playGames = 0
    
    // ビッグ消化ゲーム数
    private func BigPlayGames(big:Int) -> Int {
        return big * 20
    }
    @AppStorage("kingHanaBigPlayGames") var bigPlayGames = 0
    
    // BBランプ合計カウント
    private func BbLampCountSum(bCount:Int,yCount:Int,gCount:Int,rCount:Int) -> Int {
        return bCount + yCount + gCount + rCount
    }
    @AppStorage("kingHanaBbLampCountSum") var bbLampCountSum = 0
    
    // RBランプ合計カウント
    private func RbLampCountSum(bCount:Int,yCount:Int,gCount:Int,rCount:Int) -> Int {
        return bCount + yCount + gCount + rCount
    }
    @AppStorage("kingHanaRbLampCountSum") var rbLampCountSum = 0
    
    // RBランプ奇数示唆合計カウント
    private func RbLampKisuCountSum(bCount:Int,gCount:Int) -> Int {
        return bCount + gCount
    }
    @AppStorage("kingHanaRbLampKisuCountSum") var rbLampKisuCountSum = 0
    
    // RBランプ偶数示唆合計カウント
    private func RbLampGusuCountSum(yCount:Int,rCount:Int) -> Int {
        return yCount + rCount
    }
    @AppStorage("kingHanaRbLampGusuCountSum") var rbLampGusuCountSum = 0
    
    // Tips
    var tipKeybordHidden = commonTipKeybordHidden()
    
    func hanaReset() {
        bellCount = 0
        bigCount = 0
        regCount = 0
        bbSuikaCount = 0
        bbLampBCount = 0
        bbLampYCount = 0
        bbLampGCount = 0
        bbLampRCount = 0
        bbLampRainbowCount = 0
        rbLampBCount = 0
        rbLampYCount = 0
        rbLampGCount = 0
        rbLampRCount = 0
        rbLampRainbowCount = 0
        startGames = 0
        currentGames = 0
        minusCheck = false
    }
    @AppStorage("kingHanaSelectedMemory") var selectedMemory = "メモリー1"
    
}

// //// メモリー1
class kingHanaMemory1: ObservableObject {
    @AppStorage("kingHanaBellCountMemory1") var bellCount = 0
    @AppStorage("kingHanaBigCountMemory1") var bigCount = 0
    @AppStorage("kingHanaRegCountMemory1") var regCount = 0
    @AppStorage("kingHanaBBSuikaCountMemory1") var bbSuikaCount = 0
    @AppStorage("kingHanaBBLampBCountMemory1") var bbLampBCount = 0
    @AppStorage("kingHanaBBLampYCountMemory1") var bbLampYCount = 0
    @AppStorage("kingHanaBBLampGCountMemory1") var bbLampGCount = 0
    @AppStorage("kingHanaBBLampRCountMemory1") var bbLampRCount = 0
    @AppStorage("kingHanaBBLampRainbowCountMemory1") var bbLampRainbowCount = 0
    @AppStorage("kingHanaRbLampBCountMemory1") var rbLampBCount = 0
    @AppStorage("kingHanaRbLampYCountMemory1") var rbLampYCount = 0
    @AppStorage("kingHanaRbLampGCountMemory1") var rbLampGCount = 0
    @AppStorage("kingHanaRbLampRCountMemory1") var rbLampRCount = 0
    @AppStorage("kingHanaRbLampRainbowCountMemory1") var rbLampRainbowCount = 0
    @AppStorage("kingHanaStartGamesMemory1") var startGames = 0
    @AppStorage("kingHanaCurrentGamesMemory1") var currentGames = 0
    @AppStorage("kingHanaTotalBonusMemory1") var totalBonus = 0
    @AppStorage("kingHanaPlayGamesMemory1") var playGames = 0
    @AppStorage("kingHanaBigPlayGamesMemory1") var bigPlayGames = 0
    @AppStorage("kingHanaBbLampCountSumMemory1") var bbLampCountSum = 0
    @AppStorage("kingHanaRbLampCountSumMemory1") var rbLampCountSum = 0
    @AppStorage("kingHanaRbLampKisuCountSumMemory1") var rbLampKisuCountSum = 0
    @AppStorage("kingHanaRbLampGusuCountSumMemory1") var rbLampGusuCountSum = 0
    @AppStorage("kingHanaMemoMemory1") var memo = ""
    @AppStorage("kingHanaDateMemory1") var dateDouble = 0.0
}

// //// メモリー2
class kingHanaMemory2: ObservableObject {
    @AppStorage("kingHanaBellCountMemory2") var bellCount = 0
    @AppStorage("kingHanaBigCountMemory2") var bigCount = 0
    @AppStorage("kingHanaRegCountMemory2") var regCount = 0
    @AppStorage("kingHanaBBSuikaCountMemory2") var bbSuikaCount = 0
    @AppStorage("kingHanaBBLampBCountMemory2") var bbLampBCount = 0
    @AppStorage("kingHanaBBLampYCountMemory2") var bbLampYCount = 0
    @AppStorage("kingHanaBBLampGCountMemory2") var bbLampGCount = 0
    @AppStorage("kingHanaBBLampRCountMemory2") var bbLampRCount = 0
    @AppStorage("kingHanaBBLampRainbowCountMemory2") var bbLampRainbowCount = 0
    @AppStorage("kingHanaRbLampBCountMemory2") var rbLampBCount = 0
    @AppStorage("kingHanaRbLampYCountMemory2") var rbLampYCount = 0
    @AppStorage("kingHanaRbLampGCountMemory2") var rbLampGCount = 0
    @AppStorage("kingHanaRbLampRCountMemory2") var rbLampRCount = 0
    @AppStorage("kingHanaRbLampRainbowCountMemory2") var rbLampRainbowCount = 0
    @AppStorage("kingHanaStartGamesMemory2") var startGames = 0
    @AppStorage("kingHanaCurrentGamesMemory2") var currentGames = 0
    @AppStorage("kingHanaTotalBonusMemory2") var totalBonus = 0
    @AppStorage("kingHanaPlayGamesMemory2") var playGames = 0
    @AppStorage("kingHanaBigPlayGamesMemory2") var bigPlayGames = 0
    @AppStorage("kingHanaBbLampCountSumMemory2") var bbLampCountSum = 0
    @AppStorage("kingHanaRbLampCountSumMemory2") var rbLampCountSum = 0
    @AppStorage("kingHanaRbLampKisuCountSumMemory2") var rbLampKisuCountSum = 0
    @AppStorage("kingHanaRbLampGusuCountSumMemory2") var rbLampGusuCountSum = 0
    @AppStorage("kingHanaMemoMemory2") var memo = ""
    @AppStorage("kingHanaDateMemory2") var dateDouble = 0.0
}

// //// メモリー3
class kingHanaMemory3: ObservableObject {
    @AppStorage("kingHanaBellCountMemory3") var bellCount = 0
    @AppStorage("kingHanaBigCountMemory3") var bigCount = 0
    @AppStorage("kingHanaRegCountMemory3") var regCount = 0
    @AppStorage("kingHanaBBSuikaCountMemory3") var bbSuikaCount = 0
    @AppStorage("kingHanaBBLampBCountMemory3") var bbLampBCount = 0
    @AppStorage("kingHanaBBLampYCountMemory3") var bbLampYCount = 0
    @AppStorage("kingHanaBBLampGCountMemory3") var bbLampGCount = 0
    @AppStorage("kingHanaBBLampRCountMemory3") var bbLampRCount = 0
    @AppStorage("kingHanaBBLampRainbowCountMemory3") var bbLampRainbowCount = 0
    @AppStorage("kingHanaRbLampBCountMemory3") var rbLampBCount = 0
    @AppStorage("kingHanaRbLampYCountMemory3") var rbLampYCount = 0
    @AppStorage("kingHanaRbLampGCountMemory3") var rbLampGCount = 0
    @AppStorage("kingHanaRbLampRCountMemory3") var rbLampRCount = 0
    @AppStorage("kingHanaRbLampRainbowCountMemory3") var rbLampRainbowCount = 0
    @AppStorage("kingHanaStartGamesMemory3") var startGames = 0
    @AppStorage("kingHanaCurrentGamesMemory3") var currentGames = 0
    @AppStorage("kingHanaTotalBonusMemory3") var totalBonus = 0
    @AppStorage("kingHanaPlayGamesMemory3") var playGames = 0
    @AppStorage("kingHanaBigPlayGamesMemory3") var bigPlayGames = 0
    @AppStorage("kingHanaBbLampCountSumMemory3") var bbLampCountSum = 0
    @AppStorage("kingHanaRbLampCountSumMemory3") var rbLampCountSum = 0
    @AppStorage("kingHanaRbLampKisuCountSumMemory3") var rbLampKisuCountSum = 0
    @AppStorage("kingHanaRbLampGusuCountSumMemory3") var rbLampGusuCountSum = 0
    @AppStorage("kingHanaMemoMemory3") var memo = ""
    @AppStorage("kingHanaDateMemory3") var dateDouble = 0.0
}


// /////////////////////
// ビュー：メインビュー
// /////////////////////
struct kingHanaViewTop: View {
    @ObservedObject var hana = kingHanaVar()
    let displayMode = ["通常時", "BIG", "REG"]     // 機種リストの表示モード選択肢
    @State var isSelectedDisplayMode = "通常時"
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    @State var isShowAlert = false
    @FocusState var isFocused: Bool
    @State var shouldReload = false
    @ObservedObject var hanaMemory1 = kingHanaMemory1()
    @ObservedObject var hanaMemory2 = kingHanaMemory2()
    @ObservedObject var hanaMemory3 = kingHanaMemory3()
    
    var body: some View {
//        NavigationView {
            ZStack {
                List {
                    // //// 通常時
                    if isSelectedDisplayMode == "通常時" {
                        // 縦向き
                        if orientation.isPortrait || (orientation.isFlat && lastOrientation.isPortrait) {
                            kingHanaSubAssyNormalPortraitCountSection(hana: hana)
                        }
                        // 横向き
//                        else if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
                        else {
                            kingHanaSubAssyNormalLandScapeCountSection(hana: hana)
                        }
                        // ゲーム数入力部分
                        Section("ゲーム数入力") {
                            // 打ち始めゲーム数入力
                            unitTextFieldGamesInput(title: "打ち始め", inputValue: $hana.startGames)
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
                            // 現在ゲーム数入力
                            unitTextFieldGamesInput(title: "現在", inputValue: $hana.currentGames)
                                .focused($isFocused)
                            // 消化ゲーム数
                            HStack {
                                Text("消化ゲーム数")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text("\(hana.playGames)")
                                    .frame(maxWidth: .infinity, alignment: .center)
                            }
                        }
                    }
                    
                    // //// ビッグ
                    else if isSelectedDisplayMode == "BIG" {
                        // //// 縦向き
                        if orientation.isPortrait || (orientation.isFlat && lastOrientation.isPortrait) {
                            kingHanaSubAssyBigPortrait(hana: hana)
                            unitClearScrollSection(spaceHeight: 240)
                        }
                        
                        // //// 横向き
//                        else if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
                        else {
                            kingHanaSubAssyBigLandScape(hana: hana)
                        }
                    }
                    
                    // //// レギュラー
                    else if isSelectedDisplayMode == "REG" {
                        kingHanaSubAssyRegPortrait(hana: hana)
                    }
                }
                
                // //// モード選択
                VStack {
                    Picker("", selection: $isSelectedDisplayMode) {
                        ForEach(displayMode, id: \.self) { mode in
//                            Text($0)
                            Text(mode)
                        }
                    }
                    .background(Color(UIColor.systemGroupedBackground))
                    .pickerStyle(.segmented)
                    Spacer()
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
            .navigationTitle("キングハナハナ")
            .navigationBarTitleDisplayMode(.inline)
            
            // //// ツールバーボタン
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    HStack {
                        HStack {
                            // //// データ読み出し
                            unitButtonLoadMemory(loadView: AnyView(kingHanaViewLoadMemory(hana: hana, hanaMemory1: hanaMemory1, hanaMemory2: hanaMemory2, hanaMemory3: hanaMemory3)))
                            // //// データ保存
                            unitButtonSaveMemory(saveView: AnyView(kingHanaViewSaveMemory(hana: hana, hanaMemory1: hanaMemory1, hanaMemory2: hanaMemory2, hanaMemory3: hanaMemory3)))
                        }
                        .popoverTip(tipUnitButtonMemory())
                        // マイナスボタン
                        unitButtonMinusCheck(minusCheck: $hana.minusCheck)
                        // データリセットボタン
                        unitButtonReset(isShowAlert: $isShowAlert, action: hana.hanaReset, message: "この機種の全データをリセットします")
                            .popoverTip(tipUnitButtonReset())
                    }
                }
            }
    }
}

// //////////////////////////
// ビュー：通常時・縦・カウント部分
// //////////////////////////
struct kingHanaSubAssyNormalPortraitCountSection: View {
//    @ObservedObject var hana = kingHanaVar()
    @ObservedObject var hana: kingHanaVar
    
    var body: some View {
        HStack {
            // ベル　カウントボタン
            unitCountButtonVerticalDenominate(title: "ベル", count: $hana.bellCount, color: Color("personalSpringLightYellow"), bigNumber: $hana.playGames, numberofDicimal: 2, minusBool: $hana.minusCheck, flushColor: Color.yellow)
            // ビッグ　カウントボタン
            unitCountButtonVerticalDenominate(title: "BIG", count: $hana.bigCount, color: Color("personalSummerLightRed"), bigNumber: $hana.playGames, numberofDicimal: 0, minusBool: $hana.minusCheck)
            // レギュラー　カウントボタン
            unitCountButtonVerticalDenominate(title: "REG", count: $hana.regCount, color: Color("personalSummerLightPurple"), bigNumber: $hana.playGames, numberofDicimal: 0, minusBool: $hana.minusCheck)
        }
        // ボーナス合算確率
        unitResultRatioDenomination2Line(title: "ボーナス合算", color: Color("grayBack"), count: $hana.totalBonus, bigNumber: $hana.playGames, numberofDicimal: 0)
        // ベル確率・ボーナス確率の参考情報リンク
        unitLinkButton(title: "ベル,ボーナス確率", exview: AnyView(kingHanaExViewBellBonus()))
//        Stepper("\(hana.currentGames)", value: $hana.currentGames, step: 100)
    }
}


// //////////////////////////
// ビュー：通常時・横・カウント部分
// //////////////////////////
struct kingHanaSubAssyNormalLandScapeCountSection: View {
//    @ObservedObject var hana = kingHanaVar()
    @ObservedObject var hana: kingHanaVar
    
    var body: some View {
        HStack {
            // ベル　カウントボタン
            unitCountButtonVerticalDenominate(title: "ベル", count: $hana.bellCount, color: Color("personalSpringLightYellow"), bigNumber: $hana.playGames, numberofDicimal: 2, minusBool: $hana.minusCheck, flushColor: Color.yellow)
            // ビッグ　カウントボタン
            unitCountButtonVerticalDenominate(title: "BIG", count: $hana.bigCount, color: Color("personalSummerLightRed"), bigNumber: $hana.playGames, numberofDicimal: 0, minusBool: $hana.minusCheck)
            // レギュラー　カウントボタン
            unitCountButtonVerticalDenominate(title: "REG", count: $hana.regCount, color: Color("personalSummerLightPurple"), bigNumber: $hana.playGames, numberofDicimal: 0, minusBool: $hana.minusCheck)
            // ボーナス合算確率
            unitResultRatioDenomination2Line(title: "ボーナス合算", color: Color("grayBack"), count: $hana.totalBonus, bigNumber: $hana.playGames, numberofDicimal: 0)
                .padding(.vertical)
        }
        // ベル確率・ボーナス確率の参考情報リンク
        unitLinkButton(title: "ベル,ボーナス確率", exview: AnyView(kingHanaExViewBellBonus()))
//        Stepper("\(hana.currentGames)", value: $hana.currentGames, step: 100)
    }
}


// /////////////////////////
// ビュー：ビッグ・縦
// /////////////////////////
struct kingHanaSubAssyBigPortrait: View {
    @ObservedObject var hana: kingHanaVar
    
    var body: some View {
        // //// スイカ関連
        Section{
            // スイカカウントボタン
            unitCountButtonVerticalDenominate(title: "スイカ", count: $hana.bbSuikaCount, color: .green, bigNumber: $hana.bigPlayGames, numberofDicimal: 1, minusBool: $hana.minusCheck)
            // スイカ確率の情報リンク
            unitLinkButton(title: "BB中のスイカについて", exview: AnyView(kingHanaExViewBbSuika()))
        } header: {
            Text("\nスイカ")
        }
        
        // //// フェザーランプ関連
        Section("フェザーランプ") {
            // カウントボタン横並び
            HStack {
                // 青
                unitCountButtonVerticalPercent(title: "🪽青", count: $hana.bbLampBCount, color: .personalSummerLightBlue, bigNumber: $hana.bigCount, numberofDicimal: 1, minusBool: $hana.minusCheck)
                // 黄
                unitCountButtonVerticalPercent(title: "🪽黄", count: $hana.bbLampYCount, color: .personalSpringLightYellow, bigNumber: $hana.bigCount, numberofDicimal: 1, minusBool: $hana.minusCheck, flushColor: Color.yellow)
                // 緑
                unitCountButtonVerticalPercent(title: "🪽緑", count: $hana.bbLampGCount, color: .personalSummerLightGreen, bigNumber: $hana.bigCount, numberofDicimal: 1, minusBool: $hana.minusCheck)
                // 赤
                unitCountButtonVerticalPercent(title: "🪽赤", count: $hana.bbLampRCount, color: .personalSummerLightRed, bigNumber: $hana.bigCount, numberofDicimal: 1, minusBool: $hana.minusCheck)
            }
            // //// ランプ合算確率
            unitResultRatioPercent2Line(title: "ランプ合算", color: Color("grayBack"), count: $hana.bbLampCountSum, bigNumber: $hana.bigCount, numberofDicimal: 1)
            // 参考情報リンク
            unitLinkButton(title: "BIG後のフェザーランプについて", exview: AnyView(kingHanaExViewBbLamp()))
        }
    }
    
}


// /////////////////////////
// ビュー：ビッグ・横
// /////////////////////////
struct kingHanaSubAssyBigLandScape: View {
    @ObservedObject var hana: kingHanaVar
    
    var body: some View {
        // //// スイカ関連,フェザーランプ全て
        Section{
            // //// カウントボタン横並び
            HStack {
                // スイカカウントボタン
                unitCountButtonVerticalDenominate(title: "スイカ", count: $hana.bbSuikaCount, color: .green, bigNumber: $hana.bigPlayGames, numberofDicimal: 1, minusBool: $hana.minusCheck)
                // 青
                unitCountButtonVerticalPercent(title: "🪽青", count: $hana.bbLampBCount, color: .personalSummerLightBlue, bigNumber: $hana.bigCount, numberofDicimal: 1, minusBool: $hana.minusCheck)
                // 黄
                unitCountButtonVerticalPercent(title: "🪽黄", count: $hana.bbLampYCount, color: .personalSpringLightYellow, bigNumber: $hana.bigCount, numberofDicimal: 1, minusBool: $hana.minusCheck, flushColor: Color.yellow)
                // 緑
                unitCountButtonVerticalPercent(title: "🪽緑", count: $hana.bbLampGCount, color: .personalSummerLightGreen, bigNumber: $hana.bigCount, numberofDicimal: 1, minusBool: $hana.minusCheck)
                // 赤
                unitCountButtonVerticalPercent(title: "🪽赤", count: $hana.bbLampRCount, color: .personalSummerLightRed, bigNumber: $hana.bigCount, numberofDicimal: 1, minusBool: $hana.minusCheck)
            }
            // //// ランプ合算確率
            unitResultRatioPercent2Line(title: "ランプ合算", color: Color("grayBack"), count: $hana.bbLampCountSum, bigNumber: $hana.bigCount, numberofDicimal: 1)
            // スイカ確率の情報リンク
            unitLinkButton(title: "BB中のスイカについて", exview: AnyView(kingHanaExViewBbSuika()))
            // 参考情報リンク
            unitLinkButton(title: "BIG後のフェザーランプについて", exview: AnyView(kingHanaExViewBbLamp()))
        }
    }
}


// /////////////////////////
// ビュー：レギュラー・縦横共通
// /////////////////////////
struct kingHanaSubAssyRegPortrait: View {
    @ObservedObject var hana: kingHanaVar
    
    var body: some View {
        // //// サイドランプ関連
        Section {
            // カウントボタン横並び
            HStack {
                // 青
                unitCountButtonVerticalPercent(title: "ランプ青", count: $hana.rbLampBCount, color: .personalSummerLightBlue, bigNumber: $hana.rbLampCountSum, numberofDicimal: 0, minusBool: $hana.minusCheck)
                // 黄
                unitCountButtonVerticalPercent(title: "ランプ黄", count: $hana.rbLampYCount, color: .personalSpringLightYellow, bigNumber: $hana.rbLampCountSum, numberofDicimal: 0, minusBool: $hana.minusCheck, flushColor: Color.yellow)
                // 緑
                unitCountButtonVerticalPercent(title: "ランプ緑", count: $hana.rbLampGCount, color: .personalSummerLightGreen, bigNumber: $hana.rbLampCountSum, numberofDicimal: 0, minusBool: $hana.minusCheck)
                // 赤
                unitCountButtonVerticalPercent(title: "ランプ赤", count: $hana.rbLampRCount, color: .personalSummerLightRed, bigNumber: $hana.rbLampCountSum, numberofDicimal: 0, minusBool: $hana.minusCheck)
            }
            // //// 奇数・偶数確率表示
            HStack {
                // 奇数示唆
                unitResultRatioPercent2Line(title: "奇数示唆", color: .grayBack, count: $hana.rbLampKisuCountSum, bigNumber: $hana.rbLampCountSum, numberofDicimal: 0)
                // 偶数示唆
                unitResultRatioPercent2Line(title: "偶数示唆", color: .grayBack, count: $hana.rbLampGusuCountSum, bigNumber: $hana.rbLampCountSum, numberofDicimal: 0)
            }
            // サイドランプの参考情報リンク
            unitLinkButton(title: "REG中のサイドランプについて", exview: AnyView(kingHanaExViewRegLamp()))
            // フェザーランプの参考情報リンク
            unitLinkButton(title: "REG後のフェザーランプについて", exview: AnyView(kingHanaExViewAfterRegLamp()))
        }
    }
}


// /////////////////////////////
// メモリーセーブ画面
// /////////////////////////////
struct kingHanaViewSaveMemory: View {
//    @ObservedObject var hana = kingHanaVar()
//    @ObservedObject var hanaMemory1 = kingHanaMemory1()
//    @ObservedObject var hanaMemory2 = kingHanaMemory2()
//    @ObservedObject var hanaMemory3 = kingHanaMemory3()
    @ObservedObject var hana: kingHanaVar
    @ObservedObject var hanaMemory1: kingHanaMemory1
    @ObservedObject var hanaMemory2: kingHanaMemory2
    @ObservedObject var hanaMemory3: kingHanaMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "キングハナハナ",
            selectedMemory: $hana.selectedMemory,
            memoMemory1: $hanaMemory1.memo,
            dateDoubleMemory1: $hanaMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $hanaMemory2.memo,
            dateDoubleMemory2: $hanaMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $hanaMemory3.memo,
            dateDoubleMemory3: $hanaMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        hanaMemory1.bellCount = hana.bellCount
        hanaMemory1.bigCount = hana.bigCount
        hanaMemory1.regCount = hana.regCount
        hanaMemory1.bbSuikaCount = hana.bbSuikaCount
        hanaMemory1.bbLampBCount = hana.bbLampBCount
        hanaMemory1.bbLampYCount = hana.bbLampYCount
        hanaMemory1.bbLampGCount = hana.bbLampGCount
        hanaMemory1.bbLampRCount = hana.bbLampRCount
        hanaMemory1.bbLampRainbowCount = hana.bbLampRainbowCount
        hanaMemory1.rbLampBCount = hana.rbLampBCount
        hanaMemory1.rbLampYCount = hana.rbLampYCount
        hanaMemory1.rbLampGCount = hana.rbLampGCount
        hanaMemory1.rbLampRCount = hana.rbLampRCount
        hanaMemory1.rbLampRainbowCount = hana.rbLampRainbowCount
        hanaMemory1.startGames = hana.startGames
        hanaMemory1.currentGames = hana.currentGames
        hanaMemory1.totalBonus = hana.totalBonus
        hanaMemory1.playGames = hana.playGames
        hanaMemory1.bigPlayGames = hana.bigPlayGames
        hanaMemory1.bbLampCountSum = hana.bbLampCountSum
        hanaMemory1.rbLampCountSum = hana.rbLampCountSum
        hanaMemory1.rbLampKisuCountSum = hana.rbLampKisuCountSum
        hanaMemory1.rbLampGusuCountSum = hana.rbLampGusuCountSum
    }
    func saveMemory2() {
        hanaMemory2.bellCount = hana.bellCount
        hanaMemory2.bigCount = hana.bigCount
        hanaMemory2.regCount = hana.regCount
        hanaMemory2.bbSuikaCount = hana.bbSuikaCount
        hanaMemory2.bbLampBCount = hana.bbLampBCount
        hanaMemory2.bbLampYCount = hana.bbLampYCount
        hanaMemory2.bbLampGCount = hana.bbLampGCount
        hanaMemory2.bbLampRCount = hana.bbLampRCount
        hanaMemory2.bbLampRainbowCount = hana.bbLampRainbowCount
        hanaMemory2.rbLampBCount = hana.rbLampBCount
        hanaMemory2.rbLampYCount = hana.rbLampYCount
        hanaMemory2.rbLampGCount = hana.rbLampGCount
        hanaMemory2.rbLampRCount = hana.rbLampRCount
        hanaMemory2.rbLampRainbowCount = hana.rbLampRainbowCount
        hanaMemory2.startGames = hana.startGames
        hanaMemory2.currentGames = hana.currentGames
        hanaMemory2.totalBonus = hana.totalBonus
        hanaMemory2.playGames = hana.playGames
        hanaMemory2.bigPlayGames = hana.bigPlayGames
        hanaMemory2.bbLampCountSum = hana.bbLampCountSum
        hanaMemory2.rbLampCountSum = hana.rbLampCountSum
        hanaMemory2.rbLampKisuCountSum = hana.rbLampKisuCountSum
        hanaMemory2.rbLampGusuCountSum = hana.rbLampGusuCountSum
    }
    func saveMemory3() {
        hanaMemory3.bellCount = hana.bellCount
        hanaMemory3.bigCount = hana.bigCount
        hanaMemory3.regCount = hana.regCount
        hanaMemory3.bbSuikaCount = hana.bbSuikaCount
        hanaMemory3.bbLampBCount = hana.bbLampBCount
        hanaMemory3.bbLampYCount = hana.bbLampYCount
        hanaMemory3.bbLampGCount = hana.bbLampGCount
        hanaMemory3.bbLampRCount = hana.bbLampRCount
        hanaMemory3.bbLampRainbowCount = hana.bbLampRainbowCount
        hanaMemory3.rbLampBCount = hana.rbLampBCount
        hanaMemory3.rbLampYCount = hana.rbLampYCount
        hanaMemory3.rbLampGCount = hana.rbLampGCount
        hanaMemory3.rbLampRCount = hana.rbLampRCount
        hanaMemory3.rbLampRainbowCount = hana.rbLampRainbowCount
        hanaMemory3.startGames = hana.startGames
        hanaMemory3.currentGames = hana.currentGames
        hanaMemory3.totalBonus = hana.totalBonus
        hanaMemory3.playGames = hana.playGames
        hanaMemory3.bigPlayGames = hana.bigPlayGames
        hanaMemory3.bbLampCountSum = hana.bbLampCountSum
        hanaMemory3.rbLampCountSum = hana.rbLampCountSum
        hanaMemory3.rbLampKisuCountSum = hana.rbLampKisuCountSum
        hanaMemory3.rbLampGusuCountSum = hana.rbLampGusuCountSum
    }
}


// /////////////////////////////
// メモリーロード画面
// /////////////////////////////
struct kingHanaViewLoadMemory: View {
//    @ObservedObject var hana = kingHanaVar()
//    @ObservedObject var hanaMemory1 = kingHanaMemory1()
//    @ObservedObject var hanaMemory2 = kingHanaMemory2()
//    @ObservedObject var hanaMemory3 = kingHanaMemory3()
    @ObservedObject var hana: kingHanaVar
    @ObservedObject var hanaMemory1: kingHanaMemory1
    @ObservedObject var hanaMemory2: kingHanaMemory2
    @ObservedObject var hanaMemory3: kingHanaMemory3
    @State var isShowLoadAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: "キングハナハナ",
            selectedMemory: $hana.selectedMemory,
            memoMemory1: hanaMemory1.memo,
            dateDoubleMemory1: hanaMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: hanaMemory2.memo,
            dateDoubleMemory2: hanaMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: hanaMemory3.memo,
            dateDoubleMemory3: hanaMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowLoadAlert
        )
    }
    func loadMemory1() {
        hana.bellCount = hanaMemory1.bellCount
        hana.bigCount = hanaMemory1.bigCount
        hana.regCount = hanaMemory1.regCount
        hana.bbSuikaCount = hanaMemory1.bbSuikaCount
        hana.bbLampBCount = hanaMemory1.bbLampBCount
        hana.bbLampYCount = hanaMemory1.bbLampYCount
        hana.bbLampGCount = hanaMemory1.bbLampGCount
        hana.bbLampRCount = hanaMemory1.bbLampRCount
        hana.bbLampRainbowCount = hanaMemory1.bbLampRainbowCount
        hana.rbLampBCount = hanaMemory1.rbLampBCount
        hana.rbLampYCount = hanaMemory1.rbLampYCount
        hana.rbLampGCount = hanaMemory1.rbLampGCount
        hana.rbLampRCount = hanaMemory1.rbLampRCount
        hana.rbLampRainbowCount = hanaMemory1.rbLampRainbowCount
        hana.startGames = hanaMemory1.startGames
        hana.currentGames = hanaMemory1.currentGames
        hana.totalBonus = hanaMemory1.totalBonus
        hana.playGames = hanaMemory1.playGames
        hana.bigPlayGames = hanaMemory1.bigPlayGames
        hana.bbLampCountSum = hanaMemory1.bbLampCountSum
        hana.rbLampCountSum = hanaMemory1.rbLampCountSum
        hana.rbLampKisuCountSum = hanaMemory1.rbLampKisuCountSum
        hana.rbLampGusuCountSum = hanaMemory1.rbLampGusuCountSum
    }
    func loadMemory2() {
        hana.bellCount = hanaMemory2.bellCount
        hana.bigCount = hanaMemory2.bigCount
        hana.regCount = hanaMemory2.regCount
        hana.bbSuikaCount = hanaMemory2.bbSuikaCount
        hana.bbLampBCount = hanaMemory2.bbLampBCount
        hana.bbLampYCount = hanaMemory2.bbLampYCount
        hana.bbLampGCount = hanaMemory2.bbLampGCount
        hana.bbLampRCount = hanaMemory2.bbLampRCount
        hana.bbLampRainbowCount = hanaMemory2.bbLampRainbowCount
        hana.rbLampBCount = hanaMemory2.rbLampBCount
        hana.rbLampYCount = hanaMemory2.rbLampYCount
        hana.rbLampGCount = hanaMemory2.rbLampGCount
        hana.rbLampRCount = hanaMemory2.rbLampRCount
        hana.rbLampRainbowCount = hanaMemory2.rbLampRainbowCount
        hana.startGames = hanaMemory2.startGames
        hana.currentGames = hanaMemory2.currentGames
        hana.totalBonus = hanaMemory2.totalBonus
        hana.playGames = hanaMemory2.playGames
        hana.bigPlayGames = hanaMemory2.bigPlayGames
        hana.bbLampCountSum = hanaMemory2.bbLampCountSum
        hana.rbLampCountSum = hanaMemory2.rbLampCountSum
        hana.rbLampKisuCountSum = hanaMemory2.rbLampKisuCountSum
        hana.rbLampGusuCountSum = hanaMemory2.rbLampGusuCountSum
    }
    func loadMemory3() {
        hana.bellCount = hanaMemory3.bellCount
        hana.bigCount = hanaMemory3.bigCount
        hana.regCount = hanaMemory3.regCount
        hana.bbSuikaCount = hanaMemory3.bbSuikaCount
        hana.bbLampBCount = hanaMemory3.bbLampBCount
        hana.bbLampYCount = hanaMemory3.bbLampYCount
        hana.bbLampGCount = hanaMemory3.bbLampGCount
        hana.bbLampRCount = hanaMemory3.bbLampRCount
        hana.bbLampRainbowCount = hanaMemory3.bbLampRainbowCount
        hana.rbLampBCount = hanaMemory3.rbLampBCount
        hana.rbLampYCount = hanaMemory3.rbLampYCount
        hana.rbLampGCount = hanaMemory3.rbLampGCount
        hana.rbLampRCount = hanaMemory3.rbLampRCount
        hana.rbLampRainbowCount = hanaMemory3.rbLampRainbowCount
        hana.startGames = hanaMemory3.startGames
        hana.currentGames = hanaMemory3.currentGames
        hana.totalBonus = hanaMemory3.totalBonus
        hana.playGames = hanaMemory3.playGames
        hana.bigPlayGames = hanaMemory3.bigPlayGames
        hana.bbLampCountSum = hanaMemory3.bbLampCountSum
        hana.rbLampCountSum = hanaMemory3.rbLampCountSum
        hana.rbLampKisuCountSum = hanaMemory3.rbLampKisuCountSum
        hana.rbLampGusuCountSum = hanaMemory3.rbLampGusuCountSum
    }
}


#Preview {
    kingHanaViewTop()
}
