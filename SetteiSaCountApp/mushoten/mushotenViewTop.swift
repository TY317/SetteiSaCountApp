//
//  mushotenViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/03.
//

import SwiftUI

struct mushotenViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var mushoten = Mushoten()
    @State var isShowAlert: Bool = false
    @StateObject var mushotenMemory1 = MushotenMemory1()
    @StateObject var mushotenMemory2 = MushotenMemory2()
    @StateObject var mushotenMemory3 = MushotenMemory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 通常時
                    NavigationLink(destination: mushotenViewNormal(
                        mushoten: mushoten,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.mushotenMenuNormalBadge,
                        )
                    }
                    
                    // CZ
                    NavigationLink(destination: mushotenViewCz(
                        mushoten: mushoten,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "scope",
                            textBody: "CZ 無職チャンス",
                            badgeStatus: common.mushotenMenuCzBadge,
                        )
                    }
                    
                    // 初当り
                    NavigationLink(destination: mushotenViewFirstHit(
                        mushoten: mushoten,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.mushotenMenuFirstHitBadge,
                        )
                    }
                    
                    // 魔術ボーナス
                    NavigationLink(destination: mushotenViewReg(
                        mushoten: mushoten,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "book.closed.fill",
                            textBody: "魔術ボーナス",
                            badgeStatus: common.mushotenMenuRegBadge,
                        )
                    }
                    
                    // 終了画面
                    NavigationLink(destination: mushotenViewScreen(
                        mushoten: mushoten,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "ボーナス,AT 終了画面",
                            badgeStatus: common.mushotenMenuScreenBadge,
                        )
                    }
                    
                    // AT中
                    NavigationLink(destination: mushotenViewDuringAt(
                        mushoten: mushoten,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "AT 異世界行ったら本気だす",
                            badgeStatus: common.mushotenMenuAtBadge,
                        )
                    }
                    
                    // エンディング
                    NavigationLink(destination: mushotenViewEnding(
                        mushoten: mushoten,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "flag.pattern.checkered",
                            textBody: "エンディング",
                            badgeStatus: common.mushotenMenuEndingBadge,
                        )
                    }
                    
                    // ギンちゃんトロフィー
                    NavigationLink(destination: commonViewGinchanTrophy()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "ギンちゃんトロフィー"
                        )
                    }
                } header: {
                    unitLabelMachineTopTitle(machineName: mushoten.machineName)
                }
                
                // 設定推測グラフ
                NavigationLink(destination: mushotenView95Ci(
                    mushoten: mushoten,
                    selection: 1,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: mushotenViewBayes(
                    mushoten: mushoten,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.mushotenMenuBayesBadge
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4924")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©理不尽な孫の手/MFブックス/「無職転生II」製作委員会")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.mushotenMachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: mushoten.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(mushotenSubViewLoadMemory(
                    mushoten: mushoten,
                    mushotenMemory1: mushotenMemory1,
                    mushotenMemory2: mushotenMemory2,
                    mushotenMemory3: mushotenMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(mushotenSubViewSaveMemory(
                    mushoten: mushoten,
                    mushotenMemory1: mushotenMemory1,
                    mushotenMemory2: mushotenMemory2,
                    mushotenMemory3: mushotenMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: mushoten.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct mushotenSubViewSaveMemory: View {
    @ObservedObject var mushoten: Mushoten
    @ObservedObject var mushotenMemory1: MushotenMemory1
    @ObservedObject var mushotenMemory2: MushotenMemory2
    @ObservedObject var mushotenMemory3: MushotenMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: mushoten.machineName,
            selectedMemory: $mushoten.selectedMemory,
            memoMemory1: $mushotenMemory1.memo,
            dateDoubleMemory1: $mushotenMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $mushotenMemory2.memo,
            dateDoubleMemory2: $mushotenMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $mushotenMemory3.memo,
            dateDoubleMemory3: $mushotenMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        mushotenMemory1.hitogamiCountMove = mushoten.hitogamiCountMove
        mushotenMemory1.hitogamiCountHit = mushoten.hitogamiCountHit
        mushotenMemory1.gameNumberStart = mushoten.gameNumberStart
        mushotenMemory1.gameNumberCurrent = mushoten.gameNumberCurrent
        mushotenMemory1.gameNumberPlay = mushoten.gameNumberPlay
        mushotenMemory1.czCount = mushoten.czCount
        mushotenMemory1.normalGame = mushoten.normalGame
        mushotenMemory1.firstHitCountBig = mushoten.firstHitCountBig
        mushotenMemory1.firstHitCountReg = mushoten.firstHitCountReg
        mushotenMemory1.firstHitCountBonusSum = mushoten.firstHitCountBonusSum
        mushotenMemory1.firstHitCountAt = mushoten.firstHitCountAt
        mushotenMemory1.storyCountDefault = mushoten.storyCountDefault
        mushotenMemory1.storyCountHighJaku = mushoten.storyCountHighJaku
        mushotenMemory1.storyCountHighKyo = mushoten.storyCountHighKyo
        mushotenMemory1.storyCountOver2 = mushoten.storyCountOver2
        mushotenMemory1.storyCountOver4 = mushoten.storyCountOver4
        mushotenMemory1.storyCountOver6 = mushoten.storyCountOver6
        mushotenMemory1.storyCountSum = mushoten.storyCountSum
        mushotenMemory1.screenCountDefault = mushoten.screenCountDefault
        mushotenMemory1.screenCountGusu = mushoten.screenCountGusu
        mushotenMemory1.screenCountHighJaku = mushoten.screenCountHighJaku
        mushotenMemory1.screenCountHighKyo = mushoten.screenCountHighKyo
        mushotenMemory1.screenCountOver2 = mushoten.screenCountOver2
        mushotenMemory1.screenCountOver4 = mushoten.screenCountOver4
        mushotenMemory1.screenCountOver6 = mushoten.screenCountOver6
        mushotenMemory1.screenCountSum = mushoten.screenCountSum
    }
    func saveMemory2() {
        mushotenMemory2.hitogamiCountMove = mushoten.hitogamiCountMove
        mushotenMemory2.hitogamiCountHit = mushoten.hitogamiCountHit
        mushotenMemory2.gameNumberStart = mushoten.gameNumberStart
        mushotenMemory2.gameNumberCurrent = mushoten.gameNumberCurrent
        mushotenMemory2.gameNumberPlay = mushoten.gameNumberPlay
        mushotenMemory2.czCount = mushoten.czCount
        mushotenMemory2.normalGame = mushoten.normalGame
        mushotenMemory2.firstHitCountBig = mushoten.firstHitCountBig
        mushotenMemory2.firstHitCountReg = mushoten.firstHitCountReg
        mushotenMemory2.firstHitCountBonusSum = mushoten.firstHitCountBonusSum
        mushotenMemory2.firstHitCountAt = mushoten.firstHitCountAt
        mushotenMemory2.storyCountDefault = mushoten.storyCountDefault
        mushotenMemory2.storyCountHighJaku = mushoten.storyCountHighJaku
        mushotenMemory2.storyCountHighKyo = mushoten.storyCountHighKyo
        mushotenMemory2.storyCountOver2 = mushoten.storyCountOver2
        mushotenMemory2.storyCountOver4 = mushoten.storyCountOver4
        mushotenMemory2.storyCountOver6 = mushoten.storyCountOver6
        mushotenMemory2.storyCountSum = mushoten.storyCountSum
        mushotenMemory2.screenCountDefault = mushoten.screenCountDefault
        mushotenMemory2.screenCountGusu = mushoten.screenCountGusu
        mushotenMemory2.screenCountHighJaku = mushoten.screenCountHighJaku
        mushotenMemory2.screenCountHighKyo = mushoten.screenCountHighKyo
        mushotenMemory2.screenCountOver2 = mushoten.screenCountOver2
        mushotenMemory2.screenCountOver4 = mushoten.screenCountOver4
        mushotenMemory2.screenCountOver6 = mushoten.screenCountOver6
        mushotenMemory2.screenCountSum = mushoten.screenCountSum
    }
    func saveMemory3() {
        mushotenMemory3.hitogamiCountMove = mushoten.hitogamiCountMove
        mushotenMemory3.hitogamiCountHit = mushoten.hitogamiCountHit
        mushotenMemory3.gameNumberStart = mushoten.gameNumberStart
        mushotenMemory3.gameNumberCurrent = mushoten.gameNumberCurrent
        mushotenMemory3.gameNumberPlay = mushoten.gameNumberPlay
        mushotenMemory3.czCount = mushoten.czCount
        mushotenMemory3.normalGame = mushoten.normalGame
        mushotenMemory3.firstHitCountBig = mushoten.firstHitCountBig
        mushotenMemory3.firstHitCountReg = mushoten.firstHitCountReg
        mushotenMemory3.firstHitCountBonusSum = mushoten.firstHitCountBonusSum
        mushotenMemory3.firstHitCountAt = mushoten.firstHitCountAt
        mushotenMemory3.storyCountDefault = mushoten.storyCountDefault
        mushotenMemory3.storyCountHighJaku = mushoten.storyCountHighJaku
        mushotenMemory3.storyCountHighKyo = mushoten.storyCountHighKyo
        mushotenMemory3.storyCountOver2 = mushoten.storyCountOver2
        mushotenMemory3.storyCountOver4 = mushoten.storyCountOver4
        mushotenMemory3.storyCountOver6 = mushoten.storyCountOver6
        mushotenMemory3.storyCountSum = mushoten.storyCountSum
        mushotenMemory3.screenCountDefault = mushoten.screenCountDefault
        mushotenMemory3.screenCountGusu = mushoten.screenCountGusu
        mushotenMemory3.screenCountHighJaku = mushoten.screenCountHighJaku
        mushotenMemory3.screenCountHighKyo = mushoten.screenCountHighKyo
        mushotenMemory3.screenCountOver2 = mushoten.screenCountOver2
        mushotenMemory3.screenCountOver4 = mushoten.screenCountOver4
        mushotenMemory3.screenCountOver6 = mushoten.screenCountOver6
        mushotenMemory3.screenCountSum = mushoten.screenCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct mushotenSubViewLoadMemory: View {
    @ObservedObject var mushoten: Mushoten
    @ObservedObject var mushotenMemory1: MushotenMemory1
    @ObservedObject var mushotenMemory2: MushotenMemory2
    @ObservedObject var mushotenMemory3: MushotenMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: mushoten.machineName,
            selectedMemory: $mushoten.selectedMemory,
            memoMemory1: mushotenMemory1.memo,
            dateDoubleMemory1: mushotenMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: mushotenMemory2.memo,
            dateDoubleMemory2: mushotenMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: mushotenMemory3.memo,
            dateDoubleMemory3: mushotenMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        mushoten.hitogamiCountMove = mushotenMemory1.hitogamiCountMove
        mushoten.hitogamiCountHit = mushotenMemory1.hitogamiCountHit
        mushoten.gameNumberStart = mushotenMemory1.gameNumberStart
        mushoten.gameNumberCurrent = mushotenMemory1.gameNumberCurrent
        mushoten.gameNumberPlay = mushotenMemory1.gameNumberPlay
        mushoten.czCount = mushotenMemory1.czCount
        mushoten.normalGame = mushotenMemory1.normalGame
        mushoten.firstHitCountBig = mushotenMemory1.firstHitCountBig
        mushoten.firstHitCountReg = mushotenMemory1.firstHitCountReg
        mushoten.firstHitCountBonusSum = mushotenMemory1.firstHitCountBonusSum
        mushoten.firstHitCountAt = mushotenMemory1.firstHitCountAt
        mushoten.storyCountDefault = mushotenMemory1.storyCountDefault
        mushoten.storyCountHighJaku = mushotenMemory1.storyCountHighJaku
        mushoten.storyCountHighKyo = mushotenMemory1.storyCountHighKyo
        mushoten.storyCountOver2 = mushotenMemory1.storyCountOver2
        mushoten.storyCountOver4 = mushotenMemory1.storyCountOver4
        mushoten.storyCountOver6 = mushotenMemory1.storyCountOver6
        mushoten.storyCountSum = mushotenMemory1.storyCountSum
        mushoten.screenCountDefault = mushotenMemory1.screenCountDefault
        mushoten.screenCountGusu = mushotenMemory1.screenCountGusu
        mushoten.screenCountHighJaku = mushotenMemory1.screenCountHighJaku
        mushoten.screenCountHighKyo = mushotenMemory1.screenCountHighKyo
        mushoten.screenCountOver2 = mushotenMemory1.screenCountOver2
        mushoten.screenCountOver4 = mushotenMemory1.screenCountOver4
        mushoten.screenCountOver6 = mushotenMemory1.screenCountOver6
        mushoten.screenCountSum = mushotenMemory1.screenCountSum
    }
    func loadMemory2() {
        mushoten.hitogamiCountMove = mushotenMemory2.hitogamiCountMove
        mushoten.hitogamiCountHit = mushotenMemory2.hitogamiCountHit
        mushoten.gameNumberStart = mushotenMemory2.gameNumberStart
        mushoten.gameNumberCurrent = mushotenMemory2.gameNumberCurrent
        mushoten.gameNumberPlay = mushotenMemory2.gameNumberPlay
        mushoten.czCount = mushotenMemory2.czCount
        mushoten.normalGame = mushotenMemory2.normalGame
        mushoten.firstHitCountBig = mushotenMemory2.firstHitCountBig
        mushoten.firstHitCountReg = mushotenMemory2.firstHitCountReg
        mushoten.firstHitCountBonusSum = mushotenMemory2.firstHitCountBonusSum
        mushoten.firstHitCountAt = mushotenMemory2.firstHitCountAt
        mushoten.storyCountDefault = mushotenMemory2.storyCountDefault
        mushoten.storyCountHighJaku = mushotenMemory2.storyCountHighJaku
        mushoten.storyCountHighKyo = mushotenMemory2.storyCountHighKyo
        mushoten.storyCountOver2 = mushotenMemory2.storyCountOver2
        mushoten.storyCountOver4 = mushotenMemory2.storyCountOver4
        mushoten.storyCountOver6 = mushotenMemory2.storyCountOver6
        mushoten.storyCountSum = mushotenMemory2.storyCountSum
        mushoten.screenCountDefault = mushotenMemory2.screenCountDefault
        mushoten.screenCountGusu = mushotenMemory2.screenCountGusu
        mushoten.screenCountHighJaku = mushotenMemory2.screenCountHighJaku
        mushoten.screenCountHighKyo = mushotenMemory2.screenCountHighKyo
        mushoten.screenCountOver2 = mushotenMemory2.screenCountOver2
        mushoten.screenCountOver4 = mushotenMemory2.screenCountOver4
        mushoten.screenCountOver6 = mushotenMemory2.screenCountOver6
        mushoten.screenCountSum = mushotenMemory2.screenCountSum
    }
    func loadMemory3() {
        mushoten.hitogamiCountMove = mushotenMemory3.hitogamiCountMove
        mushoten.hitogamiCountHit = mushotenMemory3.hitogamiCountHit
        mushoten.gameNumberStart = mushotenMemory3.gameNumberStart
        mushoten.gameNumberCurrent = mushotenMemory3.gameNumberCurrent
        mushoten.gameNumberPlay = mushotenMemory3.gameNumberPlay
        mushoten.czCount = mushotenMemory3.czCount
        mushoten.normalGame = mushotenMemory3.normalGame
        mushoten.firstHitCountBig = mushotenMemory3.firstHitCountBig
        mushoten.firstHitCountReg = mushotenMemory3.firstHitCountReg
        mushoten.firstHitCountBonusSum = mushotenMemory3.firstHitCountBonusSum
        mushoten.firstHitCountAt = mushotenMemory3.firstHitCountAt
        mushoten.storyCountDefault = mushotenMemory3.storyCountDefault
        mushoten.storyCountHighJaku = mushotenMemory3.storyCountHighJaku
        mushoten.storyCountHighKyo = mushotenMemory3.storyCountHighKyo
        mushoten.storyCountOver2 = mushotenMemory3.storyCountOver2
        mushoten.storyCountOver4 = mushotenMemory3.storyCountOver4
        mushoten.storyCountOver6 = mushotenMemory3.storyCountOver6
        mushoten.storyCountSum = mushotenMemory3.storyCountSum
        mushoten.screenCountDefault = mushotenMemory3.screenCountDefault
        mushoten.screenCountGusu = mushotenMemory3.screenCountGusu
        mushoten.screenCountHighJaku = mushotenMemory3.screenCountHighJaku
        mushoten.screenCountHighKyo = mushotenMemory3.screenCountHighKyo
        mushoten.screenCountOver2 = mushotenMemory3.screenCountOver2
        mushoten.screenCountOver4 = mushotenMemory3.screenCountOver4
        mushoten.screenCountOver6 = mushotenMemory3.screenCountOver6
        mushoten.screenCountSum = mushotenMemory3.screenCountSum
    }
}

#Preview {
    mushotenViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
