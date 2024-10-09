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
        return big * 24
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
                        // マイナスボタン
                        unitButtonMinusCheck(minusCheck: $hana.minusCheck)
                        // データリセットボタン
                        unitButtonReset(isShowAlert: $isShowAlert, action: hana.hanaReset, message: "この機種の全データをリセットします")
                    }
                }
            }
//        }
//        .navigationTitle("キングハナハナ")
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
struct kingHanaSubAssyNormalPortraitCountSection: View {
//    @ObservedObject var hana = kingHanaVar()
    @ObservedObject var hana: kingHanaVar
    
    var body: some View {
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
            unitCountButtonVerticalDenominate(title: "ベル", count: $hana.bellCount, color: Color("personalSpringLightYellow"), bigNumber: $hana.playGames, numberofDicimal: 2, minusBool: $hana.minusCheck)
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
                unitCountButtonVerticalPercent(title: "🪽黄", count: $hana.bbLampYCount, color: .personalSpringLightYellow, bigNumber: $hana.bigCount, numberofDicimal: 1, minusBool: $hana.minusCheck)
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
                unitCountButtonVerticalPercent(title: "🪽黄", count: $hana.bbLampYCount, color: .personalSpringLightYellow, bigNumber: $hana.bigCount, numberofDicimal: 1, minusBool: $hana.minusCheck)
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
            unitLinkButton(title: "REG中のサイドランプについて", exview: AnyView(kingHanaExViewRegLamp()))
            // フェザーランプの参考情報リンク
            unitLinkButton(title: "REG後のフェザーランプについて", exview: AnyView(kingHanaExViewAfterRegLamp()))
        }
    }
}


#Preview {
    kingHanaViewTop()
}
