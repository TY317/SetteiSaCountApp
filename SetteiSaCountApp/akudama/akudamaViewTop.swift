//
//  akudamaViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/05.
//

import SwiftUI

struct akudamaViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var akudama = Akudama()
    @State var isShowAlert: Bool = false
//    @StateObject var akudamaMemory1 = AkudamaMemory1()
//    @StateObject var akudamaMemory2 = AkudamaMemory2()
//    @StateObject var akudamaMemory3 = AkudamaMemory3()
    
    var body: some View {
        NavigationStack {
            List {
//                Section {
//                    // 注意事項
//                    Text("スロプラNEXTの利用を前提としています\n遊技前にスロプラNEXTを開始してください")
//                        .foregroundStyle(Color.secondary)
//                        .font(.footnote)
//                } header: {
//                    unitLabelMachineTopTitle(
//                        machineName: akudama.machineName,
//                    )
//                }
                
                Section {
                    // 通常時
                    NavigationLink(destination: akudamaViewNormal(
                        akudama: akudama,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.akudamaMenuNormalBadge,
                        )
                    }
                    
                    // 初当り
                    NavigationLink(destination: akudamaViewFirstHit(
                        akudama: akudama,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.akudamaMenuFirstHitBadge,
                        )
                    }
                    
                    // ST終了画面
                    NavigationLink(destination: akudamaViewScreen(
                        akudama: akudama,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "ST終了画面",
                            badgeStatus: common.akudamaMenuScreenBadge,
                        )
                    }

//                    // ST終了画面
//                    NavigationLink(destination: akudamaViewScreen(
//                        akudama: akudama,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "photo.on.rectangle.angled.fill",
//                            textBody: "ST終了画面",
//                            badgeStatus: common.akudamaMenuScreenBadge,
//                        )
//                    }
//
//                    // おみくじ
//                    NavigationLink(destination: akudamaViewOmikuji(
//                        akudama: akudama,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "tag.fill",
//                            textBody: "おみくじ",
//                            badgeStatus: common.akudamaMenuOmikujiBadge,
//                        )
//                    }
//
//                    // サミートロフィー
//                    NavigationLink(destination: commonViewSammyTrophy()) {
//                        unitLabelMenu(
//                            imageSystemName: "trophy.fill",
//                            textBody: "サミートロフィー"
//                        )
//                    }
                } header: {
                    unitLabelMachineTopTitle(
                        machineName: akudama.machineName,
                    )
                }
                
                // 設定推測グラフ
                NavigationLink(destination: akudamaView95Ci(
                    akudama: akudama,
                    selection: 1,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: akudamaViewBayes(
                    akudama: akudama,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.akudamaMenuBayesBadge
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4956")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©ぴえろ・TooKyoGames／アクダマドライブ製作委員会")
                    Text("©SANYO BUSSAN CO.,LTD.")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.akudamaMachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: akudama.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
//                unitButtonLoadMemory(loadView: AnyView(akudamaSubViewLoadMemory(
//                    akudama: akudama,
//                    akudamaMemory1: akudamaMemory1,
//                    akudamaMemory2: akudamaMemory2,
//                    akudamaMemory3: akudamaMemory3
//                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
//                unitButtonSaveMemory(saveView: AnyView(akudamaSubViewSaveMemory(
//                    akudama: akudama,
//                    akudamaMemory1: akudamaMemory1,
//                    akudamaMemory2: akudamaMemory2,
//                    akudamaMemory3: akudamaMemory3
//                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: akudama.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}

#Preview {
    akudamaViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
