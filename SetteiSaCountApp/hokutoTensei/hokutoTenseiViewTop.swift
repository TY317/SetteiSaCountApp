//
//  hokutoTenseiViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/26.
//

import SwiftUI

struct hokutoTenseiViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var hokutoTensei = HokutoTensei()
    @State var isShowAlert: Bool = false
//    @StateObject var hokutoTenseiMemory1 = HokutoTenseiMemory1()
//    @StateObject var hokutoTenseiMemory2 = HokutoTenseiMemory2()
//    @StateObject var hokutoTenseiMemory3 = HokutoTenseiMemory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("マイスロの利用を前提としています\n遊技前にマイスロを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(machineName: hokutoTensei.machineName)
                }
                
                Section {
                    // 通常時
                    NavigationLink(destination: hokutoTenseiViewNormal(
                        hokutoTensei: hokutoTensei,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.hokutoTenseiMenuNormalBadge,
                        )
                    }
                    
                    // 初当り
                    NavigationLink(destination: hokutoTenseiViewFirstHit(
                        hokutoTensei: hokutoTensei,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.hokutoTenseiMenuFirstHitBadge,
                        )
                    }
                }
                
                // 設定推測グラフ
                NavigationLink(destination: hokutoTenseiView95Ci(
                    hokutoTensei: hokutoTensei,
                    selection: 1,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: hokutoTenseiViewBayes(
                    hokutoTensei: hokutoTensei,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.hokutoTenseiMenuBayesBadge,
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4909")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©︎武論尊・原哲夫／コアミックス 1983")
                    Text("©︎COAMIX 2007 版権許諾証YJN-815")
                    Text("©︎Sammy")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.hokutoTenseiMachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: hokutoTensei.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
//                unitButtonLoadMemory(loadView: AnyView(hokutoTenseiSubViewLoadMemory(
//                    hokutoTensei: hokutoTensei,
//                    hokutoTenseiMemory1: hokutoTenseiMemory1,
//                    hokutoTenseiMemory2: hokutoTenseiMemory2,
//                    hokutoTenseiMemory3: hokutoTenseiMemory3
//                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
//                unitButtonSaveMemory(saveView: AnyView(hokutoTenseiSubViewSaveMemory(
//                    hokutoTensei: hokutoTensei,
//                    hokutoTenseiMemory1: hokutoTenseiMemory1,
//                    hokutoTenseiMemory2: hokutoTenseiMemory2,
//                    hokutoTenseiMemory3: hokutoTenseiMemory3
//                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: hokutoTensei.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}

#Preview {
    hokutoTenseiViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
