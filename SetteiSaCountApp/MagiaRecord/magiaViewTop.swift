//
//  magiaViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/03.
//

import SwiftUI

struct magiaViewTop: View {
    @ObservedObject var ver270 = Ver270()
    @ObservedObject var magia = Magia()
    @State var isShowAlert: Bool = false
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("ユニメモの利用を前提としています\n遊技前にユニメモを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(machineName: "マギアレコード")
                }
                
                Section {
                    // 通常時
                    NavigationLink(destination: magiaViewNormal()) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時"
                        )
                    }
                    // 初当り
                    NavigationLink(destination: magiaViewFirstHit()) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "ボーナス,AT 初当り"
                        )
                    }
                    // BIG終了画面
                    NavigationLink(destination: magiaViewBigScreen()) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "BIG終了画面"
                        )
                    }
                    // ボーナス終了後ボイス
                    NavigationLink(destination: magiaViewVoice()) {
                        unitLabelMenu(
                            imageSystemName: "message.fill",
                            textBody: "BIG終了後ボイス"
                        )
                    }
                    // AT終了画面
                    NavigationLink(destination: magiaViewAtScreen()) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "AT終了画面"
                        )
                    }
                }
                // 設定推測グラフ
                NavigationLink(destination: magiaView95Ci()) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4745")
                    .popoverTip(tipVer220AddLink())
            }
        }
        .onAppear {
            if ver270.magiaMachineIconBadgeStatus != "none" {
                ver270.magiaMachineIconBadgeStatus = "none"
            }
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
//                    unitButtonLoadMemory(loadView: AnyView(magiaSubViewLoadMemory()))
                    // データ保存
//                    unitButtonSaveMemory(saveView: AnyView(magiaSubViewSaveMemory()))
                }
                .popoverTip(tipUnitButtonMemory())
                // データリセット
                unitButtonReset(isShowAlert: $isShowAlert, action: magia.resetAll, message: "この機種のデータを全てリセットします")
                    .popoverTip(tipUnitButtonReset())
            }
        }
    }
}

#Preview {
    magiaViewTop()
}
