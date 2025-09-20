//
//  toreveViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/02.
//

import SwiftUI

struct toreveViewNormal: View {
    @ObservedObject var ver391: Ver391
    @ObservedObject var toreve: Toreve
    @State var isShowAlert: Bool = false
    @FocusState var isFocused: Bool
    @State var selectedSegment: String = "ミッドナイトモード"
    let segmentList: [String] = ["ミッドナイトモード", "稀咲陰謀"]
    var body: some View {
        List {
            // //// 共通🔔
            Section {
                // 注意書き
                Text("左1stで上段平行に揃う共通ベルに設定差あり\nAT中は判別不可なのでカウントは通常時のみ")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // カウントボタン
                unitCountButtonVerticalDenominate(
                    title: "共通🔔",
                    count: $toreve.bellCount,
                    color: .personalSpringLightYellow,
                    bigNumber: $toreve.gameNumberPlay,
                    numberofDicimal: 0,
                    minusBool: $toreve.minusCheck,
                    flushColor: .yellow,
                )
                .popoverTip(tipVer391ToreveNormal())
                // 参考情報）共通ベル確率
                unitLinkButtonViewBuilder(sheetTitle: "共通🔔確率") {
                    VStack {
                        // 注意書き
                        VStack(alignment: .leading) {
                            Text("・左1stで上段平行に揃う共通🔔に設定差あり")
                            Text("・AT中は押し順ナビが出て判別できないケースがあるため、カウントは通常時のみ可能")
                        }
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTableDenominate(
                                columTitle: "共通🔔",
                                denominateList: toreve.ratioBell,
                            )
                        }
                    }
                }
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        toreveView95Ci(
                            toreve: toreve,
                            selection: 7,
                        )
                    )
                )
            } header: {
                Text("共通ベル")
            }
            
            // //// ゲーム数入力
            Section {
                // 打ち始め入力
                unitTextFieldNumberInputWithUnit(
                    title: "打ち始め",
                    inputValue: $toreve.gameNumberStart,
                    unitText: "Ｇ"
                )
                .focused(self.$isFocused)
                .onChange(of: toreve.gameNumberStart) {
                    let playGame = toreve.gameNumberCurrent - toreve.gameNumberStart
                    toreve.gameNumberPlay = playGame > 0 ? playGame : 0
                }
                // 現在入力
                unitTextFieldNumberInputWithUnit(
                    title: "現在",
                    inputValue: $toreve.gameNumberCurrent,
                    unitText: "Ｇ"
                )
                .focused(self.$isFocused)
                .onChange(of: toreve.gameNumberCurrent) {
                    let playGame = toreve.gameNumberCurrent - toreve.gameNumberStart
                    toreve.gameNumberPlay = playGame > 0 ? playGame : 0
                }
                // プレイ数
                unitTextGameNumberWithoutInput(
                    gameNumber: toreve.gameNumberPlay
                )
                
            } header: {
                HStack {
                    Text("ゲーム数入力")
                }
            }
            
            // //// 小役関連
            Section {
                // レア役停止系
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止系", linkText: "レア役停止系") {
                    toreveTableKoyakuPattern()
                }
                // 参考情報）中段🍒確率
                unitLinkButtonViewBuilder(sheetTitle: "中段🍒確率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTableDenominate(
                            columTitle: "中段🍒",
                            denominateList: [16384,13107.2,10922.7],
                            lineList: [3,2,1],
                            colorList: [.white, .tableBlue, .white],
                        )
                    }
                }
                // 参考情報）レア役からのCZ当選率
                unitLinkButtonViewBuilder(sheetTitle: "レア役からのCZ当選率") {
                    VStack {
                        Picker("", selection: self.$selectedSegment) {
                            ForEach(self.segmentList, id: \.self) { czKind in
                                Text(czKind)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding(.bottom)
                        if self.selectedSegment == self.segmentList[0] {
                            Text("[通常滞在時]")
                                .font(.title2)
                            HStack(spacing: 0) {
                                unitTableSettingIndex()
                                unitTablePercent(
                                    columTitle: "チャンス目",
                                    percentList: toreve.ratioNormalChanceMidNight,
                                    numberofDicimal: 1,
                                )
                                unitTablePercent(
                                    columTitle: "強🍒",
                                    percentList: toreve.ratioNormalKyoCherryMidNight,
                                    numberofDicimal: 0,
                                )
                            }
                            .padding(.bottom)
                            Text("[高確滞在時]")
                                .font(.title2)
                            HStack(spacing: 0) {
                                unitTableSettingIndex()
                                unitTablePercent(
                                    columTitle: "チャンス目",
                                    percentList: toreve.ratioHighChanceMidNight,
                                    numberofDicimal: 0,
                                )
                                unitTablePercent(
                                    columTitle: "強🍒",
                                    percentList: toreve.ratioHighKyoCherryMidNight,
                                    numberofDicimal: 0,
                                )
                            }
                        } else {
                            Text("[通常滞在時]")
                                .font(.title2)
                            HStack(spacing: 0) {
                                unitTableSettingIndex()
                                unitTablePercent(
                                    columTitle: "卍目",
                                    percentList: toreve.ratioNormalManjiKisaki,
                                    numberofDicimal: 1,
                                )
                            }
                            .padding(.bottom)
                            Text("[高確滞在時]")
                                .font(.title2)
                            HStack(spacing: 0) {
                                unitTableSettingIndex()
                                unitTablePercent(
                                    columTitle: "卍目",
                                    percentList: toreve.ratioHighManjiKisaki,
                                    numberofDicimal: 1,
                                )
                            }
                        }
                    }
                }
            } header: {
                Text("レア役")
            }
            
            // //// 内部状態
            Section {
                // 参考情報）内部状態
                unitLinkButtonViewBuilder(sheetTitle: "内部状態") {
                    HStack(spacing: 0) {
                        unitTableString(
                            columTitle: "",
                            stringList: [
                                "種類",
                                "昇格契機",
                                "高確恩恵",
                            ],
                            maxWidth: 100,
                        )
                        unitTableString(
                            columTitle: "",
                            stringList: [
                                "通常・高確の2種類",
                                "主に🍉、弱🍒、卍目",
                                "東卍アクセル、CZ当選が優遇",
                            ],
                            maxWidth: 250,
                        )
                    }
                }
            } header: {
                Text("内部状態")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($ver391.toreveMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: toreve.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $toreve.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: toreve.resetNormal)
                }
            }
            ToolbarItem(placement: .keyboard) {
                HStack {
                    Spacer()
                    Button(action: {
                        isFocused = false
                    }, label: {
                        Text("完了")
                            .fontWeight(.bold)
                    })
                }
            }
        }
    }
}

#Preview {
    toreveViewNormal(
        ver391: Ver391(),
        toreve: Toreve(),
    )
}
