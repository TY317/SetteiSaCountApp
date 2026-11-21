//
//  seiyaViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct seiyaViewNormal: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var seiya: Seiya
    @State var isShowDestination: Bool = false
    @State var isShowAlert: Bool = false
    @FocusState var isFocused: Bool
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
            // ---- 規定周期到達時のAT直撃
            Section {
                // AT直撃率
                unitResultRatioPercent2Line(
                    title: "AT直撃率",
                    count: $seiya.cycleAtCountHit,
                    bigNumber: $seiya.cycleAtCountCycle,
                    numberofDicimal: 0
                )
                .popoverTip(tipVer4120SeiyaCycleAt())

                // 参考情報）規定周期到達時のAT直撃
                unitLinkButtonViewBuilder(sheetTitle: "規定周期到達時のAT直撃") {
                    VStack(alignment: .leading) {
//                        Text("・一輝の加護以外のときに、規定周期到達時のCZがATへ書き換わる割合")
                        Text("・一輝の加護中はこの抽選を経ずにAT直撃となる")
                    }
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "AT直撃",
                            percentList: seiya.ratioCycleAt,
                            numberofDicimal: 1,
                        )
                    }
                }

                // カウント
                DisclosureGroup {
                    // 注意書き
                    unitLabelCautionText {
                        Text("・規定周期に到達するたびに「周期到達」を、そこでATに直撃したら「AT直撃」も押してください\n・一輝の加護中は除外してください")
                    }
                    // カウントボタン横並び
                    HStack {
                        // 周期到達
                        unitCountButtonWithoutRatioWithFunc(
                            title: "周期到達",
                            count: $seiya.cycleAtCountCycle,
                            color: .personalSummerLightBlue,
                            minusBool: $seiya.minusCheck) {
                            }
                        // AT直撃
                        unitCountButtonWithoutRatioWithFunc(
                            title: "AT直撃",
                            count: $seiya.cycleAtCountHit,
                            color: .personalSummerLightRed,
                            minusBool: $seiya.minusCheck) {
                            }
                    }

                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(
                        Ci95view: AnyView(
                            seiyaView95Ci(
                                seiya: seiya,
                                selection: 4,
                            )
                        )
                    )

                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        seiyaViewBayes(
                            seiya: seiya,
                        )
                    }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("規定周期到達時のAT直撃")
            }

            // レア役
            Section {
                // レア役停止系
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止系") {
                    seiyaTableKoyakuPattern()
                }
            } header: {
                Text("小役")
            }

            // ---- 守護星座
            Section {
                // 参考情報）守護星座の加護一覧
                unitLinkButtonViewBuilder(sheetTitle: "守護星座の加護一覧") {
                    VStack {
                        VStack(alignment: .leading) {
                            Text("・WHO ARE YOU？（CZ）当選まで維持される特殊なモード")
                            Text("・守護星座の種類に応じて展開を有利に進められる")
                            Text("・AT中にも存在し、Vゲットチャレンジまで継続する")
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        HStack(spacing: 0) {
                            unitTableString(
                                columTitle: "守護星座",
                                stringList: ["星矢", "氷河", "瞬", "紫龍", "一輝"],
                                maxWidth: 70,
                                lineList: [2,2,3,3,3],
                                titleFont: .subheadline,
                            )
                            unitTableString(
                                columTitle: "示唆",
                                stringList: [
                                    "通常時・AT中共通\n周期到達ごとに規定周期短縮を抽選",
                                    "通常時・AT中共通\n小宇宙目停止時の獲得ポイント優遇",
                                    "通常時：弱🍒・小宇宙目からの\n高確移行率が優遇\nAT中：常に高確以上（夕方ステージ以上）濃厚",
                                    "通常時：🍉時のヒロインチャージや\n強CZ抽選が優遇\nAT中：🍉時のVストックチャレンジ当選率が優遇",
                                    "通常時：規定周期で当選するCZがATに変化\nAT中：規定周期で\n鳳凰Vゲットチャレンジを獲得",
                                ],
                                maxWidth: 300,
                                lineList: [2,2,3,3,3],
                                contentFont: .subheadline,
                            )
                        }
                    }
                }

                // 参考情報）設定変更時の振分け
                unitLinkButtonViewBuilder(sheetTitle: "設定変更時の振分け") {
                    VStack(spacing: 20) {
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTablePercentVer2(
                                columTitle: "加護なし",
                                percentList: [60.9,57.8,54.3,49.2],
                                numberofDicimal: 0,
                                lineList: [1,1,1,3],
                            )
                            unitTablePercentVer2(
                                columTitle: "星矢",
                                percentList: [5.9,6.3,7.8],
                                numberofDicimal: 1,
                                lineList: [1,1,4],
                            )
                            unitTablePercentVer2(
                                columTitle: "氷河",
                                percentList: [14.8],
                                numberofDicimal: 0,
                                lineList: [6],
                            )
                        }
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTablePercentVer2(
                                columTitle: "瞬",
                                percentList: [11.7],
                                numberofDicimal: 0,
                                lineList: [6],
                            )
                            unitTablePercentVer2(
                                columTitle: "紫龍",
                                percentList: [3.5,5.1,6.3,10.2],
                                numberofDicimal: 1,
                                lineList: [1,1,1,3],
                            )
                            unitTablePercentVer2(
                                columTitle: "一輝",
                                percentList: [3.1,4.3,5.1,6.3],
                                numberofDicimal: 1,
                                lineList: [1,1,1,3],
                            )
                        }
                    }
                }
                .popoverTip(tipVer4120SeiyaShugoSeiza())
            } header: {
                Text("守護星座の加護")
            }

            // ---- カード演出
            Section {
                // 参考情報）設定示唆となる星座
                unitLinkButtonViewBuilder(sheetTitle: "設定示唆となる星座") {
                    HStack(spacing: 0) {
                        unitTableString(
                            columTitle: "星座",
                            stringList: ["ハリセンボン座", "サメ座", "エビ座", "アンコウ座"],
                            maxWidth: 130,
                        )
                        unitTableString(
                            columTitle: "示唆",
                            stringList: ["設定2以上濃厚", "設定4以上濃厚", "設定5以上濃厚", "設定6濃厚"],
//                            contentTextColorList: [.black, .blue, .red, .purple],
                        )
                    }
                }

                // 参考情報）その他の演出
                unitLinkButtonViewBuilder(sheetTitle: "その他の演出") {
                    HStack(spacing: 0) {
                        unitTableString(
                            columTitle: "",
                            stringList: [
                                "ブランク",
                                "星矢",
                                "氷河",
                                "紫龍",
                                "瞬",
                                "一輝",
                                "魔鈴",
                                "シャイナ",
                                "CHANCE",
                                "激熱",
                                "シャカ",
                                "ジェミニ",
                                "サガ",
                                "火時計［小］",
                                "火時計［大］",
                                "発展",
                                "聖域",
                                "HC",
                            ],
                            maxWidth: 100,
                            lineList: [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
                        )
                        unitTableString(
                            columTitle: "示唆",
                            stringList: [
                                "ハズレ",
                                "ハズレ時は星矢の加護中の期待度アップ",
                                "ハズレ時は氷河の加護中の期待度アップ",
                                "ハズレ時は紫龍の加護中の期待度アップ",
                                "ハズレ時は瞬の加護中の期待度アップ",
                                "ハズレ時は一輝の加護中の期待度アップ",
                                "前兆示唆",
                                "前兆かつチャンス",
                                "AT本前兆濃厚",
                                "小宇宙目成立",
                                "小宇宙目成立かつチャンス",
                                "連続演出発展",
                                "聖域ステージ移行",
                                "ヒロインチャージ告知",
                            ],
                            maxWidth: 250,
                            lineList: [1,1,1,1,1,1,1,2,4,1,1,1,1,1],
                        )
                    }
                }
            } header: {
                Text("カード演出")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.seiyaMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: seiya.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
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
                unitButtonMinusCheck(minusCheck: $seiya.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: seiya.resetNormal)
            }
        }
    }
}

#Preview {
    seiyaViewNormal(
        seiya: Seiya(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
