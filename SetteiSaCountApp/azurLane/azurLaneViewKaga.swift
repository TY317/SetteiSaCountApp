//
//  azurLaneViewKaga.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/29.
//

import SwiftUI

struct azurLaneViewKaga: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var azurLane: AzurLane
    @State var isShowAlert = false
    @State var selectedCharaList: [String] = ["ジャベリン","ラフィー","綾波","Z23","エンタープライズ"]
    let firstList: [String] = ["ジャベリン","エンタープライズ","ベルファスト"]
    let fifthList: [String] = ["エンタープライズ","ベルファスト","瑞鶴","オイゲン"]
    let senarioList: [[String]] = [
        ["ジャベリン","ラフィー","綾波","Z23","エンタープライズ"],
        ["ジャベリン","ラフィー","綾波","Z23","ベルファスト"],
        ["エンタープライズ","Z23","綾波","ラフィー","ジャベリン"],
        ["ベルファスト","Z23","綾波","ラフィー","ジャベリン"],
        ["ジャベリン","ラフィー","綾波","Z23","瑞鶴"],
        ["ジャベリン","ラフィー","綾波","Z23","オイゲン"],
    ]
    let sisaList: [String] = [
        "デフォ 奇数示唆 弱",
        "奇数示唆",
        "偶数示唆",
        "設定4・6示唆",
        "設定5・6示唆",
        "デフォ 偶数示唆 弱",
    ]
    let resultIndexList: [Int] = [0,1,2,3,4,5]
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    
    var body: some View {
        List {
            // キャラ選択
            Section {
                Text("どこかで赤城or加賀が出現したらAT濃厚示唆")
                    .font(.subheadline)
                // 1人目
                unitPickerMenuString(
                    title: "1人目",
                    selected: self.$selectedCharaList[0],
                    selectlist: self.firstList
                )
                .onChange(of: self.selectedCharaList[0]) { oldValue, newValue in
                    // ジャベリンスタート
//                    if self.selectedCharaList[0] == self.firstList[0] {
                    if newValue == self.firstList[0] {
                        self.selectedCharaList = self.senarioList[0]
                    }
                    // エンタープライズスタート
//                    if self.selectedCharaList[0] == self.firstList[1] {
                    else if newValue == self.firstList[1] {
                        self.selectedCharaList = self.senarioList[2]
                    }
                    // ベルファストスタート
                    else {
                        self.selectedCharaList = self.senarioList[3]
                    }
                }
                // 2人目
                HStack {
                    Text("2人目")
                    Spacer()
                    Text(self.selectedCharaList[1])
                        .foregroundStyle(.secondary)
                }
                // 3人目
                HStack {
                    Text("3人目")
                    Spacer()
                    Text(self.selectedCharaList[2])
                        .foregroundStyle(.secondary)
                }
                // 4人目
                HStack {
                    Text("4人目")
                    Spacer()
                    Text(self.selectedCharaList[3])
                        .foregroundStyle(.secondary)
                }
                // 5人目
                // ジャベリンスタート
                if self.selectedCharaList[0] == self.firstList[0] {
                    unitPickerMenuString(
                        title: "5人目",
                        selected: self.$selectedCharaList[4],
                        selectlist: self.fifthList
                    )
                }
                // それ以外
                else {
                    HStack {
                        Text("5人目")
                        Spacer()
                        Text(self.selectedCharaList[4])
                            .foregroundStyle(.secondary)
                    }
                }
                
                // //// 示唆＆登録ボタン
                unitCountSubmitWithResult(
                    title: sisaText(charaList: self.selectedCharaList),
                    count: bindingForCount(charaList: self.selectedCharaList),
                    bigNumber: $azurLane.kagaCountSum,
                    flushColor: flushColor(charaList: self.selectedCharaList),
                    minusCheck: $azurLane.minusCheck) {
                        azurLane.kagaSumFunc()
                    }
            } header: {
                Text("前半敗北時のキャラ紹介")
            }
            
            // //// カウント結果
            Section {
                ForEach(self.resultIndexList, id: \.self) { index in
                    unitResultCountListPercent(
                        title: sisaText(charaList: self.senarioList[index]),
                        count: bindingForCount(charaList: self.senarioList[index]),
                        flashColor: flushColor(charaList: self.senarioList[index]),
                        bigNumber: $azurLane.kagaCountSum,
                        numberofDigit: 0,
                    )
                }
                
                // 参考情報）シナリオ振り分け
                unitLinkButtonViewBuilder(sheetTitle: "シナリオ振り分け") {
                    azurLaneTableKagaRatio(azurLane: azurLane)
                }
//                .popoverTip(tipVer3110AzurLaneKaga())
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    azurLaneViewBayes(
                        azurLane: azurLane,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("カウント結果")
            }
            
            // 裏ボタン
            Section {
                VStack(alignment: .leading) {
                    Text("・後半ジャッジ成功時の次ゲームにPUSHボタン押すと専用ボイスが発生する可能性あり")
                        .foregroundStyle(Color.secondary)
                        .font(.caption)
                }
                HStack(spacing: 0) {
                    unitTableString(
                        columTitle: "",
                        stringList: [
                            "たぁーのしいなぁー！",
                            "赤城の愛、 受け止めてくださるかしら？",
                        ],
                        lineList: [1,2],
                    )
                    unitTableString(
                        columTitle: "示唆",
                        stringList: [
                            "設定5 以上濃厚",
                            "設定6 濃厚",
                        ],
                        lineList: [1,2],
                    )
                }
                .frame(maxWidth: .infinity, alignment: .center)
            } header: {
                Text("裏ボタン")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.azurLaneMenuKagaBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: azurLane.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("加賀バトル")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $azurLane.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: azurLane.resetKaga)
                }
            }
        }
    }
    private func sisaText(charaList: [String]) -> String {
        switch charaList {
        case self.senarioList[0]: return self.sisaList[0]
        case self.senarioList[1]: return self.sisaList[5]
        case self.senarioList[2]: return self.sisaList[1]
        case self.senarioList[3]: return self.sisaList[2]
        case self.senarioList[4]: return self.sisaList[3]
        case self.senarioList[5]: return self.sisaList[4]
        default: return "???"
        }
    }
    private func bindingForCount(charaList: [String]) -> Binding<Int> {
        switch charaList {
        case self.senarioList[0]: return azurLane.$kagaCountDefault
        case self.senarioList[1]: return azurLane.$kagaCountDefaultGusu
        case self.senarioList[2]: return azurLane.$kagaCountKisu
        case self.senarioList[3]: return azurLane.$kagaCountGusu
        case self.senarioList[4]: return azurLane.$kagaCount46sisa
        case self.senarioList[5]: return azurLane.$kagaCount56sisa
        default: return .constant(0)
        }
    }
    private func flushColor(charaList: [String]) -> Color {
        switch charaList {
        case self.senarioList[0]: return .gray
        case self.senarioList[1]: return .gray
        case self.senarioList[2]: return .blue
        case self.senarioList[3]: return .yellow
        case self.senarioList[4]: return .green
        case self.senarioList[5]: return .red
        default: return .clear
        }
    }
}

#Preview {
    azurLaneViewKaga(
        azurLane: AzurLane(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
