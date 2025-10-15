//
//  starHanaVer2ViewJissenCount.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/15.
//

import SwiftUI

struct starHanaVer2ViewJissenCount: View {
//    @ObservedObject var ver391: Ver391
    @ObservedObject var starHana: StarHana
    let displayMode = ["通常時", "BIG", "REG"]     // 機種リストの表示モード選択肢
    @State var isSelectedDisplayMode = "通常時"
    @FocusState var isFocused: Bool
    @State var isShowAlert = false
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 250.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 250.0
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    
    var body: some View {
        ZStack {
            List {
                // //////////////////////
                // 通常時
                // //////////////////////
                if isSelectedDisplayMode == "通常時" {
                    // //// 横画面
                    if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
                        HStack {
                            // ベル　カウントボタン
                            unitCountButtonVerticalDenominate(title: "ベル", count: $starHana.bellCount, color: Color("personalSpringLightYellow"), bigNumber: $starHana.playGames, numberofDicimal: 2, minusBool: $starHana.minusCheck, flushColor: Color.yellow)
                            // ビッグ　カウントボタン
                            unitCountButtonVerticalDenominate(title: "BIG", count: $starHana.bigCount, color: Color("personalSummerLightRed"), bigNumber: $starHana.playGames, numberofDicimal: 0, minusBool: $starHana.minusCheck)
                            // レギュラー　カウントボタン
                            unitCountButtonVerticalDenominate(title: "REG", count: $starHana.regCount, color: Color("personalSummerLightPurple"), bigNumber: $starHana.playGames, numberofDicimal: 0, minusBool: $starHana.minusCheck)
                            // ボーナス合算確率
                            unitResultRatioDenomination2Line(title: "ボーナス合算", color: Color("grayBack"), count: $starHana.totalBonus, bigNumber: $starHana.playGames, numberofDicimal: 0)
                                .padding(.vertical)
                        }
                    }
                    
                    // //// 縦画面
                    else {
                        HStack {
                            // ベル　カウントボタン
                            unitCountButtonVerticalDenominate(title: "ベル", count: $starHana.bellCount, color: Color("personalSpringLightYellow"), bigNumber: $starHana.playGames, numberofDicimal: 2, minusBool: $starHana.minusCheck, flushColor: Color.yellow)
                            // ビッグ　カウントボタン
                            unitCountButtonVerticalDenominate(title: "BIG", count: $starHana.bigCount, color: Color("personalSummerLightRed"), bigNumber: $starHana.playGames, numberofDicimal: 0, minusBool: $starHana.minusCheck)
                            // レギュラー　カウントボタン
                            unitCountButtonVerticalDenominate(title: "REG", count: $starHana.regCount, color: Color("personalSummerLightPurple"), bigNumber: $starHana.playGames, numberofDicimal: 0, minusBool: $starHana.minusCheck)
                        }
                        // ボーナス合算確率
                        unitResultRatioDenomination2Line(title: "ボーナス合算", color: Color("grayBack"), count: $starHana.totalBonus, bigNumber: $starHana.playGames, numberofDicimal: 0)
                    }
                    // //// 参考情報リンク
                    unitLinkButton(
                        title: "ベル,ボーナス確率",
                        exview: AnyView(
                            unitExView5body2image(
                                title: "ベル・ボーナス確率",
                                tableView: AnyView(starHanaTableBellBonus(starHana: starHana))
//                                image1: Image("starHanaBellBonusAnalysis")
                            )
                        )
                    )
                    // 95%信頼区間グラフ
                    unitNaviLink95Ci(Ci95view: AnyView(starHanaVer2View95CiPersonal(starHana: starHana, selection: 1)))
                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        starHanaViewBayes(
//                            ver391: ver391,
                            starHana: starHana,
                            bayes: bayes,
                            viewModel: viewModel,
                        )
                    }
                    // //// 縦横共通 参考情報、ゲーム数入力
                    Section {
                        // 打ち始め
                        HStack {
                            Text("打ち始め")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("\(starHana.startGameInput)")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .foregroundStyle(Color.secondary)
                        }
                        // 現在ゲーム数入力
                        unitTextFieldGamesInput(title: "現在", inputValue: $starHana.currentGames)
                            .focused($isFocused)
                            .toolbar {
                                ToolbarItem(placement: .keyboard) {
                                    HStack {
                                        Spacer()
                                        Button(action: {
                                            isFocused = false
                                        }, label: {
                                            Text("完了")
                                                .fontWeight(.bold)
                                        })
                                    }
                                }
                            }
                        // 消化ゲーム数
                        HStack {
                            Text("消化ゲーム数")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("\(starHana.playGames)")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .foregroundStyle(Color.secondary)
                        }
                    } header: {
                        Text("ゲーム数入力")
                    }
                    unitClearScrollSectionBinding(spaceHeight: $spaceHeight)
                }
                
                // //////////////////////
                // ビッグ
                // //////////////////////
                else if isSelectedDisplayMode == displayMode[1] {
                    // //// 横画面
                    if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
                        Section {
                            HStack {
                                // スイカカウントボタン
                                unitCountButtonVerticalDenominate(title: "スイカ", count: $starHana.bbSuikaCount, color: .green, bigNumber: $starHana.bigPlayGames, numberofDicimal: 1, minusBool: $starHana.minusCheck)
                                // 青
                                unitCountButtonVerticalPercent(title: "🪽青", count: $starHana.bbLampBCount, color: .personalSummerLightBlue, bigNumber: $starHana.bigCount, numberofDicimal: 1, minusBool: $starHana.minusCheck)
                                // 黄
                                unitCountButtonVerticalPercent(title: "🪽黄", count: $starHana.bbLampYCount, color: .personalSpringLightYellow, bigNumber: $starHana.bigCount, numberofDicimal: 1, minusBool: $starHana.minusCheck, flushColor: Color.yellow)
                                // 緑
                                unitCountButtonVerticalPercent(title: "🪽緑", count: $starHana.bbLampGCount, color: .personalSummerLightGreen, bigNumber: $starHana.bigCount, numberofDicimal: 1, minusBool: $starHana.minusCheck)
                                // 赤
                                unitCountButtonVerticalPercent(title: "🪽赤", count: $starHana.bbLampRCount, color: .personalSummerLightRed, bigNumber: $starHana.bigCount, numberofDicimal: 1, minusBool: $starHana.minusCheck)
                            }
                            // //// ランプ合算確率
                            unitResultRatioPercent2Line(title: "ランプ合算", color: Color("grayBack"), count: $starHana.bbLampCountSum, bigNumber: $starHana.bigCount, numberofDicimal: 1)
                            // スイカ確率の情報リンク
                            unitLinkButton(
                                title: "BB中のスイカについて",
                                exview: AnyView(
                                    unitExView5body2image(
                                        title: "BIG中スイカ確率",
                                        tableView: AnyView(hanahanaCommonTableBigSuika())
//                                        image1Title: "[参考] 過去のハナハナシリーズ数値",
//                                        image1:Image("hanaCommonBbSuika")
                                    )
                                )
                            )
                            // 参考情報リンク
                            unitLinkButton(
                                title: "BIG後のフェザーランプについて",
                                exview: AnyView(
                                    unitExView5body2image(
                                        title: "BIG後のフェザーランプ確率",
                                        tableView: AnyView(hanahanaCommonTableBigLamp())
//                                        image1Title: "[参考] 過去のハナハナシリーズ数値",
//                                        image1:Image("hanaCommonBbLamp")
                                    )
                                )
                            )
                            // 95%信頼区間グラフ
                            unitNaviLink95Ci(Ci95view: AnyView(starHanaVer2View95CiPersonal(starHana: starHana, selection: 5)))
                            // //// 設定期待値へのリンク
                            unitNaviLinkBayes {
                                starHanaViewBayes(
//                                    ver391: ver391,
                                    starHana: starHana,
                                    bayes: bayes,
                                    viewModel: viewModel,
                                )
                            }
                        } header: {
                            Text("\nスイカ、フェザーランプ")
                        }
                    }
                    
                    // //// 縦画面
                    else {
                        // //// スイカ関連
                        Section{
                            // スイカカウントボタン
                            unitCountButtonVerticalDenominate(title: "スイカ", count: $starHana.bbSuikaCount, color: .green, bigNumber: $starHana.bigPlayGames, numberofDicimal: 1, minusBool: $starHana.minusCheck)
                            // スイカ確率の情報リンク
                            unitLinkButton(
                                title: "BB中のスイカについて",
                                exview: AnyView(
                                    unitExView5body2image(
                                        title: "BIG中スイカ確率",
                                        tableView: AnyView(hanahanaCommonTableBigSuika())
//                                        image1Title: "[参考] 過去のハナハナシリーズ数値",
//                                        image1:Image("hanaCommonBbSuika")
                                    )
                                )
                            )
                            // 95%信頼区間グラフ
                            unitNaviLink95Ci(Ci95view: AnyView(starHanaVer2View95CiPersonal(starHana: starHana, selection: 5)))
                            // //// 設定期待値へのリンク
                            unitNaviLinkBayes {
                                starHanaViewBayes(
//                                    ver391: ver391,
                                    starHana: starHana,
                                    bayes: bayes,
                                    viewModel: viewModel,
                                )
                            }
                        } header: {
                            Text("\nスイカ")
                        }
                        
                        // //// フェザーランプ関連
                        Section("フェザーランプ") {
                            // カウントボタン横並び
                            HStack {
                                // 青
                                unitCountButtonVerticalPercent(title: "🪽青", count: $starHana.bbLampBCount, color: .personalSummerLightBlue, bigNumber: $starHana.bigCount, numberofDicimal: 1, minusBool: $starHana.minusCheck)
                                // 黄
                                unitCountButtonVerticalPercent(title: "🪽黄", count: $starHana.bbLampYCount, color: .personalSpringLightYellow, bigNumber: $starHana.bigCount, numberofDicimal: 1, minusBool: $starHana.minusCheck, flushColor: Color.yellow)
                                // 緑
                                unitCountButtonVerticalPercent(title: "🪽緑", count: $starHana.bbLampGCount, color: .personalSummerLightGreen, bigNumber: $starHana.bigCount, numberofDicimal: 1, minusBool: $starHana.minusCheck)
                                // 赤
                                unitCountButtonVerticalPercent(title: "🪽赤", count: $starHana.bbLampRCount, color: .personalSummerLightRed, bigNumber: $starHana.bigCount, numberofDicimal: 1, minusBool: $starHana.minusCheck)
                            }
                            // //// ランプ合算確率
                            unitResultRatioPercent2Line(title: "ランプ合算", color: Color("grayBack"), count: $starHana.bbLampCountSum, bigNumber: $starHana.bigCount, numberofDicimal: 1)
                            // 参考情報リンク
                            unitLinkButton(
                                title: "BIG後のフェザーランプについて",
                                exview: AnyView(
                                    unitExView5body2image(
                                        title: "BIG後のフェザーランプ確率",
                                        tableView: AnyView(hanahanaCommonTableBigLamp())
//                                        image1Title: "[参考] 過去のハナハナシリーズ数値",
//                                        image1:Image("hanaCommonBbLamp")
                                    )
                                )
                            )
                            // 95%信頼区間グラフ
                            unitNaviLink95Ci(Ci95view: AnyView(starHanaVer2View95CiPersonal(starHana: starHana, selection: 6)))
                            // //// 設定期待値へのリンク
                            unitNaviLinkBayes {
                                starHanaViewBayes(
//                                    ver391: ver391,
                                    starHana: starHana,
                                    bayes: bayes,
                                    viewModel: viewModel,
                                )
                            }
                        }
                    }
                    unitClearScrollSectionBinding(spaceHeight: $spaceHeight)
                }
                
                // //////////////////////
                // レギュラー
                // //////////////////////
                else {
                    // //// サイドランプ関連
                    Section {
                        // カウントボタン横並び
                        HStack {
                            // 青
                            unitCountButtonVerticalPercent(title: "ランプ青", count: $starHana.rbLampBCount, color: .personalSummerLightBlue, bigNumber: $starHana.rbLampCountSum, numberofDicimal: 0, minusBool: $starHana.minusCheck)
                            // 黄
                            unitCountButtonVerticalPercent(title: "ランプ黄", count: $starHana.rbLampYCount, color: .personalSpringLightYellow, bigNumber: $starHana.rbLampCountSum, numberofDicimal: 0, minusBool: $starHana.minusCheck, flushColor: Color.yellow)
                            // 緑
                            unitCountButtonVerticalPercent(title: "ランプ緑", count: $starHana.rbLampGCount, color: .personalSummerLightGreen, bigNumber: $starHana.rbLampCountSum, numberofDicimal: 0, minusBool: $starHana.minusCheck)
                            // 赤
                            unitCountButtonVerticalPercent(title: "ランプ赤", count: $starHana.rbLampRCount, color: .personalSummerLightRed, bigNumber: $starHana.rbLampCountSum, numberofDicimal: 0, minusBool: $starHana.minusCheck)
                        }
                        // //// 奇数・偶数確率表示
                        HStack {
                            // 奇数示唆
                            unitResultRatioPercent2Line(title: "奇数示唆", color: .grayBack, count: $starHana.rbLampKisuCountSum, bigNumber: $starHana.rbLampCountSum, numberofDicimal: 0)
                            // 偶数示唆
                            unitResultRatioPercent2Line(title: "偶数示唆", color: .grayBack, count: $starHana.rbLampGusuCountSum, bigNumber: $starHana.rbLampCountSum, numberofDicimal: 0)
                        }
                        // サイドランプの参考情報リンク
                        unitLinkButton(
                            title: "REG中のサイドランプについて",
                            exview: AnyView(
                                unitExView5body2image(
                                    title: "REG中のサイドランプ確率",
                                    textBody1: "・REG中に1回だけ確認可能",
                                    textBody2: "・左リール中段に白７ビタ押し",
                                    textBody3: "　成功したら中・右にスイカを狙う",
                                    textBody4: "・奇数設定は青・緑が６割、偶数は黄・赤が６割。\n　ただし、設定６のみ全色均等に出現する",
                                    tableView: AnyView(hanahanaCommonTableRegSideLamp())
//                                    image1Title: "[参考] 過去のハナハナシリーズ数値",
//                                    image1: Image("hanaCommonRbSideLamp")
                                )
                            )
                        )
                        // フェザーランプの参考情報リンク
                        unitLinkButton(
                            title: "REG後のフェザーランプについて",
                            exview: AnyView(
                                unitExView5body2image(
                                    title: "REG後のフェザーランプ確率",
                                    textBody1: "・色によって設定を否定",
                                    tableView: AnyView(hanahanaCommonTableRegTopLamp())
//                                    image1Title: "[参考] 過去のハナハナシリーズ数値",
//                                    image1: Image("hanaCommonRbTopLamp")
                                )
                            )
                        )
                        // 95%信頼区間グラフ
                        unitNaviLink95Ci(Ci95view: AnyView(starHanaVer2View95CiPersonal(starHana: starHana, selection: 7)))
                        // //// 設定期待値へのリンク
                        unitNaviLinkBayes {
                            starHanaViewBayes(
//                                ver391: ver391,
                                starHana: starHana,
                                bayes: bayes,
                                viewModel: viewModel,
                            )
                        }
                    } header: {
                        Text("\nサイドランプ")
                    }
                    unitClearScrollSectionBinding(spaceHeight: $spaceHeight)
                }
            }
            
            // //////////////////////
            // //// モード選択
            // //////////////////////
            VStack {
                Picker("", selection: $isSelectedDisplayMode) {
                    ForEach(displayMode, id: \.self) { mode in
                        Text(mode)
                    }
                }
                .background(Color(UIColor.systemGroupedBackground))
                .pickerStyle(.segmented)
                Spacer()
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "スターハナハナ",
                screenClass: screenClass
            )
        }
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
        .navigationTitle("実戦カウント")
        .navigationBarTitleDisplayMode(.inline)
        
        // //// ツールバーボタン
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // カウント入力
                    unitButtonCountNumberInput(
                        inputView: AnyView(
                            starHanaSubViewCountInput(
                                starHana: starHana
                            )
                        )
                    )
                    .popoverTip(tipUnitJugHanaCommonCountInput())
                    // マイナスボタン
                    unitButtonMinusCheck(minusCheck: $starHana.minusCheck)
                    // データリセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: starHana.hanaReset)
//                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    starHanaVer2ViewJissenCount(
//        ver391: Ver391(),
        starHana: StarHana(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
