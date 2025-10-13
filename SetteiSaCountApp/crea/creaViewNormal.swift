//
//  creaViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/24.
//

import SwiftUI

struct creaViewNormal: View {
    @ObservedObject var crea: Crea
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @State var isShowAlert: Bool = false
    @FocusState var focusedField: CreaField?
    @State var selectedSegment: String = "小役カウント"
    let segmentList: [String] = ["小役カウント", "重複当選"]
    let kindList: [String] = ["🔔","🍒","🍉","ﾁｬﾝｽ目"]
    let dicimalList: [Int] = [1,0,0,0]
    let dicimalListChofuku: [Int] = [1,1,1,0]
    let colorList: [Color] = [.personalSpringLightYellow, .personalSummerLightRed, .personalSummerLightGreen, .personalSummerLightPurple]
    let flushColorList: [Color] = [.yellow, .red, .green, .purple]
    
    enum CreaField: Hashable {
        case gameStart
        case gameCurrent
        case count(Int)
    }
    
    var body: some View {
        List {
            // //// 小役関連
            Section {
                // //// 注意書き
//                Text("・小役回数はダイトモで確認できます。右上のキーボードボタンで数値の直接入力が可能です\n・重複当選はダイトモでのカウントないため自力カウントを推奨します。ボーナス揃い時にPUSHボタン押すとサイドランプ色で当選契機を示唆してくれます。")
//                    .foregroundStyle(Color.secondary)
//                    .font(.caption)
                // //// セグメントピッカー
                Picker("", selection: self.$selectedSegment) {
                    ForEach(self.segmentList, id: \.self) { segment in
                        Text(segment)
                    }
                }
                .pickerStyle(.segmented)
                
                // //// 小役カウント
                if self.selectedSegment == self.segmentList[0] {
                    HStack {
                        ForEach(self.kindList.indices, id: \.self) { index in
                            if self.kindList.indices.contains(index) &&
                                self.dicimalList.indices.contains(index) &&
                                self.colorList.indices.contains(index) &&
                                self.flushColorList.indices.contains(index) {
                                unitCountButtonVerticalDenominate(
                                    title: self.kindList[index],
                                    count: bindingCount(index),
                                    color: self.colorList[index],
                                    bigNumber: $crea.gameNumberPlay,
                                    numberofDicimal: self.dicimalList[index],
                                    minusBool: $crea.minusCheck,
                                    flushColor: self.flushColorList[index],
                                )
                            }
                        }
                    }
                }
                // //// 重複カウント
                else {
                    HStack {
                        ForEach(self.kindList.indices, id: \.self) { index in
                            if self.kindList.indices.contains(index) &&
                                self.dicimalListChofuku.indices.contains(index) &&
                                self.flushColorList.indices.contains(index) {
                                unitCountButtonVerticalPercent(
                                    title: self.kindList[index],
                                    count: bindingChofukuCount(index),
                                    color: self.flushColorList[index],
                                    bigNumber: bindingCount(index),
                                    numberofDicimal: self.dicimalListChofuku[index],
                                    minusBool: $crea.minusCheck
                                )
                            }
                        }
                    }
                }
                
                // //// 参考情報）小役確率
                unitLinkButtonViewBuilder(sheetTitle: "小役確率") {
                    creaTableKoyakuRatio(
                        crea: crea,
                    )
                }
                // //// 参考情報）重複当選率
                unitLinkButtonViewBuilder(sheetTitle: "重複当選率") {
                    creaTableChofukuRatio(
                        crea: crea,
                    )
                }
                // //// 参考情報）レア役停止形
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止形") {
                    creaTableKoyakuPattern()
                }
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        creaView95Ci(
                            crea: crea,
                            selection: 1,
                        )
                    )
                )
            } header: {
                HStack {
                    Text("小役")
                    unitToolbarButtonQuestion {
                        unitExView5body2image(
                            title: "小役、重複カウント",
                            textBody1: "・小役カウントでは小役成立ごとにカウントして下さい\n・小役回数はダイトモで確認できます。右上のキーボードボタンで数値の直接入力が可能です",
                            textBody2: "・重複当選ではボーナス重複当選ごとにカウントして下さい。小役のカウント数と重複回数から重複当選率を算出します",
                            textBody3: "・重複当選はダイトモでのカウントないため自力カウントを推奨します。ボーナス揃い時にPUSHボタン押すとサイドランプ色で当選契機を示唆してくれます。"
                        )
                    }
                }
            }
            
            // //// ゲーム数入力
            Section {
                // //// ゲーム数入力
                // 打ち始め入力
                unitTextFieldNumberInputWithUnit(
                    title: "打ち始め",
                    inputValue: $crea.gameNumberStart,
                    unitText: "Ｇ"
                )
                .focused($focusedField, equals: .gameStart)
                .onChange(of: crea.gameNumberStart) {
                    let playGame = crea.gameNumberCurrent - crea.gameNumberStart
                    crea.gameNumberPlay = playGame > 0 ? playGame : 0
                }
                // 現在入力
                unitTextFieldNumberInputWithUnit(
                    title: "現在",
                    inputValue: $crea.gameNumberCurrent,
                    unitText: "Ｇ"
                )
                .focused($focusedField, equals: .gameCurrent)
                .onChange(of: crea.gameNumberCurrent) {
                    let playGame = crea.gameNumberCurrent - crea.gameNumberStart
                    crea.gameNumberPlay = playGame > 0 ? playGame : 0
                }
                // プレイ数
                unitTextGameNumberWithoutInput(
                    gameNumber: crea.gameNumberPlay
                )
                
            } header: {
                Text("ゲーム数入力")
            }
        }
        // //// バッジのリセット
        //        .resetBadgeOnAppear($ver391.creaMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: crea.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            // カウント値ダイレクト入力
            ToolbarItem(placement: .automatic) {
                UnitToolbarButtonCountDirectInputEnumFocus<CreaField, AnyView>(
                    focus: $focusedField,
                    inputView: {
                        AnyView(
                            ForEach(self.kindList.indices, id: \.self) { index in
                                if self.kindList.indices.contains(index) {
                                    UnitTextFieldNumberInputWithUnitEnumFocus<CreaField>(
                                        title: self.kindList[index],
                                        inputValue: bindingCount(index),
                                        focusedField: $focusedField,
                                        thisField: .count(index)
                                    )
                                }
                            }
                        )
                    }
                )
            }
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $crea.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: crea.resetNormal)
            }
            ToolbarItem(placement: .keyboard) {
                HStack {
                    Spacer()
                    Button(action: {
                        focusedField = nil
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }, label: {
                        Text("完了")
                            .fontWeight(.bold)
                    })
                }
            }
        }
    }
    func bindingCount(_ index: Int) -> Binding<Int> {
        switch index {
        case 0: return $crea.koyakuCountBell
        case 1: return $crea.koyakuCountCherry
        case 2: return $crea.koyakuCountSuika
        case 3: return $crea.koyakuCountChance
        default: return .constant(0)
        }
    }
    func bindingChofukuCount(_ index: Int) -> Binding<Int> {
        switch index {
        case 0: return $crea.chofukuCountBell
        case 1: return $crea.chofukuCountCherry
        case 2: return $crea.chofukuCountSuika
        case 3: return $crea.chofukuCountChance
        default: return .constant(0)
        }
    }
}

#Preview {
    creaViewNormal(
        crea: Crea(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}

