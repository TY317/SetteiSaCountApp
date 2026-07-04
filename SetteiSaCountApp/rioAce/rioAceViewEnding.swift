//
//  rioAceViewEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct rioAceViewEnding: View {
    @ObservedObject var rioAce: RioAce
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    @State var isShowAlert: Bool = false
    @FocusState var isFocused: Bool
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
        "お客様がお望みなら(青)",
        "ちゅうもーく(黄)",
        "良い予感がする(緑)",
        "承認します(赤)",
        "激ヤバじゃん(虹)",
    ]
    let sisaList: [String] = [
        "デフォルト",
        "高設定示唆 弱",
        "高設定示唆 中",
        "高設定示唆 強",
        "設定4 以上濃厚",
    ]
    var body: some View {
        List {
            // ボイス選択
            Section {
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
                    bigNumber: $rioAce.voiceCountSum,
                    flushColor: flushColor(item: self.selectedItem),
                    minusCheck: $rioAce.minusCheck) {
                        rioAce.voiceSumFunc()
                    }
                
            } header: {
                Text("ボイス選択")
            }
            
            // カウント結果
            Section {
                ForEach(self.selectList, id: \.self) { voice in
                    unitResultCountListPercent(
                        title: sisaText(item: voice),
                        count: bindingVoice(item: voice),
                        flashColor: flushColor(item: voice),
                        bigNumber: $rioAce.voiceCountSum
                    )
                }
                
                // ボイス振分け
                unitLinkButtonViewBuilder(sheetTitle: "ボイス振分け") {
                    rioAceTableVoiceFuriwake(rioAce: rioAce)
                }
                
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    rioAceViewBayes(
                        rioAce: rioAce,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("カウント結果")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.rioAceMenuEndingBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: rioAce.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("エンディング")
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
                unitButtonReset(isShowAlert: $isShowAlert, action: rioAce.resetVoice)
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
        default: return "???"
        }
    }
    
    private func bindingVoice(item: String) -> Binding<Int> {
        switch item {
        case self.selectList[0]: return $rioAce.voiceCount1
        case self.selectList[1]: return $rioAce.voiceCount2
        case self.selectList[2]: return $rioAce.voiceCount3
        case self.selectList[3]: return $rioAce.voiceCount4
        case self.selectList[4]: return $rioAce.voiceCount5
        default: return .constant(0)
        }
    }
    
    private func flushColor(item: String) -> Color {
        switch item {
        case self.selectList[0]: return .blue
        case self.selectList[1]: return .yellow
        case self.selectList[2]: return .green
        case self.selectList[3]: return .red
        case self.selectList[4]: return .purple
        default: return .gray
        }
    }
}

#Preview {
    rioAceViewEnding(
        rioAce: RioAce(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
