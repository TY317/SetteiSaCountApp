//
//  myJug5ViewBayseTest.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/13.
//

import SwiftUI
import GoogleMobileAds
import Charts

//struct myJug5ViewBayseTest: View {
//    @ObservedObject var myJug5: MyJug5
//    @StateObject var viewModel = InterstitialViewModel()
//    let selectListGuess: [String] = [
//        "デフォルト",
//        "ｼﾞｬｸﾞﾗｰﾃﾞﾌｫﾙﾄ",
//        "均等",
//        "ニブイチ",
//        "ヨブイチ",
//        "カスタム1",
//        "カスタム2",
//        "カスタム3",
//    ]
//    @State var selectedGuess: String = "デフォルト"
////    let guessDefault: [Double] = [72,21,2,3,1,1]
//    let guessDefault: [Int] = [72,21,2,3,1,1]
////    let guessJugDefault: [Double] = [30,40,20,7,2,1]
//    let guessJugDefault: [Int] = [30,40,20,7,2,1]
//    let guessHalf: [Int] = [30,15,5,30,15,5]
//    let guessQuater: [Int] = [50,20,5,15,7,3]
//    @State var budouEnable: Bool = true
//    @State var regDetailEnable: Bool = true
//    @State var calculateStart: Bool = false
//    @State var isShowAlert: Bool = false
//    @State var isShowResult: Bool = false
//    let payoutList: [Double] = [97,98,99.9,102.8,105.3,109.4]
//    let settingList: [Int] = [1,2,3,4,5,6]
//    @State var isShowGuessCuntom: Bool = false
//    @FocusState var isFocused: Bool
//    let guessCustomKey = "bayesTestGuessCustomArrayKey"
//    @AppStorage("bayesTestGuessCustomArrayKey") var guessCustomArrayData: String = "[72,21,2,3,1,1]"
//    @State var customInputArray: [Double] = []
//    @State var guessCustom1: [Int] = []
//    @State var guessCustom2: [Int] = [1,2,3,4,5,6]
//    @State var guessCustom3: [Int] = [6,5,4,3,2,1]
//    @State var guessEvenly: [Int] = [1,1,1,1,1,1]
//    let guessCustom1Key = "bayesTestGuessCustom1Key"
//    @AppStorage("bayesTestGuessCustom1Key") var guessCustom1JSON: String = "[1,1,1,1,1,1]"
//    
//    var body: some View {
//        List {
//            // //// step1)設定配分
//            Section {
//                // パターン選択
//                unitPickerMenuString(
//                    title: "設定配分パターン",
//                    selected: self.$selectedGuess,
//                    selectlist: self.selectListGuess
//                )
//                // 配分表
//                HStack(spacing: 0) {
//                    let guessArray = choiceGuessArray(pattern: self.selectedGuess)
//                    ForEach(guessArray.indices, id: \.self) { index in
//                        let total: Double = Double(guessArray.reduce(0, +))
//                        let guess: Double = Double(guessArray[index]) / total * 100
//                        unitTablePercent(
//                            columTitle: "設定\(index+1)",
////                            percentList: [guessArray[index]],
//                            percentList: [guess],
//                            titleFont: .body,
//                            colorList: [.white],
//                        )
//                    }
//                }
//            } header: {
//                Text("STEP1) 設定配分予想")
//            }
//            
//            // //// 判別要素の設定
//            Section {
//                DisclosureGroup("判別要素") {
//                    Text("BIG確率")
//                    Text("REG確率")
//                    Toggle(isOn: self.$budouEnable) {
//                        HStack {
//                            Text("ぶどう確率")
//                                .foregroundStyle(self.budouEnable ? Color.primary : Color.secondary)
//                            unitToolbarButtonQuestion {
//                                unitExView5body2image(
//                                    title: "逆算したぶどうについて",
//                                    textBody1: "・打ち始めデータでぶどう逆算有効化がONの場合はぶどう逆算分も考慮した計算を行います"
//                                )
//                            }
//                        }
//                    }
//                    Toggle(isOn: self.$regDetailEnable) {
//                        Text("REG当選契機も考慮")
//                            .foregroundStyle(self.regDetailEnable ? Color.primary : Color.secondary)
//                    }
//                }
//            } header: {
//                Text("STEP2) 判別要素の設定")
//            }
//            
//            // //// 計算
//            Section {
//                Button {
//                    self.isShowAlert.toggle()
//                } label: {
//                    Text("計算START")
//                }
//                .buttonStyle(BorderedProminentButtonStyle())
//                .frame(maxWidth: .infinity, alignment: .center)
//                .alert("計算START",
//                       isPresented: self.$isShowAlert) {
//                    Button("キャンセル", role: .cancel) {
//                        
//                    }
//                    Button("OK", role: .destructive) {
//                        viewModel.isAdDismissed = false
//                        UINotificationFeedbackGenerator().notificationOccurred(.success)
//                        if viewModel.interstitialAd == nil {
//                            
//                        } else {
//                            viewModel.showAd()
//                        }
//                    }
//                } message: {
//                    Text("計算中広告が流れます")
//                }
//                
//            } header: {
//                Text("STEP3) 判別計算")
//            }
//            .listRowBackground(Color.clear)
//            
//            Section {
//                ForEach(self.guessCustom1.indices, id: \.self) { index in
//                    HStack {
//                        Text("設定\(index+1): ")
////                            .frame(maxWidth: .infinity, alignment: .leading)
//                        Stepper(value: self.$guessCustom1[index], in: 0...999) {
//                            HStack {
//                                let total: Int = self.guessCustom1.reduce(0, +)
//                                let guess: Double = Double(self.guessCustom1[index]) / Double(total) * 100
//                                Text("\(self.guessCustom1[index])")
//                                    .font(.title2)
//                                    .fontWeight(.bold)
//                                    .frame(maxWidth: .infinity, alignment: .center)
//                                    .offset(x: 20)
//                                Text("(\(guess, specifier: "%.1f")%)")
//                                    .frame(maxWidth: .infinity, alignment: .center)
//                            }
////                            .frame(maxWidth: .infinity, alignment: .center)
//                        }
////                        HStack {
////                            TextField("設定\(index+1)", value: self.$customInputArray[index], format: .number)
////                                .keyboardType(.numberPad)
////                                .multilineTextAlignment(.center)
////                            Text("%")
////                                .foregroundStyle(Color.secondary)
////                                .font(.footnote)
////                        }
//                    }
////                    unitTextFieldNumberInputWithUnit(
////                        title: "設定\(index+1)",
////                        inputValue: self.$customInputArray[index],
////                    )
////                    Text("\(array[index])")
//                }
//                
////                guard let data = self.guessCustomArrayData.data(using: .utf8) else { return [] }
////                if let data = self.guessCustomArrayData.data(using: .utf8),
////                   let customArray: [Double] = try? JSONDecoder().decode([Double].self, from: data) {
////                    ForEach(customArray.indices, id: \.self) { index in
////                        unitTextFieldNumberInputWithUnit(
////                            title: "設定\(index+1)",
////                            inputValue: customArray[index],
////                        )
////                    }
////                }
//            }
//        }
//        .onAppear {
//            loadAdOnAppear()
//        }
//        .onChange(of: viewModel.isAdDismissed) {
//            if viewModel.isAdDismissed {
//                self.isShowResult = true
//            }
//        }
//        .sheet(isPresented: self.$isShowResult) {
//            ResultView(
//                settingList: self.settingList,
//                result: bayesRatio(),
//                payoutList: self.payoutList,
//            )
//                .presentationDetents([.large])
//        }
//        .navigationTitle("設定判別")
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            Button {
//                self.isShowGuessCuntom.toggle()
//            } label: {
//                Image(systemName: "gearshape")
//            }
//            .sheet(isPresented: self.$isShowGuessCuntom) {
//                NavigationView {
//                    List {
//                        
//                    }
//                    .navigationTitle("設定配分カスタム")
//                    // //// ツールバー閉じるボタン
//                    .toolbar {
//                        ToolbarItem(placement: .automatic) {
//                            Button(action: {
//                                self.isShowGuessCuntom = false
//                            }, label: {
//                                Text("閉じる")
//                                    .fontWeight(.bold)
//                            })
//                        }
//                        ToolbarItem(placement: .keyboard) {
//                            HStack {
//                                Spacer()
//                                Button(action: {
////                                    focus.wrappedValue = false
//                                    self.isFocused = false
//                                }, label: {
//                                    Text("完了")
//                                        .fontWeight(.bold)
//                                })
//                            }
//                        }
//                    }
//                }
//            }
//        }
////        .onAppear {
////            self.customInputArray = decodeDoubleArray(stringData: self.guessCustomArrayData)
////        }
//        .onAppear {
//            self.guessCustom1 = decodeIntArrayFromString(stringData: self.guessCustom1JSON)
//        }
//    }
//    func decodeDoubleArray(stringData: String) -> [Double] {
//        guard let data = stringData.data(using: .utf8) else { return [] }
//        return (try? JSONDecoder().decode([Double].self, from: data)) ?? []
//    }
//    func decodeIntArrayFromString(stringData: String) -> [Int] {
//        guard let data = stringData.data(using: .utf8) else { return [] }
//        return (try? JSONDecoder().decode([Int].self, from: data)) ?? []
//    }
//    // //// 選択された配分パターンに合わせて配分値を選択する
////    func choiceGuessArray(pattern: String) -> [Double] {
////        switch pattern {
////        case self.selectListGuess[0]: return self.guessDefault
////        case self.selectListGuess[1]: return self.guessJugDefault
////        default: return self.guessDefault
////        }
////    }
//    func choiceGuessArray(pattern: String) -> [Int] {
//        switch pattern {
//        case self.selectListGuess[0]: return self.guessDefault
//        case self.selectListGuess[1]: return self.guessJugDefault
//        case self.selectListGuess[2]: return self.guessEvenly
//        case self.selectListGuess[3]: return self.guessHalf
//        case self.selectListGuess[4]: return self.guessQuater
//        case self.selectListGuess[5]: return self.guessCustom1
//        case self.selectListGuess[6]: return self.guessCustom2
//        case self.selectListGuess[7]: return self.guessCustom3
//        default: return self.guessDefault
//        }
//    }
//    
//    func loadAdOnAppear() {
//        Task {
//            await viewModel.loadAd()
//        }
//    }
//    
//    func bayesRatio() -> [Double] {
//        // //////////////////
//        // //// 対数尤度を算出
//        // //////////////////
//        // 変数をDouble値で持っておく
//        let totalGame = Double(myJug5.currentGames)  // 現在総G数
//        let totalBig = Double(myJug5.totalBigCount)  // 現在BIG数(前任者込み)
//        let totalReg = Double(myJug5.totalRegCount)  // 現在REG数(前任者込み)
//        let startGame = Double(myJug5.startGameInput)  // 打ち始めG数
//        let startReg = Double(myJug5.startRegCountInput)  // 打ち始めREG数
//        let playGame = Double(myJug5.playGame)  // 自分のプレイ数
//        let cherryReg = Double(myJug5.personalCherryRegCount)  // チェリーREG数
//        let aloneReg = Double(myJug5.personalAloneRegCount)  // 単独REG数
//        let totalBell = Double(myJug5.totalBellCount)  // ぶどう総数（逆算含む）
//        let personalBell = Double(myJug5.personalBellCount)  // ぶどう数（自分のカウントだけ）
//        
//        // //// ビッグの尤度
//        // 中身が全部0のリストを準備しておく
//        var logPostListBig = [Double](repeating: 0, count: myJug5.denominateListBigSum.count)
//        
//        // 各設定の尤度を計算
//        for (i,deno) in myJug5.denominateListBigSum.enumerated() {
//            let pBig = 1.0 / deno
//            logPostListBig[i] = totalBig * log(pBig) + (totalGame - totalBig) * log(1 - pBig)
//        }
//        
//        // //// REGの尤度
//        var logPostListReg = [Double](repeating: 0, count: myJug5.denominateListRegSum.count)
//        // 詳細ON
//        if regDetailEnable {
//            // 前任者分
//            var logPostRegStart = [Double](repeating: 0, count: myJug5.denominateListRegSum.count)
//            for (i, deno) in myJug5.denominateListRegSum.enumerated() {
//                let pReg = 1.0 / deno
//                logPostRegStart[i] = startReg * log(pReg) + (startGame - startReg) * log(1-pReg)
//            }
//            // チェリーREG分
//            var logPostRegCherry = [Double](repeating: 0, count: myJug5.denominateListRegCherry.count)
//            for (i, deno) in myJug5.denominateListRegCherry.enumerated() {
//                let pRegCherry = 1.0 / deno
//                logPostRegCherry[i] = cherryReg * log(pRegCherry) + (playGame - cherryReg) * log(1-pRegCherry)
//            }
//            // 単独REG分
//            var logPostRegAlone = [Double](repeating: 0, count: myJug5.denominateListRegAlone.count)
//            for (i, deno) in myJug5.denominateListRegAlone.enumerated() {
//                let pRegAlone = 1.0 / deno
//                logPostRegAlone[i] = aloneReg * log(pRegAlone) + (playGame - aloneReg) * log(1-pRegAlone)
//            }
//            // 全部合算しておく
////            var logPostListReg = [Double](repeating: 0, count: myJug5.denominateListRegSum.count)
//            for i in 0..<logPostRegStart.count {
//                logPostListReg[i] = logPostRegStart[i] + logPostRegCherry[i] + logPostRegAlone[i]
//            }
//        }
//        // 詳細OFF
//        else {
//            // 中身が全部0のリストを準備しておく
////            var logPostListReg = [Double](repeating: 0, count: myJug5.denominateListRegSum.count)
//            for (i,deno) in myJug5.denominateListRegSum.enumerated() {
//                let pReg = 1.0 / deno
//                logPostListReg[i] = totalReg * log(pReg) + (totalGame - totalReg) * log(1-pReg)
//            }
//        }
//        
//        // //// ぶどうの尤度
//        var logPostListBell = [Double](repeating: 0, count: myJug5.denominateListBell.count)
//        // ぶどうの判別ONの場合
//        if budouEnable {
//            // さらに逆算ONの場合
//            if myJug5.startBackCalculationEnable {
//                for (i, deno) in myJug5.denominateListBell.enumerated() {
//                    let pBell = 1.0 / deno
//                    logPostListBell[i] = totalBell * log(pBell) + (totalGame - totalBell) * log(1-pBell)
//                }
//            }
//            // 逆算はOFFの場合
//            else {
//                for (i, deno) in myJug5.denominateListBell.enumerated() {
//                    let pBell = 1.0 / deno
//                    logPostListBell[i] = personalBell * log(pBell) + (playGame - personalBell) * log(1-pBell)
//                }
//            }
//        }
//        
//        // //// 全尤度と事前確率の合算
//        let guessList = choiceGuessArray(pattern: self.selectedGuess)
//        var logPostListSum = [Double](repeating: 0, count: guessList.count)
//        for (i, guess) in guessList.enumerated() {
//            logPostListSum[i] = logPostListBig[i] + logPostListReg[i] + logPostListBell[i] + log(Double(guess/100))
//        }
//        
//        // //// 事後確率の算出
//        let maxLP = logPostListSum.max() ?? 0
//        let unnormalizedProbability: [Double] = logPostListSum.map { exp($0 - maxLP) }
//        let upSum = unnormalizedProbability.reduce(0, +)
//        let normalizedProbability: [Double] = unnormalizedProbability.map { $0 / upSum * 100 }
//        
//        return normalizedProbability
//    }
//}
//
//
//final class InterstitialViewModel: NSObject,ObservableObject,GADFullScreenContentDelegate {
//    //    private var interstitialAd: GADInterstitialAd?
//    var interstitialAd: GADInterstitialAd?
//    
//    @Published var isAdDismissed: Bool = false
//    
//    func loadAd() async {
//        do {
//            interstitialAd = try await GADInterstitialAd.load(
//                withAdUnitID: "ca-app-pub-3940256099942544/4411468910",
//                request: GADRequest()
//            )
//            // [START set_the_delegate]
//            interstitialAd?.fullScreenContentDelegate = self
//            // [END set_the_delegate]
//        } catch {
//            print("Failed to load interstitial ad with error: \(error.localizedDescription)")
//        }
//    }
//    // [END load_ad]
//    
//    // [START show_ad]
//    func showAd() {
//        //        isAdDismissed = false
//        guard let interstitialAd = interstitialAd else {
//            return print("Ad wasn't ready.")
//        }
//        
//        interstitialAd.present(fromRootViewController: nil)
//    }
//    // [END show_ad]
//    
//    // MARK: - GADFullScreenContentDelegate methods
//    
//    // [START ad_events]
//    func adDidRecordImpression(_ ad: GADFullScreenPresentingAd) {
//        print("\(#function) called")
//    }
//    
//    func adDidRecordClick(_ ad: GADFullScreenPresentingAd) {
//        print("\(#function) called")
//    }
//    
//    func ad(
//        _ ad: GADFullScreenPresentingAd,
//        didFailToPresentFullScreenContentWithError error: Error
//    ) {
//        print("\(#function) called")
//    }
//    
//    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
//        print("\(#function) called")
//    }
//    
//    func adWillDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
//        print("\(#function) called")
//    }
//    
//    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
//        print("\(#function) called")
//        // Clear the interstitial ad.
//        interstitialAd = nil
//        isAdDismissed = true
//        Task {
//            await loadAd() // 次回の広告表示の準備
//        }
//    }
//    // [END ad_events]
//    
//    // 最後に追加
//    deinit {
//        print("❌ InterstitialViewModel deinitialized")
//    }
//}
//
//struct ResultView: View {
//    var settingList: [Int] = [1,2,3,4,5,6]
//    let result: [Double]
//    let payoutList: [Double]
//    let xAxisTitle: String = "設定"
//    let yAxisTitle: String = "判別確率"
//    @Environment(\.dismiss) private var dismiss
//    
//    var body: some View {
//        NavigationView {
//            List {
//                Section {
//                    HStack(spacing: 0) {
//                        ForEach(result.indices, id: \.self) { index in
//                            unitTablePercent(
//                                columTitle: "設定\(index+1)",
//                                percentList: [result[index]],
//                                titleFont: .body,
//                                colorList: [.white]
//                            )
//                        }
//                    }
//                    Chart {
//                        ForEach(self.settingList.indices, id: \.self) { index in
//                            BarMark(
//                                x: .value(
//                                    self.xAxisTitle,
//                                          "設定\(settingList[index])"
//                                         ),
//                                y: .value(
//                                    self.yAxisTitle,
//                                    self.result[index],
//                                )
//                            )
//                            .foregroundStyle(barMarkColor(setting: self.settingList[index]))
//                            .opacity(0.7)
//                        }
//                    }
//                    .frame(height: 200)
//                }
//                
//                Section {
//                    HStack {
//                        // 設定
//                        VStack {
//                            Text("設定")
//                                .font(.title3)
//                                .fontWeight(.bold)
//                            let setting = averageSetting()
//                            Text("\(setting, specifier: "%.1f")")
//                                .font(.largeTitle)
//                                .fontWeight(.bold)
//                        }
//                        .frame(maxWidth: .infinity, alignment: .center)
//                        Rectangle()
//                            .frame(width: 1)
//                        // 機械割
//                        VStack {
//                            Text("機械割")
//                                .font(.title3)
//                                .fontWeight(.bold)
//                            let payout = averagePayout()
//                            HStack(spacing: 3) {
//                                Text("\(payout, specifier: "%.1f")")
//                                    .font(.largeTitle)
//                                    .fontWeight(.bold)
//                                Text("%")
//                            }
//                            .offset(x: 11)
//                        }
//                        .frame(maxWidth: .infinity, alignment: .center)
//                    }
//                    unitLinkButtonViewBuilder(sheetTitle: "機械割", linkText: "機械割") {
//                        HStack(spacing: 0) {
//                            unitTableSettingIndex()
//                            unitTablePercent(
//                                columTitle: "機械割",
//                                percentList: self.payoutList,
//                                numberofDicimal: 1,
//                            )
//                        }
//                    }
//                } header: {
//                    Text("期待値")
//                }
//            }
//            .navigationTitle("判別結果")
//            .navigationBarTitleDisplayMode(.inline)
//            // //// ツールバー閉じるボタン
//            .toolbar {
//                ToolbarItem(placement: .automatic) {
//                    Button(action: {
//                        dismiss()
//                    }, label: {
//                        Text("閉じる")
//                            .fontWeight(.bold)
//                    })
//                }
//            }
//        }
//    }
//    func averagePayout() -> Double {
//        var ave: Double = 0
//        for (i, res) in result.enumerated() {
//            ave += res/100 * payoutList[i]
//        }
//        return ave
//    }
//    func averageSetting() -> Double {
//        var ave: Double = 0
//        for (i, res) in result.enumerated() {
//            ave += Double(i+1) * res/100
//        }
//        return ave
//    }
//    func barMarkColor(setting: Int) -> Color {
//        switch setting {
//        case 1: return .gray
//        case 2: return .blue
//        case 3: return .yellow
//        case 4: return .green
//        case 5: return .purple
//        case 6: return .red
//        default: return .gray
//        }
//    }
//}
//
//struct payoutTable: View {
//    var body: some View {
//        Text("test")
//    }
//}
//
//#Preview {
//    myJug5ViewBayseTest(
//        myJug5: MyJug5(),
//    )
////    ResultView(
////        settingList: [1,2,3,4,5,6],
////        result: [72,21,2,3,1,1],
////        payoutList: [97,98,99.9,102.8,105.3,109.4],
////    )
//}
