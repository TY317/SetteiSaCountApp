//
//  zeni5ViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/14.
//

import SwiftUI

struct zeni5ViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var zeni5 = Zeni5()
    @State var isShowAlert: Bool = false
    @StateObject var zeni5Memory1 = Zeni5Memory1()
    @StateObject var zeni5Memory2 = Zeni5Memory2()
    @StateObject var zeni5Memory3 = Zeni5Memory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("打-WINの利用を前提としています\n遊技前に打-WINを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(machineName: zeni5.machineName)
                }
                
                Section {
                    // 通常時
                    NavigationLink(destination: zeni5ViewNormal(
                        zeni5: zeni5,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時"
                        )
                    }
                    
                    // 初当り
                    NavigationLink(destination: zeni5ViewFirstHit(
                        zeni5: zeni5,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り"
                        )
                    }
                    
                    // ボーナス終了画面
                    NavigationLink(destination: zeni5ViewScreen(
                        zeni5: zeni5,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "ボーナス終了画面"
                        )
                    }
                    
                    // エンディング
                    NavigationLink(destination: zeni5ViewEnding(
                        zeni5: zeni5,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "flag.pattern.checkered",
                            textBody: "エンディング"
                        )
                    }
                    
                    // 隠れ凪
                    NavigationLink(destination: commonViewKakureNagi()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "隠れ凪"
                        )
                    }
                }
                
                // 設定推測グラフ
                NavigationLink(destination: zeni5View95Ci(
                    zeni5: zeni5,
                    selection: 1,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }
                // 設定期待値計算
                NavigationLink(destination: zeni5ViewBayes(
                    zeni5: zeni5,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4877")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©︎モンキー・パンチ／TMS・NTV")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.zeni5MachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: zeni5.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(zeni5SubViewLoadMemory(
                    zeni5: zeni5,
                    zeni5Memory1: zeni5Memory1,
                    zeni5Memory2: zeni5Memory2,
                    zeni5Memory3: zeni5Memory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(zeni5SubViewSaveMemory(
                    zeni5: zeni5,
                    zeni5Memory1: zeni5Memory1,
                    zeni5Memory2: zeni5Memory2,
                    zeni5Memory3: zeni5Memory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: zeni5.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct zeni5SubViewSaveMemory: View {
    @ObservedObject var zeni5: Zeni5
    @ObservedObject var zeni5Memory1: Zeni5Memory1
    @ObservedObject var zeni5Memory2: Zeni5Memory2
    @ObservedObject var zeni5Memory3: Zeni5Memory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: zeni5.machineName,
            selectedMemory: $zeni5.selectedMemory,
            memoMemory1: $zeni5Memory1.memo,
            dateDoubleMemory1: $zeni5Memory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $zeni5Memory2.memo,
            dateDoubleMemory2: $zeni5Memory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $zeni5Memory3.memo,
            dateDoubleMemory3: $zeni5Memory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        
    }
    func saveMemory2() {
        
    }
    func saveMemory3() {
        
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct zeni5SubViewLoadMemory: View {
    @ObservedObject var zeni5: Zeni5
    @ObservedObject var zeni5Memory1: Zeni5Memory1
    @ObservedObject var zeni5Memory2: Zeni5Memory2
    @ObservedObject var zeni5Memory3: Zeni5Memory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: zeni5.machineName,
            selectedMemory: $zeni5.selectedMemory,
            memoMemory1: zeni5Memory1.memo,
            dateDoubleMemory1: zeni5Memory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: zeni5Memory2.memo,
            dateDoubleMemory2: zeni5Memory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: zeni5Memory3.memo,
            dateDoubleMemory3: zeni5Memory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        
    }
    func loadMemory2() {
        
    }
    func loadMemory3() {
        
    }
}


#Preview {
    zeni5ViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
