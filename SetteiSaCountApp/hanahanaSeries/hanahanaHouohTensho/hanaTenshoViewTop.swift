//
//  hanaTenshoViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/09/25.
//

import SwiftUI

class hanaTensho: ObservableObject {
    @AppStorage("hanaTenshoBellCount") var bellCount = 0
    @AppStorage("hanaTenshoBigCount") var bigCount = 0 {
        didSet {
            totalBonus = TotalBonus(big: bigCount, reg: regCount)
            bigPlayGames = BigPlayGames(big: bigCount)
        }
    }
    @AppStorage("hanaTenshoRegCount") var regCount = 0 {
        didSet {
            totalBonus = TotalBonus(big: bigCount, reg: regCount)
        }
    }
    @AppStorage("hanaTenshoBBSuikaCount") var bbSuikaCount = 0
    @AppStorage("hanaTenshoBBLampBCount") var bbLampBCount = 0 {
        didSet {
            bbLampCountSum = BbLampCountSum(bCount: bbLampBCount, yCount: bbLampYCount, gCount: bbLampGCount, rCount: bbLampRCount)
        }
    }
    @AppStorage("hanaTenshoBBLampYCount") var bbLampYCount = 0 {
        didSet {
            bbLampCountSum = BbLampCountSum(bCount: bbLampBCount, yCount: bbLampYCount, gCount: bbLampGCount, rCount: bbLampRCount)
        }
    }
    @AppStorage("hanaTenshoBBLampGCount") var bbLampGCount = 0 {
        didSet {
            bbLampCountSum = BbLampCountSum(bCount: bbLampBCount, yCount: bbLampYCount, gCount: bbLampGCount, rCount: bbLampRCount)
        }
    }
    @AppStorage("hanaTenshoBBLampRCount") var bbLampRCount = 0 {
        didSet {
            bbLampCountSum = BbLampCountSum(bCount: bbLampBCount, yCount: bbLampYCount, gCount: bbLampGCount, rCount: bbLampRCount)
        }
    }
    @AppStorage("hanaTenshoBBLampRainbowCount") var bbLampRainbowCount = 0
    @AppStorage("hanaTenshoRbLampBCount") var rbLampBCount = 0 {
        didSet {
            rbLampCountSum = RbLampCountSum(bCount: rbLampBCount, yCount: rbLampYCount, gCount: rbLampGCount, rCount: rbLampRCount)
            rbLampKisuCountSum = RbLampKisuCountSum(bCount: rbLampBCount, gCount: rbLampGCount)
        }
    }
    @AppStorage("hanaTenshoRbLampYCount") var rbLampYCount = 0 {
        didSet {
            rbLampCountSum = RbLampCountSum(bCount: rbLampBCount, yCount: rbLampYCount, gCount: rbLampGCount, rCount: rbLampRCount)
            rbLampGusuCountSum = RbLampGusuCountSum(yCount: rbLampYCount, rCount: rbLampRCount)
        }
    }
    @AppStorage("hanaTenshoRbLampGCount") var rbLampGCount = 0 {
        didSet {
            rbLampCountSum = RbLampCountSum(bCount: rbLampBCount, yCount: rbLampYCount, gCount: rbLampGCount, rCount: rbLampRCount)
            rbLampKisuCountSum = RbLampKisuCountSum(bCount: rbLampBCount, gCount: rbLampGCount)
        }
    }
    @AppStorage("hanaTenshoRbLampRCount") var rbLampRCount = 0 {
        didSet {
            rbLampCountSum = RbLampCountSum(bCount: rbLampBCount, yCount: rbLampYCount, gCount: rbLampGCount, rCount: rbLampRCount)
            rbLampGusuCountSum = RbLampGusuCountSum(yCount: rbLampYCount, rCount: rbLampRCount)
        }
    }
    @AppStorage("hanaTenshoRbLampRainbowCount") var rbLampRainbowCount = 0
    @AppStorage("hanaTenshoStartGames") var startGames = 0 {
        didSet {
            playGames = PlayGames(start: startGames, current: currentGames)
        }
    }
    @AppStorage("hanaTenshoCurrentGames") var currentGames = 0 {
        didSet {
            playGames = PlayGames(start: startGames, current: currentGames)
        }
    }
    @Published var minusCheck = false
    
    // ボーナス合算カウント
    private func TotalBonus(big:Int,reg:Int) -> Int {
        return big + reg
    }
    @AppStorage("hanaTenshoTotalBonus") var totalBonus = 0
    
    // 消化ゲーム数算出
    private func PlayGames(start:Int,current:Int) -> Int {
        let games = current - start
        return games > 0 ? games : 0
    }
    @AppStorage("hanaTenshoPlayGames") var playGames = 0
    
    // ビッグ消化ゲーム数
    private func BigPlayGames(big:Int) -> Int {
        return big * 24
    }
    @AppStorage("hanaTenshoBigPlayGames") var bigPlayGames = 0
    
    // BBランプ合計カウント
    private func BbLampCountSum(bCount:Int,yCount:Int,gCount:Int,rCount:Int) -> Int {
        return bCount + yCount + gCount + rCount
    }
    @AppStorage("hanaTenshoBbLampCountSum") var bbLampCountSum = 0
    
    // RBランプ合計カウント
    private func RbLampCountSum(bCount:Int,yCount:Int,gCount:Int,rCount:Int) -> Int {
        return bCount + yCount + gCount + rCount
    }
    @AppStorage("hanaTenshoRbLampCountSum") var rbLampCountSum = 0
    
    // RBランプ奇数示唆合計カウント
    private func RbLampKisuCountSum(bCount:Int,gCount:Int) -> Int {
        return bCount + gCount
    }
    @AppStorage("hanaTenshoRbLampKisuCountSum") var rbLampKisuCountSum = 0
    
    // RBランプ偶数示唆合計カウント
    private func RbLampGusuCountSum(yCount:Int,rCount:Int) -> Int {
        return yCount + rCount
    }
    @AppStorage("hanaTenshoRbLampGusuCountSum") var rbLampGusuCountSum = 0
    
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
    @AppStorage("hanaTenshoSelectedMemory") var selectedMemory = "メモリー1"
}


// //// メモリー1
class hanaTenshoMemory1: ObservableObject {
    @AppStorage("hanaTenshoBellCountMemory1") var bellCount = 0
    @AppStorage("hanaTenshoBigCountMemory1") var bigCount = 0
    @AppStorage("hanaTenshoRegCountMemory1") var regCount = 0
    @AppStorage("hanaTenshoBBSuikaCountMemory1") var bbSuikaCount = 0
    @AppStorage("hanaTenshoBBLampBCountMemory1") var bbLampBCount = 0
    @AppStorage("hanaTenshoBBLampYCountMemory1") var bbLampYCount = 0
    @AppStorage("hanaTenshoBBLampGCountMemory1") var bbLampGCount = 0
    @AppStorage("hanaTenshoBBLampRCountMemory1") var bbLampRCount = 0
    @AppStorage("hanaTenshoBBLampRainbowCountMemory1") var bbLampRainbowCount = 0
    @AppStorage("hanaTenshoRbLampBCountMemory1") var rbLampBCount = 0
    @AppStorage("hanaTenshoRbLampYCountMemory1") var rbLampYCount = 0
    @AppStorage("hanaTenshoRbLampGCountMemory1") var rbLampGCount = 0
    @AppStorage("hanaTenshoRbLampRCountMemory1") var rbLampRCount = 0
    @AppStorage("hanaTenshoRbLampRainbowCountMemory1") var rbLampRainbowCount = 0
    @AppStorage("hanaTenshoStartGamesMemory1") var startGames = 0
    @AppStorage("hanaTenshoCurrentGamesMemory1") var currentGames = 0
    @AppStorage("hanaTenshoTotalBonusMemory1") var totalBonus = 0
    @AppStorage("hanaTenshoPlayGamesMemory1") var playGames = 0
    @AppStorage("hanaTenshoBigPlayGamesMemory1") var bigPlayGames = 0
    @AppStorage("hanaTenshoBbLampCountSumMemory1") var bbLampCountSum = 0
    @AppStorage("hanaTenshoRbLampCountSumMemory1") var rbLampCountSum = 0
    @AppStorage("hanaTenshoRbLampKisuCountSumMemory1") var rbLampKisuCountSum = 0
    @AppStorage("hanaTenshoRbLampGusuCountSumMemory1") var rbLampGusuCountSum = 0
    @AppStorage("hanaTenshoMemoMemory1") var memo = ""
    @AppStorage("hanaTenshoDateMemory1") var dateDouble = 0.0
}

// //// メモリー2
class hanaTenshoMemory2: ObservableObject {
    @AppStorage("hanaTenshoBellCountMemory2") var bellCount = 0
    @AppStorage("hanaTenshoBigCountMemory2") var bigCount = 0
    @AppStorage("hanaTenshoRegCountMemory2") var regCount = 0
    @AppStorage("hanaTenshoBBSuikaCountMemory2") var bbSuikaCount = 0
    @AppStorage("hanaTenshoBBLampBCountMemory2") var bbLampBCount = 0
    @AppStorage("hanaTenshoBBLampYCountMemory2") var bbLampYCount = 0
    @AppStorage("hanaTenshoBBLampGCountMemory2") var bbLampGCount = 0
    @AppStorage("hanaTenshoBBLampRCountMemory2") var bbLampRCount = 0
    @AppStorage("hanaTenshoBBLampRainbowCountMemory2") var bbLampRainbowCount = 0
    @AppStorage("hanaTenshoRbLampBCountMemory2") var rbLampBCount = 0
    @AppStorage("hanaTenshoRbLampYCountMemory2") var rbLampYCount = 0
    @AppStorage("hanaTenshoRbLampGCountMemory2") var rbLampGCount = 0
    @AppStorage("hanaTenshoRbLampRCountMemory2") var rbLampRCount = 0
    @AppStorage("hanaTenshoRbLampRainbowCountMemory2") var rbLampRainbowCount = 0
    @AppStorage("hanaTenshoStartGamesMemory2") var startGames = 0
    @AppStorage("hanaTenshoCurrentGamesMemory2") var currentGames = 0
    @AppStorage("hanaTenshoTotalBonusMemory2") var totalBonus = 0
    @AppStorage("hanaTenshoPlayGamesMemory2") var playGames = 0
    @AppStorage("hanaTenshoBigPlayGamesMemory2") var bigPlayGames = 0
    @AppStorage("hanaTenshoBbLampCountSumMemory2") var bbLampCountSum = 0
    @AppStorage("hanaTenshoRbLampCountSumMemory2") var rbLampCountSum = 0
    @AppStorage("hanaTenshoRbLampKisuCountSumMemory2") var rbLampKisuCountSum = 0
    @AppStorage("hanaTenshoRbLampGusuCountSumMemory2") var rbLampGusuCountSum = 0
    @AppStorage("hanaTenshoMemoMemory2") var memo = ""
    @AppStorage("hanaTenshoDateMemory2") var dateDouble = 0.0
}

// //// メモリー3
class hanaTenshoMemory3: ObservableObject {
    @AppStorage("hanaTenshoBellCountMemory3") var bellCount = 0
    @AppStorage("hanaTenshoBigCountMemory3") var bigCount = 0
    @AppStorage("hanaTenshoRegCountMemory3") var regCount = 0
    @AppStorage("hanaTenshoBBSuikaCountMemory3") var bbSuikaCount = 0
    @AppStorage("hanaTenshoBBLampBCountMemory3") var bbLampBCount = 0
    @AppStorage("hanaTenshoBBLampYCountMemory3") var bbLampYCount = 0
    @AppStorage("hanaTenshoBBLampGCountMemory3") var bbLampGCount = 0
    @AppStorage("hanaTenshoBBLampRCountMemory3") var bbLampRCount = 0
    @AppStorage("hanaTenshoBBLampRainbowCountMemory3") var bbLampRainbowCount = 0
    @AppStorage("hanaTenshoRbLampBCountMemory3") var rbLampBCount = 0
    @AppStorage("hanaTenshoRbLampYCountMemory3") var rbLampYCount = 0
    @AppStorage("hanaTenshoRbLampGCountMemory3") var rbLampGCount = 0
    @AppStorage("hanaTenshoRbLampRCountMemory3") var rbLampRCount = 0
    @AppStorage("hanaTenshoRbLampRainbowCountMemory3") var rbLampRainbowCount = 0
    @AppStorage("hanaTenshoStartGamesMemory3") var startGames = 0
    @AppStorage("hanaTenshoCurrentGamesMemory3") var currentGames = 0
    @AppStorage("hanaTenshoTotalBonusMemory3") var totalBonus = 0
    @AppStorage("hanaTenshoPlayGamesMemory3") var playGames = 0
    @AppStorage("hanaTenshoBigPlayGamesMemory3") var bigPlayGames = 0
    @AppStorage("hanaTenshoBbLampCountSumMemory3") var bbLampCountSum = 0
    @AppStorage("hanaTenshoRbLampCountSumMemory3") var rbLampCountSum = 0
    @AppStorage("hanaTenshoRbLampKisuCountSumMemory3") var rbLampKisuCountSum = 0
    @AppStorage("hanaTenshoRbLampGusuCountSumMemory3") var rbLampGusuCountSum = 0
    @AppStorage("hanaTenshoMemoMemory3") var memo = ""
    @AppStorage("hanaTenshoDateMemory3") var dateDouble = 0.0
}


struct hanaTenshoViewTop: View {
    @ObservedObject var hana = hanaTensho()
    let displayMode = ["通常時", "BIG", "REG"]     // 機種リストの表示モード選択肢
    @State var isSelectedDisplayMode = "通常時"
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    @State var isShowAlert = false
    @FocusState var isFocused: Bool
    @State var normalClearSpaceHeight = 10.0
    @State var bigClearSpaceHeight = 250.0
    @State var regClearSpaceHeight = 200.0
    @ObservedObject var hanaMemory1 = hanaTenshoMemory1()
    @ObservedObject var hanaMemory2 = hanaTenshoMemory2()
    @ObservedObject var hanaMemory3 = hanaTenshoMemory3()
    
    var body: some View {
        ZStack {
            List {
                // //////////////////////
                // 通常時
                // //////////////////////
                if isSelectedDisplayMode == "通常時" {
                    // //// 横画面
                    if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
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
                    }
                    
                    // //// 縦画面
                    else {
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
                    }
                    // //// 参考情報リンク
                    unitLinkButton(title: "ベル,ボーナス確率", exview: AnyView(unitExView5body2image(title: "ベル・ボーナス確率", image1: Image("hanaTenshoBellBonus"))))
                    // 95%信頼区間グラフ
                    unitNaviLink95Ci(Ci95view: AnyView(hanaTenshoView95Ci(selection: 1)))
                        .popoverTip(tipUnitButtonLink95Ci())
                    // //// 縦横共通 参考情報、ゲーム数入力
                    Section {
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
                    } header: {
                        Text("ゲーム数入力")
                    }
                    unitClearScrollSectionBinding(spaceHeight: $normalClearSpaceHeight)
                }
                
                // //////////////////////
                // ビッグ
                // //////////////////////
                else if isSelectedDisplayMode == displayMode[1] {
                    // //// 横画面
                    if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
                        Section {
                            HStack {
                                // スイカカウントボタン
                                unitCountButtonVerticalDenominate(title: "スイカ", count: $hana.bbSuikaCount, color: .green, bigNumber: $hana.bigPlayGames, numberofDicimal: 1, minusBool: $hana.minusCheck)
                                // 青
                                unitCountButtonVerticalPercent(title: "🔮青", count: $hana.bbLampBCount, color: .personalSummerLightBlue, bigNumber: $hana.bigCount, numberofDicimal: 1, minusBool: $hana.minusCheck)
                                // 黄
                                unitCountButtonVerticalPercent(title: "🔮黄", count: $hana.bbLampYCount, color: .personalSpringLightYellow, bigNumber: $hana.bigCount, numberofDicimal: 1, minusBool: $hana.minusCheck, flushColor: Color.yellow)
                                // 緑
                                unitCountButtonVerticalPercent(title: "🔮緑", count: $hana.bbLampGCount, color: .personalSummerLightGreen, bigNumber: $hana.bigCount, numberofDicimal: 1, minusBool: $hana.minusCheck)
                                // 赤
                                unitCountButtonVerticalPercent(title: "🔮赤", count: $hana.bbLampRCount, color: .personalSummerLightRed, bigNumber: $hana.bigCount, numberofDicimal: 1, minusBool: $hana.minusCheck)
                            }
                            // //// ランプ合算確率
                            unitResultRatioPercent2Line(title: "ランプ合算", color: Color("grayBack"), count: $hana.bbLampCountSum, bigNumber: $hana.bigCount, numberofDicimal: 1)
                            // スイカ確率の情報リンク
                            unitLinkButton(title: "BB中のスイカについて", exview: AnyView(unitExView5body2image(title: "BIG中スイカ確率", image1:Image("hanaTenshoBbSuika"))))
                            // 参考情報リンク
                            unitLinkButton(title: "BIG後の鳳玉ランプについて", exview: AnyView(unitExView5body2image(title: "BIG後の鳳玉ランプ確率", image1:Image("hanaTenshoBigLamp"))))
                            // 95%信頼区間グラフ
                            unitNaviLink95Ci(Ci95view: AnyView(hanaTenshoView95Ci(selection: 5)))
                                .popoverTip(tipUnitButtonLink95Ci())
                        } header: {
                            Text("\nスイカ、鳳玉ランプ")
                        }
                    }
                    
                    // //// 縦画面
                    else {
                        // //// スイカ関連
                        Section{
                            // スイカカウントボタン
                            unitCountButtonVerticalDenominate(title: "スイカ", count: $hana.bbSuikaCount, color: .green, bigNumber: $hana.bigPlayGames, numberofDicimal: 1, minusBool: $hana.minusCheck)
                            // スイカ確率の情報リンク
                            unitLinkButton(title: "BB中のスイカについて", exview: AnyView(unitExView5body2image(title: "BIG中スイカ確率", image1:Image("hanaTenshoBbSuika"))))
                            // 95%信頼区間グラフ
                            unitNaviLink95Ci(Ci95view: AnyView(hanaTenshoView95Ci(selection: 5)))
                                .popoverTip(tipUnitButtonLink95Ci())
                        } header: {
                            Text("\nスイカ")
                        }
                        
                        // //// フェザーランプ関連
                        Section("鳳玉ランプ") {
                            // カウントボタン横並び
                            HStack {
                                // 青
                                unitCountButtonVerticalPercent(title: "🔮青", count: $hana.bbLampBCount, color: .personalSummerLightBlue, bigNumber: $hana.bigCount, numberofDicimal: 1, minusBool: $hana.minusCheck)
                                // 黄
                                unitCountButtonVerticalPercent(title: "🔮黄", count: $hana.bbLampYCount, color: .personalSpringLightYellow, bigNumber: $hana.bigCount, numberofDicimal: 1, minusBool: $hana.minusCheck, flushColor: Color.yellow)
                                // 緑
                                unitCountButtonVerticalPercent(title: "🔮緑", count: $hana.bbLampGCount, color: .personalSummerLightGreen, bigNumber: $hana.bigCount, numberofDicimal: 1, minusBool: $hana.minusCheck)
                                // 赤
                                unitCountButtonVerticalPercent(title: "🔮赤", count: $hana.bbLampRCount, color: .personalSummerLightRed, bigNumber: $hana.bigCount, numberofDicimal: 1, minusBool: $hana.minusCheck)
                            }
                            // //// ランプ合算確率
                            unitResultRatioPercent2Line(title: "ランプ合算", color: Color("grayBack"), count: $hana.bbLampCountSum, bigNumber: $hana.bigCount, numberofDicimal: 1)
                            // 参考情報リンク
                            unitLinkButton(title: "BIG後の鳳玉ランプについて", exview: AnyView(unitExView5body2image(title: "BIG後の鳳玉ランプ確率", image1:Image("hanaTenshoBigLamp"))))
                            // 95%信頼区間グラフ
                            unitNaviLink95Ci(Ci95view: AnyView(hanaTenshoView95Ci(selection: 6)))
                                .popoverTip(tipUnitButtonLink95Ci())
                        }
                    }
                    unitClearScrollSectionBinding(spaceHeight: $bigClearSpaceHeight)
                }
                
                // //////////////////////
                // レギュラー
                // //////////////////////
                else {
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
                        unitLinkButton(title: "REG中のサイドランプについて", exview: AnyView(unitExView5body2image(title: "REG中のサイドランプ確率", textBody1: "・REG中に1回だけ確認可能", textBody2: "・左リール中段に白７ビタ押し", textBody3: "　成功したら中・右にスイカを狙う", textBody4: "・奇数設定は青・緑が６割、偶数は黄・赤が６割。\n　ただし、設定６のみ全色均等に出現する", image1: Image("hanaTenshoRegSideLamp"))))
                        // フェザーランプの参考情報リンク
                        unitLinkButton(title: "REG後の鳳玉ランプについて", exview: AnyView(unitExView5body2image(title: "REG後の鳳玉ランプ確率", textBody1: "・色によって設定を否定", image1: Image("hanaTenshoRegTopLamp"))))
                        // 95%信頼区間グラフ
                        unitNaviLink95Ci(Ci95view: AnyView(hanaTenshoView95Ci(selection: 7)))
                            .popoverTip(tipUnitButtonLink95Ci())
                    } header: {
                        Text("\nサイドランプ")
                    }
                    unitClearScrollSectionBinding(spaceHeight: $regClearSpaceHeight)
                }
            }
            
            // //////////////////////
            // //// モード選択
            // //////////////////////
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
            if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
                self.normalClearSpaceHeight = 0
                self.bigClearSpaceHeight = 0
                self.regClearSpaceHeight = 0
            } else {
                self.normalClearSpaceHeight = 10.0
                self.bigClearSpaceHeight = 250.0
                self.regClearSpaceHeight = 200.0
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
                    self.normalClearSpaceHeight = 0
                    self.bigClearSpaceHeight = 0
                    self.regClearSpaceHeight = 0
                } else {
                    self.normalClearSpaceHeight = 10.0
                    self.bigClearSpaceHeight = 250.0
                    self.regClearSpaceHeight = 200.0
                }
            }
        }
        .onDisappear {
            // ビューが非表示になるときに監視を解除
            NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
        }
        .navigationTitle("ハナハナ鳳凰天翔")
        .navigationBarTitleDisplayMode(.inline)
        
        // //// ツールバーボタン
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    HStack {
                        // //// データ読み出し
                        unitButtonLoadMemory(loadView: AnyView(hanaTenshoViewLoadMemory(hana: hana, hanaMemory1: hanaMemory1, hanaMemory2: hanaMemory2, hanaMemory3: hanaMemory3)))
                        // //// データ保存
                        unitButtonSaveMemory(saveView: AnyView(hanaTenshoViewSaveMemory(hana: hana, hanaMemory1: hanaMemory1, hanaMemory2: hanaMemory2, hanaMemory3: hanaMemory3)))
                    }
                    .popoverTip(tipUnitButtonMemory())
                    // マイナスボタン
                    unitButtonMinusCheck(minusCheck: $hana.minusCheck)
                    // データリセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: hana.hanaReset, message: "この機種の全データをリセットします")
//                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}


// /////////////////////////////
// メモリーセーブ画面
// /////////////////////////////
struct hanaTenshoViewSaveMemory: View {
    @ObservedObject var hana: hanaTensho
    @ObservedObject var hanaMemory1: hanaTenshoMemory1
    @ObservedObject var hanaMemory2: hanaTenshoMemory2
    @ObservedObject var hanaMemory3: hanaTenshoMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "ハナハナ鳳凰天翔",
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
struct hanaTenshoViewLoadMemory: View {
    @ObservedObject var hana: hanaTensho
    @ObservedObject var hanaMemory1: hanaTenshoMemory1
    @ObservedObject var hanaMemory2: hanaTenshoMemory2
    @ObservedObject var hanaMemory3: hanaTenshoMemory3
    @State var isShowLoadAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: "ハナハナ鳳凰天翔",
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
    hanaTenshoViewTop()
}
