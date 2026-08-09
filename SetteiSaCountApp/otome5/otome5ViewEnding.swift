//
//  otome5ViewEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/06/04.
//

import SwiftUI

struct otome5ViewEnding: View {
    @ObservedObject var otome5: Otome5
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    @State var isShowAlert: Bool = false

    @State var selectedItem: String = "なんとかなるっしょ"
    let selectList: [String] = [
        "なんとかなるっしょ",
        "感謝、感謝",
        "怪しい・・",
        "どーよ？あたしも中々いけてるっしょ",
        "きゅいーん",
        "サンキュー",
        "ご機嫌っしょ",
        "攻めどきっしょ",
        "気分アゲアゲだし",
        "戦乱に忍ぶ深紅の影、石川ゴエモン",
        "なになに、気になるー？",
        "ちょーっと本気出しちゃおっかな？",
    ]
    let sisaList: [String] = [
        "デフォルト",
        "奇数示唆",
        "偶数示唆",
        "高設定示唆 弱",
        "高設定示唆 強",
        "設定2 以上濃厚",
        "設定3 以上濃厚",
        "設定4 以上濃厚",
        "設定5 以上濃厚",
        "設定6 濃厚",
        "設定2 否定",
        "設定3 否定",
    ]

    var body: some View {
        List {
            // ---- キャラ紹介
            Section {
                Text("キャラ紹介の左のキャラで設定を示唆")
            } header: {
                Text("キャラ紹介")
            }

            // ボイス選択
            Section {
                Text("レア役時のボイス種類で設定を示唆")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // サークルピッカー
                Picker("", selection: self.$selectedItem) {
                    ForEach(self.selectList, id: \.self) { item in
                        Text(item)
                    }
                }
                .pickerStyle(.wheel)
                .frame(height: 150)
                .popoverTip(tipVer430Otome5Voice())

                // //// 示唆＆登録ボタン
                unitCountSubmitWithResult(
                    title: sisaText(item: self.selectedItem),
                    count: bindingVoice(item: self.selectedItem),
                    bigNumber: $otome5.voiceCountSum,
                    flushColor: flushColor(item: self.selectedItem),
                    minusCheck: $otome5.minusCheck) {
                        otome5.voiceSumFunc()
                    }
            } header: {
                Text("ボイス選択")
            }

            // カウント結果
            Section {
                ForEach(self.selectList, id: \.self) { item in
                    unitResultCountListPercent(
                        title: sisaText(item: item),
                        count: bindingVoice(item: item),
                        flashColor: flushColor(item: item),
                        bigNumber: $otome5.voiceCountSum
                    )
                }
            } header: {
                Text("カウント結果")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.otome5MenuEndingBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: otome5.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("エンディング")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $otome5.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: otome5.resetVoice)
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
        case self.selectList[10]: return self.sisaList[10]
        case self.selectList[11]: return self.sisaList[11]
        default: return "???"
        }
    }

    private func bindingVoice(item: String) -> Binding<Int> {
        switch item {
        case self.selectList[0]: return $otome5.voiceCount1
        case self.selectList[1]: return $otome5.voiceCount2
        case self.selectList[2]: return $otome5.voiceCount3
        case self.selectList[3]: return $otome5.voiceCount4
        case self.selectList[4]: return $otome5.voiceCount5
        case self.selectList[5]: return $otome5.voiceCount6
        case self.selectList[6]: return $otome5.voiceCount7
        case self.selectList[7]: return $otome5.voiceCount8
        case self.selectList[8]: return $otome5.voiceCount9
        case self.selectList[9]: return $otome5.voiceCount10
        case self.selectList[10]: return $otome5.voiceCount11
        case self.selectList[11]: return $otome5.voiceCount12
        default: return .constant(0)
        }
    }

    private func flushColor(item: String) -> Color {
        switch item {
        case self.selectList[0]: return .gray
        case self.selectList[1]: return .blue
        case self.selectList[2]: return .yellow
        case self.selectList[3]: return .green
        case self.selectList[4]: return .red
        case self.selectList[5]: return .brown
        case self.selectList[6]: return .gray
        case self.selectList[7]: return .orange
        case self.selectList[8]: return .pink
        case self.selectList[9]: return .purple
        case self.selectList[10]: return .cyan
        case self.selectList[11]: return .orange
        default: return .gray
        }
    }
}

#Preview {
    otome5ViewEnding(
        otome5: Otome5(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
