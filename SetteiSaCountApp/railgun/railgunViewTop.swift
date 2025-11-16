//
//  railgunViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/19.
//

import SwiftUI

struct railgunViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @State var isShowAlert: Bool = false
    @StateObject var railgun = Railgun()
    @StateObject var railgunMemory1 = RailgunMemory1()
    @StateObject var railgunMemory2 = RailgunMemory2()
    @StateObject var railgunMemory3 = RailgunMemory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 通常時
                    NavigationLink(destination: railgunViewNormal(
                        railgun: railgun,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時"
                        )
                    }
                    
                    // 初当り
                    NavigationLink(destination: railgunViewFirstHit(
                        railgun: railgun,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り"
                        )
                    }
                    
                    // AT中
                    NavigationLink(destination: railgunViewDuringAt(
                        railgun: railgun,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "AT中")
                    }
                    // AT終了画面
                    NavigationLink(destination: railgunViewScreen(
                        railgun: railgun,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "AT終了画面"
                        )
                    }
                    
                    // 藤丸コイン
                    NavigationLink(destination: commonViewFujimaruCoin()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "藤丸コイン"
                        )
                    }
                } header: {
                    unitLabelMachineTopTitle(machineName: railgun.machineName)
                }
                
                // 設定推測グラフ
                NavigationLink(destination: railgunView95Ci(
                    railgun: railgun,
                    selection: 1,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }
                // 設定期待値計算
                NavigationLink(destination: railgunViewBayes(
                    railgun: railgun,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4892")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©︎2018 鎌池和馬 ／冬川基 ／ＫＡＤＯＫＡＷＡ ／PROJECT-RAILGUN T")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.railgunMachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: railgun.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(railgunSubViewLoadMemory(
                    railgun: railgun,
                    railgunMemory1: railgunMemory1,
                    railgunMemory2: railgunMemory2,
                    railgunMemory3: railgunMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(railgunSubViewSaveMemory(
                    railgun: railgun,
                    railgunMemory1: railgunMemory1,
                    railgunMemory2: railgunMemory2,
                    railgunMemory3: railgunMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: railgun.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct railgunSubViewSaveMemory: View {
    @ObservedObject var railgun: Railgun
    @ObservedObject var railgunMemory1: RailgunMemory1
    @ObservedObject var railgunMemory2: RailgunMemory2
    @ObservedObject var railgunMemory3: RailgunMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: railgun.machineName,
            selectedMemory: $railgun.selectedMemory,
            memoMemory1: $railgunMemory1.memo,
            dateDoubleMemory1: $railgunMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $railgunMemory2.memo,
            dateDoubleMemory2: $railgunMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $railgunMemory3.memo,
            dateDoubleMemory3: $railgunMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        railgunMemory1.coinCount = railgun.coinCount
        railgunMemory1.coinCountCzHit = railgun.coinCountCzHit
        railgunMemory1.normalGame = railgun.normalGame
        railgunMemory1.czCount = railgun.czCount
        railgunMemory1.atCount = railgun.atCount
        railgunMemory1.ichimaieCount1 = railgun.ichimaieCount1
        railgunMemory1.ichimaieCount2 = railgun.ichimaieCount2
        railgunMemory1.ichimaieCount3 = railgun.ichimaieCount3
        railgunMemory1.ichimaieCount4 = railgun.ichimaieCount4
        railgunMemory1.ichimaieCount5 = railgun.ichimaieCount5
        railgunMemory1.ichimaieCount6 = railgun.ichimaieCount6
        railgunMemory1.ichimaieCount7 = railgun.ichimaieCount7
        railgunMemory1.ichimaieCountSum = railgun.ichimaieCountSum
        railgunMemory1.screenCountDefault = railgun.screenCountDefault
        railgunMemory1.screenCountGusu = railgun.screenCountGusu
        railgunMemory1.screenCountHighJaku = railgun.screenCountHighJaku
        railgunMemory1.screenCountHighKyo = railgun.screenCountHighKyo
        railgunMemory1.screenCountOver2 = railgun.screenCountOver2
        railgunMemory1.screenCountOver3 = railgun.screenCountOver3
        railgunMemory1.screenCountOver4 = railgun.screenCountOver4
        railgunMemory1.screenCountOver5 = railgun.screenCountOver5
        railgunMemory1.screenCountOver6 = railgun.screenCountOver6
        railgunMemory1.screenCountSum = railgun.screenCountSum
    }
    func saveMemory2() {
        railgunMemory2.coinCount = railgun.coinCount
        railgunMemory2.coinCountCzHit = railgun.coinCountCzHit
        railgunMemory2.normalGame = railgun.normalGame
        railgunMemory2.czCount = railgun.czCount
        railgunMemory2.atCount = railgun.atCount
        railgunMemory2.ichimaieCount1 = railgun.ichimaieCount1
        railgunMemory2.ichimaieCount2 = railgun.ichimaieCount2
        railgunMemory2.ichimaieCount3 = railgun.ichimaieCount3
        railgunMemory2.ichimaieCount4 = railgun.ichimaieCount4
        railgunMemory2.ichimaieCount5 = railgun.ichimaieCount5
        railgunMemory2.ichimaieCount6 = railgun.ichimaieCount6
        railgunMemory2.ichimaieCount7 = railgun.ichimaieCount7
        railgunMemory2.ichimaieCountSum = railgun.ichimaieCountSum
        railgunMemory2.screenCountDefault = railgun.screenCountDefault
        railgunMemory2.screenCountGusu = railgun.screenCountGusu
        railgunMemory2.screenCountHighJaku = railgun.screenCountHighJaku
        railgunMemory2.screenCountHighKyo = railgun.screenCountHighKyo
        railgunMemory2.screenCountOver2 = railgun.screenCountOver2
        railgunMemory2.screenCountOver3 = railgun.screenCountOver3
        railgunMemory2.screenCountOver4 = railgun.screenCountOver4
        railgunMemory2.screenCountOver5 = railgun.screenCountOver5
        railgunMemory2.screenCountOver6 = railgun.screenCountOver6
        railgunMemory2.screenCountSum = railgun.screenCountSum
    }
    func saveMemory3() {
        railgunMemory3.coinCount = railgun.coinCount
        railgunMemory3.coinCountCzHit = railgun.coinCountCzHit
        railgunMemory3.normalGame = railgun.normalGame
        railgunMemory3.czCount = railgun.czCount
        railgunMemory3.atCount = railgun.atCount
        railgunMemory3.ichimaieCount1 = railgun.ichimaieCount1
        railgunMemory3.ichimaieCount2 = railgun.ichimaieCount2
        railgunMemory3.ichimaieCount3 = railgun.ichimaieCount3
        railgunMemory3.ichimaieCount4 = railgun.ichimaieCount4
        railgunMemory3.ichimaieCount5 = railgun.ichimaieCount5
        railgunMemory3.ichimaieCount6 = railgun.ichimaieCount6
        railgunMemory3.ichimaieCount7 = railgun.ichimaieCount7
        railgunMemory3.ichimaieCountSum = railgun.ichimaieCountSum
        railgunMemory3.screenCountDefault = railgun.screenCountDefault
        railgunMemory3.screenCountGusu = railgun.screenCountGusu
        railgunMemory3.screenCountHighJaku = railgun.screenCountHighJaku
        railgunMemory3.screenCountHighKyo = railgun.screenCountHighKyo
        railgunMemory3.screenCountOver2 = railgun.screenCountOver2
        railgunMemory3.screenCountOver3 = railgun.screenCountOver3
        railgunMemory3.screenCountOver4 = railgun.screenCountOver4
        railgunMemory3.screenCountOver5 = railgun.screenCountOver5
        railgunMemory3.screenCountOver6 = railgun.screenCountOver6
        railgunMemory3.screenCountSum = railgun.screenCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct railgunSubViewLoadMemory: View {
    @ObservedObject var railgun: Railgun
    @ObservedObject var railgunMemory1: RailgunMemory1
    @ObservedObject var railgunMemory2: RailgunMemory2
    @ObservedObject var railgunMemory3: RailgunMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: railgun.machineName,
            selectedMemory: $railgun.selectedMemory,
            memoMemory1: railgunMemory1.memo,
            dateDoubleMemory1: railgunMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: railgunMemory2.memo,
            dateDoubleMemory2: railgunMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: railgunMemory3.memo,
            dateDoubleMemory3: railgunMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        railgun.coinCount = railgunMemory1.coinCount
        railgun.coinCountCzHit = railgunMemory1.coinCountCzHit
        railgun.normalGame = railgunMemory1.normalGame
        railgun.czCount = railgunMemory1.czCount
        railgun.atCount = railgunMemory1.atCount
        railgun.ichimaieCount1 = railgunMemory1.ichimaieCount1
        railgun.ichimaieCount2 = railgunMemory1.ichimaieCount2
        railgun.ichimaieCount3 = railgunMemory1.ichimaieCount3
        railgun.ichimaieCount4 = railgunMemory1.ichimaieCount4
        railgun.ichimaieCount5 = railgunMemory1.ichimaieCount5
        railgun.ichimaieCount6 = railgunMemory1.ichimaieCount6
        railgun.ichimaieCount7 = railgunMemory1.ichimaieCount7
        railgun.ichimaieCountSum = railgunMemory1.ichimaieCountSum
        railgun.screenCountDefault = railgunMemory1.screenCountDefault
        railgun.screenCountGusu = railgunMemory1.screenCountGusu
        railgun.screenCountHighJaku = railgunMemory1.screenCountHighJaku
        railgun.screenCountHighKyo = railgunMemory1.screenCountHighKyo
        railgun.screenCountOver2 = railgunMemory1.screenCountOver2
        railgun.screenCountOver3 = railgunMemory1.screenCountOver3
        railgun.screenCountOver4 = railgunMemory1.screenCountOver4
        railgun.screenCountOver5 = railgunMemory1.screenCountOver5
        railgun.screenCountOver6 = railgunMemory1.screenCountOver6
        railgun.screenCountSum = railgunMemory1.screenCountSum
    }
    func loadMemory2() {
        railgun.coinCount = railgunMemory2.coinCount
        railgun.coinCountCzHit = railgunMemory2.coinCountCzHit
        railgun.normalGame = railgunMemory2.normalGame
        railgun.czCount = railgunMemory2.czCount
        railgun.atCount = railgunMemory2.atCount
        railgun.ichimaieCount1 = railgunMemory2.ichimaieCount1
        railgun.ichimaieCount2 = railgunMemory2.ichimaieCount2
        railgun.ichimaieCount3 = railgunMemory2.ichimaieCount3
        railgun.ichimaieCount4 = railgunMemory2.ichimaieCount4
        railgun.ichimaieCount5 = railgunMemory2.ichimaieCount5
        railgun.ichimaieCount6 = railgunMemory2.ichimaieCount6
        railgun.ichimaieCount7 = railgunMemory2.ichimaieCount7
        railgun.ichimaieCountSum = railgunMemory2.ichimaieCountSum
        railgun.screenCountDefault = railgunMemory2.screenCountDefault
        railgun.screenCountGusu = railgunMemory2.screenCountGusu
        railgun.screenCountHighJaku = railgunMemory2.screenCountHighJaku
        railgun.screenCountHighKyo = railgunMemory2.screenCountHighKyo
        railgun.screenCountOver2 = railgunMemory2.screenCountOver2
        railgun.screenCountOver3 = railgunMemory2.screenCountOver3
        railgun.screenCountOver4 = railgunMemory2.screenCountOver4
        railgun.screenCountOver5 = railgunMemory2.screenCountOver5
        railgun.screenCountOver6 = railgunMemory2.screenCountOver6
        railgun.screenCountSum = railgunMemory2.screenCountSum
    }
    func loadMemory3() {
        railgun.coinCount = railgunMemory3.coinCount
        railgun.coinCountCzHit = railgunMemory3.coinCountCzHit
        railgun.normalGame = railgunMemory3.normalGame
        railgun.czCount = railgunMemory3.czCount
        railgun.atCount = railgunMemory3.atCount
        railgun.ichimaieCount1 = railgunMemory3.ichimaieCount1
        railgun.ichimaieCount2 = railgunMemory3.ichimaieCount2
        railgun.ichimaieCount3 = railgunMemory3.ichimaieCount3
        railgun.ichimaieCount4 = railgunMemory3.ichimaieCount4
        railgun.ichimaieCount5 = railgunMemory3.ichimaieCount5
        railgun.ichimaieCount6 = railgunMemory3.ichimaieCount6
        railgun.ichimaieCount7 = railgunMemory3.ichimaieCount7
        railgun.ichimaieCountSum = railgunMemory3.ichimaieCountSum
        railgun.screenCountDefault = railgunMemory3.screenCountDefault
        railgun.screenCountGusu = railgunMemory3.screenCountGusu
        railgun.screenCountHighJaku = railgunMemory3.screenCountHighJaku
        railgun.screenCountHighKyo = railgunMemory3.screenCountHighKyo
        railgun.screenCountOver2 = railgunMemory3.screenCountOver2
        railgun.screenCountOver3 = railgunMemory3.screenCountOver3
        railgun.screenCountOver4 = railgunMemory3.screenCountOver4
        railgun.screenCountOver5 = railgunMemory3.screenCountOver5
        railgun.screenCountOver6 = railgunMemory3.screenCountOver6
        railgun.screenCountSum = railgunMemory3.screenCountSum
    }
}

#Preview {
    railgunViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
