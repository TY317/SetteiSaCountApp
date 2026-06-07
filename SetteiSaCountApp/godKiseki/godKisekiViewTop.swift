//
//  godKisekiViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/13.
//

import SwiftUI

struct godKisekiViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var godKiseki = GodKiseki()
    @State var isShowAlert: Bool = false
    @StateObject var godKisekiMemory1 = GodKisekiMemory1()
    @StateObject var godKisekiMemory2 = GodKisekiMemory2()
    @StateObject var godKisekiMemory3 = GodKisekiMemory3()
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("ユニメモの利用を前提としています\n遊技前にユニメモを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(
                        machineName: godKiseki.machineName,
                        titleFont: .title2,
                    )
                }
                
                Section {
                    // 通常時
                    NavigationLink(destination: godKisekiViewNormal(
                        godKiseki: godKiseki,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.godKisekiMenuNormalBadge,
                        )
                    }
                    
//                    // CZ
//                    NavigationLink(destination: godKisekiViewCz(
//                        godKiseki: godKiseki,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "scope",
//                            textBody: "CZ",
//                            badgeStatus: common.godKisekiMenuCzBadge,
//                        )
//                    }
                    
                    // 初当り
                    NavigationLink(destination: godKisekiViewFirstHit(
                        godKiseki: godKiseki,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.godKisekiMenuFirstHitBadge,
                        )
                    }
                    
//                    // REG
//                    NavigationLink(destination: godKisekiViewReg(
//                        godKiseki: godKiseki,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "person.2.fill",
//                            textBody: "REG",
//                            badgeStatus: common.godKisekiMenuRegBadge,
//                        )
//                    }
//                    
//                    // AT終了画面
//                    NavigationLink(destination: godKisekiViewScreen(
//                        godKiseki: godKiseki,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "photo.on.rectangle.angled.fill",
//                            textBody: "ボーナス終了画面",
//                            badgeStatus: common.godKisekiMenuScreenBadge,
//                        )
//                    }
//
//                    // エンディング
//                    NavigationLink(destination: godKisekiViewEnding(
//                        godKiseki: godKiseki,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "flag.pattern.checkered",
//                            textBody: "エンディング",
//                            badgeStatus: common.godKisekiMenuEndingBadge,
//                        )
//                    }
//
//                    // おみくじ
//                    NavigationLink(destination: godKisekiViewOmikuji(
//                        godKiseki: godKiseki,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "tag.fill",
//                            textBody: "おみくじ",
//                            badgeStatus: common.godKisekiMenuOmikujiBadge,
//                        )
//                    }
//
                    // ユニバプレート
                    NavigationLink(destination: commonViewUniversalPlate()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "ユニバプレート"
                        )
                    }
                }
                
                // 設定推測グラフ
                NavigationLink(destination: godKisekiView95Ci(
                    godKiseki: godKiseki,
                    selection: 2,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: godKisekiViewBayes(
                    godKiseki: godKiseki,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.godKisekiMenuBayesBadge
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4961")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©UNIVERSAL ENTERTAINMENT")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.godKisekiMachineIconBadge)
//        .resetMachineBadgeOnAppear(machines: $common.machines, targetId: "4961")
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: godKiseki.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(godKisekiSubViewLoadMemory(
                    godKiseki: godKiseki,
                    godKisekiMemory1: godKisekiMemory1,
                    godKisekiMemory2: godKisekiMemory2,
                    godKisekiMemory3: godKisekiMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(godKisekiSubViewSaveMemory(
                    godKiseki: godKiseki,
                    godKisekiMemory1: godKisekiMemory1,
                    godKisekiMemory2: godKisekiMemory2,
                    godKisekiMemory3: godKisekiMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: godKiseki.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct godKisekiSubViewSaveMemory: View {
    @ObservedObject var godKiseki: GodKiseki
    @ObservedObject var godKisekiMemory1: GodKisekiMemory1
    @ObservedObject var godKisekiMemory2: GodKisekiMemory2
    @ObservedObject var godKisekiMemory3: GodKisekiMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: godKiseki.machineName,
            selectedMemory: $godKiseki.selectedMemory,
            memoMemory1: $godKisekiMemory1.memo,
            dateDoubleMemory1: $godKisekiMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $godKisekiMemory2.memo,
            dateDoubleMemory2: $godKisekiMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $godKisekiMemory3.memo,
            dateDoubleMemory3: $godKisekiMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        godKisekiMemory1.ren3CountBlue = godKiseki.ren3CountBlue
        godKisekiMemory1.ren3CountBlueHit = godKiseki.ren3CountBlueHit
        godKisekiMemory1.ren3CountYellow = godKiseki.ren3CountYellow
        godKisekiMemory1.ren3CountYellowHit = godKiseki.ren3CountYellowHit
        godKisekiMemory1.normalGame = godKiseki.normalGame
        godKisekiMemory1.firstHitCountAt = godKiseki.firstHitCountAt
        
        // ---------
        // ver3.24.1
        // ---------
        godKisekiMemory1.ren4CountBlue = godKiseki.ren4CountBlue
        godKisekiMemory1.ren4CountBlueHit = godKiseki.ren4CountBlueHit
        
        // --------
        // ver3.27.0
        // --------
        godKisekiMemory1.riseZzoneCount = godKiseki.riseZzoneCount
    }
    func saveMemory2() {
        godKisekiMemory2.ren3CountBlue = godKiseki.ren3CountBlue
        godKisekiMemory2.ren3CountBlueHit = godKiseki.ren3CountBlueHit
        godKisekiMemory2.ren3CountYellow = godKiseki.ren3CountYellow
        godKisekiMemory2.ren3CountYellowHit = godKiseki.ren3CountYellowHit
        godKisekiMemory2.normalGame = godKiseki.normalGame
        godKisekiMemory2.firstHitCountAt = godKiseki.firstHitCountAt
        
        // ---------
        // ver3.24.1
        // ---------
        godKisekiMemory2.ren4CountBlue = godKiseki.ren4CountBlue
        godKisekiMemory2.ren4CountBlueHit = godKiseki.ren4CountBlueHit
        
        // --------
        // ver3.27.0
        // --------
        godKisekiMemory2.riseZzoneCount = godKiseki.riseZzoneCount
    }
    func saveMemory3() {
        godKisekiMemory3.ren3CountBlue = godKiseki.ren3CountBlue
        godKisekiMemory3.ren3CountBlueHit = godKiseki.ren3CountBlueHit
        godKisekiMemory3.ren3CountYellow = godKiseki.ren3CountYellow
        godKisekiMemory3.ren3CountYellowHit = godKiseki.ren3CountYellowHit
        godKisekiMemory3.normalGame = godKiseki.normalGame
        godKisekiMemory3.firstHitCountAt = godKiseki.firstHitCountAt
        
        // ---------
        // ver3.24.1
        // ---------
        godKisekiMemory3.ren4CountBlue = godKiseki.ren4CountBlue
        godKisekiMemory3.ren4CountBlueHit = godKiseki.ren4CountBlueHit
        
        // --------
        // ver3.27.0
        // --------
        godKisekiMemory3.riseZzoneCount = godKiseki.riseZzoneCount
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct godKisekiSubViewLoadMemory: View {
    @ObservedObject var godKiseki: GodKiseki
    @ObservedObject var godKisekiMemory1: GodKisekiMemory1
    @ObservedObject var godKisekiMemory2: GodKisekiMemory2
    @ObservedObject var godKisekiMemory3: GodKisekiMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: godKiseki.machineName,
            selectedMemory: $godKiseki.selectedMemory,
            memoMemory1: godKisekiMemory1.memo,
            dateDoubleMemory1: godKisekiMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: godKisekiMemory2.memo,
            dateDoubleMemory2: godKisekiMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: godKisekiMemory3.memo,
            dateDoubleMemory3: godKisekiMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        godKiseki.ren3CountBlue = godKisekiMemory1.ren3CountBlue
        godKiseki.ren3CountBlueHit = godKisekiMemory1.ren3CountBlueHit
        godKiseki.ren3CountYellow = godKisekiMemory1.ren3CountYellow
        godKiseki.ren3CountYellowHit = godKisekiMemory1.ren3CountYellowHit
        godKiseki.normalGame = godKisekiMemory1.normalGame
        godKiseki.firstHitCountAt = godKisekiMemory1.firstHitCountAt
        
        // ---------
        // ver3.24.1
        // ---------
        godKiseki.ren4CountBlue = godKisekiMemory1.ren4CountBlue
        godKiseki.ren4CountBlueHit = godKisekiMemory1.ren4CountBlueHit
        
        // --------
        // ver3.27.0
        // --------
        godKiseki.riseZzoneCount = godKisekiMemory1.riseZzoneCount
    }
    func loadMemory2() {
        godKiseki.ren3CountBlue = godKisekiMemory2.ren3CountBlue
        godKiseki.ren3CountBlueHit = godKisekiMemory2.ren3CountBlueHit
        godKiseki.ren3CountYellow = godKisekiMemory2.ren3CountYellow
        godKiseki.ren3CountYellowHit = godKisekiMemory2.ren3CountYellowHit
        godKiseki.normalGame = godKisekiMemory2.normalGame
        godKiseki.firstHitCountAt = godKisekiMemory2.firstHitCountAt
        
        // ---------
        // ver3.24.1
        // ---------
        godKiseki.ren4CountBlue = godKisekiMemory2.ren4CountBlue
        godKiseki.ren4CountBlueHit = godKisekiMemory2.ren4CountBlueHit
        
        // --------
        // ver3.27.0
        // --------
        godKiseki.riseZzoneCount = godKisekiMemory2.riseZzoneCount
    }
    func loadMemory3() {
        godKiseki.ren3CountBlue = godKisekiMemory3.ren3CountBlue
        godKiseki.ren3CountBlueHit = godKisekiMemory3.ren3CountBlueHit
        godKiseki.ren3CountYellow = godKisekiMemory3.ren3CountYellow
        godKiseki.ren3CountYellowHit = godKisekiMemory3.ren3CountYellowHit
        godKiseki.normalGame = godKisekiMemory3.normalGame
        godKiseki.firstHitCountAt = godKisekiMemory3.firstHitCountAt
        
        // ---------
        // ver3.24.1
        // ---------
        godKiseki.ren4CountBlue = godKisekiMemory3.ren4CountBlue
        godKiseki.ren4CountBlueHit = godKisekiMemory3.ren4CountBlueHit
        
        // --------
        // ver3.27.0
        // --------
        godKiseki.riseZzoneCount = godKisekiMemory3.riseZzoneCount
    }
}

#Preview {
    godKisekiViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
