//
//  hihodenViewDuringBonus.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/18.
//

import SwiftUI

struct hihodenViewDuringBonus: View {
    @ObservedObject var hihoden: Hihoden
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @EnvironmentObject var common: commonVar
    @State var isShowAlert: Bool = false
    @FocusState var isFocused: Bool
    
    @State var selectedItem: String = "ファラオ仮面1号"
    let selectList: [String] = [
        "ファラオ仮面1号",
        "ファラオ仮面2号",
        "ベカン子(白)",
        "ベカン子(赤)",
        "ベカン子(黄)",
        "ベロベロ大魔神",
        "巫女クレア",
        "浴衣クレア",
        "小悪魔クレア",
        "サンタクレア",
    ]
    let sisaList: [String] = [
        "高設定示唆 弱",
        "高設定示唆 強",
        "設定2 否定",
        "設定3 否定",
        "設定4 否定",
        "設定変更濃厚",
        "設定2 以上濃厚",
        "設定4 以上濃厚",
        "設定5 以上濃厚",
        "設定6 濃厚",
    ]
    
    var body: some View {
        List {
            Section {
                Text("ボーナス中ゲーム数：ダイトモを参考に入力して下さい\nハズレ回数：自力カウントして下さい")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // ボーナス中ゲーム数入力
                unitTextFieldNumberInputWithUnit(
                    title: "ボーナス中ゲーム数",
                    inputValue: $hihoden.bonusGame,
                    unitText: "Ｇ",
                )
                .focused(self.$isFocused)
                
                // ハズレ回数カウント
                unitCountButtonVerticalDenominate(
                    title: "ハズレ",
                    count: $hihoden.bonusHazureCount,
                    color: .personalSummerLightRed,
                    bigNumber: $hihoden.bonusGame,
                    numberofDicimal: 0,
                    minusBool: $hihoden.minusCheck
                )
                
                // 参考情報）ボーナス中ハズレ確率
                unitLinkButtonViewBuilder(sheetTitle: "ボーナス中のハズレ確率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTableDenominate(
                            columTitle: "ハズレ",
                            denominateList: hihoden.ratioBonusHazure,
                        )
                    }
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        hihodenView95Ci(
                            hihoden: hihoden,
                            selection: 3,
                        )
                    )
                )
                
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    hihodenViewBayes(
                        hihoden: hihoden,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("ボーナス中のハズレ")
            }
            
            // REG中のキャラ紹介
            Section {
//                DisclosureGroup {
                    // サークルピッカー
                    Picker("", selection: self.$selectedItem) {
                        ForEach(self.selectList, id: \.self) { item in
                            Text(item)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 150)
                    
                    // //// 示唆＆登録ボタン
                    unitCountSubmitWithResult(
                        title: sisaText(item: self.selectedItem),
                        count: bindingVoice(item: self.selectedItem),
                        bigNumber: $hihoden.charaCountSum,
                        flushColor: flushColor(item: self.selectedItem),
                        minusCheck: $hihoden.minusCheck) {
                            hihoden.charaSumFunc()
                        }
                    
                    // スペース用の行
//                    Text("")
//                        .listRowBackground(Color(UIColor.systemGroupedBackground))
//                        .listRowSeparator(.hidden)
                    
//                    // カウント結果
//                    ForEach(self.selectList, id: \.self) { voice in
//                        unitResultCountListPercent(
//                            title: sisaText(item: voice),
//                            count: bindingVoice(item: voice),
//                            flashColor: flushColor(item: voice),
//                            bigNumber: $hihoden.charaCountSum,
//                        )
//                    }
//                    
//                    // 参考情報）トランプ役での示唆
//                    unitLinkButtonViewBuilder(sheetTitle: "トランプ役での示唆") {
//                        VStack {
//                            VStack(alignment: .leading) {
////                                Text("・銀、金背景のキャラに注目")
//                                Text("・カードの組み合わせによる役などで伝説モードなどを示唆")
//                                hihodenTableRegSisa()
//                            }
//                        }
//                    }
//                } label: {
//                    Text("キャラカウント")
//                        .foregroundStyle(Color.blue)
//                }
            } header: {
                Text("REG中のキャラ紹介")
            }
            .popoverTip(tipVer3211HihodenChara())
            
            // カウント結果
            Section {
                // カウント結果
                ForEach(self.selectList, id: \.self) { voice in
                    unitResultCountListPercent(
                        title: sisaText(item: voice),
                        count: bindingVoice(item: voice),
                        flashColor: flushColor(item: voice),
                        bigNumber: $hihoden.charaCountSum,
                    )
                }
                
                // 参考情報）トランプ役での示唆
                unitLinkButtonViewBuilder(sheetTitle: "トランプ役での示唆") {
                    VStack {
                        VStack(alignment: .leading) {
//                                Text("・銀、金背景のキャラに注目")
                            Text("・カードの組み合わせによる役などで伝説モードなどを示唆")
                            hihodenTableRegSisa()
                        }
                    }
                }
            } header: {
                Text("カウント結果")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.hihodenMenuDuringBonusBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: hihoden.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("ボーナス中")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $hihoden.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: hihoden.resetDuringBonus)
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
    
    private func sisaText(item: String) -> String {
        switch item {
        case self.selectList[0]: return self.sisaList[0]
        case self.selectList[1]: return self.sisaList[1]
        case self.selectList[2]: return self.sisaList[2]
        case self.selectList[3]: return self.sisaList[3]
        case self.selectList[4]: return self.sisaList[4]
        case self.selectList[5]: return self.sisaList[5]
        case self.selectList[6]: return self.sisaList[6]
        case self.selectList[7]: return self.sisaList[7]
        case self.selectList[8]: return self.sisaList[8]
        case self.selectList[9]: return self.sisaList[9]
        default: return "???"
        }
    }
    
    private func bindingVoice(item: String) -> Binding<Int> {
        switch item {
        case self.selectList[0]: return $hihoden.charaCountHighJaku
        case self.selectList[1]: return $hihoden.charaCountHighKyo
        case self.selectList[2]: return $hihoden.charaCountNegate2
        case self.selectList[3]: return $hihoden.charaCountNegate3
        case self.selectList[4]: return $hihoden.charaCountNegate4
        case self.selectList[5]: return $hihoden.charaCountChange
        case self.selectList[6]: return $hihoden.charaCountOver2
        case self.selectList[7]: return $hihoden.charaCountOver4
        case self.selectList[8]: return $hihoden.charaCountOver5
        case self.selectList[9]: return $hihoden.charaCountOver6
        default: return .constant(0)
        }
    }
    
    private func flushColor(item: String) -> Color {
        switch item {
        case self.selectList[0]: return .blue
        case self.selectList[1]: return .green
        case self.selectList[2]: return .gray
        case self.selectList[3]: return .pink
        case self.selectList[4]: return .yellow
        case self.selectList[5]: return .gray
        case self.selectList[6]: return .cyan
        case self.selectList[7]: return .orange
        case self.selectList[8]: return .purple
        case self.selectList[9]: return .red
        default: return .gray
        }
    }
}

#Preview {
    hihodenViewDuringBonus(
        hihoden: Hihoden(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
