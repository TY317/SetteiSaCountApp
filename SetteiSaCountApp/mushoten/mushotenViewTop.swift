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
//    @StateObject var mushotenMemory1 = mushotenMemory1()
//    @StateObject var mushotenMemory2 = mushotenMemory2()
//    @StateObject var mushotenMemory3 = mushotenMemory3()
    
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
                            textBody: "CZ",
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
                    
                    // ギンちゃんトロフィー
                    NavigationLink(destination: commonViewGinchanTrophy()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "ギンちゃんトロフィー"
                        )
                    }
                } header: {
                    unitLabelMachineTopTitle(machineName: mushoten.machineName, titleFont: .title2)
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
//                unitButtonLoadMemory(loadView: AnyView(mushotenSubViewLoadMemory(
//                    mushoten: mushoten,
//                    mushotenMemory1: mushotenMemory1,
//                    mushotenMemory2: mushotenMemory2,
//                    mushotenMemory3: mushotenMemory3
//                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
//                unitButtonSaveMemory(saveView: AnyView(mushotenSubViewSaveMemory(
//                    mushoten: mushoten,
//                    mushotenMemory1: mushotenMemory1,
//                    mushotenMemory2: mushotenMemory2,
//                    mushotenMemory3: mushotenMemory3
//                )))
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

#Preview {
    mushotenViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
