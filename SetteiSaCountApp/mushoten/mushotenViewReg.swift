//
//  mushotenViewReg.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/03.
//

import SwiftUI

struct mushotenViewReg: View {
    @ObservedObject var mushoten: Mushoten
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
    @State var selectedItem: String = "白背景"
    let selectList: [String] = [
        "白背景",
        "第1話(銅)",
        "第2話(青)",
        "第4話(青)",
        "第7話(青)",
        "第8話(銀)",
        "第12話(青)",
        "第14話(赤)",
        "第16話(赤)",
        "第21話(金)",
        "第23話(赤)",
    ]
    let sisaList: [String] = [
        "デフォルト",
        "高設定示唆 弱",
        "高設定示唆 強",
        "設定2 以上濃厚",
        "設定4 以上濃厚",
        "設定6 濃厚",
    ]
    
    var body: some View {
        List {
            // ---- ストーリー話数
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
                    bigNumber: $mushoten.storyCountSum,
                    flushColor: flushColor(item: self.selectedItem),
                    minusCheck: $mushoten.minusCheck) {
                        mushoten.storySumFunc()
                    }
            } header: {
                Text("ストーリー話数")
            }
            
            // //// カウント結果
            Section {
                ForEach(self.sisaList, id: \.self) { item in
                    unitResultCountListPercent(
                        title: item,
                        count: bindingCountResult(item: item),
                        flashColor: flushColorResult(item: item),
                        bigNumber: $mushoten.storyCountSum,
                        numberofDigit: 0,
                    )
                }
            } header: {
                Text("カウント結果")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.mushotenMenuRegBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: mushoten.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("魔術ボーナス")
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
                unitButtonMinusCheck(minusCheck: $mushoten.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: mushoten.resetReg)
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
        case self.selectList[1]: return self.sisaList[3]
        case self.selectList[2]: return self.sisaList[1]
        case self.selectList[3]: return self.sisaList[1]
        case self.selectList[4]: return self.sisaList[1]
        case self.selectList[5]: return self.sisaList[4]
        case self.selectList[6]: return self.sisaList[1]
        case self.selectList[7]: return self.sisaList[2]
        case self.selectList[8]: return self.sisaList[2]
        case self.selectList[9]: return self.sisaList[5]
        case self.selectList[10]: return self.sisaList[2]
        default: return "???"
        }
    }
    
    private func bindingCount(item: String) -> Binding<Int> {
        switch item {
        case self.selectList[0]: return $mushoten.storyCountDefault
        case self.selectList[1]: return $mushoten.storyCountOver2
        case self.selectList[2]: return $mushoten.storyCountHighJaku
        case self.selectList[3]: return $mushoten.storyCountHighJaku
        case self.selectList[4]: return $mushoten.storyCountHighJaku
        case self.selectList[5]: return $mushoten.storyCountOver4
        case self.selectList[6]: return $mushoten.storyCountHighJaku
        case self.selectList[7]: return $mushoten.storyCountHighKyo
        case self.selectList[8]: return $mushoten.storyCountHighKyo
        case self.selectList[9]: return $mushoten.storyCountOver6
        case self.selectList[10]: return $mushoten.storyCountHighKyo
        default: return .constant(0)
        }
    }
    
    private func flushColor(item: String) -> Color {
        switch item {
        case self.selectList[0]: return Color.gray
        case self.selectList[1]: return Color.brown
        case self.selectList[2]: return Color.blue
        case self.selectList[3]: return Color.blue
        case self.selectList[4]: return Color.blue
        case self.selectList[5]: return Color.gray
        case self.selectList[6]: return Color.blue
        case self.selectList[7]: return Color.red
        case self.selectList[8]: return Color.red
        case self.selectList[9]: return Color.orange
        case self.selectList[10]: return Color.red
        default: return Color.gray
        }
    }
    
    private func bindingCountResult(item: String) -> Binding<Int> {
        switch item {
        case self.sisaList[0]: return $mushoten.storyCountDefault
        case self.sisaList[1]: return $mushoten.storyCountHighJaku
        case self.sisaList[2]: return $mushoten.storyCountHighKyo
        case self.sisaList[3]: return $mushoten.storyCountOver2
        case self.sisaList[4]: return $mushoten.storyCountOver4
        case self.sisaList[5]: return $mushoten.storyCountOver6
        default: return .constant(0)
        }
    }
    
    private func flushColorResult(item: String) -> Color {
        switch item {
        case self.sisaList[0]: return Color.gray
        case self.sisaList[1]: return Color.blue
        case self.sisaList[2]: return Color.red
        case self.sisaList[3]: return Color.brown
        case self.sisaList[4]: return Color.gray
        case self.sisaList[5]: return Color.orange
        default: return Color.gray
        }
    }
}

#Preview {
    mushotenViewReg(
        mushoten: Mushoten(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
