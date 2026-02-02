//
//  enen2ViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/11.
//

import SwiftUI

struct enen2ViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var enen2 = Enen2()
    @State var isShowAlert: Bool = false
    @StateObject var enen2Memory1 = Enen2Memory1()
    @StateObject var enen2Memory2 = Enen2Memory2()
    @StateObject var enen2Memory3 = Enen2Memory3()
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 通常時
                    NavigationLink(destination: enen2ViewNormal(
                        enen2: enen2,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.enen2MenuNormalBadge,
                        )
                    }
                    
                    // 初当り
                    NavigationLink(destination: enen2ViewFirstHit(
                        enen2: enen2,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.enen2MenuFirstHitBadge,
                        )
                    }
                    
                    // REG
                    NavigationLink(destination: enen2ViewReg(
                        enen2: enen2,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "person.3.fill",
                            textBody: "REG",
                            badgeStatus: common.enen2MenuRegBadge,
                        )
                    }
                    
                    // ボーナス終了画面
                    NavigationLink(destination: enen2ViewScreen(
                        enen2: enen2,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "ボーナス終了画面",
                            badgeStatus: common.enen2MenuScreenBadge,
                        )
                    }
                    
                    // 伝道者の罠
                    NavigationLink(destination: enen2ViewWana(
                        enen2: enen2,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "flame.fill",
                            textBody: "伝道者の罠",
                            badgeStatus: common.enen2MenuWanaBadge,
                        )
                    }
                } header: {
                    unitLabelMachineTopTitle(machineName: enen2.machineName)
                }
                
                // 設定推測グラフ
                NavigationLink(destination: enen2View95Ci(
                    enen2: enen2,
                    selection: 1,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: enen2ViewBayes(
                    enen2: enen2,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.enen2MenuBayesBadge
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4926")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©大久保篤／講談社")
                    Text("©大久保篤・講談社／特殊消防隊動画広報課")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.enen2MachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: enen2.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(enen2SubViewLoadMemory(
                    enen2: enen2,
                    enen2Memory1: enen2Memory1,
                    enen2Memory2: enen2Memory2,
                    enen2Memory3: enen2Memory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(enen2SubViewSaveMemory(
                    enen2: enen2,
                    enen2Memory1: enen2Memory1,
                    enen2Memory2: enen2Memory2,
                    enen2Memory3: enen2Memory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: enen2.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct enen2SubViewSaveMemory: View {
    @ObservedObject var enen2: Enen2
    @ObservedObject var enen2Memory1: Enen2Memory1
    @ObservedObject var enen2Memory2: Enen2Memory2
    @ObservedObject var enen2Memory3: Enen2Memory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: enen2.machineName,
            selectedMemory: $enen2.selectedMemory,
            memoMemory1: $enen2Memory1.memo,
            dateDoubleMemory1: $enen2Memory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $enen2Memory2.memo,
            dateDoubleMemory2: $enen2Memory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $enen2Memory3.memo,
            dateDoubleMemory3: $enen2Memory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        enen2Memory1.normalGame = enen2.normalGame
        enen2Memory1.firstHitCountBonus = enen2.firstHitCountBonus
        enen2Memory1.firstHitCountLoop = enen2.firstHitCountLoop
        enen2Memory1.screenCount1 = enen2.screenCount1
        enen2Memory1.screenCount2 = enen2.screenCount2
        enen2Memory1.screenCount3 = enen2.screenCount3
        enen2Memory1.screenCount4 = enen2.screenCount4
        enen2Memory1.screenCount5 = enen2.screenCount5
        enen2Memory1.screenCount6 = enen2.screenCount6
        enen2Memory1.screenCountSum = enen2.screenCountSum
        enen2Memory1.wanaCountMiss = enen2.wanaCountMiss
        enen2Memory1.wanaCountHit = enen2.wanaCountHit
        enen2Memory1.wanaCountSum = enen2.wanaCountSum
    }
    func saveMemory2() {
        enen2Memory2.normalGame = enen2.normalGame
        enen2Memory2.firstHitCountBonus = enen2.firstHitCountBonus
        enen2Memory2.firstHitCountLoop = enen2.firstHitCountLoop
        enen2Memory2.screenCount1 = enen2.screenCount1
        enen2Memory2.screenCount2 = enen2.screenCount2
        enen2Memory2.screenCount3 = enen2.screenCount3
        enen2Memory2.screenCount4 = enen2.screenCount4
        enen2Memory2.screenCount5 = enen2.screenCount5
        enen2Memory2.screenCount6 = enen2.screenCount6
        enen2Memory2.screenCountSum = enen2.screenCountSum
        enen2Memory2.wanaCountMiss = enen2.wanaCountMiss
        enen2Memory2.wanaCountHit = enen2.wanaCountHit
        enen2Memory2.wanaCountSum = enen2.wanaCountSum
    }
    func saveMemory3() {
        enen2Memory3.normalGame = enen2.normalGame
        enen2Memory3.firstHitCountBonus = enen2.firstHitCountBonus
        enen2Memory3.firstHitCountLoop = enen2.firstHitCountLoop
        enen2Memory3.screenCount1 = enen2.screenCount1
        enen2Memory3.screenCount2 = enen2.screenCount2
        enen2Memory3.screenCount3 = enen2.screenCount3
        enen2Memory3.screenCount4 = enen2.screenCount4
        enen2Memory3.screenCount5 = enen2.screenCount5
        enen2Memory3.screenCount6 = enen2.screenCount6
        enen2Memory3.screenCountSum = enen2.screenCountSum
        enen2Memory3.wanaCountMiss = enen2.wanaCountMiss
        enen2Memory3.wanaCountHit = enen2.wanaCountHit
        enen2Memory3.wanaCountSum = enen2.wanaCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct enen2SubViewLoadMemory: View {
    @ObservedObject var enen2: Enen2
    @ObservedObject var enen2Memory1: Enen2Memory1
    @ObservedObject var enen2Memory2: Enen2Memory2
    @ObservedObject var enen2Memory3: Enen2Memory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: enen2.machineName,
            selectedMemory: $enen2.selectedMemory,
            memoMemory1: enen2Memory1.memo,
            dateDoubleMemory1: enen2Memory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: enen2Memory2.memo,
            dateDoubleMemory2: enen2Memory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: enen2Memory3.memo,
            dateDoubleMemory3: enen2Memory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        enen2.normalGame = enen2Memory1.normalGame
        enen2.firstHitCountBonus = enen2Memory1.firstHitCountBonus
        enen2.firstHitCountLoop = enen2Memory1.firstHitCountLoop
        enen2.screenCount1 = enen2Memory1.screenCount1
        enen2.screenCount2 = enen2Memory1.screenCount2
        enen2.screenCount3 = enen2Memory1.screenCount3
        enen2.screenCount4 = enen2Memory1.screenCount4
        enen2.screenCount5 = enen2Memory1.screenCount5
        enen2.screenCount6 = enen2Memory1.screenCount6
        enen2.screenCountSum = enen2Memory1.screenCountSum
        enen2.wanaCountMiss = enen2Memory1.wanaCountMiss
        enen2.wanaCountHit = enen2Memory1.wanaCountHit
        enen2.wanaCountSum = enen2Memory1.wanaCountSum
    }
    func loadMemory2() {
        enen2.normalGame = enen2Memory2.normalGame
        enen2.firstHitCountBonus = enen2Memory2.firstHitCountBonus
        enen2.firstHitCountLoop = enen2Memory2.firstHitCountLoop
        enen2.screenCount1 = enen2Memory2.screenCount1
        enen2.screenCount2 = enen2Memory2.screenCount2
        enen2.screenCount3 = enen2Memory2.screenCount3
        enen2.screenCount4 = enen2Memory2.screenCount4
        enen2.screenCount5 = enen2Memory2.screenCount5
        enen2.screenCount6 = enen2Memory2.screenCount6
        enen2.screenCountSum = enen2Memory2.screenCountSum
        enen2.wanaCountMiss = enen2Memory2.wanaCountMiss
        enen2.wanaCountHit = enen2Memory2.wanaCountHit
        enen2.wanaCountSum = enen2Memory2.wanaCountSum
    }
    func loadMemory3() {
        enen2.normalGame = enen2Memory3.normalGame
        enen2.firstHitCountBonus = enen2Memory3.firstHitCountBonus
        enen2.firstHitCountLoop = enen2Memory3.firstHitCountLoop
        enen2.screenCount1 = enen2Memory3.screenCount1
        enen2.screenCount2 = enen2Memory3.screenCount2
        enen2.screenCount3 = enen2Memory3.screenCount3
        enen2.screenCount4 = enen2Memory3.screenCount4
        enen2.screenCount5 = enen2Memory3.screenCount5
        enen2.screenCount6 = enen2Memory3.screenCount6
        enen2.screenCountSum = enen2Memory3.screenCountSum
        enen2.wanaCountMiss = enen2Memory3.wanaCountMiss
        enen2.wanaCountHit = enen2Memory3.wanaCountHit
        enen2.wanaCountSum = enen2Memory3.wanaCountSum
    }
}

#Preview {
    enen2ViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
