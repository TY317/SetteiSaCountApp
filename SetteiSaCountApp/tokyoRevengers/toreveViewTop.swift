//
//  toreveViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/02.
//

import SwiftUI

struct toreveViewTop: View {
    @ObservedObject var ver390: Ver390
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var toreve = Toreve()
    @State var isShowAlert: Bool = false
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("マイスロの利用を前提としています\n遊技前にマイスロを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(machineName: toreve.machineName)
                }
                
                // //// メニュー
                Section {
                    // 通常時
                    NavigationLink(destination: toreveViewNormal(
                        toreve: toreve,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時"
                        )
                    }
                    // 周期履歴
                    NavigationLink(destination: toreveViewCycle(
                        toreve: toreve,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "pencil.and.list.clipboard",
                            textBody: "周期履歴",
                        )
                    }
                    // 初当り
                    NavigationLink(destination: toreveViewFirstHit(
                        toreve: toreve,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り"
                        )
                    }
                    // 東卍チャンス
                    NavigationLink(destination: toreveViewTomanChallenge(
                        toreve: toreve,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "figure.stairs",
                            textBody: "東卍チャンス"
                        )
                    }
                    // AT終了画面
                    NavigationLink(destination: toreveViewScreen(
                        toreve: toreve,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "終了画面"
                        )
                    }
                    // リベンジ
                    NavigationLink(destination: toreveViewRevenge(
                        toreve: toreve,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "arrow.trianglehead.2.counterclockwise",
                            textBody: "リベンジ"
                        )
                    }
                    // 上位AT
                    NavigationLink(destination: toreveViewPremiumAt(
                        toreve: toreve,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "smoke.fill",
                            textBody: "東卍ラッシュバースト")
                    }
                    // サミートロフィー
                    NavigationLink(destination: commonViewSammyTrophy()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "サミートロフィー"
                        )
                    }
                }
                
                // 設定推測グラフ
                NavigationLink(destination: toreveView95Ci(
                    toreve: toreve,
                    selection: 1
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }
                // 設定期待値計算
                NavigationLink(destination: toreveViewBayes(
                    toreve: toreve,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4849")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©︎和久井健／講談社")
                    Text("©︎和久井健・講談社／アニメ「東京リベンジャーズ」製作委員会")
                    Text("©︎Sammy")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($ver390.toreveMachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: toreve.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
//                    unitButtonLoadMemory(loadView: AnyView(toreveSubViewLoadMemory(
//                        toreve: toreve,
//                        toreveMemory1: toreveMemory1,
//                        toreveMemory2: toreveMemory2,
//                        toreveMemory3: toreveMemory3
//                    )))
                    // データ保存
//                    unitButtonSaveMemory(saveView: AnyView(toreveSubViewSaveMemory(
//                        toreve: toreve,
//                        toreveMemory1: toreveMemory1,
//                        toreveMemory2: toreveMemory2,
//                        toreveMemory3: toreveMemory3
//                    )))
                }
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: toreve.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}

#Preview {
    toreveViewTop(
        ver390: Ver390(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
