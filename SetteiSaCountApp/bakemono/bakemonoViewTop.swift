//
//  bakemonoViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/11/30.
//

import SwiftUI

struct bakemonoViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var bakemono = Bakemono()
    @State var isShowAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    
                }
                
                // 設定推測グラフ
                NavigationLink(destination: bakemonoView95Ci(
//                    bakemono: bakemono,
//                    selection: 1,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: bakemonoViewBayes(
//                    bakemono: bakemono,
//                    bayes: bayes,
//                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4898")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©︎西尾維新／講談社・アニプレックス・シャフト")
                    Text("©︎Sammy")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.bakemonoMachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: bakemono.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
//                unitButtonLoadMemory(loadView: AnyView(bakemonoSubViewLoadMemory(
//                    bakemono: bakemono,
//                    bakemonoMemory1: bakemonoMemory1,
//                    bakemonoMemory2: bakemonoMemory2,
//                    bakemonoMemory3: bakemonoMemory3
//                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
//                unitButtonSaveMemory(saveView: AnyView(bakemonoSubViewSaveMemory(
//                    bakemono: bakemono,
//                    bakemonoMemory1: bakemonoMemory1,
//                    bakemonoMemory2: bakemonoMemory2,
//                    bakemonoMemory3: bakemonoMemory3
//                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: bakemono.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}

#Preview {
    bakemonoViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
