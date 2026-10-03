//
//  kanokariViewDuringRb.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct kanokariViewDuringRb: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var kanokari: Kanokari
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
    // キャラ紹介シナリオ（1〜5人目）
    let senarioList: [[String]] = [
        ["和也", "麻美", "瑠夏", "墨", "千鶴"],
        ["和也", "麻美", "瑠夏", "墨", "千鶴(コスプレ)"],
        ["和也", "麻美", "瑠夏", "墨(コスプレ)", "千鶴(コスプレ)"],
        ["和也", "麻美", "瑠夏(コスプレ)", "墨(コスプレ)", "千鶴(コスプレ)"],
        ["和也", "麻美(コスプレ)", "瑠夏(コスプレ)", "墨(コスプレ)", "千鶴(コスプレ)"],
        ["和也", "麻美(水着)", "瑠夏(水着)", "墨(水着)", "千鶴(水着)"],
        ["肺魚", "麻美", "瑠夏", "墨", "千鶴"],
        ["麻美", "肺魚", "瑠夏", "墨", "千鶴"],
        ["麻美", "瑠夏", "肺魚", "墨", "千鶴"],
        ["麻美", "瑠夏", "墨", "肺魚", "千鶴"],
        ["麻美", "瑠夏", "墨", "千鶴", "肺魚"],
        ["麻美", "麻美(水着)", "瑠夏", "墨", "千鶴"],
        ["麻美", "瑠夏", "瑠夏(水着)", "墨", "千鶴"],
        ["麻美", "瑠夏", "墨", "墨(水着)", "千鶴"],
        ["麻美", "瑠夏", "墨", "千鶴", "千鶴(水着)"],
    ]
    let senarioNumberList: [String] = ["①","②","③","④","⑤","⑥","⑦","⑧","⑨","⑩","⑪","⑫","⑬","⑭","⑮"]
    // 各シナリオの示唆（sisaList のインデックス）
    let senarioSisaIndex: [Int] = [0, 1, 2, 3, 4, 14, 5, 6, 7, 8, 9, 10, 11, 12, 13]
    let sisaList: [String] = [
        "デフォルト",
        "奇数示唆",
        "偶数示唆",
        "高設定示唆 弱",
        "高設定示唆 強",
        "設定1 否定",
        "設定2 否定",
        "設定3 否定",
        "設定4 否定",
        "設定5 否定",
        "設定2 以上濃厚",
        "設定3 以上濃厚",
        "設定4 以上濃厚",
        "設定5 以上濃厚",
        "設定6 濃厚",
    ]
    let sisaColorList: [Color] = [
        .gray, .blue, .yellow, .green, .red,
        .cyan, .teal, .indigo, .pink, .mint,
        .brown, .orange, .orange, .red, .purple,
    ]
    @State var selectedSenario: [String] = ["和也", "麻美", "瑠夏", "墨", "千鶴"]

    var body: some View {
        List {
            // ---- キャラ紹介シナリオ選択
            Section {
                // 1人目から順に選ぶと、残りの候補が絞り込まれる
                ForEach(0..<5, id: \.self) { position in
                    let options = self.options(position: position)
                    if options.count > 1 {
                        unitPickerMenuString(
                            title: "\(position + 1)人目",
                            selected: self.bindingPosition(position),
                            selectlist: options
                        )
                    } else {
                        HStack {
                            Text("\(position + 1)人目")
                            Spacer()
                            Text(self.selectedSenario[position])
                                .foregroundStyle(.secondary)
                        }
                    }
                }

                // //// 示唆＆登録ボタン
                let sisaIndex = self.selectedSisaIndex
                unitCountSubmitWithResult(
                    title: self.sisaList[sisaIndex],
                    count: bindingCount(sisaIndex: sisaIndex),
                    bigNumber: $kanokari.rbCharaCountSum,
                    flushColor: self.sisaColorList[sisaIndex],
                    minusCheck: $kanokari.minusCheck) {
                        kanokari.rbCharaSumFunc()
                    }
            } header: {
                Text("キャラ紹介シナリオ選択")
            }

            // ---- カウント結果
            Section {
                ForEach(self.sisaList.indices, id: \.self) { index in
                    unitResultCountListPercent(
                        title: self.sisaList[index],
                        count: bindingCount(sisaIndex: index),
                        flashColor: self.sisaColorList[index],
                        bigNumber: $kanokari.rbCharaCountSum
                    )
                }

                // 参考情報）シナリオごとの示唆
                unitLinkButtonViewBuilder(sheetTitle: "キャラ紹介シナリオでの示唆", detent: .large) {
                    senarioTable
                }

                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    kanokariViewBayes(
                        kanokari: kanokari,
                    )
                }
            } header: {
                Text("カウント結果")
            }

            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.kanokariMenuDuringRbBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: kanokari.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("RB中")
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
                unitButtonMinusCheck(minusCheck: $kanokari.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: kanokari.resetRbChara)
            }
        }
    }

    // //// 選択中のシナリオの示唆（sisaList のインデックス）
    private var selectedSisaIndex: Int {
        guard let index = self.senarioList.firstIndex(of: self.selectedSenario) else { return 0 }
        return self.senarioSisaIndex[index]
    }

    // //// position 人目の候補（それより前の人物が一致するシナリオから、重複なしで集める）
    private func options(position: Int) -> [String] {
        let prefix = Array(self.selectedSenario.prefix(position))
        var result: [String] = []
        for senario in self.senarioList where Array(senario.prefix(position)) == prefix {
            if !result.contains(senario[position]) {
                result.append(senario[position])
            }
        }
        return result
    }

    // //// position 人目を選び直したら、そこまでが一致する最初のシナリオに合わせる
    private func bindingPosition(_ position: Int) -> Binding<String> {
        Binding(
            get: { self.selectedSenario[position] },
            set: { newValue in
                let prefix = Array(self.selectedSenario.prefix(position)) + [newValue]
                if let senario = self.senarioList.first(where: { Array($0.prefix(position + 1)) == prefix }) {
                    self.selectedSenario = senario
                }
            }
        )
    }

    private func bindingCount(sisaIndex: Int) -> Binding<Int> {
        switch sisaIndex {
        case 0: return $kanokari.rbCharaCountDefault
        case 1: return $kanokari.rbCharaCountKisu
        case 2: return $kanokari.rbCharaCountGusu
        case 3: return $kanokari.rbCharaCountHighJaku
        case 4: return $kanokari.rbCharaCountHighKyo
        case 5: return $kanokari.rbCharaCountNegate1
        case 6: return $kanokari.rbCharaCountNegate2
        case 7: return $kanokari.rbCharaCountNegate3
        case 8: return $kanokari.rbCharaCountNegate4
        case 9: return $kanokari.rbCharaCountNegate5
        case 10: return $kanokari.rbCharaCountOver2
        case 11: return $kanokari.rbCharaCountOver3
        case 12: return $kanokari.rbCharaCountOver4
        case 13: return $kanokari.rbCharaCountOver5
        case 14: return $kanokari.rbCharaCountOver6
        default: return .constant(0)
        }
    }

    // //// 参考情報：シナリオ一覧
    private var senarioTable: some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(self.senarioList.indices, id: \.self) { index in
                HStack(alignment: .top) {
                    Text(self.senarioNumberList[index])
                        .frame(width: 30)
                    VStack(alignment: .leading, spacing: 2) {
                        Text(self.senarioList[index].joined(separator: " → "))
                            .font(.caption)
                        Text(self.sisaList[self.senarioSisaIndex[index]])
                            .font(.subheadline)
                            .fontWeight(.bold)
                    }
                }
            }
        }
    }
}

#Preview {
    kanokariViewDuringRb(
        kanokari: Kanokari(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
