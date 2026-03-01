//
//  enen2ViewReg.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/02.
//

import SwiftUI

struct enen2ViewReg: View {
    @ObservedObject var enen2: Enen2
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    
    @State var isShowAlert: Bool = false
    
    let senarioList: [[String]] = [
        ["森羅日下部","アーサー・ボイル","環古達","茉希尾瀬","武久火縄"],
        ["森羅日下部","ヴィクトル・リヒト","ヴァルカン・ジョセフ","アイリス","秋樽桜備"],
        ["森羅日下部","アーサー・ボイル","環古達","茉希尾瀬","新門紅丸"],
        ["森羅日下部","ヴィクトル・リヒト","ヴァルカン・ジョセフ","アイリス","森羅日下部(金)"],
        ["Dr.ジョヴァンニ","カロン","ハウメア","フレイル","因果春日谷"],
        ["Dr.ジョヴァンニ","カロン","ハウメア","フレイル","オロチ"],
        ["Dr.ジョヴァンニ","カロン","ハウメア","フレイル","リツ"],
        ["Dr.ジョヴァンニ","カロン","ハウメア","フレイル","象日下部"],
        ["まもるくん","秋樽桜備","因果春日谷","蒼一郎アーグ","レオナルド・バーンズ"],
        ["アイリス","まもるくん","因果春日谷","蒼一郎アーグ","レオナルド・バーンズ"],
        ["アイリス","秋樽桜備","まもるくん","蒼一郎アーグ","レオナルド・バーンズ"],
        ["アイリス","秋樽桜備","因果春日谷","まもるくん","レオナルド・バーンズ"],
        ["アイリス","秋樽桜備","因果春日谷","蒼一郎アーグ","まもるくん"],
        ["アイリス","秋樽桜備","因果春日谷","蒼一郎アーグ","レオナルド・バーンズ"],
        ["Dr.ジョヴァンニ","秋樽桜備","蒼一郎アーグ","レオナルド・バーンズ","新門紅丸"],
    ]
    @State var selectedSenario: [String] = ["森羅日下部","アーサー・ボイル","環古達","茉希尾瀬","武久火縄"]
    let sisaList: [String] = [
        "デフォルト",
        "偶数示唆",
        "設定4 以上濃厚",
        "設定6 濃厚",
        "奇数示唆",
        "高設定示唆 弱",
        "高設定示唆 強",
        "設定5 以上濃厚",
        "設定1 否定",
        "設定2 否定",
        "設定3 否定",
        "設定4 否定",
        "設定5 否定",
    ]
    let indexList: [Int] = [0,4,1,5,6,8,9,10,11,12,2,7,3]
    
    let specialSenarioList: [String] = [
        "5人目 森羅日下部",
        "黒野出現",
        "ジョーカー出現",
        "シンラ(死ノ圧)出現",
    ]
    @State var selectedSpecial: String = "5人目 森羅日下部"
    
    let itemList: [String] = ["通常シナリオ", "特殊シナリオ"]
    @State var selectedItem: String = "通常シナリオ"
    
    var body: some View {
        List {
            // ---- キャラ選択
            Section {
                // セグメントピッカー
                Picker("", selection: self.$selectedItem) {
                    ForEach(self.itemList, id: \.self) { item in
                        Text(item)
                    }
                }
                .pickerStyle(.segmented)
                .popoverTip(tipVer3210Enen2Chara())
                
                // ---- 通常パターン
                if self.selectedItem == self.itemList[0] {
                    // ---------
                    // ---- 1人目
                    // ---------
                    let firstList = [
                        self.senarioList[0][0],
                        self.senarioList[4][0],
                        self.senarioList[8][0],
                        self.senarioList[9][0],
                    ]
                    unitPickerMenuString(
                        title: "1人目",
                        selected: self.$selectedSenario[0],
                        selectlist: firstList
                    )
                    .onChange(of: self.selectedSenario[0]) { oldValue, newValue in
                        // 森羅スタート
                        if newValue == firstList[0] {
                            self.selectedSenario = self.senarioList[0]
                        }
                        // ジョヴァンニスタート
                        else if newValue == firstList[1] {
                            self.selectedSenario = self.senarioList[4]
                        }
                        // まもるくんスタート
                        else if newValue == firstList[2] {
                            self.selectedSenario = self.senarioList[8]
                        }
                        // アイリススタート
                        else {
                            self.selectedSenario = self.senarioList[9]
                        }
                    }
                    
                    // ------
                    // 森羅スタート
                    // ------
                    if self.selectedSenario[0] == firstList[0] {
                        // 2人目
                        let secondList: [String] = [
                            self.senarioList[0][1],
                            self.senarioList[1][1],
                        ]
                        unitPickerMenuString(
                            title: "2人目",
                            selected: self.$selectedSenario[1],
                            selectlist: secondList
                        )
                        .onChange(of: self.selectedSenario[1]) { oldValue, newValue in
                            // リヒト
                            if newValue == secondList[1] {
                                self.selectedSenario = self.senarioList[1]
                            }
                            // アーサー
                            else {
                                self.selectedSenario = self.senarioList[0]
                            }
                        }
                        
                        // ---- アーサールート
                        if self.selectedSenario[1] == secondList[0] {
                            // 3人目
                            HStack {
                                Text("3人目")
                                Spacer()
                                Text(self.selectedSenario[2])
                                    .foregroundStyle(.secondary)
                            }
                            // 4人目
                            HStack {
                                Text("4人目")
                                Spacer()
                                Text(self.selectedSenario[3])
                                    .foregroundStyle(.secondary)
                            }
                            // 5人目
                            let fifthList: [String] = [
                                self.senarioList[0][4],
                                self.senarioList[2][4],
                            ]
                            unitPickerMenuString(
                                title: "5人目",
                                selected: self.$selectedSenario[4],
                                selectlist: fifthList
                            )
                        }
                        
                        // ---- リヒトルート
                        else {
                            // 3人目
                            HStack {
                                Text("3人目")
                                Spacer()
                                Text(self.selectedSenario[2])
                                    .foregroundStyle(.secondary)
                            }
                            // 4人目
                            HStack {
                                Text("4人目")
                                Spacer()
                                Text(self.selectedSenario[3])
                                    .foregroundStyle(.secondary)
                            }
                            // 5人目
                            let fifthList: [String] = [
                                self.senarioList[1][4],
                                self.senarioList[3][4],
                            ]
                            unitPickerMenuString(
                                title: "5人目",
                                selected: self.$selectedSenario[4],
                                selectlist: fifthList
                            )
                        }
                    }
                    
                    // -------
                    // ジョヴァンニスタート
                    // -------
                    else if self.selectedSenario[0] == firstList[1] {
                        // 2人目
                        let secondList: [String] = [
                            self.senarioList[4][1],
                            self.senarioList[14][1],
                        ]
                        unitPickerMenuString(
                            title: "2人目",
                            selected: self.$selectedSenario[1],
                            selectlist: secondList
                        )
                        .onChange(of: self.selectedSenario[1]) { oldValue, newValue in
                            // オウビルート
                            if newValue == secondList[1] {
                                self.selectedSenario = self.senarioList[14]
                            }
                            // カロンルート
                            else {
                                self.selectedSenario = self.senarioList[4]
                            }
                        }
                        
                        // ---- カロンルート
                        if self.selectedSenario[1] == secondList[0] {
                            // 3人目
                            HStack {
                                Text("3人目")
                                Spacer()
                                Text(self.selectedSenario[2])
                                    .foregroundStyle(.secondary)
                            }
                            // 4人目
                            HStack {
                                Text("4人目")
                                Spacer()
                                Text(self.selectedSenario[3])
                                    .foregroundStyle(.secondary)
                            }
                            // 5人目
                            let fifthList: [String] = [
                                self.senarioList[4][4],
                                self.senarioList[5][4],
                                self.senarioList[6][4],
                                self.senarioList[7][4],
                            ]
                            unitPickerMenuString(
                                title: "5人目",
                                selected: self.$selectedSenario[4],
                                selectlist: fifthList
                            )
                        }
                        
                        // オウビルート
                        else {
                            // 3人目
                            HStack {
                                Text("3人目")
                                Spacer()
                                Text(self.selectedSenario[2])
                                    .foregroundStyle(.secondary)
                            }
                            // 4人目
                            HStack {
                                Text("4人目")
                                Spacer()
                                Text(self.selectedSenario[3])
                                    .foregroundStyle(.secondary)
                            }
                            // 5人目
                            HStack {
                                Text("5人目")
                                Spacer()
                                Text(self.selectedSenario[4])
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    
                    // ------
                    // まもるくんスタート
                    // ------
                    else if self.selectedSenario[0] == firstList[2] {
                        // 2人目
                        HStack {
                            Text("2人目")
                            Spacer()
                            Text(self.selectedSenario[1])
                                .foregroundStyle(.secondary)
                        }
                        // 3人目
                        HStack {
                            Text("3人目")
                            Spacer()
                            Text(self.selectedSenario[2])
                                .foregroundStyle(.secondary)
                        }
                        // 4人目
                        HStack {
                            Text("4人目")
                            Spacer()
                            Text(self.selectedSenario[3])
                                .foregroundStyle(.secondary)
                        }
                        // 5人目
                        HStack {
                            Text("5人目")
                            Spacer()
                            Text(self.selectedSenario[4])
                                .foregroundStyle(.secondary)
                        }
                    }
                    
                    // -----
                    // アイリススタート
                    // -----
                    else {
                        // 2人目
                        let secondList: [String] = [
                            self.senarioList[9][1],
                            self.senarioList[10][1],
                        ]
                        unitPickerMenuString(
                            title: "2人目",
                            selected: self.$selectedSenario[1],
                            selectlist: secondList
                        )
                        .onChange(of: self.selectedSenario[1]) { oldValue, newValue in
                            // オウビルート
                            if newValue == secondList[1] {
                                self.selectedSenario = self.senarioList[10]
                            }
                            // まもるくんルート
                            else {
                                self.selectedSenario = self.senarioList[9]
                            }
                        }
                        
                        // ---- 2人目まもるくんルート
                        if self.selectedSenario[1] == secondList[0] {
                            // 3人目
                            HStack {
                                Text("3人目")
                                Spacer()
                                Text(self.selectedSenario[2])
                                    .foregroundStyle(.secondary)
                            }
                            // 4人目
                            HStack {
                                Text("4人目")
                                Spacer()
                                Text(self.selectedSenario[3])
                                    .foregroundStyle(.secondary)
                            }
                            // 5人目
                            HStack {
                                Text("5人目")
                                Spacer()
                                Text(self.selectedSenario[4])
                                    .foregroundStyle(.secondary)
                            }
                        }
                        
                        // ---- 2人目オウビルート
                        else {
                            // 3人目
                            let thirdList: [String] = [
                                self.senarioList[10][2],
                                self.senarioList[11][2],
                            ]
                            unitPickerMenuString(
                                title: "3人目",
                                selected: self.$selectedSenario[2],
                                selectlist: thirdList
                            )
                            .onChange(of: self.selectedSenario[2]) { oldValue, newValue in
                                // いんかルート
                                if newValue == thirdList[1] {
                                    self.selectedSenario = self.senarioList[11]
                                }
                                // まもるくんルート
                                else {
                                    self.selectedSenario = self.senarioList[10]
                                }
                            }
                            
                            // ---- 3人目まもるくんルート
                            if self.selectedSenario[2] == thirdList[0] {
                                // 4人目
                                HStack {
                                    Text("4人目")
                                    Spacer()
                                    Text(self.selectedSenario[3])
                                        .foregroundStyle(.secondary)
                                }
                                // 5人目
                                HStack {
                                    Text("5人目")
                                    Spacer()
                                    Text(self.selectedSenario[4])
                                        .foregroundStyle(.secondary)
                                }
                            }
                            // ---- 3人目インカルート
                            else {
                                // 4人目
                                let forthList: [String] = [
                                    self.senarioList[11][3],
                                    self.senarioList[12][3],
                                ]
                                unitPickerMenuString(
                                    title: "4人目",
                                    selected: self.$selectedSenario[3],
                                    selectlist: forthList
                                )
                                .onChange(of: self.selectedSenario[3]) { oldValue, newValue in
                                    // あーぐルート
                                    if newValue == forthList[1] {
                                        self.selectedSenario = self.senarioList[12]
                                    }
                                    // まもるくんルート
                                    else {
                                        self.selectedSenario = self.senarioList[11]
                                    }
                                }
                                
                                // ---- 4人目まもるくんルート
                                if self.selectedSenario[3] == forthList[0] {
                                    // 5人目
                                    HStack {
                                        Text("5人目")
                                        Spacer()
                                        Text(self.selectedSenario[4])
                                            .foregroundStyle(.secondary)
                                    }
                                }
                                
                                // ---- 4人目アーグルート
                                else {
                                    // 5人目
                                    let fifthList: [String] = [
                                        self.senarioList[12][4],
                                        self.senarioList[13][4],
                                    ]
                                    unitPickerMenuString(
                                        title: "5人目",
                                        selected: self.$selectedSenario[4],
                                        selectlist: fifthList
                                    )
                                }
                            }
                        }
                    }
                    
                    // //// 示唆＆登録ボタン
                    unitCountSubmitWithResult(
                        title: sisaText(senario: self.selectedSenario),
                        count: bindingForCount(senario: self.selectedSenario),
                        bigNumber: $enen2.charaCountSum,
                        flushColor: flushColor(senario: self.selectedSenario),
                        minusCheck: $enen2.minusCheck) {
                            enen2.charaSumFunc()
                        }
                }
                
                // -----
                // 特殊パターン
                // -----
                else {
                    // 注意書き
                    unitLabelCautionText {
                        Text("通常シナリオにない選択肢が出た場合はこちら")
                    }
                    // シナリオ選択
                    unitPickerMenuString(
                        title: "シナリオ",
                        selected: self.$selectedSpecial,
                        selectlist: self.specialSenarioList
                    )
                    
                    // 5人目しんら
                    if self.selectedSpecial == self.specialSenarioList[0] {
                        // 説明
                        Text("4人目までがシンラ→リヒト→ヴァルカン→アイリス以外のパターンで5人目に森羅日下部(金)出現")
                            .foregroundStyle(Color.secondary)
                            .font(.caption)
                        // カウントボタン
                        unitCountSubmitWithResult(
                            title: self.sisaList[7],
                            count: $enen2.charaCountOver5,
                            bigNumber: $enen2.charaCountSum,
                            flushColor: .red,
                            minusCheck: $enen2.minusCheck) {
                                enen2.charaSumFunc()
                            }
                    }
                    // 黒野
                    else if self.selectedSpecial == self.specialSenarioList[1] {
                        // 説明
                        Text("順番不問で優一郎黒野が出現")
                            .foregroundStyle(Color.secondary)
                            .font(.caption)
                        // カウントボタン
                        unitCountSubmitWithResult(
                            title: self.sisaList[2],
                            count: $enen2.charaCountOver4,
                            bigNumber: $enen2.charaCountSum,
                            flushColor: .orange,
                            minusCheck: $enen2.minusCheck) {
                                enen2.charaSumFunc()
                            }
                    }
                    // ジョーカー
                    else if self.selectedSpecial == self.specialSenarioList[2] {
                        // 説明
                        Text("順番不問でジョーカーが出現")
                            .foregroundStyle(Color.secondary)
                            .font(.caption)
                        // カウントボタン
                        unitCountSubmitWithResult(
                            title: self.sisaList[7],
                            count: $enen2.charaCountOver5,
                            bigNumber: $enen2.charaCountSum,
                            flushColor: .red,
                            minusCheck: $enen2.minusCheck) {
                                enen2.charaSumFunc()
                            }
                    }
                    // しんら氏のあつ
                    else {
                        // 説明
                        Text("順番不問でシンラ(死ノ圧)が出現")
                            .foregroundStyle(Color.secondary)
                            .font(.caption)
                        // カウントボタン
                        unitCountSubmitWithResult(
                            title: self.sisaList[3],
                            count: $enen2.charaCountOver6,
                            bigNumber: $enen2.charaCountSum,
                            flushColor: .purple,
                            minusCheck: $enen2.minusCheck) {
                                enen2.charaSumFunc()
                            }
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
                        count: bindingResult(index: index),
                        flashColor: flushColorResult(index: index),
                        bigNumber: $enen2.charaCountSum
                    )
                }
                unitLinkButtonViewBuilder(sheetTitle: "キャラ紹介シナリオでの示唆", detent: .large) {
                    enen2TableRegSenario()
                }
            } header: {
                Text("カウント結果")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.enen2MenuRegBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: enen2.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("REG")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $enen2.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: enen2.resetReg)
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
        case self.senarioList[6]: return self.sisaList[6]
        case self.senarioList[7]: return self.sisaList[7]
        case self.senarioList[8]: return self.sisaList[8]
        case self.senarioList[9]: return self.sisaList[9]
        case self.senarioList[10]: return self.sisaList[10]
        case self.senarioList[11]: return self.sisaList[11]
        case self.senarioList[12]: return self.sisaList[12]
        case self.senarioList[13]: return self.sisaList[3]
        case self.senarioList[14]: return self.sisaList[2]
        default: return "???"
        }
    }
    
    private func bindingForCount(senario: [String]) -> Binding<Int> {
        switch senario {
        case self.senarioList[0]: return enen2.$charaCountDefault
        case self.senarioList[1]: return enen2.$charaCountGusu
        case self.senarioList[2]: return enen2.$charaCountOver4
        case self.senarioList[3]: return enen2.$charaCountOver6
        case self.senarioList[4]: return enen2.$charaCountKisu
        case self.senarioList[5]: return enen2.$charaCountHighJaku
        case self.senarioList[6]: return enen2.$charaCountHighKyo
        case self.senarioList[7]: return enen2.$charaCountOver5
        case self.senarioList[8]: return enen2.$charaCountNegate1
        case self.senarioList[9]: return enen2.$charaCountNegate2
        case self.senarioList[10]: return enen2.$charaCountNegate3
        case self.senarioList[11]: return enen2.$charaCountNegate4
        case self.senarioList[12]: return enen2.$charaCountNegate5
        case self.senarioList[13]: return enen2.$charaCountOver6
        case self.senarioList[14]: return enen2.$charaCountOver4
        default: return .constant(0)
        }
    }
    
    private func flushColor(senario: [String]) -> Color {
        switch senario {
        case self.senarioList[0]: return .gray
        case self.senarioList[1]: return .yellow
        case self.senarioList[2]: return .orange
        case self.senarioList[3]: return .purple
        case self.senarioList[4]: return .blue
        case self.senarioList[5]: return .green
        case self.senarioList[6]: return .red
        case self.senarioList[7]: return .red
        case self.senarioList[8]: return .cyan
        case self.senarioList[9]: return .gray
        case self.senarioList[10]: return .indigo
        case self.senarioList[11]: return .pink
        case self.senarioList[12]: return .mint
        case self.senarioList[13]: return .purple
        case self.senarioList[14]: return .orange
        default: return .clear
        }
    }
    
    private func bindingResult(index: Int) -> Binding<Int> {
        switch index {
        case 0: return enen2.$charaCountDefault
        case 1: return enen2.$charaCountGusu
        case 2: return enen2.$charaCountOver4
        case 3: return enen2.$charaCountOver6
        case 4: return enen2.$charaCountKisu
        case 5: return enen2.$charaCountHighJaku
        case 6: return enen2.$charaCountHighKyo
        case 7: return enen2.$charaCountOver5
        case 8: return enen2.$charaCountNegate1
        case 9: return enen2.$charaCountNegate2
        case 10: return enen2.$charaCountNegate3
        case 11: return enen2.$charaCountNegate4
        case 12: return enen2.$charaCountNegate5
        default: return .constant(0)
        }
    }
    
    private func flushColorResult(index: Int) -> Color {
        switch index {
        case 0: return .gray
        case 1: return .yellow
        case 2: return .orange
        case 3: return .purple
        case 4: return .blue
        case 5: return .green
        case 6: return .red
        case 7: return .red
        case 8: return .cyan
        case 9: return .gray
        case 10: return .indigo
        case 11: return .pink
        case 12: return .mint
        default: return .gray
        }
    }
}

#Preview {
    enen2ViewReg(
        enen2: Enen2(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
