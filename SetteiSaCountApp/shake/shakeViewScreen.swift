//
//  shakeViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/05.
//

import SwiftUI

struct shakeViewScreen: View {
    @ObservedObject var shake: Shake
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    @State var isShowAlert: Bool = false
    @State var selectedItem: String = "Paris(青)"
    let selectList: [String] = [
        "Paris(青)",
        "Bangkok(黄)",
        "Hanoi(緑)",
        "Athens(紫)",
        "Amsterdam(虹)",
        "Special(金)",
        "NewYork(黒)",
    ]
    let sisaList: [String] = [
        "デフォルト",
        "高設定示唆 弱",
        "高設定示唆 中",
        "高設定示唆 強",
        "設定6 濃厚",
        "1000枚以上獲得",
        "1500枚以上獲得",
    ]
    
    var body: some View {
        List {
            // ---- 終了画面
            Section {
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
                    bigNumber: $shake.screenCountSum,
                    flushColor: flushColor(item: self.selectedItem),
                    minusCheck: $shake.minusCheck) {
                        shake.screenSumFunc()
                    }
            } header: {
                Text("終了画面")
            }
            
            // //// カウント結果
            Section {
                ForEach(self.selectList, id: \.self) { item in
                    unitResultCountListPercent(
                        title: sisaText(item: item),
                        count: bindingCount(item: item),
                        flashColor: flushColor(item: item),
                        bigNumber: $shake.screenCountSum,
                        numberofDigit: 0,
                    )
                }
            } header: {
                Text("カウント結果")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.shakeMenuScreenBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: shake.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("BIG終了画面")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $shake.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: shake.resetScreen)
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
        default: return "???"
        }
    }
    
    private func bindingCount(item: String) -> Binding<Int> {
        switch item {
        case self.selectList[0]: return $shake.screenCountDefault
        case self.selectList[1]: return $shake.screenCountHighJaku
        case self.selectList[2]: return $shake.screenCountHighChu
        case self.selectList[3]: return $shake.screenCountHighKyo
        case self.selectList[4]: return $shake.screenCountOver6
        case self.selectList[5]: return $shake.screenCountOver1000
        case self.selectList[6]: return $shake.screenCountOver1500
        default: return .constant(0)
        }
    }
    
    private func flushColor(item: String) -> Color {
        switch item {
        case self.selectList[0]: return Color.blue
        case self.selectList[1]: return Color.yellow
        case self.selectList[2]: return Color.green
        case self.selectList[3]: return Color.purple
        case self.selectList[4]: return Color.red
        case self.selectList[4]: return Color.orange
        case self.selectList[4]: return Color.gray
        default: return Color.gray
        }
    }
}

#Preview {
    shakeViewScreen(
        shake: Shake(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
