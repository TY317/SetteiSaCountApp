//
//  kaguyaViewReg.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/10/13.
//

import SwiftUI
import TipKit

// //////////////////
// Tip：初当たりカウントの説明
// //////////////////
struct kaguyaTipRegCharaSelect: Tip {
    var title: Text {
        Text("キャラ選択")
    }
    var message: Text? {
        Text("2人目まででシナリオ確定できます。\n紹介されたキャラを選択した状態で登録するとカウントできます。")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

struct kaguyaViewReg: View {
    @ObservedObject var ver390: Ver390
//    @ObservedObject var kaguya = KaguyaSama()
    @ObservedObject var kaguya: KaguyaSama
    @State var isShowAlert = false
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let spaceHeightPortrait = 250.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 250.0
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    
    var body: some View {
        List {
            Section {
                // //// サークルピッカー横並び
                HStack {
                    // 1人目
                    unitPickerCircleString(title: "1人目", selected: $kaguya.regCharaSelectedFirst, selectList: kaguya.regCharaSelectListFirst)
                    // 2人目
                    // 1人目白銀の時の2人目
                    if kaguya.regCharaSelectedFirst == "白銀" {
                        unitPickerCircleString(title: "2人目", selected: $kaguya.regCharaSelectedSecondAfterShirogane, selectList: kaguya.regCharaSelectListSecondAfterShirogane)
                    }
                    // 1人目虹背景時の2人目
                    else if kaguya.regCharaSelectedFirst == "かぐや(虹背景)" {
                        unitPickerCircleString(title: "2人目", selected: $kaguya.regCharaSelectedSecondAfterRainbow, selectList: kaguya.regCharaSelectListSecondAfterRainbow)
                    }
                    // 1人目かぐやの時の2人目
                    else {
                        unitPickerCircleString(title: "2人目", selected: $kaguya.regCharaSelectedSecondAfterKaguya, selectList: kaguya.regCharaSelectListSecondAfterKaguya)
                    }
                }
                .popoverTip(kaguyaTipRegCharaSelect())
                // //// 選択されているシナリオのカウント表示
                // 1人目が白銀
                if kaguya.regCharaSelectedFirst == "白銀" {
                    // 2人目がベツィー
                    if kaguya.regCharaSelectedSecondAfterShirogane == "ベツィー" {
                        unitResultCountListPercent(title: "通常A否定", count: $kaguya.regCharaCountBezi, flashColor: .orange, bigNumber: $kaguya.regCharaCountSum)
                    }
                    // 2人目が圭
                    else if kaguya.regCharaSelectedSecondAfterShirogane == "白銀圭" {
                        unitResultCountListPercent(title: "高設定示唆 弱", count: $kaguya.regCharaCountKei, flashColor: .blue, bigNumber: $kaguya.regCharaCountSum)
                    }
                    // 2人目がかぐや
                    else {
                        unitResultCountListPercent(title: "デフォルト", count: $kaguya.regCharaCountDefault, flashColor: .gray, bigNumber: $kaguya.regCharaCountSum)
                    }
                }
                // 1人目が虹背景
                else if kaguya.regCharaSelectedFirst == "かぐや(虹背景)" {
                    unitResultCountListPercent(title: "設定4以上＋1G連", count: $kaguya.regCharaCountRainbow, flashColor: .purple, bigNumber: $kaguya.regCharaCountSum)
                }
                // 1人目がかぐや
                else {
                    // // 2人目が白銀パパ
                    if kaguya.regCharaSelectedSecondAfterKaguya == "白銀パパ" {
                        unitResultCountListPercent(title: "設定4以上濃厚", count: $kaguya.regCharaCountPapa, flashColor: .red, bigNumber: $kaguya.regCharaCountSum)
                    }
                    // 2人目が藤原
                    else if kaguya.regCharaSelectedSecondAfterKaguya == "藤原" {
                        unitResultCountListPercent(title: "設定2以上濃厚", count: $kaguya.regCharaCountHayasaka, flashColor: .green, bigNumber: $kaguya.regCharaCountSum)
                    }
                    // 2人目が大仏
                    else if kaguya.regCharaSelectedSecondAfterKaguya == "大仏" {
                        unitResultCountListPercent(title: "上位モード示唆", count: $kaguya.regCharaCountOsaragi, flashColor: .yellow, bigNumber: $kaguya.regCharaCountSum)
                    }
                    // 2人目が白銀
                    else {
                        unitResultCountListPercent(title: "デフォルト", count: $kaguya.regCharaCountDefault, flashColor: .gray, bigNumber: $kaguya.regCharaCountSum)
                    }
                }
                // //// 登録ボタン
                Button {
                    // 1人目が白銀
                    if kaguya.regCharaSelectedFirst == "白銀" {
                        // 2人目がベツィー
                        if kaguya.regCharaSelectedSecondAfterShirogane == "ベツィー" {
                            kaguya.regCharaCountBezi = countUpDown(minusCheck: kaguya.minusCheck, count: kaguya.regCharaCountBezi)
                        }
                        // 2人目が圭
                        else if kaguya.regCharaSelectedSecondAfterShirogane == "白銀圭" {
                            kaguya.regCharaCountKei = countUpDown(minusCheck: kaguya.minusCheck, count: kaguya.regCharaCountKei)
                        }
                        // 2人目がかぐや
                        else {
                            kaguya.regCharaCountDefault = countUpDown(minusCheck: kaguya.minusCheck, count: kaguya.regCharaCountDefault)
                        }
                    }
                    // 1人目が虹背景
                    else if kaguya.regCharaSelectedFirst == "かぐや(虹背景)" {
                        kaguya.regCharaCountRainbow = countUpDown(minusCheck: kaguya.minusCheck, count: kaguya.regCharaCountRainbow)
                    }
                    // 1人目がかぐや
                    else {
                        // // 2人目が白銀パパ
                        if kaguya.regCharaSelectedSecondAfterKaguya == "白銀パパ" {
                            kaguya.regCharaCountPapa = countUpDown(minusCheck: kaguya.minusCheck, count: kaguya.regCharaCountPapa)
                        }
                        // 2人目が藤原
                        else if kaguya.regCharaSelectedSecondAfterKaguya == "藤原" {
                            kaguya.regCharaCountHayasaka = countUpDown(minusCheck: kaguya.minusCheck, count: kaguya.regCharaCountHayasaka)
                        }
                        // 2人目が大仏
                        else if kaguya.regCharaSelectedSecondAfterKaguya == "大仏" {
                            kaguya.regCharaCountOsaragi = countUpDown(minusCheck: kaguya.minusCheck, count: kaguya.regCharaCountOsaragi)
                        }
                        // 2人目が白銀
                        else {
                            kaguya.regCharaCountDefault = countUpDown(minusCheck: kaguya.minusCheck, count: kaguya.regCharaCountDefault)
                        }
                    }
                } label: {
                    HStack {
                        Spacer()
                        if kaguya.minusCheck == false {
                            Text("登録")
                                .fontWeight(.bold)
//                                .foregroundColor(Color.blue)
                                .foregroundStyle(Color.blue)
                        } else {
                            Text("マイナス")
                                .fontWeight(.bold)
//                                .foregroundColor(Color.red)
                                .foregroundStyle(Color.red)
                        }
                        Spacer()
                    }
                }

            } header: {
                Text("紹介キャラ選択")
            }
            // //// カウント結果表示
            Section {
                // デフォルト
                unitResultCountListPercent(title: "デフォルト", count: $kaguya.regCharaCountDefault, flashColor: .gray, bigNumber: $kaguya.regCharaCountSum)
                // 白銀圭
                unitResultCountListPercent(title: "高設定示唆 弱", count: $kaguya.regCharaCountKei, flashColor: .blue, bigNumber: $kaguya.regCharaCountSum)
                // 早坂
                unitResultCountListPercent(title: "設定2以上濃厚", count: $kaguya.regCharaCountHayasaka, flashColor: .green, bigNumber: $kaguya.regCharaCountSum)
                // 白銀パパ
                unitResultCountListPercent(title: "設定4以上濃厚", count: $kaguya.regCharaCountPapa, flashColor: .red, bigNumber: $kaguya.regCharaCountSum)
                // 虹背景
                unitResultCountListPercent(title: "設定4以上＋1G連", count: $kaguya.regCharaCountRainbow, flashColor: .purple, bigNumber: $kaguya.regCharaCountSum)
                // 大仏
                unitResultCountListPercent(title: "上位モード示唆", count: $kaguya.regCharaCountOsaragi, flashColor: .yellow, bigNumber: $kaguya.regCharaCountSum)
                // べツィー
                unitResultCountListPercent(title: "通常A否定", count: $kaguya.regCharaCountBezi, flashColor: .orange, bigNumber: $kaguya.regCharaCountSum)
                // 参考情報リンク
                unitLinkButton(title: "キャラ紹介シナリオの振分けについて", exview: AnyView(unitExView5body2image(title: "キャラ紹介シナリオ振分け", textBody1: "・紹介されるキャラと順番はシナリオで管理されている", textBody2: "・大仏、べツィーは設定差はなくボーナス後のモード示唆", image1: Image("kaguyaRegCharaRatio"), image2: Image("kaguyaRegCharaPattern"))))
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(Ci95view: AnyView(kaguyaView95Ci(kaguya: kaguya, selection: 1)))
//                    .popoverTip(tipUnitButtonLink95Ci())
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    kaguyaViewBayes(
                        ver390: ver390,
                        kaguya: kaguya,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("カウント結果")
            }
            // //// 空スペース
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "かぐや様は告らせたい",
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
                self.spaceHeight = self.spaceHeightLandscape
            } else {
                self.spaceHeight = self.spaceHeight
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
                    self.spaceHeight = self.spaceHeightLandscape
                } else {
                    self.spaceHeight = self.spaceHeightPortrait
                }
            }
        }
        .onDisappear {
            // ビューが非表示になるときに監視を解除
            NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
        }
        .navigationTitle("REG中のキャラ紹介")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    unitButtonMinusCheck(minusCheck: $kaguya.minusCheck)
                    unitButtonReset(isShowAlert: $isShowAlert, action: kaguya.resetRegChara)
//                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    kaguyaViewReg(
        ver390: Ver390(),
        kaguya: KaguyaSama(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
