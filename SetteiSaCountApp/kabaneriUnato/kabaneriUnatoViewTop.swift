//
//  kabaneriUnatoViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/28.
//

import SwiftUI

struct kabaneriUnatoViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var kabaneriUnato = KabaneriUnato()
    @State var isShowAlert: Bool = false
//    @StateObject var kabaneriUnatoMemory1 = KabaneriUnatoMemory1()
//    @StateObject var kabaneriUnatoMemory2 = KabaneriUnatoMemory2()
//    @StateObject var kabaneriUnatoMemory3 = KabaneriUnatoMemory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("マイスロの利用を前提としています\n遊技前にマイスロを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(
                        machineName: kabaneriUnato.machineName,
                        titleFont: .title2,
                    )
                }
                
                Section {
                    // 通常時
                    NavigationLink(destination: kabaneriUnatoViewNormal(
                        kabaneriUnato: kabaneriUnato,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.kabaneriUnatoMenuNormalBadge,
                        )
                    }
                    
                    // 初あたり
                    NavigationLink(destination: kabaneriUnatoViewFirstHit(
                        kabaneriUnato: kabaneriUnato,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.kabaneriUnatoMenuFirstHitBadge,
                        )
                    }
                    
                    // カバネリボーナス
                    NavigationLink(destination: kabaneriUnatoViewKabaneriBonus(
                        kabaneriUnato: kabaneriUnato,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "person.2.fill",
                            textBody: "カバネリボーナス",
                            badgeStatus: common.kabaneriUnatoMenuKabaneriBonusBadge,
                        )
                    }
                }
                
                // 設定推測グラフ
//                NavigationLink(destination: kabaneriUnatoView95Ci(
//                    kabaneriUnato: kabaneriUnato,
//                    selection: 1,
//                )) {
//                    unitLabelMenu(
//                        imageSystemName: "chart.bar.xaxis",
//                        textBody: "設定推測グラフ"
//                    )
//                }

                // 設定期待値計算
//                NavigationLink(destination: kabaneriUnatoViewBayes(
//                    kabaneriUnato: kabaneriUnato,
//                    bayes: bayes,
//                    viewModel: viewModel,
//                )) {
//                    unitLabelMenu(
//                        imageSystemName: "gauge.open.with.lines.needle.33percent",
//                        textBody: "設定期待値",
//                        badgeStatus: common.kabaneriUnatoMenuBayesBadge
//                    )
//                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4930")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©カバネリ製作委員会")
                    Text("©Sammy")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.kabaneriUnatoMachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: kabaneriUnato.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
//                unitButtonLoadMemory(loadView: AnyView(kabaneriUnatoSubViewLoadMemory(
//                    kabaneriUnato: kabaneriUnato,
//                    kabaneriUnatoMemory1: kabaneriUnatoMemory1,
//                    kabaneriUnatoMemory2: kabaneriUnatoMemory2,
//                    kabaneriUnatoMemory3: kabaneriUnatoMemory3
//                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
//                unitButtonSaveMemory(saveView: AnyView(kabaneriUnatoSubViewSaveMemory(
//                    kabaneriUnato: kabaneriUnato,
//                    kabaneriUnatoMemory1: kabaneriUnatoMemory1,
//                    kabaneriUnatoMemory2: kabaneriUnatoMemory2,
//                    kabaneriUnatoMemory3: kabaneriUnatoMemory3
//                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: kabaneriUnato.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}

#Preview {
    kabaneriUnatoViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
