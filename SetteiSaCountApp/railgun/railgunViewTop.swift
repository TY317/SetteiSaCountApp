//
//  railgunViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/19.
//

import SwiftUI

struct railgunViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @State var isShowAlert: Bool = false
    @StateObject var railgun = Railgun()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 通常時
                    NavigationLink(destination: railgunViewNormal(
                        railgun: railgun,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時"
                        )
                    }
                    
                    // 初当り
                    NavigationLink(destination: railgunViewFirstHit(
                        railgun: railgun,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り"
                        )
                    }
                    
                    // AT中
                    NavigationLink(destination: railgunViewDuringAt(
                        railgun: railgun,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "AT中")
                    }
                    // AT終了画面
                    NavigationLink(destination: railgunViewScreen(
                        railgun: railgun,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "AT終了画面"
                        )
                    }
                    
                    // 藤丸コイン
                    NavigationLink(destination: commonViewFujimaruCoin()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "藤丸コイン"
                        )
                    }
                } header: {
                    unitLabelMachineTopTitle(machineName: railgun.machineName)
                }
                
                // 設定推測グラフ
                NavigationLink(destination: railgunView95Ci(
                    railgun: railgun,
                    selection: 1,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }
                // 設定期待値計算
                NavigationLink(destination: railgunViewBayes(
                    railgun: railgun,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4892")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©︎2018 鎌池和馬 ／冬川基 ／ＫＡＤＯＫＡＷＡ ／PROJECT-RAILGUN T")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.railgunMachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: railgun.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
//                unitButtonLoadMemory(loadView: AnyView(railgunSubViewLoadMemory(
//                    railgun: railgun,
//                    railgunMemory1: railgunMemory1,
//                    railgunMemory2: railgunMemory2,
//                    railgunMemory3: railgunMemory3
//                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
//                unitButtonSaveMemory(saveView: AnyView(railgunSubViewSaveMemory(
//                    railgun: railgun,
//                    railgunMemory1: railgunMemory1,
//                    railgunMemory2: railgunMemory2,
//                    railgunMemory3: railgunMemory3
//                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: railgun.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}

#Preview {
    railgunViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
