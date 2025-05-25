//
//  arifureViewCharacter.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/03.
//

import SwiftUI

struct arifureViewCharacter: View {
//    @ObservedObject var ver250 = Ver250()
//    @ObservedObject var arifure = Arifure()
    @ObservedObject var arifure: Arifure
    @State var isShowAlert = false
    @State var selectedCategory: String = "通常"
    let selectListCategory: [String] = ["通常", "金文字", "ﾐﾆｷｬﾗﾑｰﾋﾞｰ"]
    @State var selectedGoldChara: String = "白崎 香織(使徒の姿)"
    let selectListGoldChara: [String] = ["白崎 香織(使徒の姿)", "ユエ(吸血姫)", "南雲 ハジメ(学生)"]
    let selectListFirstChara: [String] = [
        "南雲 ハジメ",
        "ユエ",
        "天之河 光輝",
        "フリード・バグアー",
        "ノイント",
        "ミュウ"
    ]
    @State var selectedFirstChara: String = "南雲 ハジメ"
    let selectListHajimeSecondChara: [String] = [
        "白崎 香織",
        "ユエ"
    ]
    @State var selectedHajimeScondChara: String = "白崎 香織"
    let selectListYueSecondChara: [String] = [
        "シア・ハウリア",
        "南雲 ハジメ"
    ]
    @State var selectedYueScondChara: String = "シア・ハウリア"
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 250.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 250.0
    
    var body: some View {
        List {
            Section {
                // //// 分類選択
                Picker("", selection: self.$selectedCategory) {
                    ForEach(self.selectListCategory, id: \.self) { category in
                        Text(category)
                    }
                }
                .pickerStyle(.segmented)
                // //// 分類ごとの登録
                // ミニキャラムービー
                if self.selectedCategory == self.selectListCategory[2] {
                    Text("ー")
                        .foregroundStyle(.secondary)
                    Text("ー")
                        .foregroundStyle(.secondary)
                    Text("ー")
                        .foregroundStyle(.secondary)
                    // AT濃厚
//                    unitResultCountListPercent(
//                        title: "AT濃厚",
//                        count: $arifure.charaCountAt,
//                        flashColor: .red,
//                        bigNumber: $arifure.charaCountSum
//                    )
                    unitResultCountListWithoutRatio(title: "AT濃厚", count: $arifure.charaCountAt, flashColor: .red)
                }
                // 金文字
                else if self.selectedCategory == self.selectListCategory[1] {
                    // 1人目
                    HStack {
                        Text("1人目")
                        Spacer()
                        Text("不問")
                            .foregroundStyle(.secondary)
                    }
                    // 2人目
                    HStack {
                        Text("2人目")
                        Spacer()
                        Text("不問")
                            .foregroundStyle(.secondary)
                    }
                    // 3人目
                    unitPickerMenuString(
                        title: "3人目",
                        selected: self.$selectedGoldChara,
                        selectlist: self.selectListGoldChara
                    )
                    // AT+設定4 以上濃厚
                    if self.selectedGoldChara == self.selectListGoldChara[0] {
//                        unitResultCountListPercent(
//                            title: "AT+設定4 以上濃厚",
//                            count: $arifure.charaCountOver4,
//                            flashColor: .orange,
//                            bigNumber: $arifure.charaCountSum
//                        )
                        unitResultCountListWithoutRatio(title: "AT+設定4 以上濃厚", count: $arifure.charaCountOver4, flashColor: .orange)
                    }
                    // AT+設定5 以上濃厚
                    else if self.selectedGoldChara == self.selectListGoldChara[1] {
//                        unitResultCountListPercent(
//                            title: "AT+設定5 以上濃厚",
//                            count: $arifure.charaCountOver5,
//                            flashColor: .orange,
//                            bigNumber: $arifure.charaCountSum
//                        )
                        unitResultCountListWithoutRatio(title: "AT+設定5 以上濃厚", count: $arifure.charaCountOver5, flashColor: .orange)
                    }
                    // AT+設定6 濃厚
                    else {
//                        unitResultCountListPercent(
//                            title: "AT+設定6 濃厚",
//                            count: $arifure.charaCountOver6,
//                            flashColor: .orange,
//                            bigNumber: $arifure.charaCountSum
//                        )
                        unitResultCountListWithoutRatio(title: "AT+設定6 濃厚", count: $arifure.charaCountOver6, flashColor: .orange)
                    }
                }
                // 通常
                else {
                    // 1人目
                    unitPickerMenuString(
                        title: "1人目",
                        selected: self.$selectedFirstChara,
                        selectlist: self.selectListFirstChara
                    )
                    // ハジメ
                    if self.selectedFirstChara == self.selectListFirstChara[0] {
                        // 2人目
                        unitPickerMenuString(
                            title: "2人目",
                            selected: self.$selectedHajimeScondChara,
                            selectlist: self.selectListHajimeSecondChara
                        )
                        // 3人目
                        HStack {
                            Text("3人目")
                            Spacer()
                            Text("畑山 愛子")
                                .foregroundStyle(Color.secondary)
                        }
                        if self.selectedHajimeScondChara == self.selectListHajimeSecondChara[0] {
                            // 偶数示唆
                            unitResultCountListPercent(
                                title: "偶数示唆",
                                count: $arifure.charaCountGusu,
                                flashColor: .gray,
                                bigNumber: $arifure.charaCountSum
                            )
                        } else {
                            // 設定2 以上濃厚＋356示唆
                            unitResultCountListPercent(
                                title: "設定2 以上濃厚＋356示唆",
                                count: $arifure.charaCountOver2Kyo,
                                flashColor: .personalSummerLightGreen,
                                bigNumber: $arifure.charaCountSum
                            )
                        }
                    }
                    // ユエ
                    else if self.selectedFirstChara == self.selectListFirstChara[1] {
                        // 2人目
                        unitPickerMenuString(
                            title: "2人目",
                            selected: self.$selectedYueScondChara,
                            selectlist: self.selectListYueSecondChara
                        )
                        // 3人目
                        HStack {
                            Text("3人目")
                            Spacer()
                            Text("ティオ・クラルス")
                                .foregroundStyle(Color.secondary)
                        }
                        if self.selectedYueScondChara == self.selectListYueSecondChara[0] {
                            // 奇数示唆
                            unitResultCountListPercent(
                                title: "奇数示唆",
                                count: $arifure.charaCountKisu,
                                flashColor: .gray,
                                bigNumber: $arifure.charaCountSum
                            )
                        } else {
                            // 設定2 以上濃厚＋356示唆
                            unitResultCountListPercent(
                                title: "設定2 以上濃厚＋偶数示唆",
                                count: $arifure.charaCountOver2Gusu,
                                flashColor: .yellow,
                                bigNumber: $arifure.charaCountSum
                            )
                        }
                    }
                    // 天野河
                    else if self.selectedFirstChara == self.selectListFirstChara[2] {
                        // 2人目
                        HStack {
                            Text("2人目")
                            Spacer()
                            Text("八重樫 雫")
                                .foregroundStyle(Color.secondary)
                        }
                        // 3人目
                        HStack {
                            Text("3人目")
                            Spacer()
                            Text("坂上 龍太郎")
                                .foregroundStyle(Color.secondary)
                        }
                        // 高設定示唆　弱
                        unitResultCountListPercent(
                            title: "高設定示唆 弱",
                            count: $arifure.charaCountHighJaku,
                            flashColor: .blue,
                            bigNumber: $arifure.charaCountSum
                        )
                    }
                    // フリード
                    else if self.selectedFirstChara == self.selectListFirstChara[3] {
                        // 2人目
                        HStack {
                            Text("2人目")
                            Spacer()
                            Text("ミハイル")
                                .foregroundStyle(Color.secondary)
                        }
                        // 3人目
                        HStack {
                            Text("3人目")
                            Spacer()
                            Text("カトレア")
                                .foregroundStyle(Color.secondary)
                        }
                        // 高設定示唆 強
                        unitResultCountListPercent(
                            title: "高設定示唆 強",
                            count: $arifure.charaCountHighKyo,
                            flashColor: .green,
                            bigNumber: $arifure.charaCountSum
                        )
                    }
                    // ノイント
                    else if self.selectedFirstChara == self.selectListFirstChara[4] {
                        // 2人目
                        HStack {
                            Text("2人目")
                            Spacer()
                            Text("檜山 大介")
                                .foregroundStyle(Color.secondary)
                        }
                        // 3人目
                        HStack {
                            Text("3人目")
                            Spacer()
                            Text("清水 幸利")
                                .foregroundStyle(Color.secondary)
                        }
                        // 偶数濃厚
                        unitResultCountListPercent(
                            title: "偶数濃厚",
                            count: $arifure.charaCountGusuKyo,
                            flashColor: .yellow,
                            bigNumber: $arifure.charaCountSum
                        )
                    }
                    // ミュウ
                    else {
                        // 2人目
                        HStack {
                            Text("2人目")
                            Spacer()
                            Text("レミア")
                                .foregroundStyle(Color.secondary)
                        }
                        // 3人目
                        HStack {
                            Text("3人目")
                            Spacer()
                            Text("リリアーナ・S・B・ハイリヒ")
                                .foregroundStyle(Color.secondary)
                        }
                        // 設定2 以上濃厚
                        unitResultCountListPercent(
                            title: "設定2 以上濃厚",
                            count: $arifure.charaCountOver2,
                            flashColor: .cyan,
                            bigNumber: $arifure.charaCountSum
                        )
                    }
                }
                // //// 登録ボタン
                Button {
                    // ミニキャラムービー
                    if self.selectedCategory == self.selectListCategory[2] {
                        // AT濃厚
                        arifure.charaCountAt = countUpDown(minusCheck: arifure.minusCheck, count: arifure.charaCountAt)
                    }
                    // 金文字
                    else if self.selectedCategory == self.selectListCategory[1] {
                        // AT+設定4 以上濃厚
                        if self.selectedGoldChara == self.selectListGoldChara[0] {
                            arifure.charaCountOver4 = countUpDown(minusCheck: arifure.minusCheck, count: arifure.charaCountOver4)
                        }
                        // AT+設定5 以上濃厚
                        else if self.selectedGoldChara == self.selectListGoldChara[1] {
                            arifure.charaCountOver5 = countUpDown(minusCheck: arifure.minusCheck, count: arifure.charaCountOver5)
                        }
                        // AT+設定6 濃厚
                        else {
                            arifure.charaCountOver6 = countUpDown(minusCheck: arifure.minusCheck, count: arifure.charaCountOver6)
                        }
                    }
                    // 通常
                    else {
                        // ハジメ
                        if self.selectedFirstChara == self.selectListFirstChara[0] {
                            if self.selectedHajimeScondChara == self.selectListHajimeSecondChara[0] {
                                arifure.charaCountGusu = countUpDown(minusCheck: arifure.minusCheck, count: arifure.charaCountGusu)
                            } else {
                                // 設定2 以上濃厚＋356示唆
                                arifure.charaCountOver2Kyo = countUpDown(minusCheck: arifure.minusCheck, count: arifure.charaCountOver2Kyo)
                            }
                        }
                        // ユエ
                        else if self.selectedFirstChara == self.selectListFirstChara[1] {
                            if self.selectedYueScondChara == self.selectListYueSecondChara[0] {
                                // 奇数示唆
                                arifure.charaCountKisu = countUpDown(minusCheck: arifure.minusCheck, count: arifure.charaCountKisu)
                            } else {
                                // 設定2 以上濃厚＋356示唆
                                arifure.charaCountOver2Gusu = countUpDown(minusCheck: arifure.minusCheck, count: arifure.charaCountOver2Gusu)
                            }
                        }
                        // 天野河
                        else if self.selectedFirstChara == self.selectListFirstChara[2] {
                            // 高設定示唆　弱
                            arifure.charaCountHighJaku = countUpDown(minusCheck: arifure.minusCheck, count: arifure.charaCountHighJaku)
                        }
                        // フリード
                        else if self.selectedFirstChara == self.selectListFirstChara[3] {
                            // 高設定示唆 強
                            arifure.charaCountHighKyo = countUpDown(minusCheck: arifure.minusCheck, count: arifure.charaCountHighKyo)
                        }
                        // ノイント
                        else if self.selectedFirstChara == self.selectListFirstChara[4] {
                            // 偶数濃厚
                            arifure.charaCountGusuKyo = countUpDown(minusCheck: arifure.minusCheck, count: arifure.charaCountGusuKyo)
                        }
                        // ミュウ
                        else {
                            // 設定2 以上濃厚
                            arifure.charaCountOver2 = countUpDown(minusCheck: arifure.minusCheck, count: arifure.charaCountOver2)
                        }
                    }
                } label: {
                    HStack {
                        Spacer()
                        if arifure.minusCheck == false {
                            Text("登録")
                                .fontWeight(.bold)
                                .foregroundStyle(Color.blue)
                        } else {
                            Text("1行削除")
                                .fontWeight(.bold)
                                .foregroundStyle(Color.red)
                        }
                        Spacer()
                    }
                }
            } header: {
                Text("キャラ選択")
            }
            
            // //// カウント結果
            Section {
                // 偶数示唆
                unitResultCountListPercent(
                    title: "偶数示唆",
                    count: $arifure.charaCountGusu,
                    flashColor: .gray,
                    bigNumber: $arifure.charaCountSum
                )
                // 奇数示唆
                unitResultCountListPercent(
                    title: "奇数示唆",
                    count: $arifure.charaCountKisu,
                    flashColor: .gray,
                    bigNumber: $arifure.charaCountSum
                )
                // 高設定示唆　弱
                unitResultCountListPercent(
                    title: "高設定示唆 弱",
                    count: $arifure.charaCountHighJaku,
                    flashColor: .blue,
                    bigNumber: $arifure.charaCountSum
                )
                // 高設定示唆 強
                unitResultCountListPercent(
                    title: "高設定示唆 強",
                    count: $arifure.charaCountHighKyo,
                    flashColor: .green,
                    bigNumber: $arifure.charaCountSum
                )
                // 偶数濃厚
                unitResultCountListPercent(
                    title: "偶数濃厚",
                    count: $arifure.charaCountGusuKyo,
                    flashColor: .yellow,
                    bigNumber: $arifure.charaCountSum
                )
                // 設定2 以上濃厚
                unitResultCountListPercent(
                    title: "設定2 以上濃厚",
                    count: $arifure.charaCountOver2,
                    flashColor: .cyan,
                    bigNumber: $arifure.charaCountSum
                )
                // 設定2 以上濃厚＋356示唆
                unitResultCountListPercent(
                    title: "設定2 以上濃厚＋356示唆",
                    count: $arifure.charaCountOver2Kyo,
                    flashColor: .personalSummerLightGreen,
                    bigNumber: $arifure.charaCountSum
                )
                // 設定2 以上濃厚＋偶数示唆
                unitResultCountListPercent(
                    title: "設定2 以上濃厚＋偶数示唆",
                    count: $arifure.charaCountOver2Gusu,
                    flashColor: .yellow,
                    bigNumber: $arifure.charaCountSum
                )
                // AT濃厚
//                unitResultCountListPercent(
//                    title: "AT濃厚",
//                    count: $arifure.charaCountAt,
//                    flashColor: .red,
//                    bigNumber: $arifure.charaCountSum
//                )
                unitResultCountListWithoutRatio(title: "AT濃厚", count: $arifure.charaCountAt, flashColor: .red)
                // AT+設定4 以上濃厚
//                unitResultCountListPercent(
//                    title: "AT+設定4 以上濃厚",
//                    count: $arifure.charaCountOver4,
//                    flashColor: .orange,
//                    bigNumber: $arifure.charaCountSum
//                )
                unitResultCountListWithoutRatio(title: "AT+設定4 以上濃厚", count: $arifure.charaCountOver4, flashColor: .orange)
                // AT+設定5 以上濃厚
//                unitResultCountListPercent(
//                    title: "AT+設定5 以上濃厚",
//                    count: $arifure.charaCountOver5,
//                    flashColor: .orange,
//                    bigNumber: $arifure.charaCountSum
//                )
                unitResultCountListWithoutRatio(title: "AT+設定5 以上濃厚", count: $arifure.charaCountOver5, flashColor: .orange)
                // AT+設定6 濃厚
//                unitResultCountListPercent(
//                    title: "AT+設定6 濃厚",
//                    count: $arifure.charaCountOver6,
//                    flashColor: .orange,
//                    bigNumber: $arifure.charaCountSum
//                )
                unitResultCountListWithoutRatio(title: "AT+設定6 濃厚", count: $arifure.charaCountOver6, flashColor: .orange)
                // //// 参考情報）振り分け
                unitLinkButton(
                    title: "キャラ紹介振り分け",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "キャラ紹介振り分け",
                            tableView: AnyView(arifureSubViewTableChara(arifure: arifure))
                        )
                    )
                )
//                .popoverTip(tipVer250ArifureCharacterRatio())
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(arifureView95Ci(arifure: arifure, selection: 13)))
                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("カウント結果")
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ありふれた職業で世界最強",
                screenClass: screenClass
            )
        }
//        .onAppear {
//            if ver250.arifureMenuCharacterBadgeStatus != "none" {
//                ver250.arifureMenuCharacterBadgeStatus = "none"
//            }
//        }
        // //// 画面の向き情報の取得部分
        .onAppear {
            // ビューが表示されるときにデバイスの向きを取得
            self.orientation = UIDevice.current.orientation
            // 向きがフラットでなければlastOrientationの値を更新
            if self.orientation.isFlat {
                
            }
            else {
                self.lastOrientation = self.orientation
            }
            if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
                self.scrollViewHeight = self.scrollViewHeightLandscape
                self.spaceHeight = self.spaceHeightLandscape
            } else {
                self.scrollViewHeight = self.scrollViewHeightPortrait
                self.spaceHeight = self.spaceHeightPortrait
            }
            // デバイスの向きの変更を監視する
            NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: .main) { _ in
                self.orientation = UIDevice.current.orientation
                // 向きがフラットでなければlastOrientationの値を更新
                if self.orientation.isFlat {
                    
                }
                else {
                    self.lastOrientation = self.orientation
                }
                if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
                    self.scrollViewHeight = self.scrollViewHeightLandscape
                    self.spaceHeight = self.spaceHeightLandscape
                } else {
                    self.scrollViewHeight = self.scrollViewHeightPortrait
                    self.spaceHeight = self.spaceHeightPortrait
                }
            }
        }
        .onDisappear {
            // ビューが非表示になるときに監視を解除
            NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
        }
        .navigationTitle("ミュウボーナス中のキャラ紹介")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $arifure.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: arifure.resetCharacter)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    arifureViewCharacter(arifure: Arifure())
}
