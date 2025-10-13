//
//  newOni3ViewEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/12.
//

import SwiftUI

struct newOni3ViewEnding: View {
    @ObservedObject var newOni3: NewOni3
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @EnvironmentObject var common: commonVar
    @State var isShowAlert = false
    @State var selectedItem: String = "わりぃがさっさとかたづけさせてもらうぜ！"
    let selectList: [String] = [
        "わりぃがさっさとかたづけさせてもらうぜ！",
        "主よ この者にご加護を！",
        "私…あなたと一緒に生きていく！",
        "お主の力見せてもらおう！",
        "ここが腕の見せ所だな！",
        "楽しんでるでござるか？",
        "サポートは任せるでござる！",
        "拙者も蒼鬼殿のような侍になるでござる！",
        "あたいはここで見守ってるよ",
        "あんたの力信じるよ！",
        "鬼武者を超えた鬼武者だね！",
        "お前こそ真の鬼武者だ！",
        "にゃにゃにゃーん",
    ]
    
    var body: some View {
        List {
            // //// ボイス選択
            Section {
                Text("レア役成立時にPUSHボタンで示唆ボイス発生")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                
                // サークルピッカー
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
                    bigNumber: $newOni3.endingCountSum,
                    flushColor: flushColor(item: self.selectedItem),
                    minusCheck: $newOni3.minusCheck) {
                        newOni3.endingSumFunc()
                    }
            } header: {
                Text("ボイス選択")
            }
            
            // //// カウント結果
            Section {
                ForEach(self.selectList, id: \.self) { item in
                    unitResultCountListPercent(
                        title: sisaText(item: item),
                        count: bindingCount(item: item),
                        flashColor: flushColor(item: item),
                        bigNumber: $newOni3.endingCountSum,
                        numberofDigit: 0,
                    )
                }
            } header: {
                Text("カウント結果")
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
        .navigationTitle("エンディング")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $newOni3.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: newOni3.resetEnding)
            }
        }
    }
    private func sisaText(item: String) -> String {
        switch item {
        case self.selectList[0]: return "デフォルト"
        case self.selectList[1]: return "奇数示唆 弱"
        case self.selectList[2]: return "偶数示唆 弱"
        case self.selectList[3]: return "奇数示唆 強"
        case self.selectList[4]: return "偶数示唆 強"
        case self.selectList[5]: return "設定2 否定"
        case self.selectList[6]: return "設定3 否定"
        case self.selectList[7]: return "設定4 否定"
        case self.selectList[8]: return "設定2 以上濃厚"
        case self.selectList[9]: return "設定3 以上濃厚"
        case self.selectList[10]: return "設定4 以上濃厚"
        case self.selectList[11]: return "設定5 以上濃厚"
        case self.selectList[12]: return "設定6 濃厚"
        default: return "???"
        }
    }
    
    private func bindingCount(item: String) -> Binding<Int> {
        switch item {
        case self.selectList[0]: return $newOni3.endingCountDefault
        case self.selectList[1]: return $newOni3.endingCountKisuJaku
        case self.selectList[2]: return $newOni3.endingCountGusuJaku
        case self.selectList[3]: return $newOni3.endingCountKisuKyo
        case self.selectList[4]: return $newOni3.endingCountGusuKyo
        case self.selectList[5]: return $newOni3.endingCountNegate2
        case self.selectList[6]: return $newOni3.endingCountNegate3
        case self.selectList[7]: return $newOni3.endingCountNegate4
        case self.selectList[8]: return $newOni3.endingCountOver2
        case self.selectList[9]: return $newOni3.endingCountOver3
        case self.selectList[10]: return $newOni3.endingCountOver4
        case self.selectList[11]: return $newOni3.endingCountOver5
        case self.selectList[12]: return $newOni3.endingCountOver6
        default: return .constant(0)
        }
    }
    
    private func flushColor(item: String) -> Color {
        switch item {
        case self.selectList[0]: return Color.gray
        case self.selectList[1]: return Color.blue
        case self.selectList[2]: return Color.yellow
        case self.selectList[3]: return Color.blue
        case self.selectList[4]: return Color.yellow
        case self.selectList[5]: return Color.cyan
        case self.selectList[6]: return Color.green
        case self.selectList[7]: return Color.red
        case self.selectList[8]: return Color.cyan
        case self.selectList[9]: return Color.green
        case self.selectList[10]: return Color.red
        case self.selectList[11]: return Color.purple
        case self.selectList[12]: return Color.orange
        default: return Color.gray
        }
    }
}

#Preview {
    newOni3ViewEnding(
        newOni3: NewOni3(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
