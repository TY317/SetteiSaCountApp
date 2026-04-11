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
    
    let senarioList: [[String]] = [
        ["ココ・ヘクマティアル","ヨナ","ルツ","レーム","バルメ"],
        ["トージョ","ワイリ","ウゴ","マオ","アール"],
        ["チェキータ","陳国明","カレン・ロウ","-","-"],
        ["天田南","ブックマン","ヘックス","-","-"],
        ["キャスパー・ヘクマティアル","エコー","Dr.マイアミ 他","-","-"],
        ["ココ・ヘクマティアル(幼少期)","-","-","-","-"],
    ]
    @State var selectedSenario: [String] = ["ココ・ヘクマティアル","ヨナ","ルツ","レーム","バルメ"]
    let sisaList: [String] = [
        "奇数示唆",
        "偶数示唆",
        "高設定示唆",
        "設定2 以上濃厚",
        "設定4 以上濃厚",
        "設定6 濃厚",
    ]
    let indexList: [Int] = [0,1,2,3,4,5]
    
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
                    self.senarioList[5][0],
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
                    // トージョ
                    else if newValue == firstList[1] {
                        self.selectedSenario = self.senarioList[1]
                    }
                    // チェキータ
                    else if newValue == firstList[2] {
                        self.selectedSenario = self.senarioList[2]
                    }
                    // 天田
                    else if newValue == firstList[3] {
                        self.selectedSenario = self.senarioList[3]
                    }
                    // キャスパー
                    else if newValue == firstList[4] {
                        self.selectedSenario = self.senarioList[4]
                    }
                    // アイリススタート
                    else {
                        self.selectedSenario = self.senarioList[5]
                    }
                }
                
                // 2人目以降
                ForEach(self.selectedSenario.indices, id: \.self) { index in
                    if index > 0 {
                        let textNumber: Int = index + 1
                        HStack {
                            Text("\(textNumber)人目")
                            Spacer()
                            Text(self.selectedSenario[index])
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                
                // //// 示唆＆登録ボタン
                unitCountSubmitWithResult(
                    title: sisaText(senario: self.selectedSenario),
                    count: bindingForCount(senario: self.selectedSenario),
                    bigNumber: $jormungand.charaCountSum,
                    flushColor: flushColor(senario: self.selectedSenario),
                    minusCheck: $jormungand.minusCheck) {
                        jormungand.charaSumFunc()
                    }
            } header: {
                Text("キャラ選択")
            }
            
            // ---- カウント結果
            Section {
                ForEach(self.senarioList, id: \.self) { senario in
                    unitResultCountListPercent(
                        title: sisaText(senario: senario),
                        count: bindingForCount(senario: senario),
                        flashColor: flushColor(senario: senario),
                        bigNumber: $jormungand.charaCountSum
                    )
                }
            } header: {
                Text("カウント結果")
            }
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
    
    
}

#Preview {
    jormungandViewReg(
        jormungand: Jormungand(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
