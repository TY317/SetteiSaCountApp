//
//  newOni3ViewOniBonus.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/11.
//

import SwiftUI

struct newOni3ViewOniBonus: View {
    @ObservedObject var newOni3: NewOni3
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @EnvironmentObject var common: commonVar
    @State var isShowAlert = false
    @State var selectedItem: String = "青背景キャラ"
    let selectList: [String] = [
        "青背景キャラ",
        "阿倫＆みの吉",
        "幻魔",
        "無間地獄の幻魔",
        "フォーティンブラス",
        "極限覚醒鬼武者",
        "エンタライオン",
    ]
    
    var body: some View {
        List {
            // //// 奇遇カウント
            Section {
                VStack(alignment: .leading) {
                    Text("・1〜8ゲーム目までは青背景キャラ")
                    Text("・味方キャラor敵キャラで奇・偶を示唆")
                }
                .foregroundStyle(Color.secondary)
                .font(.caption)
                // カウントボタン横並び
                HStack {
                    // 味方キャラ
                    unitCountButtonPercentWithFunc(
                        title: "味方(奇数示唆)",
                        count: $newOni3.personSenarioCountMikata,
                        color: .personalSummerLightBlue,
                        bigNumber: $newOni3.personSenarioCountSum,
                        numberofDicimal: 0,
                        minusBool: $newOni3.minusCheck) {
                            newOni3.oniBonusSumFunc()
                        }
                    // 敵キャラ
                    unitCountButtonPercentWithFunc(
                        title: "敵(偶数示唆)",
                        count: $newOni3.personSenarioCountTeki,
                        color: .personalSpringLightYellow,
                        bigNumber: $newOni3.personSenarioCountSum,
                        numberofDicimal: 0,
                        minusBool: $newOni3.minusCheck) {
                            newOni3.oniBonusSumFunc()
                        }
                }
            } header: {
                Text("1〜8Gまでのキャラ種類")
            }
            
            // //// 9,10Gのキャラ種類
            Section {
                VStack(alignment: .leading) {
                    Text("・9〜10ゲーム目は設定示唆キャラが出現する可能性あり")
                }
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
                
                // 示唆＆登録ボタン
                unitCountSubmitWithResult(
                    title: sisaText(item: self.selectedItem),
                    count: bindingCount(item: self.selectedItem),
                    bigNumber: $newOni3.personFinalCountSum,
                    flushColor: flushColor(item: self.selectedItem),
                    minusCheck: $newOni3.minusCheck) {
                        newOni3.oniBonusSumFunc()
                    }
            } header: {
                Text("9〜10Gまでのキャラ種類 選択")
            }
            
            // //// カウント結果
            Section {
                ForEach(self.selectList, id: \.self) { item in
                    unitResultCountListPercent(
                        title: sisaText(item: item),
                        count: bindingCount(item: item),
                        flashColor: flushColor(item: item),
                        bigNumber: $newOni3.personFinalCountSum,
                        numberofDigit: 0,
                    )
                }
            } header: {
                Text("9〜10Gまでのキャラ種類 カウント結果")
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: newOni3.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("鬼ボーナス")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $newOni3.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: newOni3.resetOniBonus)
            }
        }
    }
    private func sisaText(item: String) -> String {
        switch item {
        case self.selectList[0]: return "デフォルト"
        case self.selectList[1]: return "高設定示唆"
        case self.selectList[2]: return "設定2 以上濃厚"
        case self.selectList[3]: return "設定3 以上濃厚"
        case self.selectList[4]: return "設定4 以上濃厚"
        case self.selectList[5]: return "設定5 以上濃厚"
        case self.selectList[6]: return "設定6 濃厚"
        default: return "???"
        }
    }
    
    private func bindingCount(item: String) -> Binding<Int> {
        switch item {
        case self.selectList[0]: return $newOni3.personFinalCountDefault
        case self.selectList[1]: return $newOni3.personFinalCountHigh
        case self.selectList[2]: return $newOni3.personFinalCountOver2
        case self.selectList[3]: return $newOni3.personFinalCountOver3
        case self.selectList[4]: return $newOni3.personFinalCountOver4
        case self.selectList[5]: return $newOni3.personFinalCountOver5
        case self.selectList[6]: return $newOni3.personFinalCountOver6
        default: return .constant(0)
        }
    }
    private func flushColor(item: String) -> Color {
        switch item {
        case self.selectList[0]: return Color.gray
        case self.selectList[1]: return Color.green
        case self.selectList[2]: return Color.green
        case self.selectList[3]: return Color.green
        case self.selectList[4]: return Color.red
        case self.selectList[5]: return Color.purple
        case self.selectList[6]: return Color.orange
        default: return Color.gray
        }
    }
}

#Preview {
    newOni3ViewOniBonus(
        newOni3: NewOni3(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
