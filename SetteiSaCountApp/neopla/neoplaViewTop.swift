//
//  neoplaViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/11/09.
//

import SwiftUI

struct neoplaViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var neopla = Neopla()
    @State var isShowAlert: Bool = false
    var body: some View {
        NavigationStack {
            List {
                Section {
                    
                } header: {
                    unitLabelMachineTopTitle(machineName: neopla.machineName)
                }
                
                // 設定推測グラフ
                NavigationLink(destination: neoplaView95Ci(
                    neopla: neopla,
                    selection: 1,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: neoplaViewBayes(
                    neopla: neopla,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4873")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©︎SEVENLEAGUE")
                    Text("©︎YAMASA NEXT")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.neoplaMachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: neopla.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
//                unitButtonLoadMemory(loadView: AnyView(neoplaSubViewLoadMemory(
//                    neopla: neopla,
//                    neoplaMemory1: neoplaMemory1,
//                    neoplaMemory2: neoplaMemory2,
//                    neoplaMemory3: neoplaMemory3
//                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
//                unitButtonSaveMemory(saveView: AnyView(neoplaSubViewSaveMemory(
//                    neopla: neopla,
//                    neoplaMemory1: neoplaMemory1,
//                    neoplaMemory2: neoplaMemory2,
//                    neoplaMemory3: neoplaMemory3
//                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: neopla.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}

#Preview {
    neoplaViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
