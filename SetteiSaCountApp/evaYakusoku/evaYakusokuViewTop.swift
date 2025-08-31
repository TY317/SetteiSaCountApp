//
//  evaYakusokuViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/14.
//

import SwiftUI
import FirebaseCrashlytics

struct evaYakusokuViewTop: View {
    @ObservedObject var ver380: Ver380
    @StateObject var evaYakusoku = EvaYakusoku()
    @State var isShowAlert: Bool = false
    @StateObject var evaYakusokuMemory1 = EvaYakusokuMemory1()
    @StateObject var evaYakusokuMemory2 = EvaYakusokuMemory2()
    @StateObject var evaYakusokuMemory3 = EvaYakusokuMemory3()
    
    var body: some View {
//        List {
//            Button("クラッシュを発生させる") {
//                fatalError("テストクラッシュ")
//            }
//        }
        NavigationStack {
            List {
                Section {
                    // 通常時
                    NavigationLink(destination: evaYakusokuViewNormal(
                        ver380: ver380,
                        evaYakusoku: evaYakusoku,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: ver380.evaYakusokuMenuNormalBadge,
                        )
                    }
                    
                    // 初当り
                    NavigationLink(destination: evaYakusokuViewFirstHit(
//                        ver352: ver352,
                        evaYakusoku: evaYakusoku,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
//                            badgeStatus: ver352.evaYakusokuMenuFirstHitBadge
                        )
                    }
                    
                    // REG中のキャラ紹介
                    NavigationLink(destination: evaYakusokuViewRegChara(
                        evaYakusoku: evaYakusoku,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "person.3.fill",
                            textBody: "REG中のキャラ紹介"
                        )
                    }
                    
                    // ボーナス終了画面
                    NavigationLink(destination: evaYakusokuViewScreen(
                        evaYakusoku: evaYakusoku,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "ボーナス終了画面"
                        )
                    }
                    
                    // BT ビタ押し成功時のムービー
                    NavigationLink(destination: evaYakusokuViewBtMovie(
                        evaYakusoku: evaYakusoku,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "movieclapper.fill",
                            textBody: "BT ビタ押し成功時のムービー"
                        )
                    }
                } header: {
                    unitLabelMachineTopTitle(
                        machineName: evaYakusoku.machineName,
                        titleFont: .title2,
                    )
                }
                
                // 設定推測グラフ
                NavigationLink(destination: evaYakusokuView95Ci(
                    evaYakusoku: evaYakusoku,
                    selection: 4,
                )) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4830")
                
                // copyright
                unitSectionCopyright {
                    Text("©カラー")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($ver380.evaYakusokuMachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: evaYakusoku.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(evaYakusokuSubViewLoadMemory(
                        evaYakusoku: evaYakusoku,
                        evaYakusokuMemory1: evaYakusokuMemory1,
                        evaYakusokuMemory2: evaYakusokuMemory2,
                        evaYakusokuMemory3: evaYakusokuMemory3
                    )))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(evaYakusokuSubViewSaveMemory(
                        evaYakusoku: evaYakusoku,
                        evaYakusokuMemory1: evaYakusokuMemory1,
                        evaYakusokuMemory2: evaYakusokuMemory2,
                        evaYakusokuMemory3: evaYakusokuMemory3
                    )))
                }
                // データリセット
                unitButtonReset(isShowAlert: $isShowAlert, action: evaYakusoku.resetAll, message: "この機種のデータを全てリセットします")
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct evaYakusokuSubViewSaveMemory: View {
    @ObservedObject var evaYakusoku: EvaYakusoku
    @ObservedObject var evaYakusokuMemory1: EvaYakusokuMemory1
    @ObservedObject var evaYakusokuMemory2: EvaYakusokuMemory2
    @ObservedObject var evaYakusokuMemory3: EvaYakusokuMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: evaYakusoku.machineName,
            selectedMemory: $evaYakusoku.selectedMemory,
            memoMemory1: $evaYakusokuMemory1.memo,
            dateDoubleMemory1: $evaYakusokuMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $evaYakusokuMemory2.memo,
            dateDoubleMemory2: $evaYakusokuMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $evaYakusokuMemory3.memo,
            dateDoubleMemory3: $evaYakusokuMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        evaYakusokuMemory1.bonusCountSBig = evaYakusoku.bonusCountSBig
        evaYakusokuMemory1.bonusCountBig = evaYakusoku.bonusCountBig
        evaYakusokuMemory1.bonusCountBigSum = evaYakusoku.bonusCountBigSum
        evaYakusokuMemory1.bonusCountReg = evaYakusoku.bonusCountReg
        evaYakusokuMemory1.bonusCountAllSum = evaYakusoku.bonusCountAllSum
        evaYakusokuMemory1.gameNumberStart = evaYakusoku.gameNumberStart
        evaYakusokuMemory1.gameNumberCurrent = evaYakusoku.gameNumberCurrent
        evaYakusokuMemory1.gameNumberPlay = evaYakusoku.gameNumberPlay
        
        // ///////////////
        // ver3.5.1で追加
        // 小役
        // ///////////////
        evaYakusokuMemory1.koyakuCountBell = evaYakusoku.koyakuCountBell
        evaYakusokuMemory1.koyakuCountCherry = evaYakusoku.koyakuCountCherry
        evaYakusokuMemory1.koyakuCountSuikaSum = evaYakusoku.koyakuCountSuikaSum
        evaYakusokuMemory1.koyakuCountReach = evaYakusoku.koyakuCountReach
        evaYakusokuMemory1.koyakuCountBoso = evaYakusoku.koyakuCountBoso
        evaYakusokuMemory1.koyakuCountAllSum = evaYakusoku.koyakuCountAllSum
        
        // ///////////
        // ver3.5.2で追加
        // ///////////
        evaYakusokuMemory1.bonusCountSBigBlue = evaYakusoku.bonusCountSBigBlue
    }
    func saveMemory2() {
        evaYakusokuMemory2.bonusCountSBig = evaYakusoku.bonusCountSBig
        evaYakusokuMemory2.bonusCountBig = evaYakusoku.bonusCountBig
        evaYakusokuMemory2.bonusCountBigSum = evaYakusoku.bonusCountBigSum
        evaYakusokuMemory2.bonusCountReg = evaYakusoku.bonusCountReg
        evaYakusokuMemory2.bonusCountAllSum = evaYakusoku.bonusCountAllSum
        evaYakusokuMemory2.gameNumberStart = evaYakusoku.gameNumberStart
        evaYakusokuMemory2.gameNumberCurrent = evaYakusoku.gameNumberCurrent
        evaYakusokuMemory2.gameNumberPlay = evaYakusoku.gameNumberPlay
        
        // ///////////////
        // ver3.5.1で追加
        // 小役
        // ///////////////
        evaYakusokuMemory2.koyakuCountBell = evaYakusoku.koyakuCountBell
        evaYakusokuMemory2.koyakuCountCherry = evaYakusoku.koyakuCountCherry
        evaYakusokuMemory2.koyakuCountSuikaSum = evaYakusoku.koyakuCountSuikaSum
        evaYakusokuMemory2.koyakuCountReach = evaYakusoku.koyakuCountReach
        evaYakusokuMemory2.koyakuCountBoso = evaYakusoku.koyakuCountBoso
        evaYakusokuMemory2.koyakuCountAllSum = evaYakusoku.koyakuCountAllSum
        
        // ///////////
        // ver3.5.2で追加
        // ///////////
        evaYakusokuMemory2.bonusCountSBigBlue = evaYakusoku.bonusCountSBigBlue
    }
    func saveMemory3() {
        evaYakusokuMemory3.bonusCountSBig = evaYakusoku.bonusCountSBig
        evaYakusokuMemory3.bonusCountBig = evaYakusoku.bonusCountBig
        evaYakusokuMemory3.bonusCountBigSum = evaYakusoku.bonusCountBigSum
        evaYakusokuMemory3.bonusCountReg = evaYakusoku.bonusCountReg
        evaYakusokuMemory3.bonusCountAllSum = evaYakusoku.bonusCountAllSum
        evaYakusokuMemory3.gameNumberStart = evaYakusoku.gameNumberStart
        evaYakusokuMemory3.gameNumberCurrent = evaYakusoku.gameNumberCurrent
        evaYakusokuMemory3.gameNumberPlay = evaYakusoku.gameNumberPlay
        
        // ///////////////
        // ver3.5.1で追加
        // 小役
        // ///////////////
        evaYakusokuMemory3.koyakuCountBell = evaYakusoku.koyakuCountBell
        evaYakusokuMemory3.koyakuCountCherry = evaYakusoku.koyakuCountCherry
        evaYakusokuMemory3.koyakuCountSuikaSum = evaYakusoku.koyakuCountSuikaSum
        evaYakusokuMemory3.koyakuCountReach = evaYakusoku.koyakuCountReach
        evaYakusokuMemory3.koyakuCountBoso = evaYakusoku.koyakuCountBoso
        evaYakusokuMemory3.koyakuCountAllSum = evaYakusoku.koyakuCountAllSum
        
        // ///////////
        // ver3.5.2で追加
        // ///////////
        evaYakusokuMemory3.bonusCountSBigBlue = evaYakusoku.bonusCountSBigBlue
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct evaYakusokuSubViewLoadMemory: View {
    @ObservedObject var evaYakusoku: EvaYakusoku
    @ObservedObject var evaYakusokuMemory1: EvaYakusokuMemory1
    @ObservedObject var evaYakusokuMemory2: EvaYakusokuMemory2
    @ObservedObject var evaYakusokuMemory3: EvaYakusokuMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: evaYakusoku.machineName,
            selectedMemory: $evaYakusoku.selectedMemory,
            memoMemory1: evaYakusokuMemory1.memo,
            dateDoubleMemory1: evaYakusokuMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: evaYakusokuMemory2.memo,
            dateDoubleMemory2: evaYakusokuMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: evaYakusokuMemory3.memo,
            dateDoubleMemory3: evaYakusokuMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        evaYakusoku.bonusCountSBig = evaYakusokuMemory1.bonusCountSBig
        evaYakusoku.bonusCountBig = evaYakusokuMemory1.bonusCountBig
        evaYakusoku.bonusCountBigSum = evaYakusokuMemory1.bonusCountBigSum
        evaYakusoku.bonusCountReg = evaYakusokuMemory1.bonusCountReg
        evaYakusoku.bonusCountAllSum = evaYakusokuMemory1.bonusCountAllSum
        evaYakusoku.gameNumberStart = evaYakusokuMemory1.gameNumberStart
        evaYakusoku.gameNumberCurrent = evaYakusokuMemory1.gameNumberCurrent
        evaYakusoku.gameNumberPlay = evaYakusokuMemory1.gameNumberPlay
        
        // ///////////////
        // ver3.5.1で追加
        // 小役
        // ///////////////
        evaYakusoku.koyakuCountBell = evaYakusokuMemory1.koyakuCountBell
        evaYakusoku.koyakuCountCherry = evaYakusokuMemory1.koyakuCountCherry
        evaYakusoku.koyakuCountSuikaSum = evaYakusokuMemory1.koyakuCountSuikaSum
        evaYakusoku.koyakuCountReach = evaYakusokuMemory1.koyakuCountReach
        evaYakusoku.koyakuCountBoso = evaYakusokuMemory1.koyakuCountBoso
        evaYakusoku.koyakuCountAllSum = evaYakusokuMemory1.koyakuCountAllSum
        
        // ///////////
        // ver3.5.2で追加
        // ///////////
        evaYakusoku.bonusCountSBigBlue = evaYakusokuMemory1.bonusCountSBigBlue
    }
    func loadMemory2() {
        evaYakusoku.bonusCountSBig = evaYakusokuMemory2.bonusCountSBig
        evaYakusoku.bonusCountBig = evaYakusokuMemory2.bonusCountBig
        evaYakusoku.bonusCountBigSum = evaYakusokuMemory2.bonusCountBigSum
        evaYakusoku.bonusCountReg = evaYakusokuMemory2.bonusCountReg
        evaYakusoku.bonusCountAllSum = evaYakusokuMemory2.bonusCountAllSum
        evaYakusoku.gameNumberStart = evaYakusokuMemory2.gameNumberStart
        evaYakusoku.gameNumberCurrent = evaYakusokuMemory2.gameNumberCurrent
        evaYakusoku.gameNumberPlay = evaYakusokuMemory2.gameNumberPlay
        
        // ///////////////
        // ver3.5.1で追加
        // 小役
        // ///////////////
        evaYakusoku.koyakuCountBell = evaYakusokuMemory2.koyakuCountBell
        evaYakusoku.koyakuCountCherry = evaYakusokuMemory2.koyakuCountCherry
        evaYakusoku.koyakuCountSuikaSum = evaYakusokuMemory2.koyakuCountSuikaSum
        evaYakusoku.koyakuCountReach = evaYakusokuMemory2.koyakuCountReach
        evaYakusoku.koyakuCountBoso = evaYakusokuMemory2.koyakuCountBoso
        evaYakusoku.koyakuCountAllSum = evaYakusokuMemory2.koyakuCountAllSum
        
        // ///////////
        // ver3.5.2で追加
        // ///////////
        evaYakusoku.bonusCountSBigBlue = evaYakusokuMemory2.bonusCountSBigBlue
    }
    func loadMemory3() {
        evaYakusoku.bonusCountSBig = evaYakusokuMemory3.bonusCountSBig
        evaYakusoku.bonusCountBig = evaYakusokuMemory3.bonusCountBig
        evaYakusoku.bonusCountBigSum = evaYakusokuMemory3.bonusCountBigSum
        evaYakusoku.bonusCountReg = evaYakusokuMemory3.bonusCountReg
        evaYakusoku.bonusCountAllSum = evaYakusokuMemory3.bonusCountAllSum
        evaYakusoku.gameNumberStart = evaYakusokuMemory3.gameNumberStart
        evaYakusoku.gameNumberCurrent = evaYakusokuMemory3.gameNumberCurrent
        evaYakusoku.gameNumberPlay = evaYakusokuMemory3.gameNumberPlay
        
        // ///////////////
        // ver3.5.1で追加
        // 小役
        // ///////////////
        evaYakusoku.koyakuCountBell = evaYakusokuMemory3.koyakuCountBell
        evaYakusoku.koyakuCountCherry = evaYakusokuMemory3.koyakuCountCherry
        evaYakusoku.koyakuCountSuikaSum = evaYakusokuMemory3.koyakuCountSuikaSum
        evaYakusoku.koyakuCountReach = evaYakusokuMemory3.koyakuCountReach
        evaYakusoku.koyakuCountBoso = evaYakusokuMemory3.koyakuCountBoso
        evaYakusoku.koyakuCountAllSum = evaYakusokuMemory3.koyakuCountAllSum
        
        // ///////////
        // ver3.5.2で追加
        // ///////////
        evaYakusoku.bonusCountSBigBlue = evaYakusokuMemory3.bonusCountSBigBlue
    }
}

#Preview {
    evaYakusokuViewTop(
        ver380: Ver380(),
    )
}
