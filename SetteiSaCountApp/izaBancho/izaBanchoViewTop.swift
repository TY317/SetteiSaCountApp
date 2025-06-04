//
//  izaBanchoViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/31.
//

import SwiftUI

struct izaBanchoViewTop: View {
    @ObservedObject var ver330: Ver330
    @StateObject var izaBancho = IzaBancho()
    @State var isShowAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("ダイトモの利用を前提としています\n遊技前にダイトモを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(machineName: izaBancho.machineName)
                }
                
                Section {
                    // 通常時
                    NavigationLink(destination: izaBanchoViewNormal(
                        izaBancho: izaBancho
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時"
                        )
                    }
                    // 初当り
                    NavigationLink(destination: izaBanchoViewFirstHit(
                        izaBancho: izaBancho
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り"
                        )
                    }
                    // AT中
                    NavigationLink(destination: izaBanchoViewAtGift(
                        izaBancho: izaBancho
                    )) {
                        unitLabelMenu(
                            imageSystemName: "gift.fill",
                            textBody: "AT突入時の成敗報酬"
                        )
                    }
                    // AT終了画面
                    NavigationLink(destination: izaBanchoViewScreen(
                        izaBancho: izaBancho
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "AT終了画面"
                        )
                    }
                }
                
                // 設定推測グラフ
//                NavigationLink(destination: izaBanchoView95Ci(
//                    izaBancho: izaBancho,
//                    selection: 1
//                )) {
//                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
//                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4805")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($ver330.izaBanchoMachineIconBadgeStaus)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: izaBancho.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
//                    unitButtonLoadMemory(loadView: AnyView(izaBanchoSubViewLoadMemory(
//                        izaBancho: izaBancho,
//                        izaBanchoMemory1: izaBanchoMemory1,
//                        izaBanchoMemory2: izaBanchoMemory2,
//                        izaBanchoMemory3: izaBanchoMemory3
//                    )))
                    // データ保存
//                    unitButtonSaveMemory(saveView: AnyView(izaBanchoSubViewSaveMemory(
//                        izaBancho: izaBancho,
//                        izaBanchoMemory1: izaBanchoMemory1,
//                        izaBanchoMemory2: izaBanchoMemory2,
//                        izaBanchoMemory3: izaBanchoMemory3
//                    )))
                }
                .popoverTip(tipUnitButtonMemory())
                // データリセット
                unitButtonReset(isShowAlert: $isShowAlert, action: izaBancho.resetAll, message: "この機種のデータを全てリセットします")
            }
        }
    }
}

#Preview {
    izaBanchoViewTop(
        ver330: Ver330()
    )
}
