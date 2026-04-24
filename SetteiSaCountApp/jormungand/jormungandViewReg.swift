//
//  jormungandViewReg.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/11.
//

import SwiftUI

struct jormungandViewReg: View {
    @ObservedObject var jormungand: Jormungand
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    
    @State var isShowAlert: Bool = false
    
//    let senarioList: [[String]] = [
//        ["ココ・ヘクマティアル","ヨナ","ルツ","レーム","バルメ"],
//        ["トージョ","ワイリ","ウゴ","マオ","アール"],
//        ["チェキータ","陳国明","カレン・ロウ","-","-"],
//        ["天田南","ブックマン","ヘックス","-","-"],
//        ["キャスパー・ヘクマティアル","エコー","Dr.マイアミ 他","-","-"],
//        ["ココ・ヘクマティアル(幼少期)","-","-","-","-"],
//    ]
    let senarioList: [[String]] = [
        ["ココ・ヘクマティアル","ルツ","バルメ"],
        ["ヨナ","レーム","バルメ"],
        ["トージョ","ウゴ","アール"],
        ["ワイリ","マオ","アール"],
        ["チェキータ","陳国明","カレン・ロウ"],
    ]
//    @State var selectedSenario: [String] = ["ココ・ヘクマティアル","ヨナ","ルツ","レーム","バルメ"]
    @State var selectedSenario: [String] = ["ココ・ヘクマティアル","ルツ","バルメ"]
    let sisaList: [String] = [
        "奇数示唆",
        "偶数示唆",
        "高設定示唆",
        "設定2 以上濃厚",
        "設定4 以上濃厚",
        "設定6 濃厚",
    ]
    let indexList: [Int] = [0,1,2,]
    let indexList3: [Int] = [0,1,2,3,4,5]
    let thirdList: [String] = [
        "バルメ",
        "アール",
        "カレン・ロウ",
        "天田南",
        "ブックマン",
        "ヘックス",
        "キャスパー・ヘクマティアル",
        "エコー",
        "Dr.マイアミ 他",
        "ココ・ヘクマティアル(幼少期)",
    ]
    @State var flushBool: Bool = false
    @State var flushBool3: Bool = false
    let colorList12: [Color] = [.blue, .yellow, .green]
    let colorList3: [Color] = [.blue, .yellow, .green, .brown, .orange, .purple]
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
    
    var body: some View {
        List {
            // ---- キャラ選択
            Section {
                // ---------
                // ---- 1人目
                // ---------
                let firstList = [
                    self.senarioList[0][0],
                    self.senarioList[1][0],
                    self.senarioList[2][0],
                    self.senarioList[3][0],
                    self.senarioList[4][0],
                ]
                unitPickerMenuString(
                    title: "1人目",
                    selected: self.$selectedSenario[0],
                    selectlist: firstList
                )
                .onChange(of: self.selectedSenario[0]) { oldValue, newValue in
                    // ココ
                    if newValue == firstList[0] {
                        self.selectedSenario = self.senarioList[0]
                    }
                    // ヨナ
                    else if newValue == firstList[1] {
                        self.selectedSenario = self.senarioList[1]
                    }
                    // トージョ
                    else if newValue == firstList[2] {
                        self.selectedSenario = self.senarioList[2]
                    }
                    // ワイリ
                    else if newValue == firstList[3] {
                        self.selectedSenario = self.senarioList[3]
                    }
                    // チェキータ
                    else {
                        self.selectedSenario = self.senarioList[4]
                    }
                }
                
                // -------
                // 2人目
                // -------
                if self.selectedSenario[0] == self.senarioList[4][0] {
                    HStack {
                        Text("2人目")
                        Spacer()
                        Text(self.selectedSenario[1])
                            .foregroundStyle(.secondary)
                    }
                }
                else {
                    unitPickerMenuString(
                        title: "2人目",
                        selected: self.$selectedSenario[1],
                        selectlist: secondList(first: self.selectedSenario[0])
                    )
                }
                
                // -------
                // 3人目
                // -------
                unitPickerMenuString(
                    title: "3人目",
                    selected: self.$selectedSenario[2],
                    selectlist: self.thirdList
                    
                )
                
                // 1,2人目示唆
                unitResultListPercentBoolFlush(
                    title: sisaText12(first: self.selectedSenario[0]),
                    count: binding12(first: self.selectedSenario[0]),
                    bigNumber: $jormungand.charaCountSum,
                    flushTrigger: self.$flushBool,
                    flushColor: color12(first: self.selectedSenario[0])
                )
                // 3人目示唆
                unitResultListPercentBoolFlush(
                    title: sisaText3(third: self.selectedSenario[2]),
                    count: binding3(third: self.selectedSenario[2]),
                    bigNumber: $jormungand.chara3CountSum,
                    flushTrigger: self.$flushBool3,
                    flushColor: color3(third: self.selectedSenario[2])
                )
                
                Button {
                    // ---- 1,2人目
                    if jormungand.minusCheck {
                        if int12(first: self.selectedSenario[0]) > 0 {
                            self.flushBool.toggle()
                        }
                    }
                    if self.selectedSenario[0] == self.senarioList[0][0] ||
                        self.selectedSenario[0] == self.senarioList[1][0] {
                        jormungand.charaCountKisu = countUpDown(
                            minusCheck: jormungand.minusCheck,
                            count: jormungand.charaCountKisu
                        )
                    }
                    else if self.selectedSenario[0] == self.senarioList[4][0] {
                        jormungand.charaCountHigh = countUpDown(
                            minusCheck: jormungand.minusCheck,
                            count: jormungand.charaCountHigh
                        )
                    }
                    else {
                        jormungand.charaCountGusu = countUpDown(
                            minusCheck: jormungand.minusCheck,
                            count: jormungand.charaCountGusu
                        )
                    }
                    if jormungand.minusCheck == false {
                        if int12(first: self.selectedSenario[0]) > 0 {
                            self.flushBool.toggle()
                        }
                    }
                    
                    // ---- 3人目
                    if jormungand.minusCheck {
                        if int3(third: self.selectedSenario[2]) > 0 {
                            self.flushBool3.toggle()
                        }
                    }
                    if self.selectedSenario[2] == self.thirdList[0] {
                        jormungand.chara3CountKisu = countUpDown(
                            minusCheck: jormungand.minusCheck,
                            count: jormungand.chara3CountKisu
                        )
                    }
                    else if self.selectedSenario[2] == self.thirdList[1] {
                        jormungand.chara3CountGusu = countUpDown(
                            minusCheck: jormungand.minusCheck,
                            count: jormungand.chara3CountGusu
                        )
                    }
                    else if self.selectedSenario[2] == self.thirdList[2] {
                        jormungand.chara3CountHigh = countUpDown(
                            minusCheck: jormungand.minusCheck,
                            count: jormungand.chara3CountHigh
                        )
                    }
                    else if self.selectedSenario[2] == self.thirdList[6] ||
                                self.selectedSenario[2] == self.thirdList[7] ||
                                self.selectedSenario[2] == self.thirdList[8] {
                        jormungand.chara3CountOver4 = countUpDown(
                            minusCheck: jormungand.minusCheck,
                            count: jormungand.chara3CountOver4
                        )
                    }
                    else if self.selectedSenario[2] == self.thirdList[9] {
                        jormungand.chara3CountOver6 = countUpDown(
                            minusCheck: jormungand.minusCheck,
                            count: jormungand.chara3CountOver6
                        )
                    }
                    else {
                        jormungand.chara3CountOver2 = countUpDown(
                            minusCheck: jormungand.minusCheck,
                            count: jormungand.chara3CountOver2
                        )
                    }
                    if jormungand.minusCheck == false {
                        if int3(third: self.selectedSenario[2]) > 0 {
                            self.flushBool3.toggle()
                        }
                    }
                    
                    // 共通
                    jormungand.charaSumFunc()
                } label: {
                    HStack {
                        Spacer()
                        if jormungand.minusCheck == false {
                            Text("登録")
                                .fontWeight(.bold)
                                .foregroundStyle(Color.blue)
                        } else {
                            Text("マイナス")
                                .fontWeight(.bold)
                                .foregroundStyle(Color.red)
                        }
                        Spacer()
                    }
                }
                
            } header: {
                Text("キャラ選択")
            }
            
            // ---- カウント結果
            Section {
                ForEach(self.indexList, id: \.self) { index in
                    unitResultCountListPercent(
                        title: self.sisaList[index],
                        count: resultBinding12(index: index),
                        flashColor: colorList12[index],
                        bigNumber: $jormungand.charaCountSum
                    )
                }
                
                // 参考情報）キャラ振分け
                unitLinkButtonViewBuilder(
                    sheetTitle: "1,2人目 振分け") {
                        jormungandTableChara12(jormungand: jormungand)
                    }
            } header: {
                Text("1,2人目 カウント結果")
            }
            
            // 3人目カウント結果
            Section {
                ForEach(self.indexList3, id: \.self) { index in
                    unitResultCountListPercent(
                        title: self.sisaList[index],
                        count: resultBinding3(index: index),
                        flashColor: colorList3[index],
                        bigNumber: $jormungand.chara3CountSum
                    )
                }
                
                // 参考情報）キャラ振分け
                unitLinkButtonViewBuilder(sheetTitle: "3人目 振分け") {
                    jormungandTableChara3(jormungand: jormungand)
                }
            } header: {
                Text("3人目 カウント結果")
            }
            
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.jormungandMenuRegBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: jormungand.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("REG")
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
                unitButtonMinusCheck(minusCheck: $jormungand.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: jormungand.resetReg)
            }
        }
    }
    private func sisaText(senario: [String]) -> String {
        switch senario {
        case self.senarioList[0]: return self.sisaList[0]
        case self.senarioList[1]: return self.sisaList[1]
        case self.senarioList[2]: return self.sisaList[2]
        case self.senarioList[3]: return self.sisaList[3]
        case self.senarioList[4]: return self.sisaList[4]
        case self.senarioList[5]: return self.sisaList[5]
        default: return "???"
        }
    }
    
    private func bindingForCount(senario: [String]) -> Binding<Int> {
        switch senario {
        case self.senarioList[0]: return jormungand.$charaCountKisu
        case self.senarioList[1]: return jormungand.$charaCountGusu
        case self.senarioList[2]: return jormungand.$charaCountHigh
        case self.senarioList[3]: return jormungand.$charaCountOver2
        case self.senarioList[4]: return jormungand.$charaCountOver4
        case self.senarioList[5]: return jormungand.$charaCountOver6
        default: return .constant(0)
        }
    }
    
    private func flushColor(senario: [String]) -> Color {
        switch senario {
        case self.senarioList[0]: return .blue
        case self.senarioList[1]: return .yellow
        case self.senarioList[2]: return .green
        case self.senarioList[3]: return .brown
        case self.senarioList[4]: return .orange
        case self.senarioList[5]: return .purple
        default: return .clear
        }
    }
    
    private func secondList(first: String) -> [String] {
        switch first {
        case self.senarioList[2][0]: return ["ウゴ","マオ"]
        case self.senarioList[3][0]: return ["ウゴ","マオ"]
        default: return ["ルツ","レーム",]
        }
    }
    
    private func sisaText12(first: String) -> String {
        switch first {
        case self.senarioList[2][0]: return self.sisaList[1]
        case self.senarioList[3][0]: return self.sisaList[1]
        case self.senarioList[4][0]: return self.sisaList[2]
        default: return self.sisaList[0]
        }
    }
    
    private func binding12(first: String) -> Binding<Int> {
        switch first {
        case self.senarioList[0][0]: return jormungand.$charaCountKisu
        case self.senarioList[1][0]: return jormungand.$charaCountKisu
        case self.senarioList[2][0]: return jormungand.$charaCountGusu
        case self.senarioList[3][0]: return jormungand.$charaCountGusu
        case self.senarioList[4][0]: return jormungand.$charaCountHigh
        default: return .constant(0)
        }
    }
    
    private func color12(first: String) -> Color {
        switch first {
        case self.senarioList[2][0]: return .yellow
        case self.senarioList[3][0]: return .yellow
        case self.senarioList[4][0]: return .green
        default: return .blue
        }
    }
    
    private func int12(first: String) -> Int {
        switch first {
        case self.senarioList[2][0]: return jormungand.charaCountGusu
        case self.senarioList[3][0]: return jormungand.charaCountGusu
        case self.senarioList[4][0]: return jormungand.charaCountHigh
        default: return jormungand.charaCountKisu
        }
    }
    
    private func resultBinding12(index: Int) -> Binding<Int> {
        switch index {
        case self.indexList[0]: return jormungand.$charaCountKisu
        case self.indexList[1]: return jormungand.$charaCountGusu
        case self.indexList[2]: return jormungand.$charaCountHigh
        default: return .constant(0)
        }
    }
    
    private func sisaText3(third: String) -> String {
        switch third {
        case self.thirdList[0]: return self.sisaList[0]
        case self.thirdList[1]: return self.sisaList[1]
        case self.thirdList[2]: return self.sisaList[2]
        case self.thirdList[6]: return self.sisaList[4]
        case self.thirdList[7]: return self.sisaList[4]
        case self.thirdList[8]: return self.sisaList[4]
        case self.thirdList[9]: return self.sisaList[5]
        default: return self.sisaList[3]
        }
    }
    
    private func binding3(third: String) -> Binding<Int> {
        switch third {
        case self.thirdList[0]: return $jormungand.chara3CountKisu
        case self.thirdList[1]: return $jormungand.chara3CountGusu
        case self.thirdList[2]: return $jormungand.chara3CountHigh
        case self.thirdList[3]: return $jormungand.chara3CountOver2
        case self.thirdList[4]: return $jormungand.chara3CountOver2
        case self.thirdList[5]: return $jormungand.chara3CountOver2
        case self.thirdList[6]: return $jormungand.chara3CountOver4
        case self.thirdList[7]: return $jormungand.chara3CountOver4
        case self.thirdList[8]: return $jormungand.chara3CountOver4
        case self.thirdList[9]: return $jormungand.chara3CountOver6
        default: return .constant(0)
        }
    }
    
    private func color3(third: String) -> Color {
        switch third {
        case self.thirdList[0]: return .blue
        case self.thirdList[1]: return .yellow
        case self.thirdList[2]: return .green
        case self.thirdList[6]: return .orange
        case self.thirdList[7]: return .orange
        case self.thirdList[8]: return .orange
        case self.thirdList[9]: return .purple
        default: return .brown
        }
    }
    
    private func int3(third: String) -> Int {
        switch third {
        case self.thirdList[0]: return jormungand.chara3CountKisu
        case self.thirdList[1]: return jormungand.chara3CountGusu
        case self.thirdList[2]: return jormungand.chara3CountHigh
        case self.thirdList[3]: return jormungand.chara3CountOver2
        case self.thirdList[4]: return jormungand.chara3CountOver2
        case self.thirdList[5]: return jormungand.chara3CountOver2
        case self.thirdList[6]: return jormungand.chara3CountOver4
        case self.thirdList[7]: return jormungand.chara3CountOver4
        case self.thirdList[8]: return jormungand.chara3CountOver4
        case self.thirdList[9]: return jormungand.chara3CountOver6
        default: return jormungand.chara3CountKisu
        }
    }
    
    private func resultBinding3(index: Int) -> Binding<Int> {
        switch index {
        case self.indexList3[0]: return jormungand.$chara3CountKisu
        case self.indexList3[1]: return jormungand.$chara3CountGusu
        case self.indexList3[2]: return jormungand.$chara3CountHigh
        case self.indexList3[3]: return jormungand.$chara3CountOver2
        case self.indexList3[4]: return jormungand.$chara3CountOver4
        case self.indexList3[5]: return jormungand.$chara3CountOver6
        default: return .constant(0)
        }
    }
}

#Preview {
    jormungandViewReg(
        jormungand: Jormungand(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
