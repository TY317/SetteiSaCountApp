//
//  urmiraViewShimaData.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/18.
//

import SwiftUI

struct urmiraViewShimaData: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var urmira: Urmira
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   //
    @State var isShowAlert = false
    @State private var shimaGames: [Int] = []
    @State private var shimaBigs: [Int] = []
    @State private var shimaRegs: [Int] = []
    @AppStorage("urmiraShimaGameJSON") var shimaGameJSON: String = "[0,0,0,0,0]"
    @AppStorage("urmiraShimaBigJSON") var shimaBigJSON: String = "[0,0,0,0,0]"
    @AppStorage("urmiraShimaRegJSON") var shimaRegJSON: String = "[0,0,0,0,0]"
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

    private func resetShimaData() {
        let zeros = Array(repeating: 0, count: common.shimaInitialColumn)
        self.shimaGames = zeros
        self.shimaBigs = zeros
        self.shimaRegs = zeros
        if let dataG = try? JSONEncoder().encode(zeros), let strG = String(data: dataG, encoding: .utf8) {
            self.shimaGameJSON = strG
        }
        if let dataB = try? JSONEncoder().encode(zeros), let strB = String(data: dataB, encoding: .utf8) {
            self.shimaBigJSON = strB
        }
        if let dataR = try? JSONEncoder().encode(zeros), let strR = String(data: dataR, encoding: .utf8) {
            self.shimaRegJSON = strR
        }
        UINotificationFeedbackGenerator().notificationOccurred(.warning)
    }

    // 入力フォーカスの識別子
    private enum FocusedField: Hashable {
        case game(Int)
        case big(Int)
        case reg(Int)
    }
    @FocusState private var focusedField: FocusedField?

    var body: some View {
        List {
            Section {
                // ヘッダー（列タイトル）
                HStack {
                    Text("台番")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Text("ゲーム数")
                        .frame(maxWidth: .infinity)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Text("BIG")
                        .frame(maxWidth: .infinity)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Text("REG")
                        .frame(maxWidth: .infinity)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                // 各行の入力
                ForEach(0..<shimaGames.count, id: \.self) { index in
                    HStack(spacing: 8) {
                        // 台番号表示
                        Text("\(index + 1)台目")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        // ゲーム数
                        if self.shimaGames.indices.contains(index) {
//                            urmira(
                            unitTextFieldShima(
                                placeholder: "G",
                                value: Binding(
                                    get: { String(shimaGames[index]) },
                                    set: { shimaGames[index] = Int($0) ?? 0 }
                                )
                            )
                            .focused($focusedField, equals: FocusedField.game(index))
                        }
                        // BIG
                        if self.shimaBigs.indices.contains(index) {
//                            urmira(
                            unitTextFieldShima(
                                placeholder: "B",
                                value: Binding(
                                    get: { String(shimaBigs[index]) },
                                    set: { shimaBigs[index] = Int($0) ?? 0 }
                                )
                            )
                            .focused($focusedField, equals: FocusedField.big(index))
                        }
                        if self.shimaRegs.indices.contains(index) {
                            // REG
//                            urmira(
                            unitTextFieldShima(
                                placeholder: "R",
                                value: Binding(
                                    get: { String(shimaRegs[index]) },
                                    set: { shimaRegs[index] = Int($0) ?? 0 }
                                )
                            )
                            .focused($focusedField, equals: FocusedField.reg(index))
                        }
                    }
                    .padding(.vertical, -4)
                }
                
                // 行追加ボタン
                Button(action: {
                    // 行を追加
                    self.shimaGames.append(0)
                    self.shimaBigs.append(0)
                    self.shimaRegs.append(0)
                    UINotificationFeedbackGenerator().notificationOccurred(.success)
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("行を追加")
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            } header: {
                Text("島データ入力")
            }
            
            Section {
                unitResultListCountNotBinding(
                    title: "総ゲーム数",
                    count: shimaGames.reduce(0, +),
                    unit: "Ｇ",
                )
                unitResultListCountNotBinding(
                    title: "総BIG数",
                    count: shimaBigs.reduce(0, +),
                )
                unitResultListCountNotBinding(
                    title: "総REG数",
                    count: shimaRegs.reduce(0, +),
                )
                HStack {
                    unitResultDenoNotBinding(
                        title: "BIG",
                        count: shimaBigs.reduce(0, +),
                        bigNumber: shimaGames.reduce(0, +),
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    unitResultDenoNotBinding(
                        title: "REG",
                        count: shimaRegs.reduce(0, +),
                        bigNumber: shimaGames.reduce(0, +),
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    unitResultDenoNotBinding(
                        title: "ボーナス合算",
                        count: (shimaBigs.reduce(0, +) + shimaRegs.reduce(0, +)),
                        bigNumber: shimaGames.reduce(0, +),
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "設定差情報",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "\(urmira.machineName)設定差",
                            tableView: AnyView(
                                urmiraTableRatio(urmira: urmira)
                            )
                        )
                    )
                )
                
                // 95%信頼区間グラフ
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        urmiraVer2View95CiShima(urmira: urmira)
                    )
                )
            } header: {
                Text("合計")
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.urmiraMenuShimaBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: urmira.machineName,
                screenClass: screenClass
            )
        }
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
        .navigationTitle("島データ入力")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Button(action: moveToPreviousField) {
                    Image(systemName: "chevron.left")
                }
                Button(action: moveToNextField) {
                    Image(systemName: "chevron.right")
                }
                Spacer()
                Button("完了") { focusedField = nil }
                    .fontWeight(.bold)
            }
            ToolbarItem(placement: .automatic) {
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: resetShimaData,
                )
            }
        }
        // appstorageのJSONを配列にして変数に入れとく
        .onAppear {
            self.shimaGames = decodeIntArrayFromString(stringData: self.shimaGameJSON)
            self.shimaBigs = decodeIntArrayFromString(stringData: self.shimaBigJSON)
            self.shimaRegs = decodeIntArrayFromString(stringData: self.shimaRegJSON)
            // 配列の長さを揃える（最低1行）
            let maxCount = max(self.shimaGames.count, self.shimaBigs.count, self.shimaRegs.count)
            if maxCount == 0 {
                self.shimaGames = [0]
                self.shimaBigs = [0]
                self.shimaRegs = [0]
            } else {
                if self.shimaGames.count < maxCount { self.shimaGames.append(contentsOf: Array(repeating: 0, count: maxCount - self.shimaGames.count)) }
                if self.shimaBigs.count < maxCount { self.shimaBigs.append(contentsOf: Array(repeating: 0, count: maxCount - self.shimaBigs.count)) }
                if self.shimaRegs.count < maxCount { self.shimaRegs.append(contentsOf: Array(repeating: 0, count: maxCount - self.shimaRegs.count)) }
            }
        }
        // //// 値が変更されるたびにAppstorageの値を更新して保存
        .onChange(of: self.shimaGames) { oldValue, newValue in
            if let data = try? JSONEncoder().encode(newValue),
               let str = String(data: data, encoding: .utf8) {
                self.shimaGameJSON = str
                urmira.shimaGames = shimaGames.reduce(0, +)
            }
        }
        .onChange(of: self.shimaBigs) { oldValue, newValue in
            if let data = try? JSONEncoder().encode(newValue),
               let str = String(data: data, encoding: .utf8) {
                self.shimaBigJSON = str
                urmira.shimaBigs = shimaBigs.reduce(0, +)
                urmira.shimaBonusSum = urmira.shimaBigs + urmira.shimaRegs
            }
        }
        .onChange(of: self.shimaRegs) { oldValue, newValue in
            if let data = try? JSONEncoder().encode(newValue),
               let str = String(data: data, encoding: .utf8) {
                self.shimaRegJSON = str
                urmira.shimaRegs = shimaRegs.reduce(0, +)
                urmira.shimaBonusSum = urmira.shimaBigs + urmira.shimaRegs
            }
        }
    }
    
    private func moveToNextField() {
        guard let current = focusedField else { return }
        switch current {
        case .game(let i):
            focusedField = .big(i)
        case .big(let i):
            focusedField = .reg(i)
        case .reg(let i):
            let nextRow = i + 1
            if nextRow < shimaGames.count {
                focusedField = .game(nextRow)
            } else {
                // 最終行のREGの次は何もしない（必要なら新規行追加などに変更可能）
                focusedField = nil
            }
        }
    }

    private func moveToPreviousField() {
        guard let current = focusedField else { return }
        switch current {
        case .game(let i):
            let prevRow = i - 1
            if prevRow >= 0 {
                focusedField = .reg(prevRow)
            } else {
                // 先頭行のGの前は何もしない
                focusedField = nil
            }
        case .big(let i):
            focusedField = .game(i)
        case .reg(let i):
            focusedField = .big(i)
        }
    }
}

#Preview {
    urmiraViewShimaData(
        urmira: Urmira(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
