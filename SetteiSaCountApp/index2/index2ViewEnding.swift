//
//  index2ViewEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct index2ViewEnding: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var index2: Index2
    @State var isShowDestination: Bool = false
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

    @State var selectedItem: String = "頑張ったね"
    let selectList: [String] = [
        "頑張ったね",
        "調子良いね",
        "ワクワクしてきたかも",
        "いけるかも",
        "やったあ！",
        "すごい！すごい！",
        "とっても美味しい！",
        "すっごくうれしい！",
        "おめでとう！",
    ]
    let sisaList: [String] = [
        "???(頑張ったね)",
        "???(調子良いね)",
        "???(ワクワク)",
        "???(いけるかも)",
        "???(やったあ！)",
        "???(すごい！)",
        "???(美味しい！)",
        "???(うれしい！)",
        "???(おめでとう！)",
    ]

    var body: some View {
        List {
            // セリフ選択
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
                    count: bindingComment(item: self.selectedItem),
                    bigNumber: $index2.commentCountSum,
                    flushColor: flushColor(item: self.selectedItem),
                    minusCheck: $index2.minusCheck) {
                        index2.commentSumFunc()
                    }
            } header: {
                Text("セリフ選択")
            }

            // カウント結果
            Section {
                ForEach(self.selectList, id: \.self) { item in
                    unitResultCountListPercent(
                        title: sisaText(item: item),
                        count: bindingComment(item: item),
                        flashColor: flushColor(item: item),
                        bigNumber: $index2.commentCountSum
                    )
                }
            } header: {
                Text("カウント結果")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.index2MenuEndingBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: index2.machineName,
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
                unitButtonMinusCheck(minusCheck: $index2.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: index2.resetComment)
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
        default: return "???"
        }
    }

    private func bindingComment(item: String) -> Binding<Int> {
        switch item {
        case self.selectList[0]: return $index2.commentCount1
        case self.selectList[1]: return $index2.commentCount2
        case self.selectList[2]: return $index2.commentCount3
        case self.selectList[3]: return $index2.commentCount4
        case self.selectList[4]: return $index2.commentCount5
        case self.selectList[5]: return $index2.commentCount6
        case self.selectList[6]: return $index2.commentCount7
        case self.selectList[7]: return $index2.commentCount8
        case self.selectList[8]: return $index2.commentCount9
        default: return .constant(0)
        }
    }

    private func flushColor(item: String) -> Color {
        switch item {
        case self.selectList[0]: return .gray
        case self.selectList[1]: return .gray
        case self.selectList[2]: return .gray
        case self.selectList[3]: return .gray
        case self.selectList[4]: return .blue
        case self.selectList[5]: return .green
        case self.selectList[6]: return .red
        case self.selectList[7]: return .purple
        case self.selectList[8]: return .orange
        default: return .gray
        }
    }
}

#Preview {
    index2ViewEnding(
        index2: Index2(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
