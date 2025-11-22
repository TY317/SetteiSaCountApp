//
//  neoplaViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/11/09.
//

import SwiftUI

struct neoplaViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var neopla = Neopla()
    @State var isShowAlert: Bool = false
    @StateObject var neoplaMemory1 = NeoplaMemory1()
    @StateObject var neoplaMemory2 = NeoplaMemory2()
    @StateObject var neoplaMemory3 = NeoplaMemory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 通常時
                    NavigationLink(destination: neoplaViewNormal(
                        neopla: neopla,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.neoplaMenuNormalBadge,
                        )
                    }
                    
                    // 初当り
                    NavigationLink(destination: neoplaViewFirstHit(
                        neopla: neopla,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り"
                        )
                    }
                    
                    // ボーナス中
                    NavigationLink(destination: neoplaViewDuringBonus(
                        neopla: neopla,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "globe.asia.australia",
                            textBody: "ボーナス中"
                        )
                    }
                    
                    // ボーナス終了画面
                    NavigationLink(destination: neoplaViewScreen(
                        neopla: neopla,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "ボーナス終了画面",
                            badgeStatus: common.neoplaMenuScreenBadge,
                        )
                    }
                    
                    // ケロッとトロフィー
                    NavigationLink(destination: commonViewKerottoTrophy()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "ケロットトロフィー")
                    }
                } header: {
                    unitLabelMachineTopTitle(machineName: neopla.machineName)
                }
                
                // 設定推測グラフ
                NavigationLink(destination: neoplaView95Ci(
                    neopla: neopla,
                    selection: 1,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: neoplaViewBayes(
                    neopla: neopla,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4873")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©︎SEVENLEAGUE")
                    Text("©︎YAMASA NEXT")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.neoplaMachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: neopla.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(neoplaSubViewLoadMemory(
                    neopla: neopla,
                    neoplaMemory1: neoplaMemory1,
                    neoplaMemory2: neoplaMemory2,
                    neoplaMemory3: neoplaMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(neoplaSubViewSaveMemory(
                    neopla: neopla,
                    neoplaMemory1: neoplaMemory1,
                    neoplaMemory2: neoplaMemory2,
                    neoplaMemory3: neoplaMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: neopla.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}

// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct neoplaSubViewSaveMemory: View {
    @ObservedObject var neopla: Neopla
    @ObservedObject var neoplaMemory1: NeoplaMemory1
    @ObservedObject var neoplaMemory2: NeoplaMemory2
    @ObservedObject var neoplaMemory3: NeoplaMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: neopla.machineName,
            selectedMemory: $neopla.selectedMemory,
            memoMemory1: $neoplaMemory1.memo,
            dateDoubleMemory1: $neoplaMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $neoplaMemory2.memo,
            dateDoubleMemory2: $neoplaMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $neoplaMemory3.memo,
            dateDoubleMemory3: $neoplaMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        neoplaMemory1.bonusCountBigRed = neopla.bonusCountBigRed
        neoplaMemory1.bonusCountBigBlue = neopla.bonusCountBigBlue
        neoplaMemory1.bonusCountBigSum = neopla.bonusCountBigSum
        neoplaMemory1.bonusCountReg = neopla.bonusCountReg
        neoplaMemory1.bonusCountSum = neopla.bonusCountSum
        neoplaMemory1.normalGame = neopla.normalGame
    }
    func saveMemory2() {
        neoplaMemory2.bonusCountBigRed = neopla.bonusCountBigRed
        neoplaMemory2.bonusCountBigBlue = neopla.bonusCountBigBlue
        neoplaMemory2.bonusCountBigSum = neopla.bonusCountBigSum
        neoplaMemory2.bonusCountReg = neopla.bonusCountReg
        neoplaMemory2.bonusCountSum = neopla.bonusCountSum
        neoplaMemory2.normalGame = neopla.normalGame
    }
    func saveMemory3() {
        neoplaMemory3.bonusCountBigRed = neopla.bonusCountBigRed
        neoplaMemory3.bonusCountBigBlue = neopla.bonusCountBigBlue
        neoplaMemory3.bonusCountBigSum = neopla.bonusCountBigSum
        neoplaMemory3.bonusCountReg = neopla.bonusCountReg
        neoplaMemory3.bonusCountSum = neopla.bonusCountSum
        neoplaMemory3.normalGame = neopla.normalGame
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct neoplaSubViewLoadMemory: View {
    @ObservedObject var neopla: Neopla
    @ObservedObject var neoplaMemory1: NeoplaMemory1
    @ObservedObject var neoplaMemory2: NeoplaMemory2
    @ObservedObject var neoplaMemory3: NeoplaMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: neopla.machineName,
            selectedMemory: $neopla.selectedMemory,
            memoMemory1: neoplaMemory1.memo,
            dateDoubleMemory1: neoplaMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: neoplaMemory2.memo,
            dateDoubleMemory2: neoplaMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: neoplaMemory3.memo,
            dateDoubleMemory3: neoplaMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        neopla.bonusCountBigRed = neoplaMemory1.bonusCountBigRed
        neopla.bonusCountBigBlue = neoplaMemory1.bonusCountBigBlue
        neopla.bonusCountBigSum = neoplaMemory1.bonusCountBigSum
        neopla.bonusCountReg = neoplaMemory1.bonusCountReg
        neopla.bonusCountSum = neoplaMemory1.bonusCountSum
        neopla.normalGame = neoplaMemory1.normalGame
    }
    func loadMemory2() {
        neopla.bonusCountBigRed = neoplaMemory2.bonusCountBigRed
        neopla.bonusCountBigBlue = neoplaMemory2.bonusCountBigBlue
        neopla.bonusCountBigSum = neoplaMemory2.bonusCountBigSum
        neopla.bonusCountReg = neoplaMemory2.bonusCountReg
        neopla.bonusCountSum = neoplaMemory2.bonusCountSum
        neopla.normalGame = neoplaMemory2.normalGame
    }
    func loadMemory3() {
        neopla.bonusCountBigRed = neoplaMemory3.bonusCountBigRed
        neopla.bonusCountBigBlue = neoplaMemory3.bonusCountBigBlue
        neopla.bonusCountBigSum = neoplaMemory3.bonusCountBigSum
        neopla.bonusCountReg = neoplaMemory3.bonusCountReg
        neopla.bonusCountSum = neoplaMemory3.bonusCountSum
        neopla.normalGame = neoplaMemory3.normalGame
    }
}

#Preview {
    neoplaViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
