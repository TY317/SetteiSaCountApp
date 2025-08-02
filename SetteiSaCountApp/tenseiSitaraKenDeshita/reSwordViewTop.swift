//
//  reSwordViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/31.
//

import SwiftUI

struct reSwordViewTop: View {
    @ObservedObject var ver360: Ver360
    @StateObject var reSword = ReSword()
    @State var isShowAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("e-slot+の利用を前提としています\n遊技前にe-slot+を開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(machineName: reSword.machineName)
                }
                
                Section {
                    // 通常時
                    NavigationLink(destination: reSwordViewNormal(
                        reSword: reSword,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時"
                        )
                    }
                    
                    // 初当り
                    NavigationLink(destination: reSwordViewFirstHit(
                        reSword: reSword,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り"
                        )
                    }
                }
                
//                // 設定推測グラフ
//                NavigationLink(destination: reSwordView95Ci(
//                    reSword: reSword,
//                    selection: 1
//                )) {
//                    unitLabelMenu(
//                        imageSystemName: "chart.bar.xaxis",
//                        textBody: "設定推測グラフ"
//                    )
//                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4843"
                )
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($ver360.reSwordMachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: reSword.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
//                    unitButtonLoadMemory(loadView: AnyView(reSwordSubViewLoadMemory(
//                        reSword: reSword,
//                        reSwordMemory1: reSwordMemory1,
//                        reSwordMemory2: reSwordMemory2,
//                        reSwordMemory3: reSwordMemory3
//                    )))
                    // データ保存
//                    unitButtonSaveMemory(saveView: AnyView(reSwordSubViewSaveMemory(
//                        reSword: reSword,
//                        reSwordMemory1: reSwordMemory1,
//                        reSwordMemory2: reSwordMemory2,
//                        reSwordMemory3: reSwordMemory3
//                    )))
                }
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: reSword.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}

#Preview {
    reSwordViewTop(
        ver360: Ver360(),
    )
}
