//
//  vvv2ViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/16.
//

import SwiftUI

struct vvv2ViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var vvv2 = Vvv2()
    @State var isShowAlert: Bool = false
    @StateObject var vvv2Memory1 = Vvv2Memory1()
    @StateObject var vvv2Memory2 = Vvv2Memory2()
    @StateObject var vvv2Memory3 = Vvv2Memory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 通常時
                    NavigationLink(destination: vvv2ViewNormal(
                        vvv2: vvv2,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時"
                        )
                    }
                    // 初当り
                    NavigationLink(destination: vvv2ViewFirstHit(
                        vvv2: vvv2,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り"
                        )
                    }
                    // 終了画面
                    NavigationLink(destination: vvv2ViewScreen(
                        vvv2: vvv2,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "CZ・ボーナス終了画面")
                    }
                    // 革命ラッシュ
                    NavigationLink(destination: vvv2ViewRush(
                        vvv2: vvv2,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "v.circle.fill",
                            textBody: "(超)革命ラッシュ"
                        )
                    }
                } header: {
                    unitLabelMachineTopTitle(machineName: vvv2.machineName)
                }
                
//                // 設定推測グラフ
//                NavigationLink(destination: vvv2View95Ci(
//                    vvv2: vvv2,
//                    selection: 1,
//                )) {
//                    unitLabelMenu(
//                        imageSystemName: "chart.bar.xaxis",
//                        textBody: "設定推測グラフ"
//                    )
//                }
//                
//                // 設定期待値計算
//                NavigationLink(destination: vvv2ViewBayes(
//                    vvv2: vvv2,
//                    bayes: bayes,
//                    viewModel: viewModel,
//                )) {
//                    unitLabelMenu(
//                        imageSystemName: "gauge.open.with.lines.needle.33percent",
//                        textBody: "設定期待値",
//                    )
//                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4885")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©︎SUNRISE/VVV Committee")
                    Text("©︎SANKYO")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.vvv2MachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: vvv2.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(vvv2SubViewLoadMemory(
                    vvv2: vvv2,
                    vvv2Memory1: vvv2Memory1,
                    vvv2Memory2: vvv2Memory2,
                    vvv2Memory3: vvv2Memory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(vvv2SubViewSaveMemory(
                    vvv2: vvv2,
                    vvv2Memory1: vvv2Memory1,
                    vvv2Memory2: vvv2Memory2,
                    vvv2Memory3: vvv2Memory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: vvv2.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct vvv2SubViewSaveMemory: View {
    @ObservedObject var vvv2: Vvv2
    @ObservedObject var vvv2Memory1: Vvv2Memory1
    @ObservedObject var vvv2Memory2: Vvv2Memory2
    @ObservedObject var vvv2Memory3: Vvv2Memory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: vvv2.machineName,
            selectedMemory: $vvv2.selectedMemory,
            memoMemory1: $vvv2Memory1.memo,
            dateDoubleMemory1: $vvv2Memory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $vvv2Memory2.memo,
            dateDoubleMemory2: $vvv2Memory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $vvv2Memory3.memo,
            dateDoubleMemory3: $vvv2Memory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        vvv2Memory1.bonusCountKakumei = vvv2.bonusCountKakumei
        vvv2Memory1.bonusCountKessen = vvv2.bonusCountKessen
        vvv2Memory1.bonusCountSum = vvv2.bonusCountSum
        vvv2Memory1.screenCountDefault = vvv2.screenCountDefault
        vvv2Memory1.screenCountBlue1 = vvv2.screenCountBlue1
        vvv2Memory1.screenCountBlue2 = vvv2.screenCountBlue2
        vvv2Memory1.screenCountRed1 = vvv2.screenCountRed1
        vvv2Memory1.screenCountRed2 = vvv2.screenCountRed2
        vvv2Memory1.screenCountPurple = vvv2.screenCountPurple
        vvv2Memory1.screenCountSilver = vvv2.screenCountSilver
        vvv2Memory1.screenCountGold = vvv2.screenCountGold
        vvv2Memory1.screenCountSum = vvv2.screenCountSum
        vvv2Memory1.roundCount10 = vvv2.roundCount10
        vvv2Memory1.roundCount20 = vvv2.roundCount20
        vvv2Memory1.roundCountDrive = vvv2.roundCountDrive
        vvv2Memory1.roundCountSum = vvv2.roundCountSum
    }
    func saveMemory2() {
        vvv2Memory2.bonusCountKakumei = vvv2.bonusCountKakumei
        vvv2Memory2.bonusCountKessen = vvv2.bonusCountKessen
        vvv2Memory2.bonusCountSum = vvv2.bonusCountSum
        vvv2Memory2.screenCountDefault = vvv2.screenCountDefault
        vvv2Memory2.screenCountBlue1 = vvv2.screenCountBlue1
        vvv2Memory2.screenCountBlue2 = vvv2.screenCountBlue2
        vvv2Memory2.screenCountRed1 = vvv2.screenCountRed1
        vvv2Memory2.screenCountRed2 = vvv2.screenCountRed2
        vvv2Memory2.screenCountPurple = vvv2.screenCountPurple
        vvv2Memory2.screenCountSilver = vvv2.screenCountSilver
        vvv2Memory2.screenCountGold = vvv2.screenCountGold
        vvv2Memory2.screenCountSum = vvv2.screenCountSum
        vvv2Memory2.roundCount10 = vvv2.roundCount10
        vvv2Memory2.roundCount20 = vvv2.roundCount20
        vvv2Memory2.roundCountDrive = vvv2.roundCountDrive
        vvv2Memory2.roundCountSum = vvv2.roundCountSum
    }
    func saveMemory3() {
        vvv2Memory3.bonusCountKakumei = vvv2.bonusCountKakumei
        vvv2Memory3.bonusCountKessen = vvv2.bonusCountKessen
        vvv2Memory3.bonusCountSum = vvv2.bonusCountSum
        vvv2Memory3.screenCountDefault = vvv2.screenCountDefault
        vvv2Memory3.screenCountBlue1 = vvv2.screenCountBlue1
        vvv2Memory3.screenCountBlue2 = vvv2.screenCountBlue2
        vvv2Memory3.screenCountRed1 = vvv2.screenCountRed1
        vvv2Memory3.screenCountRed2 = vvv2.screenCountRed2
        vvv2Memory3.screenCountPurple = vvv2.screenCountPurple
        vvv2Memory3.screenCountSilver = vvv2.screenCountSilver
        vvv2Memory3.screenCountGold = vvv2.screenCountGold
        vvv2Memory3.screenCountSum = vvv2.screenCountSum
        vvv2Memory3.roundCount10 = vvv2.roundCount10
        vvv2Memory3.roundCount20 = vvv2.roundCount20
        vvv2Memory3.roundCountDrive = vvv2.roundCountDrive
        vvv2Memory3.roundCountSum = vvv2.roundCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct vvv2SubViewLoadMemory: View {
    @ObservedObject var vvv2: Vvv2
    @ObservedObject var vvv2Memory1: Vvv2Memory1
    @ObservedObject var vvv2Memory2: Vvv2Memory2
    @ObservedObject var vvv2Memory3: Vvv2Memory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: vvv2.machineName,
            selectedMemory: $vvv2.selectedMemory,
            memoMemory1: vvv2Memory1.memo,
            dateDoubleMemory1: vvv2Memory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: vvv2Memory2.memo,
            dateDoubleMemory2: vvv2Memory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: vvv2Memory3.memo,
            dateDoubleMemory3: vvv2Memory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        vvv2.bonusCountKakumei = vvv2Memory1.bonusCountKakumei
        vvv2.bonusCountKessen = vvv2Memory1.bonusCountKessen
        vvv2.bonusCountSum = vvv2Memory1.bonusCountSum
        vvv2.screenCountDefault = vvv2Memory1.screenCountDefault
        vvv2.screenCountBlue1 = vvv2Memory1.screenCountBlue1
        vvv2.screenCountBlue2 = vvv2Memory1.screenCountBlue2
        vvv2.screenCountRed1 = vvv2Memory1.screenCountRed1
        vvv2.screenCountRed2 = vvv2Memory1.screenCountRed2
        vvv2.screenCountPurple = vvv2Memory1.screenCountPurple
        vvv2.screenCountSilver = vvv2Memory1.screenCountSilver
        vvv2.screenCountGold = vvv2Memory1.screenCountGold
        vvv2.screenCountSum = vvv2Memory1.screenCountSum
        vvv2.roundCount10 = vvv2Memory1.roundCount10
        vvv2.roundCount20 = vvv2Memory1.roundCount20
        vvv2.roundCountDrive = vvv2Memory1.roundCountDrive
        vvv2.roundCountSum = vvv2Memory1.roundCountSum
    }
    func loadMemory2() {
        vvv2.bonusCountKakumei = vvv2Memory2.bonusCountKakumei
        vvv2.bonusCountKessen = vvv2Memory2.bonusCountKessen
        vvv2.bonusCountSum = vvv2Memory2.bonusCountSum
        vvv2.screenCountDefault = vvv2Memory2.screenCountDefault
        vvv2.screenCountBlue1 = vvv2Memory2.screenCountBlue1
        vvv2.screenCountBlue2 = vvv2Memory2.screenCountBlue2
        vvv2.screenCountRed1 = vvv2Memory2.screenCountRed1
        vvv2.screenCountRed2 = vvv2Memory2.screenCountRed2
        vvv2.screenCountPurple = vvv2Memory2.screenCountPurple
        vvv2.screenCountSilver = vvv2Memory2.screenCountSilver
        vvv2.screenCountGold = vvv2Memory2.screenCountGold
        vvv2.screenCountSum = vvv2Memory2.screenCountSum
        vvv2.roundCount10 = vvv2Memory2.roundCount10
        vvv2.roundCount20 = vvv2Memory2.roundCount20
        vvv2.roundCountDrive = vvv2Memory2.roundCountDrive
        vvv2.roundCountSum = vvv2Memory2.roundCountSum
    }
    func loadMemory3() {
        vvv2.bonusCountKakumei = vvv2Memory3.bonusCountKakumei
        vvv2.bonusCountKessen = vvv2Memory3.bonusCountKessen
        vvv2.bonusCountSum = vvv2Memory3.bonusCountSum
        vvv2.screenCountDefault = vvv2Memory3.screenCountDefault
        vvv2.screenCountBlue1 = vvv2Memory3.screenCountBlue1
        vvv2.screenCountBlue2 = vvv2Memory3.screenCountBlue2
        vvv2.screenCountRed1 = vvv2Memory3.screenCountRed1
        vvv2.screenCountRed2 = vvv2Memory3.screenCountRed2
        vvv2.screenCountPurple = vvv2Memory3.screenCountPurple
        vvv2.screenCountSilver = vvv2Memory3.screenCountSilver
        vvv2.screenCountGold = vvv2Memory3.screenCountGold
        vvv2.screenCountSum = vvv2Memory3.screenCountSum
        vvv2.roundCount10 = vvv2Memory3.roundCount10
        vvv2.roundCount20 = vvv2Memory3.roundCount20
        vvv2.roundCountDrive = vvv2Memory3.roundCountDrive
        vvv2.roundCountSum = vvv2Memory3.roundCountSum
    }
}

#Preview {
    vvv2ViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
