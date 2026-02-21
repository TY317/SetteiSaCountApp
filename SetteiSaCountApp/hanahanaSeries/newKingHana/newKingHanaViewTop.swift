//
//  newKingHanaViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/16.
//

import SwiftUI

struct newKingHanaViewTop: View {
    @StateObject var newKingHana = NewKingHana()
    @State var isShowAlert: Bool = false
//    @StateObject var newKingHanaMemory1 = newKingHanaMemory1()
//    @StateObject var newKingHanaMemory2 = newKingHanaMemory2()
//    @StateObject var newKingHanaMemory3 = newKingHanaMemory3()
    @ObservedObject var bayes: Bayes
    @StateObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    
                } header: {
                    unitLabelMachineTopTitle(
                        machineName: newKingHana.machineName
                    )
                }
                
                // //// 見
                Section {
                    // データ入力
                    NavigationLink(destination: newKingHanaViewKenDataInput(
                        newKingHana: newKingHana
                    )) {
                        unitLabelMenu(
                            imageSystemName: "magnifyingglass",
                            textBody: "データ確認"
                        )
                    }
                    
                    // 島データ
                    NavigationLink(destination: newKingHanaViewShimaData(
                        newKingHana: newKingHana,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "waveform.path.ecg.magnifyingglass",
                            textBody: "島データ確認",
                            badgeStatus: common.newKingHanaMenuShimaBadge,
                        )
                    }
                } header: {
                    unitHeaderLabelKen()
                }
                
                // //// 実戦
                Section {
                    // データ入力
                    NavigationLink(destination: newKingHanaViewJissenStartData(
                        newKingHana: newKingHana
                    )) {
                        unitLabelMenu(
                            imageSystemName: "airplane.departure",
                            textBody: "打ち始めデータ"
                        )
                    }
                    // 実戦カウント
                    NavigationLink(destination: newKingHanaViewJissenCount(
                        newKingHana: newKingHana,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "arcade.stick.and.arrow.down",
                            textBody: "実戦カウント"
                        )
                    }
                    // トータル結果確認
                    NavigationLink(destination: newKingHanaViewJissenTotalDataCheck(
                        newKingHana: newKingHana,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "airplane.arrival",
                            textBody: "総合結果確認"
                        )
                    }
                } header: {
                    Text("実戦")
                        .fontWeight(.bold)
                        .font(.headline)
                }
                // 設定推測グラフ
//                NavigationLink(destination: newKingHanaVer2View95CiTotal(
//                    newKingHana: newKingHana
//                )) {
//                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
//                }
                // 設定期待値計算
                NavigationLink(destination: newKingHanaViewBayes(
                    newKingHana: newKingHana,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                    )
                }
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4912")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©PIONEER")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.newKingHanaMachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: newKingHana.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
//                    unitButtonLoadMemory(loadView: AnyView(newKingHanaSubViewLoadMemory(
//                        newKingHana: newKingHana,
//                        newKingHanaMemory1: newKingHanaMemory1,
//                        newKingHanaMemory2: newKingHanaMemory2,
//                        newKingHanaMemory3: newKingHanaMemory3
//                    )))
                    // データ保存
//                    unitButtonSaveMemory(saveView: AnyView(newKingHanaSubViewSaveMemory(
//                        newKingHana: newKingHana,
//                        newKingHanaMemory1: newKingHanaMemory1,
//                        newKingHanaMemory2: newKingHanaMemory2,
//                        newKingHanaMemory3: newKingHanaMemory3
//                    )))
                }
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: newKingHana.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
//        .onAppear {
//            if ver220.newKingHanaNewBadgeStatus != "none" {
//                ver220.newKingHanaNewBadgeStatus = "none"
//            }
//        }
    }
}

#Preview {
    newKingHanaViewTop(
        newKingHana: NewKingHana(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel()
    )
    .environmentObject(commonVar())
}
