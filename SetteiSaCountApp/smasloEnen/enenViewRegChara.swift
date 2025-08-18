//
//  enenViewRegChara.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/16.
//

import SwiftUI

struct enenViewRegChara: View {
    @ObservedObject var enen: Enen
    @State var isShowAlert = false
    @State var selectedCharaList: [String] = [
        "森羅日下部",
        "アーサー・ボイル",
        "環古達",
        "茉希尾瀬",
        "武久火縄",
    ]
    @State var selectedFirst: String = "森羅日下部"
    @State var selectedSecond: String = "アーサー・ボイル"
    @State var selectedThird: String = "環古達"
    @State var selectedForth: String = "茉希尾瀬"
    @State var selectedFifth: String = "武久火縄"
    let firstList: [String] = ["森羅日下部", "Dr.ジョヴァンニ", "アイリス"]
    let sinraSecondList: [String] = ["アーサー・ボイル", "ヴィクトル・リヒト"]
    let sinraFifthList: [String] = ["武久火縄", "新門紅丸"]
    let jovaSecondList: [String] = ["アロー", "秋樽桜備"]
    let jovaFifthList: [String] = ["ヨナ", "象日下部"]
    let airisuSecondList: [String] = ["秋樽桜備", "まもるくん"]
    let airisuThirdList: [String] = ["ハラン", "まもるくん"]
    let airisuForthList: [String] = ["プリンセス火華", "まもるくん"]
    let airisuFifthList: [String] = ["レオナルド・バーンズ", "まもるくん"]
    let senarioList: [[String]] = [
        ["森羅日下部","アーサー・ボイル","環古達","茉希尾瀬","武久火縄"],
        ["森羅日下部","アーサー・ボイル","環古達","茉希尾瀬","新門紅丸"],
        ["森羅日下部","ヴィクトル・リヒト","ヴァルカン・ジョセフ","アイリス","秋樽桜備"],
        ["Dr.ジョヴァンニ","アロー","アサルト","フレイル","ヨナ"],
        ["Dr.ジョヴァンニ","アロー","アサルト","フレイル","象日下部"],
        ["Dr.ジョヴァンニ","秋樽桜備","プリンセス火華","レオナルド・バーンズ","新門紅丸"],
        ["アイリス","まもるくん","ハラン","プリンセス火華","レオナルド・バーンズ"],
        ["アイリス","秋樽桜備","まもるくん","プリンセス火華","レオナルド・バーンズ"],
        ["アイリス","秋樽桜備","ハラン","まもるくん","レオナルド・バーンズ"],
        ["アイリス","秋樽桜備","ハラン","プリンセス火華","まもるくん"],
        ["アイリス","秋樽桜備","ハラン","プリンセス火華","レオナルド・バーンズ"],
    ]
    let sisaList: [String] = [
        "デフォルト",
        "設定4 以上濃厚",
        "設定1・4・6 示唆",
        "設定2・5 示唆",
        "設定5 以上濃厚",
        "設定1 否定",
        "設定2 否定",
        "設定4 否定",
        "設定5 否定",
        "設定6 濃厚",
    ]
    let resultIndexList: [Int] = [0,2,3,6,7,8,9,1,4,10]
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 300.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 300.0
    let lazyVGridCountPortrait: Int = 3
    let lazyVGridCountLandscape: Int = 5
    @State var lazyVGridCount: Int = 3
    let maxWidth2: CGFloat = 60
    let maxWidth3: CGFloat = .infinity
    let maxWidth4: CGFloat = .infinity
    let maxWidth5: CGFloat = 60
    var body: some View {
        List {
            // //// キャラ選択
            Section {
                // 1人目
                unitPickerMenuString(
                    title: "1人目",
                    selected: self.$selectedCharaList[0],
                    selectlist: self.firstList,
                )
                .onChange(of: self.selectedCharaList[0]) {
                    // 森羅スタート
                    if self.selectedCharaList[0] == self.firstList[0] {
                        self.selectedCharaList = self.senarioList[0]
                    }
                    // ジョヴァンニ　スタート
                    else if self.selectedCharaList[0] == self.firstList[1] {
                        self.selectedCharaList = self.senarioList[3]
                    }
                    // アイリス　スタート
                    else {
                        self.selectedCharaList = self.senarioList[7]
                    }
                }
                
                // 森羅スタート
                if self.selectedCharaList[0] == self.firstList[0] {
                    // 2人目
                    unitPickerMenuString(
                        title: "2人目",
                        selected: self.$selectedCharaList[1],
                        selectlist: self.sinraSecondList
                    )
                    .onChange(of: self.selectedCharaList[1]) {
                        if self.selectedCharaList[1] == self.sinraSecondList[0] {
                            self.selectedCharaList = self.senarioList[0]
                        } else {
                            self.selectedCharaList = self.senarioList[2]
                        }
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
                    // アーサーシナリオ
                    if self.selectedCharaList[1] == self.sinraSecondList[0] {
                        unitPickerMenuString(
                            title: "5人目",
                            selected: self.$selectedCharaList[4],
                            selectlist: self.sinraFifthList
                        )
                    }
                    // リヒトシナリオ
                    else {
                        HStack {
                            Text("5人目")
                            Spacer()
                            Text(self.selectedCharaList[4])
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                
                // ジョヴァンニ　スタート
                else if self.selectedCharaList[0] == self.firstList[1] {
                    // 2人目
                    unitPickerMenuString(
                        title: "2人目",
                        selected: self.$selectedCharaList[1],
                        selectlist: self.jovaSecondList
                    )
                    .onChange(of: self.selectedCharaList[1]) {
                        if self.selectedCharaList[1] == self.jovaSecondList[0] {
                            self.selectedCharaList = self.senarioList[3]
                        } else {
                            self.selectedCharaList = self.senarioList[5]
                        }
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
                    if self.selectedCharaList[1] == self.jovaSecondList[0] {
                        // アローシナリオ
                        unitPickerMenuString(
                            title: "5人目",
                            selected: self.$selectedCharaList[4],
                            selectlist: self.jovaFifthList
                        )
                    } else {
                        // 大隊長シナリオ
                        HStack {
                            Text("5人目")
                            Spacer()
                            Text(self.selectedCharaList[4])
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                
                // アイリス　スタート
                else {
                    // 2人目
                    unitPickerMenuString(
                        title: "2人目",
                        selected: self.$selectedCharaList[1],
                        selectlist: self.airisuSecondList
                    )
                    .onChange(of: self.selectedCharaList[1]) {
                        if self.selectedCharaList[1] == self.airisuSecondList[0] {
                            self.selectedCharaList = self.senarioList[7]
                        } else {
                            self.selectedCharaList = self.senarioList[6]
                        }
                    }
                    // 2人目 まもるくん
                    if self.selectedCharaList[1] == self.airisuSecondList[1] {
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
                        HStack {
                            Text("5人目")
                            Spacer()
                            Text(self.selectedCharaList[4])
                                .foregroundStyle(.secondary)
                        }
                    }
                    // 2人目まもるくん　以外
                    else {
                        // 3人目
                        unitPickerMenuString(
                            title: "3人目",
                            selected: self.$selectedCharaList[2],
                            selectlist: self.airisuThirdList
                        )
                        .onChange(of: self.selectedCharaList[2]) {
                            if self.selectedCharaList[2] == self.airisuThirdList[0] {
                                self.selectedCharaList = self.senarioList[8]
                            } else {
                                self.selectedCharaList = self.senarioList[7]
                            }
                        }
                        // 3人目　まもるくん
                        if self.selectedCharaList[2] == self.airisuThirdList[1] {
                            // 4人目
                            HStack {
                                Text("4人目")
                                Spacer()
                                Text(self.selectedCharaList[3])
                                    .foregroundStyle(.secondary)
                            }
                            // 5人目
                            HStack {
                                Text("5人目")
                                Spacer()
                                Text(self.selectedCharaList[4])
                                    .foregroundStyle(.secondary)
                            }
                        }
                        // 3人目　まもるくん以外
                        else {
                            // 4人目
                            unitPickerMenuString(
                                title: "4人目",
                                selected: self.$selectedCharaList[3],
                                selectlist: self.airisuForthList
                            )
                            .onChange(of: self.selectedCharaList[3]) {
                                if self.selectedCharaList[3] == self.airisuForthList[0] {
                                    self.selectedCharaList = self.senarioList[9]
                                } else {
                                    self.selectedCharaList = self.senarioList[8]
                                }
                            }
                            // 4人目まもるくん
                            if self.selectedCharaList[3] == self.airisuForthList[1] {
                                // 5人目
                                HStack {
                                    Text("5人目")
                                    Spacer()
                                    Text(self.selectedCharaList[4])
                                        .foregroundStyle(.secondary)
                                }
                            }
                            // 4人目まもるくん　以外
                            else {
                                unitPickerMenuString(
                                    title: "5人目",
                                    selected: self.$selectedCharaList[4],
                                    selectlist: self.airisuFifthList,
                                )
                            }
                        }
                    }
                }
                
                // //// 示唆＆登録ボタン
                unitCountSubmitWithResult(
                    title: sisaText(charaList: self.selectedCharaList),
                    count: bindingForCount(charaList: self.selectedCharaList),
                    bigNumber: $enen.charaCountSum,
                    flushColor: flushColor(charaList: self.selectedCharaList),
                    minusCheck: $enen.minusCheck) {
                        enen.charaCountSumFunc()
                    }
            } header: {
                Text("キャラ選択")
            }
            
            // //// カウント結果
            Section {
                ForEach(self.resultIndexList, id: \.self) { index in
                    unitResultCountListPercent(
                        title: sisaText(charaList: self.senarioList[index]),
                        count: bindingForCount(charaList: self.senarioList[index]),
                        flashColor: flushColor(charaList: self.senarioList[index]),
                        bigNumber: $enen.charaCountSum,
                        numberofDigit: 0,
                    )
                }
                // 参考情報）振り分け
                unitLinkButtonViewBuilder(sheetTitle: "シナリオ振分け") {
                    enenTableCharaRatio(
                        enen: enen,
                    )
                }
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        enenView95Ci(
                            enen: enen,
                            selection: 3,
                        )
                    )
                )
            } header: {
                Text("カウント結果")
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: enen.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("REG中のキャラ")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $enen.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: enen.resetChara)
                }
            }
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
    }
    
    private func sisaText(charaList: [String]) -> String {
        switch charaList {
        case self.senarioList[0]: return self.sisaList[0]
        case self.senarioList[1]: return self.sisaList[1]
        case self.senarioList[2]: return self.sisaList[2]
        case self.senarioList[3]: return self.sisaList[3]
        case self.senarioList[4]: return self.sisaList[4]
        case self.senarioList[5]: return self.sisaList[1]
        case self.senarioList[6]: return self.sisaList[5]
        case self.senarioList[7]: return self.sisaList[6]
        case self.senarioList[8]: return self.sisaList[7]
        case self.senarioList[9]: return self.sisaList[8]
        case self.senarioList[10]: return self.sisaList[9]
        default: return "???"
        }
    }
    
    private func bindingForCount(charaList: [String]) -> Binding<Int> {
        switch charaList {
        case self.senarioList[0]: return enen.$charaCountDefault
        case self.senarioList[1]: return enen.$charaCountOver4
        case self.senarioList[2]: return enen.$charaCount146Sisa
        case self.senarioList[3]: return enen.$charaCount25Sisa
        case self.senarioList[4]: return enen.$charaCountOver5
        case self.senarioList[5]: return enen.$charaCountOver4
        case self.senarioList[6]: return enen.$charaCountNegate1
        case self.senarioList[7]: return enen.$charaCountNegate2
        case self.senarioList[8]: return enen.$charaCountNegate4
        case self.senarioList[9]: return enen.$charaCountNegate5
        case self.senarioList[10]: return enen.$charaCountOver6
        default: return .constant(0)
        }
    }
    
    private func flushColor(charaList: [String]) -> Color {
        switch charaList {
        case self.senarioList[0]: return .gray
        case self.senarioList[1]: return .orange
        case self.senarioList[2]: return .yellow
        case self.senarioList[3]: return .blue
        case self.senarioList[4]: return .red
        case self.senarioList[5]: return .orange
        case self.senarioList[6]: return .green
        case self.senarioList[7]: return .cyan
        case self.senarioList[8]: return .brown
        case self.senarioList[9]: return .gray
        case self.senarioList[10]: return .purple
        default: return .clear
        }
    }
 }

#Preview {
    enenViewRegChara(
        enen: Enen(),
    )
}
