//
//  magiaViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/06.
//

import SwiftUI
import TipKit

struct magiaViewNormal: View {
//    @ObservedObject var ver310: Ver310
//    @ObservedObject var magia = Magia()
    @ObservedObject var magia: Magia
    @State var isShowAlert = false
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 250.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 250.0
    @State var selectedSegment: String = "AT終了後の移行"
    let segmentList: [String] = ["AT終了後の移行", "いろはからの昇格"]
    
    var body: some View {
//        TipView(tipVer310MagiaMagicGirlMode())
        List {
            // //// 小役確率
            Section {
                Text("現在値はユニメモで確認してください")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // //// 参考情報）小役停止形
                unitLinkButton(
                    title: "小役停止形",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "小役停止形",
                            image1: Image("magiaKoyaku")
                        )
                    )
                )
                // //// 参考情報）弱チェリー確率
                unitLinkButton(
                    title: "弱🍒確率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "弱🍒確率",
                            tableView: AnyView(magiaTableJakuCherry(magia: magia))
                        )
                    )
                )
            } header: {
                Text("小役確率")
            }
            
            // //// スイカからのCZ当選
            Section {
                // //// カウントボタン横並び
                HStack {
                    // スイカ
                    unitCountButtonVerticalWithoutRatio(
                        title: "スイカ",
                        count: $magia.suikaCzCountSuika,
                        color: .personalSummerLightGreen,
                        minusBool: $magia.minusCheck
                    )
                    // CZ当選
                    unitCountButtonVerticalWithoutRatio(
                        title: "CZ",
                        count: $magia.suikaCzCountCz,
                        color: .personalSummerLightRed,
                        minusBool: $magia.minusCheck
                    )
                    // 当選率
                    unitResultRatioPercent2Line(
                        title: "当選率",
                        count: $magia.suikaCzCountCz,
                        bigNumber: $magia.suikaCzCountSuika,
                        numberofDicimal: 0
                    )
                    .padding(.vertical)
                }
                // //// 参考情報）スイカからのCZ
                unitLinkButton(
                    title: "スイカからのCZについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "スイカからのCZ",
                            textBody1: "・通常時スイカからのCZ マギアチャレンジ当選に設定差あり",
                            tableView: AnyView(magiaTableSuikaCz(magia: magia))
                        )
                    )
                )
//                .popoverTip(tipVer310MagiaCzRatio())
                // //// 参考情報）魔法少女モードについて
                unitLinkButton(
                    title: "魔法少女モードについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "魔法少女モード",
                            textBody1: "・通常時は6種類のモードが存在し、モードによって恩恵を得られる",
                            textBody2: "・AT当選までモードを維持（いろはモードのみAT非当選のボーナス終了時に移行抽選）",
                            textBody3: "・ステチェン時のアイキャッチでモードを示唆。キャラの持ち物が弱示唆で、キャラが強示唆となる",
                            textBody4: "・モンキーターンのライバルモードに近いシステムと思われる",
                            textBody5: "・スイカからのCZ当選については、さなモード滞在状態を意識しながらカウントするとベター",
                            tableView: AnyView(magiaTableMode())
                        )
                    )
                )
//                .popoverTip(tipVer271MagiaMagicGirlMode())
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(magiaView95Ci(magia: magia, selection: 1)))
//                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("スイカからのCZ当選")
            }
            
            // //// 魔法少女モードのカウント
            Section {
                Text("見抜けないことの方が多いと思いますが、メモ代わり程度でご使用ください")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                
                // //// 移行、昇格の選択
                Picker("", selection: self.$selectedSegment) {
                    ForEach(self.segmentList, id: \.self) { seg in
                        Text(seg)
                    }
                }
                .pickerStyle(.segmented)
                
                // //// カウントボタン
                // //// 横画面
                if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
                    // AT終了後の移行
                    if self.selectedSegment == self.segmentList[0] {
                        VStack {
                            HStack {
                                // いろは
                                unitCountButtonVerticalPercent(
                                    title: "いろは",
                                    count: $magia.mgmTransferCountIroha,
                                    color: .pink,
                                    bigNumber: $magia.mgmTransferCountSum,
                                    numberofDicimal: 1,
                                    minusBool: $magia.minusCheck
                                )
                                // やちよ
                                unitCountButtonVerticalPercent(
                                    title: "やちよ",
                                    count: $magia.mgmTransferCountYachiyo,
                                    color: .blue,
                                    bigNumber: $magia.mgmTransferCountSum,
                                    numberofDicimal: 1,
                                    minusBool: $magia.minusCheck
                                )
                                // 鶴乃
                                unitCountButtonVerticalPercent(
                                    title: "鶴乃",
                                    count: $magia.mgmTransferCountTsuruno,
                                    color: .yellow,
                                    bigNumber: $magia.mgmTransferCountSum,
                                    numberofDicimal: 1,
                                    minusBool: $magia.minusCheck
                                )
//                            }
//                            HStack {
                                // さな
                                unitCountButtonVerticalPercent(
                                    title: "さな",
                                    count: $magia.mgmTransferCountSana,
                                    color: .green,
                                    bigNumber: $magia.mgmTransferCountSum,
                                    numberofDicimal: 1,
                                    minusBool: $magia.minusCheck
                                )
                                // フェリシア
                                unitCountButtonVerticalPercent(
                                    title: "フェリシア",
                                    count: $magia.mgmTransferCountFerishia,
                                    color: .purple,
                                    bigNumber: $magia.mgmTransferCountSum,
                                    numberofDicimal: 1,
                                    minusBool: $magia.minusCheck
                                )
                                // 黒江
                                unitCountButtonVerticalPercent(
                                    title: "黒江",
                                    count: $magia.mgmTransferCountKuroe,
                                    color: .gray,
                                    bigNumber: $magia.mgmTransferCountSum,
                                    numberofDicimal: 1,
                                    minusBool: $magia.minusCheck
                                )
                            }
                        }
                    }
                    // いろはからの昇格
                    else {
                        VStack {
                            HStack {
                                // いろは
                                unitCountButtonVerticalPercent(
                                    title: "いろは",
                                    count: $magia.mgmRisingCountIroha,
                                    color: .personalSummerLightRed,
                                    bigNumber: $magia.mgmRisingCountSum,
                                    numberofDicimal: 1,
                                    minusBool: $magia.minusCheck
                                )
                                // やちよ
                                unitCountButtonVerticalPercent(
                                    title: "やちよ",
                                    count: $magia.mgmRisingCountYachiyo,
                                    color: .personalSummerLightBlue,
                                    bigNumber: $magia.mgmRisingCountSum,
                                    numberofDicimal: 1,
                                    minusBool: $magia.minusCheck
                                )
                                // 鶴乃
                                unitCountButtonVerticalPercent(
                                    title: "鶴乃",
                                    count: $magia.mgmRisingCountTsuruno,
                                    color: .personalSpringLightYellow,
                                    bigNumber: $magia.mgmRisingCountSum,
                                    numberofDicimal: 1,
                                    minusBool: $magia.minusCheck
                                )
//                            }
//                            HStack {
                                // さな
                                unitCountButtonVerticalPercent(
                                    title: "さな",
                                    count: $magia.mgmRisingCountSana,
                                    color: .personalSummerLightGreen,
                                    bigNumber: $magia.mgmRisingCountSum,
                                    numberofDicimal: 1,
                                    minusBool: $magia.minusCheck
                                )
                                // フェリシア
                                unitCountButtonVerticalPercent(
                                    title: "フェリシア",
                                    count: $magia.mgmRisingCountFerishia,
                                    color: .personalSummerLightPurple,
                                    bigNumber: $magia.mgmRisingCountSum,
                                    numberofDicimal: 1,
                                    minusBool: $magia.minusCheck
                                )
                                // 黒江
                                unitCountButtonVerticalPercent(
                                    title: "黒江",
                                    count: $magia.mgmRisingCountKuroe,
                                    color: .grayBack,
                                    bigNumber: $magia.mgmRisingCountSum,
                                    numberofDicimal: 1,
                                    minusBool: $magia.minusCheck
                                )
                            }
                        }
                    }
                }
                // //// 縦画面
                else {
                    // AT終了後の移行
                    if self.selectedSegment == self.segmentList[0] {
                        VStack {
                            HStack {
                                // いろは
                                unitCountButtonVerticalPercent(
                                    title: "いろは",
                                    count: $magia.mgmTransferCountIroha,
                                    color: .pink,
                                    bigNumber: $magia.mgmTransferCountSum,
                                    numberofDicimal: 1,
                                    minusBool: $magia.minusCheck
                                )
                                // やちよ
                                unitCountButtonVerticalPercent(
                                    title: "やちよ",
                                    count: $magia.mgmTransferCountYachiyo,
                                    color: .blue,
                                    bigNumber: $magia.mgmTransferCountSum,
                                    numberofDicimal: 1,
                                    minusBool: $magia.minusCheck
                                )
                                // 鶴乃
                                unitCountButtonVerticalPercent(
                                    title: "鶴乃",
                                    count: $magia.mgmTransferCountTsuruno,
                                    color: .yellow,
                                    bigNumber: $magia.mgmTransferCountSum,
                                    numberofDicimal: 1,
                                    minusBool: $magia.minusCheck
                                )
                            }
                            HStack {
                                // さな
                                unitCountButtonVerticalPercent(
                                    title: "さな",
                                    count: $magia.mgmTransferCountSana,
                                    color: .green,
                                    bigNumber: $magia.mgmTransferCountSum,
                                    numberofDicimal: 1,
                                    minusBool: $magia.minusCheck
                                )
                                // フェリシア
                                unitCountButtonVerticalPercent(
                                    title: "フェリシア",
                                    count: $magia.mgmTransferCountFerishia,
                                    color: .purple,
                                    bigNumber: $magia.mgmTransferCountSum,
                                    numberofDicimal: 1,
                                    minusBool: $magia.minusCheck
                                )
                                // 黒江
                                unitCountButtonVerticalPercent(
                                    title: "黒江",
                                    count: $magia.mgmTransferCountKuroe,
                                    color: .gray,
                                    bigNumber: $magia.mgmTransferCountSum,
                                    numberofDicimal: 1,
                                    minusBool: $magia.minusCheck
                                )
                            }
                        }
                    }
                    // いろはからの昇格
                    else {
                        VStack {
                            HStack {
                                // いろは
                                unitCountButtonVerticalPercent(
                                    title: "いろは",
                                    count: $magia.mgmRisingCountIroha,
                                    color: .personalSummerLightRed,
                                    bigNumber: $magia.mgmRisingCountSum,
                                    numberofDicimal: 1,
                                    minusBool: $magia.minusCheck
                                )
                                // やちよ
                                unitCountButtonVerticalPercent(
                                    title: "やちよ",
                                    count: $magia.mgmRisingCountYachiyo,
                                    color: .personalSummerLightBlue,
                                    bigNumber: $magia.mgmRisingCountSum,
                                    numberofDicimal: 1,
                                    minusBool: $magia.minusCheck
                                )
                                // 鶴乃
                                unitCountButtonVerticalPercent(
                                    title: "鶴乃",
                                    count: $magia.mgmRisingCountTsuruno,
                                    color: .personalSpringLightYellow,
                                    bigNumber: $magia.mgmRisingCountSum,
                                    numberofDicimal: 1,
                                    minusBool: $magia.minusCheck
                                )
                            }
                            HStack {
                                // さな
                                unitCountButtonVerticalPercent(
                                    title: "さな",
                                    count: $magia.mgmRisingCountSana,
                                    color: .personalSummerLightGreen,
                                    bigNumber: $magia.mgmRisingCountSum,
                                    numberofDicimal: 1,
                                    minusBool: $magia.minusCheck
                                )
                                // フェリシア
                                unitCountButtonVerticalPercent(
                                    title: "フェリシア",
                                    count: $magia.mgmRisingCountFerishia,
                                    color: .personalSummerLightPurple,
                                    bigNumber: $magia.mgmRisingCountSum,
                                    numberofDicimal: 1,
                                    minusBool: $magia.minusCheck
                                )
                                // 黒江
                                unitCountButtonVerticalPercent(
                                    title: "黒江",
                                    count: $magia.mgmRisingCountKuroe,
                                    color: .grayBack,
                                    bigNumber: $magia.mgmRisingCountSum,
                                    numberofDicimal: 1,
                                    minusBool: $magia.minusCheck
                                )
                            }
                        }
                    }
                }
                
                // //// 参考情報）魔法少女モードについて
                unitLinkButton(
                    title: "魔法少女モードについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "魔法少女モード",
                            textBody1: "・通常時は6種類のモードが存在し、モードによって恩恵を得られる",
                            textBody2: "・AT当選までモードを維持（いろはモードのみAT非当選のボーナス終了時に移行抽選）",
                            textBody3: "・ステチェン時のアイキャッチでモードを示唆。キャラの持ち物が弱示唆で、キャラが強示唆となる",
                            textBody4: "・モンキーターンのライバルモードに近いシステムと思われる",
                            textBody5: "・スイカからのCZ当選については、さなモード滞在状態を意識しながらカウントするとベター",
                            tableView: AnyView(magiaTableMode())
                        )
                    )
                )
                
                // //// 参考情報）魔法少女モード抽選確率
                unitLinkButton(
                    title: "魔法少女モード抽選確率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "魔法少女モード抽選確率",
                            textBody1: "・AT終了後にモード移行抽選",
                            textBody2: "・いろはモード滞在時のみAT非当選のボーナス終了時に昇格抽選あり",
                            tableView: AnyView(magiaTableMagicGirlMode(magia: magia))
                        )
                    )
                )
            } header: {
                Text("魔法少女モード")
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "マギアレコード",
                screenClass: screenClass
            )
        }
//        .onAppear {
//            if ver310.magiaMenuNormalBadgeStatus != "none" {
//                ver310.magiaMenuNormalBadgeStatus = "none"
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
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $magia.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: magia.resetNormal)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    magiaViewNormal(
//        ver310: Ver310(),
        magia: Magia()
    )
}
