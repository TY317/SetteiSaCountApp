//
//  draHanaSenkohViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/16.
//

import SwiftUI


// /////////////////////
// 変数
// /////////////////////
//protocol hanaVar {
//    var bellCount: Int { get set }
//    var bigCount: Int { get set }
//    var regCount: Int {get set }
//    var bbSuikaCount: Int {get set }
//    var bbLampBCount: Int { get set }
//    var bbLampYCount: Int { get set }
//    var bbLampGCount: Int { get set }
//    var bbLampRCount: Int { get set }
//    var bbLampRainbowCount: Int { get set }
//    var rbLampBCount: Int { get set }
//    var rbLampYCount: Int { get set }
//    var rbLampGCount: Int { get set }
//    var rbLampRCount: Int { get set }
//    var rbLampRainbowCount: Int { get set }
//    
//    func hanaReset()
//}

class draHanaSenkohVar: ObservableObject, hanaVar {
    @AppStorage("draHanaSenkohBellCount") var bellCount = 0
    @AppStorage("draHanaSenkohBigCount") var bigCount = 0 {
        didSet {
            totalBonus = TotalBonus(big: bigCount, reg: regCount)
            bigPlayGames = BigPlayGames(big: bigCount)
        }
    }
    @AppStorage("draHanaSenkohRegCount") var regCount = 0 {
        didSet {
            totalBonus = TotalBonus(big: bigCount, reg: regCount)
        }
    }
    @AppStorage("draHanaSenkohBBSuikaCount") var bbSuikaCount = 0
    @AppStorage("draHanaSenkohBBLampBCount") var bbLampBCount = 0 {
        didSet {
            bbLampCountSum = BbLampCountSum(bCount: bbLampBCount, yCount: bbLampYCount, gCount: bbLampGCount, rCount: bbLampRCount)
        }
    }
    @AppStorage("draHanaSenkohBBLampYCount") var bbLampYCount = 0 {
        didSet {
            bbLampCountSum = BbLampCountSum(bCount: bbLampBCount, yCount: bbLampYCount, gCount: bbLampGCount, rCount: bbLampRCount)
        }
    }
    @AppStorage("draHanaSenkohBBLampGCount") var bbLampGCount = 0 {
        didSet {
            bbLampCountSum = BbLampCountSum(bCount: bbLampBCount, yCount: bbLampYCount, gCount: bbLampGCount, rCount: bbLampRCount)
        }
    }
    @AppStorage("draHanaSenkohBBLampRCount") var bbLampRCount = 0 {
        didSet {
            bbLampCountSum = BbLampCountSum(bCount: bbLampBCount, yCount: bbLampYCount, gCount: bbLampGCount, rCount: bbLampRCount)
        }
    }
    @AppStorage("draHanaSenkohBBLampRainbowCount") var bbLampRainbowCount = 0
    @AppStorage("draHanaSenkohRbLampBCount") var rbLampBCount = 0 {
        didSet {
            rbLampCountSum = RbLampCountSum(bCount: rbLampBCount, yCount: rbLampYCount, gCount: rbLampGCount, rCount: rbLampRCount)
            rbLampKisuCountSum = RbLampKisuCountSum(bCount: rbLampBCount, gCount: rbLampGCount)
        }
    }
    @AppStorage("draHanaSenkohRbLampYCount") var rbLampYCount = 0 {
        didSet {
            rbLampCountSum = RbLampCountSum(bCount: rbLampBCount, yCount: rbLampYCount, gCount: rbLampGCount, rCount: rbLampRCount)
            rbLampGusuCountSum = RbLampGusuCountSum(yCount: rbLampYCount, rCount: rbLampRCount)
        }
    }
    @AppStorage("draHanaSenkohRbLampGCount") var rbLampGCount = 0 {
        didSet {
            rbLampCountSum = RbLampCountSum(bCount: rbLampBCount, yCount: rbLampYCount, gCount: rbLampGCount, rCount: rbLampRCount)
            rbLampKisuCountSum = RbLampKisuCountSum(bCount: rbLampBCount, gCount: rbLampGCount)
        }
    }
    @AppStorage("draHanaSenkohRbLampRCount") var rbLampRCount = 0 {
        didSet {
            rbLampCountSum = RbLampCountSum(bCount: rbLampBCount, yCount: rbLampYCount, gCount: rbLampGCount, rCount: rbLampRCount)
            rbLampGusuCountSum = RbLampGusuCountSum(yCount: rbLampYCount, rCount: rbLampRCount)
        }
    }
    @AppStorage("draHanaSenkohRbLampRainbowCount") var rbLampRainbowCount = 0
    @AppStorage("draHanaSenkohStartGames") var startGames = 0 {
        didSet {
            playGames = PlayGames(start: startGames, current: currentGames)
        }
    }
    @AppStorage("draHanaSenkohCurrentGames") var currentGames = 0 {
        didSet {
            playGames = PlayGames(start: startGames, current: currentGames)
        }
    }
    @Published var minusCheck = false
    
    // ボーナス合算カウント
    private func TotalBonus(big:Int,reg:Int) -> Int {
        return big + reg
    }
    @AppStorage("draHanaSenkohTotalBonus") var totalBonus = 0
    
    // 消化ゲーム数算出
    private func PlayGames(start:Int,current:Int) -> Int {
        let games = current - start
        return games > 0 ? games : 0
    }
    @AppStorage("draHanaSenkohPlayGames") var playGames = 0
    
    // ビッグ消化ゲーム数
    private func BigPlayGames(big:Int) -> Int {
        return big * 21
    }
    @AppStorage("draHanaSenkohBigPlayGames") var bigPlayGames = 0
    
    // BBランプ合計カウント
    private func BbLampCountSum(bCount:Int,yCount:Int,gCount:Int,rCount:Int) -> Int {
        return bCount + yCount + gCount + rCount
    }
    @AppStorage("draHanaSenkohBbLampCountSum") var bbLampCountSum = 0
    
    // RBランプ合計カウント
    private func RbLampCountSum(bCount:Int,yCount:Int,gCount:Int,rCount:Int) -> Int {
        return bCount + yCount + gCount + rCount
    }
    @AppStorage("draHanaSenkohRbLampCountSum") var rbLampCountSum = 0
    
    // RBランプ奇数示唆合計カウント
    private func RbLampKisuCountSum(bCount:Int,gCount:Int) -> Int {
        return bCount + gCount
    }
    @AppStorage("draHanaSenkohRbLampKisuCountSum") var rbLampKisuCountSum = 0
    
    // RBランプ偶数示唆合計カウント
    private func RbLampGusuCountSum(yCount:Int,rCount:Int) -> Int {
        return yCount + rCount
    }
    @AppStorage("draHanaSenkohRbLampGusuCountSum") var rbLampGusuCountSum = 0
    
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
    @AppStorage("draHanaSenkohSelectedMemory") var selectedMemory = "メモリー1"
    
}


// //// メモリー1
class draHanaSenkohMemory1: ObservableObject {
    @AppStorage("draHanaSenkohBellCountMemory1") var bellCount = 0
    @AppStorage("draHanaSenkohBigCountMemory1") var bigCount = 0
    @AppStorage("draHanaSenkohRegCountMemory1") var regCount = 0
    @AppStorage("draHanaSenkohBBSuikaCountMemory1") var bbSuikaCount = 0
    @AppStorage("draHanaSenkohBBLampBCountMemory1") var bbLampBCount = 0
    @AppStorage("draHanaSenkohBBLampYCountMemory1") var bbLampYCount = 0
    @AppStorage("draHanaSenkohBBLampGCountMemory1") var bbLampGCount = 0
    @AppStorage("draHanaSenkohBBLampRCountMemory1") var bbLampRCount = 0
    @AppStorage("draHanaSenkohBBLampRainbowCountMemory1") var bbLampRainbowCount = 0
    @AppStorage("draHanaSenkohRbLampBCountMemory1") var rbLampBCount = 0
    @AppStorage("draHanaSenkohRbLampYCountMemory1") var rbLampYCount = 0
    @AppStorage("draHanaSenkohRbLampGCountMemory1") var rbLampGCount = 0
    @AppStorage("draHanaSenkohRbLampRCountMemory1") var rbLampRCount = 0
    @AppStorage("draHanaSenkohRbLampRainbowCountMemory1") var rbLampRainbowCount = 0
    @AppStorage("draHanaSenkohStartGamesMemory1") var startGames = 0
    @AppStorage("draHanaSenkohCurrentGamesMemory1") var currentGames = 0
    @AppStorage("draHanaSenkohTotalBonusMemory1") var totalBonus = 0
    @AppStorage("draHanaSenkohPlayGamesMemory1") var playGames = 0
    @AppStorage("draHanaSenkohBigPlayGamesMemory1") var bigPlayGames = 0
    @AppStorage("draHanaSenkohBbLampCountSumMemory1") var bbLampCountSum = 0
    @AppStorage("draHanaSenkohRbLampCountSumMemory1") var rbLampCountSum = 0
    @AppStorage("draHanaSenkohRbLampKisuCountSumMemory1") var rbLampKisuCountSum = 0
    @AppStorage("draHanaSenkohRbLampGusuCountSumMemory1") var rbLampGusuCountSum = 0
    @AppStorage("draHanaSenkohMemoMemory1") var memo = ""
    @AppStorage("draHanaSenkohDateMemory1") var dateDouble = 0.0
}

// //// メモリー2
class draHanaSenkohMemory2: ObservableObject {
    @AppStorage("draHanaSenkohBellCountMemory2") var bellCount = 0
    @AppStorage("draHanaSenkohBigCountMemory2") var bigCount = 0
    @AppStorage("draHanaSenkohRegCountMemory2") var regCount = 0
    @AppStorage("draHanaSenkohBBSuikaCountMemory2") var bbSuikaCount = 0
    @AppStorage("draHanaSenkohBBLampBCountMemory2") var bbLampBCount = 0
    @AppStorage("draHanaSenkohBBLampYCountMemory2") var bbLampYCount = 0
    @AppStorage("draHanaSenkohBBLampGCountMemory2") var bbLampGCount = 0
    @AppStorage("draHanaSenkohBBLampRCountMemory2") var bbLampRCount = 0
    @AppStorage("draHanaSenkohBBLampRainbowCountMemory2") var bbLampRainbowCount = 0
    @AppStorage("draHanaSenkohRbLampBCountMemory2") var rbLampBCount = 0
    @AppStorage("draHanaSenkohRbLampYCountMemory2") var rbLampYCount = 0
    @AppStorage("draHanaSenkohRbLampGCountMemory2") var rbLampGCount = 0
    @AppStorage("draHanaSenkohRbLampRCountMemory2") var rbLampRCount = 0
    @AppStorage("draHanaSenkohRbLampRainbowCountMemory2") var rbLampRainbowCount = 0
    @AppStorage("draHanaSenkohStartGamesMemory2") var startGames = 0
    @AppStorage("draHanaSenkohCurrentGamesMemory2") var currentGames = 0
    @AppStorage("draHanaSenkohTotalBonusMemory2") var totalBonus = 0
    @AppStorage("draHanaSenkohPlayGamesMemory2") var playGames = 0
    @AppStorage("draHanaSenkohBigPlayGamesMemory2") var bigPlayGames = 0
    @AppStorage("draHanaSenkohBbLampCountSumMemory2") var bbLampCountSum = 0
    @AppStorage("draHanaSenkohRbLampCountSumMemory2") var rbLampCountSum = 0
    @AppStorage("draHanaSenkohRbLampKisuCountSumMemory2") var rbLampKisuCountSum = 0
    @AppStorage("draHanaSenkohRbLampGusuCountSumMemory2") var rbLampGusuCountSum = 0
    @AppStorage("draHanaSenkohMemoMemory2") var memo = ""
    @AppStorage("draHanaSenkohDateMemory2") var dateDouble = 0.0
}

// //// メモリー3
class draHanaSenkohMemory3: ObservableObject {
    @AppStorage("draHanaSenkohBellCountMemory3") var bellCount = 0
    @AppStorage("draHanaSenkohBigCountMemory3") var bigCount = 0
    @AppStorage("draHanaSenkohRegCountMemory3") var regCount = 0
    @AppStorage("draHanaSenkohBBSuikaCountMemory3") var bbSuikaCount = 0
    @AppStorage("draHanaSenkohBBLampBCountMemory3") var bbLampBCount = 0
    @AppStorage("draHanaSenkohBBLampYCountMemory3") var bbLampYCount = 0
    @AppStorage("draHanaSenkohBBLampGCountMemory3") var bbLampGCount = 0
    @AppStorage("draHanaSenkohBBLampRCountMemory3") var bbLampRCount = 0
    @AppStorage("draHanaSenkohBBLampRainbowCountMemory3") var bbLampRainbowCount = 0
    @AppStorage("draHanaSenkohRbLampBCountMemory3") var rbLampBCount = 0
    @AppStorage("draHanaSenkohRbLampYCountMemory3") var rbLampYCount = 0
    @AppStorage("draHanaSenkohRbLampGCountMemory3") var rbLampGCount = 0
    @AppStorage("draHanaSenkohRbLampRCountMemory3") var rbLampRCount = 0
    @AppStorage("draHanaSenkohRbLampRainbowCountMemory3") var rbLampRainbowCount = 0
    @AppStorage("draHanaSenkohStartGamesMemory3") var startGames = 0
    @AppStorage("draHanaSenkohCurrentGamesMemory3") var currentGames = 0
    @AppStorage("draHanaSenkohTotalBonusMemory3") var totalBonus = 0
    @AppStorage("draHanaSenkohPlayGamesMemory3") var playGames = 0
    @AppStorage("draHanaSenkohBigPlayGamesMemory3") var bigPlayGames = 0
    @AppStorage("draHanaSenkohBbLampCountSumMemory3") var bbLampCountSum = 0
    @AppStorage("draHanaSenkohRbLampCountSumMemory3") var rbLampCountSum = 0
    @AppStorage("draHanaSenkohRbLampKisuCountSumMemory3") var rbLampKisuCountSum = 0
    @AppStorage("draHanaSenkohRbLampGusuCountSumMemory3") var rbLampGusuCountSum = 0
    @AppStorage("draHanaSenkohMemoMemory3") var memo = ""
    @AppStorage("draHanaSenkohDateMemory3") var dateDouble = 0.0
}


// /////////////////////
// ビュー：メインビュー
// /////////////////////
struct draHanaSenkohViewTop: View {
    @ObservedObject var hana = draHanaSenkohVar()
    @ObservedObject var hanaMemory1 = draHanaSenkohMemory1()
    @ObservedObject var hanaMemory2 = draHanaSenkohMemory2()
    @ObservedObject var hanaMemory3 = draHanaSenkohMemory3()
    let displayMode = ["通常時", "BIG", "REG"]     // 機種リストの表示モード選択肢
    @State var isSelectedDisplayMode = "通常時"
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    @State var isShowAlert = false
    @FocusState var isFocused: Bool
    
    var body: some View {
//        NavigationView {
            ZStack {
                List {
                    // //// 通常時
                    if isSelectedDisplayMode == "通常時" {
                        // 縦向き
                        if orientation.isPortrait || (orientation.isFlat && lastOrientation.isPortrait) {
                            draHanaSenkohSubAssyNormalPortraitCountSection(hana: hana)
                        }
                        // 横向き
//                        else if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
                        else {
                            draHanaSenkohSubAssyNormalLandScapeCountSection(hana: hana)
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
                            draHanaSenkohSubAssyBigPortrait(hana: hana)
                            unitClearScrollSection(spaceHeight: 240)
                        }
                        
                        // //// 横向き
//                        else if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
                        else {
                            draHanaSenkohSubAssyBigLandScape(hana: hana)
                        }
                    }
                    
                    // //// レギュラー
                    else if isSelectedDisplayMode == "REG" {
                        draHanaSenkohSubAssyRegPortrait(hana: hana)
                    }
                }
                
                // //// モード選択
                VStack {
                    Picker("", selection: $isSelectedDisplayMode) {
                        ForEach(displayMode, id: \.self) { mode in
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
            .navigationTitle("ドラゴンハナハナ閃光")
            .navigationBarTitleDisplayMode(.inline)
            
            // //// ツールバーボタン
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    HStack {
                        HStack {
                            // //// データ読み出し
                            unitButtonLoadMemory(loadView: AnyView(draHanaSenkohViewLoadMemory(hana: hana, hanaMemory1: hanaMemory1, hanaMemory2: hanaMemory2, hanaMemory3: hanaMemory3)))
                            // //// データ保存
                            unitButtonSaveMemory(saveView: AnyView(draHanaSenkohViewSaveMemory(hana: hana, hanaMemory1: hanaMemory1, hanaMemory2: hanaMemory2, hanaMemory3: hanaMemory3)))
                        }
//                        .popoverTip(tipUnitButtonMemory())
                        // マイナスボタン
                        unitButtonMinusCheck(minusCheck: $hana.minusCheck)
                        // データリセットボタン
                        unitButtonReset(isShowAlert: $isShowAlert, action: hana.hanaReset, message: "この機種の全データをリセットします")
//                            .popoverTip(tipUnitButtonReset())
                    }
                }
            }
//        }
//        .navigationTitle("ドラゴンハナハナ閃光")
//        .navigationBarTitleDisplayMode(.inline)
//        
//        // //// ツールバーボタン
//        .toolbar {
//            ToolbarItem(placement: .automatic) {
//                HStack {
//                    // マイナスボタン
//                    unitButtonMinusCheck(minusCheck: $hana.minusCheck)
//                    // データリセットボタン
//                    unitButtonReset(isShowAlert: $isShowAlert, action: hana.hanaReset, message: "この機種の全データをリセットします")
//                }
//            }
//        }
    }
}

// //////////////////////////
// ビュー：通常時・縦・カウント部分
// //////////////////////////
struct draHanaSenkohSubAssyNormalPortraitCountSection: View {
//    @ObservedObject var hana = kingHanaVar()
    @ObservedObject var hana: draHanaSenkohVar
    
    var body: some View {
        ZStack {
            // //// カウントボタン横並び
            HStack {
                // ベル　カウントボタン
                unitCountButtonVerticalDenominate(title: "ベル", count: $hana.bellCount, color: Color("personalSpringLightYellow"), bigNumber: $hana.playGames, numberofDicimal: 2, minusBool: $hana.minusCheck, flushColor: Color.yellow, flushBool: true)
                // ビッグ　カウントボタン
                unitCountButtonVerticalDenominate(title: "BIG", count: $hana.bigCount, color: Color("personalSummerLightRed"), bigNumber: $hana.playGames, numberofDicimal: 0, minusBool: $hana.minusCheck, flushBool: true)
                // レギュラー　カウントボタン
                unitCountButtonVerticalDenominate(title: "REG", count: $hana.regCount, color: Color("personalSummerLightPurple"), bigNumber: $hana.playGames, numberofDicimal: 0, minusBool: $hana.minusCheck, flushBool: true)
            }
        }
        // ボーナス合算確率
        unitResultRatioDenomination2Line(title: "ボーナス合算", color: Color("grayBack"), count: $hana.totalBonus, bigNumber: $hana.playGames, numberofDicimal: 0)
        // ベル確率・ボーナス確率の参考情報リンク
        unitLinkButton(title: "ベル,ボーナス確率", exview: AnyView(draHanaSenkohExViewBellBonus()))
//        Stepper("\(hana.currentGames)", value: $hana.currentGames, step: 100)
        // 95%信頼区間グラフ
        unitNaviLink95Ci(Ci95view: AnyView(draHanaSenkohView95Ci(selection: 1)))
//            .popoverTip(tipUnitButtonLink95Ci())
    }
}


// //////////////////////////
// ビュー：通常時・横・カウント部分
// //////////////////////////
struct draHanaSenkohSubAssyNormalLandScapeCountSection: View {
//    @ObservedObject var hana = kingHanaVar()
    @ObservedObject var hana: draHanaSenkohVar
    
    var body: some View {
        ZStack {
            // //// ボタン・表示部分
            HStack {
                // ベル　カウントボタン
                unitCountButtonVerticalDenominate(title: "ベル", count: $hana.bellCount, color: Color("personalSpringLightYellow"), bigNumber: $hana.playGames, numberofDicimal: 2, minusBool: $hana.minusCheck, flushColor: Color.yellow, flushBool: true)
                // ビッグ　カウントボタン
                unitCountButtonVerticalDenominate(title: "BIG", count: $hana.bigCount, color: Color("personalSummerLightRed"), bigNumber: $hana.playGames, numberofDicimal: 0, minusBool: $hana.minusCheck, flushBool: true)
                // レギュラー　カウントボタン
                unitCountButtonVerticalDenominate(title: "REG", count: $hana.regCount, color: Color("personalSummerLightPurple"), bigNumber: $hana.playGames, numberofDicimal: 0, minusBool: $hana.minusCheck, flushBool: true)
                // ボーナス合算確率
                unitResultRatioDenomination2Line(title: "ボーナス合算", color: Color("grayBack"), count: $hana.totalBonus, bigNumber: $hana.playGames, numberofDicimal: 0)
                    .padding(.vertical)
            }
        }
        // ベル確率・ボーナス確率の参考情報リンク
        unitLinkButton(title: "ベル,ボーナス確率", exview: AnyView(draHanaSenkohExViewBellBonus()))
//        Stepper("\(hana.currentGames)", value: $hana.currentGames, step: 100)
        // 95%信頼区間グラフ
        unitNaviLink95Ci(Ci95view: AnyView(draHanaSenkohView95Ci(selection: 1)))
//            .popoverTip(tipUnitButtonLink95Ci())
    }
}


// /////////////////////////////
// ビュー：参考情報：ベル・ボーナス確率
// /////////////////////////////
struct draHanaSenkohExViewBellBonus: View {
    var body: some View {
        unitExView5body2image(title: "ベル・ボーナス確率", image1: Image("draHanaSenkohBellBonusAnalysis"))
    }
}

// /////////////////////////
// ビュー：ビッグ・縦
// /////////////////////////
struct draHanaSenkohSubAssyBigPortrait: View {
    @ObservedObject var hana: draHanaSenkohVar
    
    var body: some View {
        // //// スイカ関連
        Section{
            // スイカカウントボタン
            unitCountButtonVerticalDenominate(title: "スイカ", count: $hana.bbSuikaCount, color: .green, bigNumber: $hana.bigPlayGames, numberofDicimal: 1, minusBool: $hana.minusCheck)
            // スイカ確率の情報リンク
            unitLinkButton(title: "BB中のスイカについて", exview: AnyView(draHanaExViewBigSuika()))
            // 95%信頼区間グラフ
            unitNaviLink95Ci(Ci95view: AnyView(draHanaSenkohView95Ci(selection: 5)))
//                .popoverTip(tipUnitButtonLink95Ci())
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
            unitLinkButton(title: "BIG後のフェザーランプについて", exview: AnyView(draHanaExViewBigLamp()))
            // 95%信頼区間グラフ
            unitNaviLink95Ci(Ci95view: AnyView(draHanaSenkohView95Ci(selection: 6)))
//                .popoverTip(tipUnitButtonLink95Ci())
        }
    }
    
}


// /////////////////////////
// ビュー：ビッグ・横
// /////////////////////////
struct draHanaSenkohSubAssyBigLandScape: View {
    @ObservedObject var hana: draHanaSenkohVar
    
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
            unitLinkButton(title: "BB中のスイカについて", exview: AnyView(draHanaExViewBigSuika()))
            // 参考情報リンク
            unitLinkButton(title: "BIG後のフェザーランプについて", exview: AnyView(draHanaExViewBigLamp()))
            // 95%信頼区間グラフ
            unitNaviLink95Ci(Ci95view: AnyView(draHanaSenkohView95Ci(selection: 5)))
//                .popoverTip(tipUnitButtonLink95Ci())
        }
    }
}


// /////////////////////////
// ビュー：参考情報：BB中のスイカ
// /////////////////////////
struct draHanaExViewBigSuika: View {
    var body: some View {
        unitExView5body2image(title: "BIG中スイカ確率", image1Title: "[参考] キングハナハナの数値", image1: Image("draHanaBigSuikaAnalysis"))
    }
}


// ////////////////////////
// ビュー：参考情報：BIG後のフェザーランプ
// ////////////////////////
struct draHanaExViewBigLamp: View {
    var body: some View {
        unitExView5body2image(title: "BIG後のフェザーランプ確率", image1Title: "[参考] キングハナハナの数値", image1: Image("kingHanaBigLampAnalysis"))
    }
}

// /////////////////////////
// ビュー：レギュラー・縦横共通
// /////////////////////////
struct draHanaSenkohSubAssyRegPortrait: View {
    @ObservedObject var hana: draHanaSenkohVar
    
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
            unitLinkButton(title: "REG中のサイドランプについて", exview: AnyView(draHanaExViewRegSideLamp()))
            // フェザーランプの参考情報リンク
            unitLinkButton(title: "REG後のフェザーランプについて", exview: AnyView(draHanaExViewRegAfterLamp()))
            // 95%信頼区間グラフ
            unitNaviLink95Ci(Ci95view: AnyView(draHanaSenkohView95Ci(selection: 7)))
//                .popoverTip(tipUnitButtonLink95Ci())
        }
    }
}


// /////////////////////////
// ビュー：REG中のサイドランプ
// /////////////////////////
struct draHanaExViewRegSideLamp: View {
    var body: some View {
        unitExView5body2image(title: "REG中のサイドランプ確率", textBody1: "・REG中に1回だけ確認可能", textBody2: "・左リール中段に白７ビタ押し", textBody3: "　成功したら中・右にスイカを狙う", textBody4: "・奇数設定は青・緑が６割、偶数は黄・赤が６割。\n　ただし、設定６のみ全色均等に出現する", image1Title: "[参考] キングハナハナの数値", image1: Image("kingHanaRegLampAnalysis"))
    }
}


// ////////////////////////
// ビュー：REG後のフェザーランプ
// ////////////////////////
struct draHanaExViewRegAfterLamp: View {
    var body: some View {
        unitExView5body2image(title: "REG後のフェザーランプ確率", textBody1: "・色によって設定を否定", image1Title: "[参考] キングハナハナの数値", image1: Image("kingHanaAfterRegLampAnalysis"))
    }
}


// /////////////////////////////
// メモリーセーブ画面
// /////////////////////////////
struct draHanaSenkohViewSaveMemory: View {
    @ObservedObject var hana: draHanaSenkohVar
    @ObservedObject var hanaMemory1: draHanaSenkohMemory1
    @ObservedObject var hanaMemory2: draHanaSenkohMemory2
    @ObservedObject var hanaMemory3: draHanaSenkohMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "ドラゴンハナハナ閃光",
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
struct draHanaSenkohViewLoadMemory: View {
    @ObservedObject var hana: draHanaSenkohVar
    @ObservedObject var hanaMemory1: draHanaSenkohMemory1
    @ObservedObject var hanaMemory2: draHanaSenkohMemory2
    @ObservedObject var hanaMemory3: draHanaSenkohMemory3
    @State var isShowLoadAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: "ドラゴンハナハナ閃光",
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
    draHanaSenkohViewTop()
}
