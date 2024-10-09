//
//  hanaTenshoViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/09/25.
//

import SwiftUI

class hanaTensho: ObservableObject, hanaVar {
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
                            unitCountButtonVerticalDenominate(title: "ベル", count: $hana.bellCount, color: Color("personalSpringLightYellow"), bigNumber: $hana.playGames, numberofDicimal: 2, minusBool: $hana.minusCheck)
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
                            unitCountButtonVerticalDenominate(title: "ベル", count: $hana.bellCount, color: Color("personalSpringLightYellow"), bigNumber: $hana.playGames, numberofDicimal: 2, minusBool: $hana.minusCheck)
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
                                unitCountButtonVerticalPercent(title: "🔮黄", count: $hana.bbLampYCount, color: .personalSpringLightYellow, bigNumber: $hana.bigCount, numberofDicimal: 1, minusBool: $hana.minusCheck)
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
                                unitCountButtonVerticalPercent(title: "🔮黄", count: $hana.bbLampYCount, color: .personalSpringLightYellow, bigNumber: $hana.bigCount, numberofDicimal: 1, minusBool: $hana.minusCheck)
                                // 緑
                                unitCountButtonVerticalPercent(title: "🔮緑", count: $hana.bbLampGCount, color: .personalSummerLightGreen, bigNumber: $hana.bigCount, numberofDicimal: 1, minusBool: $hana.minusCheck)
                                // 赤
                                unitCountButtonVerticalPercent(title: "🔮赤", count: $hana.bbLampRCount, color: .personalSummerLightRed, bigNumber: $hana.bigCount, numberofDicimal: 1, minusBool: $hana.minusCheck)
                            }
                            // //// ランプ合算確率
                            unitResultRatioPercent2Line(title: "ランプ合算", color: Color("grayBack"), count: $hana.bbLampCountSum, bigNumber: $hana.bigCount, numberofDicimal: 1)
                            // 参考情報リンク
                            unitLinkButton(title: "BIG後の鳳玉ランプについて", exview: AnyView(unitExView5body2image(title: "BIG後の鳳玉ランプ確率", image1:Image("hanaTenshoBigLamp"))))
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
                            unitCountButtonVerticalPercent(title: "ランプ黄", count: $hana.rbLampYCount, color: .personalSpringLightYellow, bigNumber: $hana.rbLampCountSum, numberofDicimal: 0, minusBool: $hana.minusCheck)
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
                    // マイナスボタン
                    unitButtonMinusCheck(minusCheck: $hana.minusCheck)
                    // データリセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: hana.hanaReset, message: "この機種の全データをリセットします")
                }
            }
        }
    }
}

#Preview {
    hanaTenshoViewTop()
}
