//
//  zeni5ViewEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/14.
//

import SwiftUI

struct zeni5ViewEnding: View {
    @ObservedObject var zeni5: Zeni5
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @EnvironmentObject var common: commonVar
    @State var isShowAlert = false
    @State var selectedItem: String = "どうかこの者に幸あれ"
    let selectList: [String] = [
        "どうかこの者に幸あれ",
        "地道に進める所存です",
        "この銭形の目は誤魔化せんぞ",
        "まだ実力を隠しているな",
        "これぞ無我の境地、今こそ悟りを！",
        "美味い酒が飲めそうだ",
        "これで私も超セレブってわけね！",
        "ばっかもーーん",
    ]
    
    var body: some View {
        List {
            // //// ボイス選択
            Section {
                Text("押し順リプレイの時のボイスに設定示唆パータンあり")
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
                    bigNumber: $zeni5.endingCountSum,
                    flushColor: flushColor(item: self.selectedItem),
                    minusCheck: $zeni5.minusCheck) {
                        zeni5.endingSumFunc()
                    }
            } header: {
                Text("ボイス選択")
            }
            
            // //// カウント結果
            Section {
                ForEach(self.selectList, id: \.self) { item in
                    if item != self.selectList[0]{
                        unitResultCountListPercent(
                            title: sisaText(item: item),
                            count: bindingCount(item: item),
                            flashColor: flushColor(item: item),
                            bigNumber: $zeni5.endingCountSum,
                            numberofDigit: 0,
                        )
                    }
                }
            } header: {
                Text("カウント結果")
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: zeni5.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("エンディング")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $zeni5.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: zeni5.resetEnding)
            }
        }
    }
    private func sisaText(item: String) -> String {
        switch item {
        case self.selectList[0]: return "デフォルト"
        case self.selectList[1]: return "デフォルト"
        case self.selectList[2]: return "???(この銭形の…)"
        case self.selectList[3]: return "???(まだ実力を…)"
        case self.selectList[4]: return "???(これぞ無我…)"
        case self.selectList[5]: return "???(美味い酒が…)"
        case self.selectList[6]: return "???(これで私も…)"
        case self.selectList[7]: return "???(ばっかもー…)"
        default: return "???"
        }
    }
    
    private func bindingCount(item: String) -> Binding<Int> {
        switch item {
        case self.selectList[0]: return $zeni5.endingCountDefault
        case self.selectList[1]: return $zeni5.endingCountDefault
        case self.selectList[2]: return $zeni5.endingCount2
        case self.selectList[3]: return $zeni5.endingCount3
        case self.selectList[4]: return $zeni5.endingCount4
        case self.selectList[5]: return $zeni5.endingCount5
        case self.selectList[6]: return $zeni5.endingCount6
        case self.selectList[7]: return $zeni5.endingCount7
        default: return .constant(0)
        }
    }
    
    private func flushColor(item: String) -> Color {
        switch item {
        case self.selectList[0]: return Color.gray
        case self.selectList[1]: return Color.gray
        case self.selectList[2]: return Color.blue
        case self.selectList[3]: return Color.yellow
        case self.selectList[4]: return Color.green
        case self.selectList[5]: return Color.red
        case self.selectList[6]: return Color.purple
        case self.selectList[7]: return Color.orange
        default: return Color.gray
        }
    }
}

#Preview {
    zeni5ViewEnding(
        zeni5: Zeni5(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
