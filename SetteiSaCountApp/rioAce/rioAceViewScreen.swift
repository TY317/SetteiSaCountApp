//
//  rioAceViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/05/03.
//

import SwiftUI

struct rioAceViewScreen: View {
    @ObservedObject var rioAce: RioAce
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    @State var isShowAlert: Bool = false
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 250.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 250.0
    let lazyVGridCountPortrait: Int = 3
    let lazyVGridCountLandscape: Int = 5
    @State var lazyVGridCount: Int = 3
    
    @State var selectedItem: String = "サインなし"
    let selectList: [String] = [
        "サインなし",
        "リオ",
        "ミント",
        "リナ",
    ]
    let sisaList: [String] = [
        "???(なし)",
        "???(リオ)",
        "???(ミント)",
        "???(リナ)",
    ]
    var body: some View {
        List {
            // サイン選択
            Section {
                // 注意書き
                Text("終了画面左上のサインで設定を示唆")
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
                
                // //// 示唆＆登録ボタン
                unitCountSubmitWithResult(
                    title: sisaText(item: self.selectedItem),
                    count: bindingVoice(item: self.selectedItem),
                    bigNumber: $rioAce.screenCountSum,
                    flushColor: flushColor(item: self.selectedItem),
                    minusCheck: $rioAce.minusCheck) {
                        rioAce.screenSumFunc()
                    }
                
            } header: {
                Text("サイン選択")
            }
            
            // カウント結果
            Section {
                ForEach(self.selectList, id: \.self) { signature in
                    unitResultCountListPercent(
                        title: sisaText(item: signature),
                        count: bindingVoice(item: signature),
                        flashColor: flushColor(item: signature),
                        bigNumber: $rioAce.screenCountSum
                    )
                }
            } header: {
                Text("カウント結果")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.rioAceMenuScreenBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: rioAce.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("終了画面")
        .navigationBarTitleDisplayMode(.inline)
        // //// 画面の向き情報の取得部分
        .applyOrientationHandling(
            orientation: self.$orientation,
            lastOrientation: self.$lastOrientation,
            scrollViewHeight: self.$scrollViewHeight,
            spaceHeight: self.$spaceHeight,
            lazyVGridCount: self.$lazyVGridCount,
            scrollViewHeightPortrait: self.scrollViewHeightPortrait,
            scrollViewHeightLandscape: self.scrollViewHeightLandscape,
            spaceHeightPortrait: self.spaceHeightPortrait,
            spaceHeightLandscape: self.spaceHeightLandscape,
            lazyVGridCountPortrait: self.lazyVGridCountPortrait,
            lazyVGridCountLandscape: self.lazyVGridCountLandscape
        )
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $rioAce.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: rioAce.resetScreen)
            }
        }
    }
    
    private func sisaText(item: String) -> String {
        switch item {
        case self.selectList[0]: return self.sisaList[0]
        case self.selectList[1]: return self.sisaList[1]
        case self.selectList[2]: return self.sisaList[2]
        case self.selectList[3]: return self.sisaList[3]
        default: return "???"
        }
    }
    
    private func bindingVoice(item: String) -> Binding<Int> {
        switch item {
        case self.selectList[0]: return $rioAce.screenCountNone
        case self.selectList[1]: return $rioAce.screenCountRio
        case self.selectList[2]: return $rioAce.screenCountMint
        case self.selectList[3]: return $rioAce.screenCountRina
        default: return .constant(0)
        }
    }
    
    private func flushColor(item: String) -> Color {
        switch item {
        case self.selectList[0]: return .gray
        case self.selectList[1]: return .blue
        case self.selectList[2]: return .green
        case self.selectList[3]: return .red
        default: return .gray
        }
    }
}

#Preview {
    rioAceViewScreen(
        rioAce: RioAce(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
