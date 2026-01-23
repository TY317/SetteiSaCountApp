//
//  bakemonoViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/11/30.
//

import SwiftUI

struct bakemonoViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var bakemono = Bakemono()
    @State var isShowAlert: Bool = false
    @StateObject var bakemonoMemory1 = BakemonoMemory1()
    @StateObject var bakemonoMemory2 = BakemonoMemory2()
    @StateObject var bakemonoMemory3 = BakemonoMemory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("マイスロの利用を前提としています\n遊技前にマイスロを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(machineName: bakemono.machineName)
                }
                
                Section {
                    // 通常時
                    NavigationLink(destination: bakemonoViewNormal(
                        bakemono: bakemono,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.bakemonoMenuNormalBadge,
                        )
                    }
                    
                    // 初当り
                    NavigationLink(destination: bakemonoViewFirstHit(
                        bakemono: bakemono,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.bakemonoMenuFirstHitBadge,
                        )
                    }
                    
                    // 倖時間
                    NavigationLink(destination: bakemonoViewAt(
                        bakemono: bakemono,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "clock.fill",
                            textBody: "倖時間",
                            badgeStatus: common.bakemonoMenuAtBadge,
                        )
                    }
                    
                    // 終了画面
                    NavigationLink(destination: bakemonoViewScreen(
                        bakemono: bakemono,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "AT終了画面",
                            badgeStatus: common.bakemonoMenuScreenBadge,
                        )
                    }
                    
                    // サミートロフィー
                    NavigationLink(destination: commonViewSammyTrophy()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "サミートロフィー"
                        )
                    }
                }
                
                // 設定推測グラフ
                NavigationLink(destination: bakemonoView95Ci(
                    bakemono: bakemono,
                    selection: 2,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: bakemonoViewBayes(
                    bakemono: bakemono,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.bakemonoMenuBayesBadge,
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4898")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©︎西尾維新／講談社・アニプレックス・シャフト")
                    Text("©︎Sammy")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.bakemonoMachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: bakemono.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(bakemonoSubViewLoadMemory(
                    bakemono: bakemono,
                    bakemonoMemory1: bakemonoMemory1,
                    bakemonoMemory2: bakemonoMemory2,
                    bakemonoMemory3: bakemonoMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(bakemonoSubViewSaveMemory(
                    bakemono: bakemono,
                    bakemonoMemory1: bakemonoMemory1,
                    bakemonoMemory2: bakemonoMemory2,
                    bakemonoMemory3: bakemonoMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: bakemono.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}

// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct bakemonoSubViewSaveMemory: View {
    @ObservedObject var bakemono: Bakemono
    @ObservedObject var bakemonoMemory1: BakemonoMemory1
    @ObservedObject var bakemonoMemory2: BakemonoMemory2
    @ObservedObject var bakemonoMemory3: BakemonoMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: bakemono.machineName,
            selectedMemory: $bakemono.selectedMemory,
            memoMemory1: $bakemonoMemory1.memo,
            dateDoubleMemory1: $bakemonoMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $bakemonoMemory2.memo,
            dateDoubleMemory2: $bakemonoMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $bakemonoMemory3.memo,
            dateDoubleMemory3: $bakemonoMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        bakemonoMemory1.totalGame = bakemono.totalGame
        bakemonoMemory1.koyakuCountSuika = bakemono.koyakuCountSuika
        bakemonoMemory1.normalGame = bakemono.normalGame
        bakemonoMemory1.firstHitCountAt = bakemono.firstHitCountAt
        bakemonoMemory1.fixScreen1 = bakemono.fixScreen1
        bakemonoMemory1.fixScreen2 = bakemono.fixScreen2
        bakemonoMemory1.fixScreen3 = bakemono.fixScreen3
        bakemonoMemory1.fixScreenSum = bakemono.fixScreenSum
        bakemonoMemory1.screenCount1 = bakemono.screenCount1
        bakemonoMemory1.screenCount2 = bakemono.screenCount2
        bakemonoMemory1.screenCount3 = bakemono.screenCount3
        bakemonoMemory1.screenCount4 = bakemono.screenCount4
        bakemonoMemory1.screenCount5 = bakemono.screenCount5
        bakemonoMemory1.screenCount6 = bakemono.screenCount6
        bakemonoMemory1.screenCount7 = bakemono.screenCount7
        bakemonoMemory1.screenCount8 = bakemono.screenCount8
        bakemonoMemory1.screenCount9 = bakemono.screenCount9
        bakemonoMemory1.screenCount10 = bakemono.screenCount10
        bakemonoMemory1.screenCount11 = bakemono.screenCount11
        bakemonoMemory1.screenCountSum = bakemono.screenCountSum
        
        // -------------
        // ver3.15.0で追加
        // -------------
        bakemonoMemory1.koyakuCountJakuCherry = bakemono.koyakuCountJakuCherry
        bakemonoMemory1.jakuCherryAtCount = bakemono.jakuCherryAtCount
        
        // ---------
        // ver3.17.1で追加
        // ---------
        bakemonoMemory1.rareCzCountSuika = bakemono.rareCzCountSuika
        bakemonoMemory1.rareCzCountSuikaHit = bakemono.rareCzCountSuikaHit
        bakemonoMemory1.rareCzCountKyoCherry = bakemono.rareCzCountKyoCherry
        bakemonoMemory1.rareCzCountChance = bakemono.rareCzCountChance
        bakemonoMemory1.rareCzCountKyoRareSum = bakemono.rareCzCountKyoRareSum
        bakemonoMemory1.rareCzCountKyoRareHit = bakemono.rareCzCountKyoRareHit
    }
    func saveMemory2() {
        bakemonoMemory2.totalGame = bakemono.totalGame
        bakemonoMemory2.koyakuCountSuika = bakemono.koyakuCountSuika
        bakemonoMemory2.normalGame = bakemono.normalGame
        bakemonoMemory2.firstHitCountAt = bakemono.firstHitCountAt
        bakemonoMemory2.fixScreen1 = bakemono.fixScreen1
        bakemonoMemory2.fixScreen2 = bakemono.fixScreen2
        bakemonoMemory2.fixScreen3 = bakemono.fixScreen3
        bakemonoMemory2.fixScreenSum = bakemono.fixScreenSum
        bakemonoMemory2.screenCount1 = bakemono.screenCount1
        bakemonoMemory2.screenCount2 = bakemono.screenCount2
        bakemonoMemory2.screenCount3 = bakemono.screenCount3
        bakemonoMemory2.screenCount4 = bakemono.screenCount4
        bakemonoMemory2.screenCount5 = bakemono.screenCount5
        bakemonoMemory2.screenCount6 = bakemono.screenCount6
        bakemonoMemory2.screenCount7 = bakemono.screenCount7
        bakemonoMemory2.screenCount8 = bakemono.screenCount8
        bakemonoMemory2.screenCount9 = bakemono.screenCount9
        bakemonoMemory2.screenCount10 = bakemono.screenCount10
        bakemonoMemory2.screenCount11 = bakemono.screenCount11
        bakemonoMemory2.screenCountSum = bakemono.screenCountSum
        
        // -------------
        // ver3.15.0で追加
        // -------------
        bakemonoMemory2.koyakuCountJakuCherry = bakemono.koyakuCountJakuCherry
        bakemonoMemory2.jakuCherryAtCount = bakemono.jakuCherryAtCount
        
        // ---------
        // ver3.17.1で追加
        // ---------
        bakemonoMemory2.rareCzCountSuika = bakemono.rareCzCountSuika
        bakemonoMemory2.rareCzCountSuikaHit = bakemono.rareCzCountSuikaHit
        bakemonoMemory2.rareCzCountKyoCherry = bakemono.rareCzCountKyoCherry
        bakemonoMemory2.rareCzCountChance = bakemono.rareCzCountChance
        bakemonoMemory2.rareCzCountKyoRareSum = bakemono.rareCzCountKyoRareSum
        bakemonoMemory2.rareCzCountKyoRareHit = bakemono.rareCzCountKyoRareHit
    }
    func saveMemory3() {
        bakemonoMemory3.totalGame = bakemono.totalGame
        bakemonoMemory3.koyakuCountSuika = bakemono.koyakuCountSuika
        bakemonoMemory3.normalGame = bakemono.normalGame
        bakemonoMemory3.firstHitCountAt = bakemono.firstHitCountAt
        bakemonoMemory3.fixScreen1 = bakemono.fixScreen1
        bakemonoMemory3.fixScreen2 = bakemono.fixScreen2
        bakemonoMemory3.fixScreen3 = bakemono.fixScreen3
        bakemonoMemory3.fixScreenSum = bakemono.fixScreenSum
        bakemonoMemory3.screenCount1 = bakemono.screenCount1
        bakemonoMemory3.screenCount2 = bakemono.screenCount2
        bakemonoMemory3.screenCount3 = bakemono.screenCount3
        bakemonoMemory3.screenCount4 = bakemono.screenCount4
        bakemonoMemory3.screenCount5 = bakemono.screenCount5
        bakemonoMemory3.screenCount6 = bakemono.screenCount6
        bakemonoMemory3.screenCount7 = bakemono.screenCount7
        bakemonoMemory3.screenCount8 = bakemono.screenCount8
        bakemonoMemory3.screenCount9 = bakemono.screenCount9
        bakemonoMemory3.screenCount10 = bakemono.screenCount10
        bakemonoMemory3.screenCount11 = bakemono.screenCount11
        bakemonoMemory3.screenCountSum = bakemono.screenCountSum
        
        // -------------
        // ver3.15.0で追加
        // -------------
        bakemonoMemory3.koyakuCountJakuCherry = bakemono.koyakuCountJakuCherry
        bakemonoMemory3.jakuCherryAtCount = bakemono.jakuCherryAtCount
        
        // ---------
        // ver3.17.1で追加
        // ---------
        bakemonoMemory3.rareCzCountSuika = bakemono.rareCzCountSuika
        bakemonoMemory3.rareCzCountSuikaHit = bakemono.rareCzCountSuikaHit
        bakemonoMemory3.rareCzCountKyoCherry = bakemono.rareCzCountKyoCherry
        bakemonoMemory3.rareCzCountChance = bakemono.rareCzCountChance
        bakemonoMemory3.rareCzCountKyoRareSum = bakemono.rareCzCountKyoRareSum
        bakemonoMemory3.rareCzCountKyoRareHit = bakemono.rareCzCountKyoRareHit
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct bakemonoSubViewLoadMemory: View {
    @ObservedObject var bakemono: Bakemono
    @ObservedObject var bakemonoMemory1: BakemonoMemory1
    @ObservedObject var bakemonoMemory2: BakemonoMemory2
    @ObservedObject var bakemonoMemory3: BakemonoMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: bakemono.machineName,
            selectedMemory: $bakemono.selectedMemory,
            memoMemory1: bakemonoMemory1.memo,
            dateDoubleMemory1: bakemonoMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: bakemonoMemory2.memo,
            dateDoubleMemory2: bakemonoMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: bakemonoMemory3.memo,
            dateDoubleMemory3: bakemonoMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        bakemono.totalGame = bakemonoMemory1.totalGame
        bakemono.koyakuCountSuika = bakemonoMemory1.koyakuCountSuika
        bakemono.normalGame = bakemonoMemory1.normalGame
        bakemono.firstHitCountAt = bakemonoMemory1.firstHitCountAt
        bakemono.fixScreen1 = bakemonoMemory1.fixScreen1
        bakemono.fixScreen2 = bakemonoMemory1.fixScreen2
        bakemono.fixScreen3 = bakemonoMemory1.fixScreen3
        bakemono.fixScreenSum = bakemonoMemory1.fixScreenSum
        bakemono.screenCount1 = bakemonoMemory1.screenCount1
        bakemono.screenCount2 = bakemonoMemory1.screenCount2
        bakemono.screenCount3 = bakemonoMemory1.screenCount3
        bakemono.screenCount4 = bakemonoMemory1.screenCount4
        bakemono.screenCount5 = bakemonoMemory1.screenCount5
        bakemono.screenCount6 = bakemonoMemory1.screenCount6
        bakemono.screenCount7 = bakemonoMemory1.screenCount7
        bakemono.screenCount8 = bakemonoMemory1.screenCount8
        bakemono.screenCount9 = bakemonoMemory1.screenCount9
        bakemono.screenCount10 = bakemonoMemory1.screenCount10
        bakemono.screenCount11 = bakemonoMemory1.screenCount11
        bakemono.screenCountSum = bakemonoMemory1.screenCountSum
        
        // -------------
        // ver3.15.0で追加
        // -------------
        bakemono.koyakuCountJakuCherry = bakemonoMemory1.koyakuCountJakuCherry
        bakemono.jakuCherryAtCount = bakemonoMemory1.jakuCherryAtCount
        
        // ---------
        // ver3.17.1で追加
        // ---------
        bakemono.rareCzCountSuika = bakemonoMemory1.rareCzCountSuika
        bakemono.rareCzCountSuikaHit = bakemonoMemory1.rareCzCountSuikaHit
        bakemono.rareCzCountKyoCherry = bakemonoMemory1.rareCzCountKyoCherry
        bakemono.rareCzCountChance = bakemonoMemory1.rareCzCountChance
        bakemono.rareCzCountKyoRareSum = bakemonoMemory1.rareCzCountKyoRareSum
        bakemono.rareCzCountKyoRareHit = bakemonoMemory1.rareCzCountKyoRareHit
    }
    func loadMemory2() {
        bakemono.totalGame = bakemonoMemory2.totalGame
        bakemono.koyakuCountSuika = bakemonoMemory2.koyakuCountSuika
        bakemono.normalGame = bakemonoMemory2.normalGame
        bakemono.firstHitCountAt = bakemonoMemory2.firstHitCountAt
        bakemono.fixScreen1 = bakemonoMemory2.fixScreen1
        bakemono.fixScreen2 = bakemonoMemory2.fixScreen2
        bakemono.fixScreen3 = bakemonoMemory2.fixScreen3
        bakemono.fixScreenSum = bakemonoMemory2.fixScreenSum
        bakemono.screenCount1 = bakemonoMemory2.screenCount1
        bakemono.screenCount2 = bakemonoMemory2.screenCount2
        bakemono.screenCount3 = bakemonoMemory2.screenCount3
        bakemono.screenCount4 = bakemonoMemory2.screenCount4
        bakemono.screenCount5 = bakemonoMemory2.screenCount5
        bakemono.screenCount6 = bakemonoMemory2.screenCount6
        bakemono.screenCount7 = bakemonoMemory2.screenCount7
        bakemono.screenCount8 = bakemonoMemory2.screenCount8
        bakemono.screenCount9 = bakemonoMemory2.screenCount9
        bakemono.screenCount10 = bakemonoMemory2.screenCount10
        bakemono.screenCount11 = bakemonoMemory2.screenCount11
        bakemono.screenCountSum = bakemonoMemory2.screenCountSum
        
        // -------------
        // ver3.15.0で追加
        // -------------
        bakemono.koyakuCountJakuCherry = bakemonoMemory2.koyakuCountJakuCherry
        bakemono.jakuCherryAtCount = bakemonoMemory2.jakuCherryAtCount
        
        // ---------
        // ver3.17.1で追加
        // ---------
        bakemono.rareCzCountSuika = bakemonoMemory2.rareCzCountSuika
        bakemono.rareCzCountSuikaHit = bakemonoMemory2.rareCzCountSuikaHit
        bakemono.rareCzCountKyoCherry = bakemonoMemory2.rareCzCountKyoCherry
        bakemono.rareCzCountChance = bakemonoMemory2.rareCzCountChance
        bakemono.rareCzCountKyoRareSum = bakemonoMemory2.rareCzCountKyoRareSum
        bakemono.rareCzCountKyoRareHit = bakemonoMemory2.rareCzCountKyoRareHit
    }
    func loadMemory3() {
        bakemono.totalGame = bakemonoMemory3.totalGame
        bakemono.koyakuCountSuika = bakemonoMemory3.koyakuCountSuika
        bakemono.normalGame = bakemonoMemory3.normalGame
        bakemono.firstHitCountAt = bakemonoMemory3.firstHitCountAt
        bakemono.fixScreen1 = bakemonoMemory3.fixScreen1
        bakemono.fixScreen2 = bakemonoMemory3.fixScreen2
        bakemono.fixScreen3 = bakemonoMemory3.fixScreen3
        bakemono.fixScreenSum = bakemonoMemory3.fixScreenSum
        bakemono.screenCount1 = bakemonoMemory3.screenCount1
        bakemono.screenCount2 = bakemonoMemory3.screenCount2
        bakemono.screenCount3 = bakemonoMemory3.screenCount3
        bakemono.screenCount4 = bakemonoMemory3.screenCount4
        bakemono.screenCount5 = bakemonoMemory3.screenCount5
        bakemono.screenCount6 = bakemonoMemory3.screenCount6
        bakemono.screenCount7 = bakemonoMemory3.screenCount7
        bakemono.screenCount8 = bakemonoMemory3.screenCount8
        bakemono.screenCount9 = bakemonoMemory3.screenCount9
        bakemono.screenCount10 = bakemonoMemory3.screenCount10
        bakemono.screenCount11 = bakemonoMemory3.screenCount11
        bakemono.screenCountSum = bakemonoMemory3.screenCountSum
        
        // -------------
        // ver3.15.0で追加
        // -------------
        bakemono.koyakuCountJakuCherry = bakemonoMemory3.koyakuCountJakuCherry
        bakemono.jakuCherryAtCount = bakemonoMemory3.jakuCherryAtCount
        
        // ---------
        // ver3.17.1で追加
        // ---------
        bakemono.rareCzCountSuika = bakemonoMemory3.rareCzCountSuika
        bakemono.rareCzCountSuikaHit = bakemonoMemory3.rareCzCountSuikaHit
        bakemono.rareCzCountKyoCherry = bakemonoMemory3.rareCzCountKyoCherry
        bakemono.rareCzCountChance = bakemonoMemory3.rareCzCountChance
        bakemono.rareCzCountKyoRareSum = bakemonoMemory3.rareCzCountKyoRareSum
        bakemono.rareCzCountKyoRareHit = bakemonoMemory3.rareCzCountKyoRareHit
    }
}

#Preview {
    bakemonoViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
