//
//  creaViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/24.
//

import SwiftUI

struct creaViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var crea = Crea()
    @State var isShowAlert: Bool = false
    @StateObject var creaMemory1 = CreaMemory1()
    @StateObject var creaMemory2 = CreaMemory2()
    @StateObject var creaMemory3 = CreaMemory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("ダイトモの利用を前提としています\n遊技前にダイトモを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                        .padding(.vertical, -5)
                } header: {
                    unitLabelMachineTopTitle(machineName: crea.machineName)
                }
                
                // //// メニュー
                Section {
                    // 通常時
                    NavigationLink(destination: creaViewNormal(
                        crea: crea,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.creaMenuNormalBadge,
                        )
                    }
                    // 初当り
                    NavigationLink(destination: creaViewFirstHit(
                        crea: crea,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り"
                        )
                    }
                    // REG中のカード
                    NavigationLink(destination: creaViewRegCard(
                        crea: crea,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "person.text.rectangle.fill",
                            textBody: "REG中のカード"
                        )
                    }
                    // BT中のハズレ
                    NavigationLink(destination: creaViewBt(
                        crea: crea,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "BT中",
                            badgeStatus: common.creaMenuBtBadge,
                        )
                    }
                    // BIG
                    NavigationLink(destination: creaViewStamp(
                        crea: crea,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "checkmark.seal.fill",
                            textBody: "BIG終了後のスタンプ"
                        )
                    }
                    // トロフィー
                    NavigationLink(destination: commonViewKopandaTrophy()) {
                        unitLabelMenu(imageSystemName: "trophy.fill", textBody: "コパンダトロフィー")
                    }
                }
                
                // 設定推測グラフ
                NavigationLink(destination: creaView95Ci(
                    crea: crea,
                    selection: 1,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }
                // 設定期待値計算
                NavigationLink(destination: creaViewBayes(
                    crea: crea,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4860")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©︎DAITO GIKEN,INC.")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.creaMachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: crea.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(creaSubViewLoadMemory(
                    crea: crea,
                    creaMemory1: creaMemory1,
                    creaMemory2: creaMemory2,
                    creaMemory3: creaMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(creaSubViewSaveMemory(
                    crea: crea,
                    creaMemory1: creaMemory1,
                    creaMemory2: creaMemory2,
                    creaMemory3: creaMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: crea.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
//            HStack {
//                HStack {
//                    // データ読み出し
//                    unitButtonLoadMemory(loadView: AnyView(creaSubViewLoadMemory(
//                        crea: crea,
//                        creaMemory1: creaMemory1,
//                        creaMemory2: creaMemory2,
//                        creaMemory3: creaMemory3
//                    )))
//                    // データ保存
//                    unitButtonSaveMemory(saveView: AnyView(creaSubViewSaveMemory(
//                        crea: crea,
//                        creaMemory1: creaMemory1,
//                        creaMemory2: creaMemory2,
//                        creaMemory3: creaMemory3
//                    )))
//                }
//                // データリセット
//                unitButtonReset(isShowAlert: $isShowAlert, action: crea.resetAll, message: "この機種のデータを全てリセットします")
//            }
        }
    }
}

// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct creaSubViewSaveMemory: View {
    @ObservedObject var crea: Crea
    @ObservedObject var creaMemory1: CreaMemory1
    @ObservedObject var creaMemory2: CreaMemory2
    @ObservedObject var creaMemory3: CreaMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: crea.machineName,
            selectedMemory: $crea.selectedMemory,
            memoMemory1: $creaMemory1.memo,
            dateDoubleMemory1: $creaMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $creaMemory2.memo,
            dateDoubleMemory2: $creaMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $creaMemory3.memo,
            dateDoubleMemory3: $creaMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        creaMemory1.koyakuCountBell = crea.koyakuCountBell
        creaMemory1.koyakuCountCherry = crea.koyakuCountCherry
        creaMemory1.koyakuCountSuika = crea.koyakuCountSuika
        creaMemory1.koyakuCountChance = crea.koyakuCountChance
        creaMemory1.chofukuCountBell = crea.chofukuCountBell
        creaMemory1.chofukuCountCherry = crea.chofukuCountCherry
        creaMemory1.chofukuCountSuika = crea.chofukuCountSuika
        creaMemory1.chofukuCountChance = crea.chofukuCountChance
        creaMemory1.gameNumberStart = crea.gameNumberStart
        creaMemory1.gameNumberCurrent = crea.gameNumberCurrent
        creaMemory1.gameNumberPlay = crea.gameNumberPlay
        creaMemory1.bonusCountBig = crea.bonusCountBig
        creaMemory1.bonusCountReg = crea.bonusCountReg
        creaMemory1.bonusCountSum = crea.bonusCountSum
        creaMemory1.regCardCountDefault = crea.regCardCountDefault
        creaMemory1.regCardCountHighJaku = crea.regCardCountHighJaku
        creaMemory1.regCardCountHighKyo = crea.regCardCountHighKyo
        creaMemory1.regCardCountOver4 = crea.regCardCountOver4
        creaMemory1.regCardCountOver6 = crea.regCardCountOver6
        creaMemory1.regCardCountSum = crea.regCardCountSum
        creaMemory1.stampCountDefault = crea.stampCountDefault
        creaMemory1.stampCountGusu = crea.stampCountGusu
        creaMemory1.stampCountHighJaku = crea.stampCountHighJaku
        creaMemory1.stampCountHighKyo = crea.stampCountHighKyo
        creaMemory1.stampCountSum = crea.stampCountSum
        
        // //////////////
        // ver3.11.0で追加
        // //////////////
        creaMemory1.btGame = crea.btGame
        creaMemory1.btHazure = crea.btHazure
        
        // ----------
        // ver3.13.1で追加
        // ----------
        creaMemory1.koyakuCountSuberiSuika = crea.koyakuCountSuberiSuika
        creaMemory1.koyakuCountPylamid = crea.koyakuCountPylamid
        creaMemory1.chofukuCountSuberiSuika = crea.chofukuCountSuberiSuika
        creaMemory1.chofukuCountPylamid = crea.chofukuCountPylamid
    }
    func saveMemory2() {
        creaMemory2.koyakuCountBell = crea.koyakuCountBell
        creaMemory2.koyakuCountCherry = crea.koyakuCountCherry
        creaMemory2.koyakuCountSuika = crea.koyakuCountSuika
        creaMemory2.koyakuCountChance = crea.koyakuCountChance
        creaMemory2.chofukuCountBell = crea.chofukuCountBell
        creaMemory2.chofukuCountCherry = crea.chofukuCountCherry
        creaMemory2.chofukuCountSuika = crea.chofukuCountSuika
        creaMemory2.chofukuCountChance = crea.chofukuCountChance
        creaMemory2.gameNumberStart = crea.gameNumberStart
        creaMemory2.gameNumberCurrent = crea.gameNumberCurrent
        creaMemory2.gameNumberPlay = crea.gameNumberPlay
        creaMemory2.bonusCountBig = crea.bonusCountBig
        creaMemory2.bonusCountReg = crea.bonusCountReg
        creaMemory2.bonusCountSum = crea.bonusCountSum
        creaMemory2.regCardCountDefault = crea.regCardCountDefault
        creaMemory2.regCardCountHighJaku = crea.regCardCountHighJaku
        creaMemory2.regCardCountHighKyo = crea.regCardCountHighKyo
        creaMemory2.regCardCountOver4 = crea.regCardCountOver4
        creaMemory2.regCardCountOver6 = crea.regCardCountOver6
        creaMemory2.regCardCountSum = crea.regCardCountSum
        creaMemory2.stampCountDefault = crea.stampCountDefault
        creaMemory2.stampCountGusu = crea.stampCountGusu
        creaMemory2.stampCountHighJaku = crea.stampCountHighJaku
        creaMemory2.stampCountHighKyo = crea.stampCountHighKyo
        creaMemory2.stampCountSum = crea.stampCountSum
        
        // //////////////
        // ver3.11.0で追加
        // //////////////
        creaMemory2.btGame = crea.btGame
        creaMemory2.btHazure = crea.btHazure
        
        // ----------
        // ver3.13.1で追加
        // ----------
        creaMemory2.koyakuCountSuberiSuika = crea.koyakuCountSuberiSuika
        creaMemory2.koyakuCountPylamid = crea.koyakuCountPylamid
        creaMemory2.chofukuCountSuberiSuika = crea.chofukuCountSuberiSuika
        creaMemory2.chofukuCountPylamid = crea.chofukuCountPylamid
    }
    func saveMemory3() {
        creaMemory3.koyakuCountBell = crea.koyakuCountBell
        creaMemory3.koyakuCountCherry = crea.koyakuCountCherry
        creaMemory3.koyakuCountSuika = crea.koyakuCountSuika
        creaMemory3.koyakuCountChance = crea.koyakuCountChance
        creaMemory3.chofukuCountBell = crea.chofukuCountBell
        creaMemory3.chofukuCountCherry = crea.chofukuCountCherry
        creaMemory3.chofukuCountSuika = crea.chofukuCountSuika
        creaMemory3.chofukuCountChance = crea.chofukuCountChance
        creaMemory3.gameNumberStart = crea.gameNumberStart
        creaMemory3.gameNumberCurrent = crea.gameNumberCurrent
        creaMemory3.gameNumberPlay = crea.gameNumberPlay
        creaMemory3.bonusCountBig = crea.bonusCountBig
        creaMemory3.bonusCountReg = crea.bonusCountReg
        creaMemory3.bonusCountSum = crea.bonusCountSum
        creaMemory3.regCardCountDefault = crea.regCardCountDefault
        creaMemory3.regCardCountHighJaku = crea.regCardCountHighJaku
        creaMemory3.regCardCountHighKyo = crea.regCardCountHighKyo
        creaMemory3.regCardCountOver4 = crea.regCardCountOver4
        creaMemory3.regCardCountOver6 = crea.regCardCountOver6
        creaMemory3.regCardCountSum = crea.regCardCountSum
        creaMemory3.stampCountDefault = crea.stampCountDefault
        creaMemory3.stampCountGusu = crea.stampCountGusu
        creaMemory3.stampCountHighJaku = crea.stampCountHighJaku
        creaMemory3.stampCountHighKyo = crea.stampCountHighKyo
        creaMemory3.stampCountSum = crea.stampCountSum
        
        // //////////////
        // ver3.11.0で追加
        // //////////////
        creaMemory3.btGame = crea.btGame
        creaMemory3.btHazure = crea.btHazure
        
        // ----------
        // ver3.13.1で追加
        // ----------
        creaMemory3.koyakuCountSuberiSuika = crea.koyakuCountSuberiSuika
        creaMemory3.koyakuCountPylamid = crea.koyakuCountPylamid
        creaMemory3.chofukuCountSuberiSuika = crea.chofukuCountSuberiSuika
        creaMemory3.chofukuCountPylamid = crea.chofukuCountPylamid
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct creaSubViewLoadMemory: View {
    @ObservedObject var crea: Crea
    @ObservedObject var creaMemory1: CreaMemory1
    @ObservedObject var creaMemory2: CreaMemory2
    @ObservedObject var creaMemory3: CreaMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: crea.machineName,
            selectedMemory: $crea.selectedMemory,
            memoMemory1: creaMemory1.memo,
            dateDoubleMemory1: creaMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: creaMemory2.memo,
            dateDoubleMemory2: creaMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: creaMemory3.memo,
            dateDoubleMemory3: creaMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        crea.koyakuCountBell = creaMemory1.koyakuCountBell
        crea.koyakuCountCherry = creaMemory1.koyakuCountCherry
        crea.koyakuCountSuika = creaMemory1.koyakuCountSuika
        crea.koyakuCountChance = creaMemory1.koyakuCountChance
        crea.chofukuCountBell = creaMemory1.chofukuCountBell
        crea.chofukuCountCherry = creaMemory1.chofukuCountCherry
        crea.chofukuCountSuika = creaMemory1.chofukuCountSuika
        crea.chofukuCountChance = creaMemory1.chofukuCountChance
        crea.gameNumberStart = creaMemory1.gameNumberStart
        crea.gameNumberCurrent = creaMemory1.gameNumberCurrent
        crea.gameNumberPlay = creaMemory1.gameNumberPlay
        crea.bonusCountBig = creaMemory1.bonusCountBig
        crea.bonusCountReg = creaMemory1.bonusCountReg
        crea.bonusCountSum = creaMemory1.bonusCountSum
        crea.regCardCountDefault = creaMemory1.regCardCountDefault
        crea.regCardCountHighJaku = creaMemory1.regCardCountHighJaku
        crea.regCardCountHighKyo = creaMemory1.regCardCountHighKyo
        crea.regCardCountOver4 = creaMemory1.regCardCountOver4
        crea.regCardCountOver6 = creaMemory1.regCardCountOver6
        crea.regCardCountSum = creaMemory1.regCardCountSum
        crea.stampCountDefault = creaMemory1.stampCountDefault
        crea.stampCountGusu = creaMemory1.stampCountGusu
        crea.stampCountHighJaku = creaMemory1.stampCountHighJaku
        crea.stampCountHighKyo = creaMemory1.stampCountHighKyo
        crea.stampCountSum = creaMemory1.stampCountSum
        
        // //////////////
        // ver3.11.0で追加
        // //////////////
        crea.btGame = creaMemory1.btGame
        crea.btHazure = creaMemory1.btHazure
        
        // ----------
        // ver3.13.1で追加
        // ----------
        crea.koyakuCountSuberiSuika = creaMemory1.koyakuCountSuberiSuika
        crea.koyakuCountPylamid = creaMemory1.koyakuCountPylamid
        crea.chofukuCountSuberiSuika = creaMemory1.chofukuCountSuberiSuika
        crea.chofukuCountPylamid = creaMemory1.chofukuCountPylamid
    }
    func loadMemory2() {
        crea.koyakuCountBell = creaMemory2.koyakuCountBell
        crea.koyakuCountCherry = creaMemory2.koyakuCountCherry
        crea.koyakuCountSuika = creaMemory2.koyakuCountSuika
        crea.koyakuCountChance = creaMemory2.koyakuCountChance
        crea.chofukuCountBell = creaMemory2.chofukuCountBell
        crea.chofukuCountCherry = creaMemory2.chofukuCountCherry
        crea.chofukuCountSuika = creaMemory2.chofukuCountSuika
        crea.chofukuCountChance = creaMemory2.chofukuCountChance
        crea.gameNumberStart = creaMemory2.gameNumberStart
        crea.gameNumberCurrent = creaMemory2.gameNumberCurrent
        crea.gameNumberPlay = creaMemory2.gameNumberPlay
        crea.bonusCountBig = creaMemory2.bonusCountBig
        crea.bonusCountReg = creaMemory2.bonusCountReg
        crea.bonusCountSum = creaMemory2.bonusCountSum
        crea.regCardCountDefault = creaMemory2.regCardCountDefault
        crea.regCardCountHighJaku = creaMemory2.regCardCountHighJaku
        crea.regCardCountHighKyo = creaMemory2.regCardCountHighKyo
        crea.regCardCountOver4 = creaMemory2.regCardCountOver4
        crea.regCardCountOver6 = creaMemory2.regCardCountOver6
        crea.regCardCountSum = creaMemory2.regCardCountSum
        crea.stampCountDefault = creaMemory2.stampCountDefault
        crea.stampCountGusu = creaMemory2.stampCountGusu
        crea.stampCountHighJaku = creaMemory2.stampCountHighJaku
        crea.stampCountHighKyo = creaMemory2.stampCountHighKyo
        crea.stampCountSum = creaMemory2.stampCountSum
        
        // //////////////
        // ver3.11.0で追加
        // //////////////
        crea.btGame = creaMemory2.btGame
        crea.btHazure = creaMemory2.btHazure
        
        // ----------
        // ver3.13.1で追加
        // ----------
        crea.koyakuCountSuberiSuika = creaMemory2.koyakuCountSuberiSuika
        crea.koyakuCountPylamid = creaMemory2.koyakuCountPylamid
        crea.chofukuCountSuberiSuika = creaMemory2.chofukuCountSuberiSuika
        crea.chofukuCountPylamid = creaMemory2.chofukuCountPylamid
    }
    func loadMemory3() {
        crea.koyakuCountBell = creaMemory3.koyakuCountBell
        crea.koyakuCountCherry = creaMemory3.koyakuCountCherry
        crea.koyakuCountSuika = creaMemory3.koyakuCountSuika
        crea.koyakuCountChance = creaMemory3.koyakuCountChance
        crea.chofukuCountBell = creaMemory3.chofukuCountBell
        crea.chofukuCountCherry = creaMemory3.chofukuCountCherry
        crea.chofukuCountSuika = creaMemory3.chofukuCountSuika
        crea.chofukuCountChance = creaMemory3.chofukuCountChance
        crea.gameNumberStart = creaMemory3.gameNumberStart
        crea.gameNumberCurrent = creaMemory3.gameNumberCurrent
        crea.gameNumberPlay = creaMemory3.gameNumberPlay
        crea.bonusCountBig = creaMemory3.bonusCountBig
        crea.bonusCountReg = creaMemory3.bonusCountReg
        crea.bonusCountSum = creaMemory3.bonusCountSum
        crea.regCardCountDefault = creaMemory3.regCardCountDefault
        crea.regCardCountHighJaku = creaMemory3.regCardCountHighJaku
        crea.regCardCountHighKyo = creaMemory3.regCardCountHighKyo
        crea.regCardCountOver4 = creaMemory3.regCardCountOver4
        crea.regCardCountOver6 = creaMemory3.regCardCountOver6
        crea.regCardCountSum = creaMemory3.regCardCountSum
        crea.stampCountDefault = creaMemory3.stampCountDefault
        crea.stampCountGusu = creaMemory3.stampCountGusu
        crea.stampCountHighJaku = creaMemory3.stampCountHighJaku
        crea.stampCountHighKyo = creaMemory3.stampCountHighKyo
        crea.stampCountSum = creaMemory3.stampCountSum
        
        // //////////////
        // ver3.11.0で追加
        // //////////////
        crea.btGame = creaMemory3.btGame
        crea.btHazure = creaMemory3.btHazure
        
        // ----------
        // ver3.13.1で追加
        // ----------
        crea.koyakuCountSuberiSuika = creaMemory3.koyakuCountSuberiSuika
        crea.koyakuCountPylamid = creaMemory3.koyakuCountPylamid
        crea.chofukuCountSuberiSuika = creaMemory3.chofukuCountSuberiSuika
        crea.chofukuCountPylamid = creaMemory3.chofukuCountPylamid
    }
}

#Preview {
    creaViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
