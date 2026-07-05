//
//  karakuri2ViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/06/27.
//

import SwiftUI

struct karakuri2ViewTop: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @StateObject var karakuri2 = Karakuri2()
    @State var isShowAlert: Bool = false
    @StateObject var karakuri2Memory1 = Karakuri2Memory1()
    @StateObject var karakuri2Memory2 = Karakuri2Memory2()
    @StateObject var karakuri2Memory3 = Karakuri2Memory3()
    var body: some View {
        NavigationStack {
            List {
//                Section {
//                    // 注意事項
//                    Text("の利用を前提としています\n遊技前にを開始してください")
//                        .foregroundStyle(Color.secondary)
//                        .font(.footnote)
//                } header: {
//                    unitLabelMachineTopTitle(
//                        machineName: karakuri2.machineName,
//                    )
//                }
                
                Section {
                    // 通常時
                    NavigationLink(destination: karakuri2ViewNormal(
                        karakuri2: karakuri2,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.karakuri2MenuNormalBadge,
                        )
                    }
                    
                    // CZ履歴
                    NavigationLink(destination: karakuri2ViewHistory(
                        karakuri2: karakuri2,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "pencil.and.list.clipboard",
                            textBody: "CZ履歴",
                            badgeStatus: common.karakuri2MenuHistoryBadge,
                        )
                    }
                    
                    // 初当り
                    NavigationLink(destination: karakuri2ViewFirstHit(
                        karakuri2: karakuri2,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.karakuri2MenuFirstHitBadge,
                        )
                    }

                    // 終了画面
                    NavigationLink(destination: karakuri2ViewScreen(
                        karakuri2: karakuri2,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "AT終了画面",
                            badgeStatus: common.karakuri2MenuScreenBadge,
                        )
                    }

                } header: {
                    unitLabelMachineTopTitle(
                        machineName: karakuri2.machineName,
                        titleFont: .title,
                    )
                }
                
                // 設定推測グラフ
                NavigationLink(destination: karakuri2View95Ci(
                    karakuri2: karakuri2,
                    selection: 2,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: karakuri2ViewBayes(
                    karakuri2: karakuri2,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.karakuri2MenuBayesBadge
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/5019")
                
                // コピーライト
                unitSectionCopyright {
                    Text("原作／藤田和日郎「からくりサーカス」（小学館少年サンデーコミックス刊）")
                    Text("©藤田和日郎・小学館／ツインエンジン")
                }
            }
        }
        // //// バッジのリセット
        .resetMachineBadgeOnAppear(machines: $common.machines, targetId: "5019")
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: karakuri2.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(karakuri2SubViewLoadMemory(
                    karakuri2: karakuri2,
                    karakuri2Memory1: karakuri2Memory1,
                    karakuri2Memory2: karakuri2Memory2,
                    karakuri2Memory3: karakuri2Memory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(karakuri2SubViewSaveMemory(
                    karakuri2: karakuri2,
                    karakuri2Memory1: karakuri2Memory1,
                    karakuri2Memory2: karakuri2Memory2,
                    karakuri2Memory3: karakuri2Memory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: karakuri2.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct karakuri2SubViewSaveMemory: View {
    @ObservedObject var karakuri2: Karakuri2
    @ObservedObject var karakuri2Memory1: Karakuri2Memory1
    @ObservedObject var karakuri2Memory2: Karakuri2Memory2
    @ObservedObject var karakuri2Memory3: Karakuri2Memory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: karakuri2.machineName,
            selectedMemory: $karakuri2.selectedMemory,
            memoMemory1: $karakuri2Memory1.memo,
            dateDoubleMemory1: $karakuri2Memory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $karakuri2Memory2.memo,
            dateDoubleMemory2: $karakuri2Memory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $karakuri2Memory3.memo,
            dateDoubleMemory3: $karakuri2Memory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        karakuri2Memory1.normalGame = karakuri2.normalGame
        karakuri2Memory1.firstHitCountCz = karakuri2.firstHitCountCz
        karakuri2Memory1.firstHitCountAt = karakuri2.firstHitCountAt
        karakuri2Memory1.screenCount1 = karakuri2.screenCount1
        karakuri2Memory1.screenCount2 = karakuri2.screenCount2
        karakuri2Memory1.screenCount3 = karakuri2.screenCount3
        karakuri2Memory1.screenCount4 = karakuri2.screenCount4
        karakuri2Memory1.screenCount5 = karakuri2.screenCount5
        karakuri2Memory1.screenCount6 = karakuri2.screenCount6
        karakuri2Memory1.screenCountSum = karakuri2.screenCountSum
        karakuri2Memory1.gameArrayData = karakuri2.gameArrayData
        karakuri2Memory1.kindArrayData = karakuri2.kindArrayData
        karakuri2Memory1.screenArrayData = karakuri2.screenArrayData
    }
    func saveMemory2() {
        karakuri2Memory2.normalGame = karakuri2.normalGame
        karakuri2Memory2.firstHitCountCz = karakuri2.firstHitCountCz
        karakuri2Memory2.firstHitCountAt = karakuri2.firstHitCountAt
        karakuri2Memory2.screenCount1 = karakuri2.screenCount1
        karakuri2Memory2.screenCount2 = karakuri2.screenCount2
        karakuri2Memory2.screenCount3 = karakuri2.screenCount3
        karakuri2Memory2.screenCount4 = karakuri2.screenCount4
        karakuri2Memory2.screenCount5 = karakuri2.screenCount5
        karakuri2Memory2.screenCount6 = karakuri2.screenCount6
        karakuri2Memory2.screenCountSum = karakuri2.screenCountSum
        karakuri2Memory2.gameArrayData = karakuri2.gameArrayData
        karakuri2Memory2.kindArrayData = karakuri2.kindArrayData
        karakuri2Memory2.screenArrayData = karakuri2.screenArrayData
    }
    func saveMemory3() {
        karakuri2Memory3.normalGame = karakuri2.normalGame
        karakuri2Memory3.firstHitCountCz = karakuri2.firstHitCountCz
        karakuri2Memory3.firstHitCountAt = karakuri2.firstHitCountAt
        karakuri2Memory3.screenCount1 = karakuri2.screenCount1
        karakuri2Memory3.screenCount2 = karakuri2.screenCount2
        karakuri2Memory3.screenCount3 = karakuri2.screenCount3
        karakuri2Memory3.screenCount4 = karakuri2.screenCount4
        karakuri2Memory3.screenCount5 = karakuri2.screenCount5
        karakuri2Memory3.screenCount6 = karakuri2.screenCount6
        karakuri2Memory3.screenCountSum = karakuri2.screenCountSum
        karakuri2Memory3.gameArrayData = karakuri2.gameArrayData
        karakuri2Memory3.kindArrayData = karakuri2.kindArrayData
        karakuri2Memory3.screenArrayData = karakuri2.screenArrayData
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct karakuri2SubViewLoadMemory: View {
    @ObservedObject var karakuri2: Karakuri2
    @ObservedObject var karakuri2Memory1: Karakuri2Memory1
    @ObservedObject var karakuri2Memory2: Karakuri2Memory2
    @ObservedObject var karakuri2Memory3: Karakuri2Memory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: karakuri2.machineName,
            selectedMemory: $karakuri2.selectedMemory,
            memoMemory1: karakuri2Memory1.memo,
            dateDoubleMemory1: karakuri2Memory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: karakuri2Memory2.memo,
            dateDoubleMemory2: karakuri2Memory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: karakuri2Memory3.memo,
            dateDoubleMemory3: karakuri2Memory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        karakuri2.normalGame = karakuri2Memory1.normalGame
        karakuri2.firstHitCountCz = karakuri2Memory1.firstHitCountCz
        karakuri2.firstHitCountAt = karakuri2Memory1.firstHitCountAt
        karakuri2.screenCount1 = karakuri2Memory1.screenCount1
        karakuri2.screenCount2 = karakuri2Memory1.screenCount2
        karakuri2.screenCount3 = karakuri2Memory1.screenCount3
        karakuri2.screenCount4 = karakuri2Memory1.screenCount4
        karakuri2.screenCount5 = karakuri2Memory1.screenCount5
        karakuri2.screenCount6 = karakuri2Memory1.screenCount6
        karakuri2.screenCountSum = karakuri2Memory1.screenCountSum
        let gameArrayDataDecoded = decodeIntArray(from: karakuri2Memory1.gameArrayData)
        saveArray(gameArrayDataDecoded, forKey: karakuri2.gameArrayKey)
        let kindArrayDataDecoded = decodeStringArray(from: karakuri2Memory1.kindArrayData)
        saveArray(kindArrayDataDecoded, forKey: karakuri2.kindArrayKey)
        let screenArrayDataDecoded = decodeStringArray(from: karakuri2Memory1.screenArrayData)
        saveArray(screenArrayDataDecoded, forKey: karakuri2.screenArrayKey)
    }
    func loadMemory2() {
        karakuri2.normalGame = karakuri2Memory2.normalGame
        karakuri2.firstHitCountCz = karakuri2Memory2.firstHitCountCz
        karakuri2.firstHitCountAt = karakuri2Memory2.firstHitCountAt
        karakuri2.screenCount1 = karakuri2Memory2.screenCount1
        karakuri2.screenCount2 = karakuri2Memory2.screenCount2
        karakuri2.screenCount3 = karakuri2Memory2.screenCount3
        karakuri2.screenCount4 = karakuri2Memory2.screenCount4
        karakuri2.screenCount5 = karakuri2Memory2.screenCount5
        karakuri2.screenCount6 = karakuri2Memory2.screenCount6
        karakuri2.screenCountSum = karakuri2Memory2.screenCountSum
        let gameArrayDataDecoded = decodeIntArray(from: karakuri2Memory2.gameArrayData)
        saveArray(gameArrayDataDecoded, forKey: karakuri2.gameArrayKey)
        let kindArrayDataDecoded = decodeStringArray(from: karakuri2Memory2.kindArrayData)
        saveArray(kindArrayDataDecoded, forKey: karakuri2.kindArrayKey)
        let screenArrayDataDecoded = decodeStringArray(from: karakuri2Memory2.screenArrayData)
        saveArray(screenArrayDataDecoded, forKey: karakuri2.screenArrayKey)
    }
    func loadMemory3() {
        karakuri2.normalGame = karakuri2Memory3.normalGame
        karakuri2.firstHitCountCz = karakuri2Memory3.firstHitCountCz
        karakuri2.firstHitCountAt = karakuri2Memory3.firstHitCountAt
        karakuri2.screenCount1 = karakuri2Memory3.screenCount1
        karakuri2.screenCount2 = karakuri2Memory3.screenCount2
        karakuri2.screenCount3 = karakuri2Memory3.screenCount3
        karakuri2.screenCount4 = karakuri2Memory3.screenCount4
        karakuri2.screenCount5 = karakuri2Memory3.screenCount5
        karakuri2.screenCount6 = karakuri2Memory3.screenCount6
        karakuri2.screenCountSum = karakuri2Memory3.screenCountSum
        let gameArrayDataDecoded = decodeIntArray(from: karakuri2Memory3.gameArrayData)
        saveArray(gameArrayDataDecoded, forKey: karakuri2.gameArrayKey)
        let kindArrayDataDecoded = decodeStringArray(from: karakuri2Memory3.kindArrayData)
        saveArray(kindArrayDataDecoded, forKey: karakuri2.kindArrayKey)
        let screenArrayDataDecoded = decodeStringArray(from: karakuri2Memory3.screenArrayData)
        saveArray(screenArrayDataDecoded, forKey: karakuri2.screenArrayKey)
    }
}

#Preview {
    karakuri2ViewTop()
        .environmentObject(commonVar())
        .environmentObject(Bayes())
        .environmentObject(InterstitialViewModel())
}
