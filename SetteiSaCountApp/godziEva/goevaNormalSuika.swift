//
//  goevaNormalSuika.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/27.
//

import SwiftUI

struct goevaNormalSuika: View {
//    @ObservedObject var goeva = Goeva()
    @ObservedObject var goeva: Goeva
    @State var isShowAlert = false
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    
    var body: some View {
//        NavigationView {
            List {
                Section {
                    // //// スイカとCZのカウント
                    HStack {
                        // スイカのカウント
                        unitCountButtonVerticalWithoutRatio(title: "スイカ", count: $goeva.normalSuikaCount, color: .personalSummerLightGreen, minusBool: $goeva.minusCheck)
                        // CZのカウント
                        unitCountButtonVerticalWithoutRatio(title: "CZ", count: $goeva.normalCzCount, color: .personalSummerLightRed, minusBool: $goeva.minusCheck)
                        // CZ当選率
                        unitResultRatioPercent2Line(title: "CZ当選率", color: .grayBack, count: $goeva.normalCzCount, bigNumber: $goeva.normalSuikaCount, numberofDicimal: 0)
                            .padding(.vertical)
                    }
                    // 参考情報：スイカからのCZ当選率
                    unitLinkButton(title: "スイカからのCZ当選について", exview: AnyView(goevaExViewNormalSuika()))
                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(Ci95view: AnyView(goevaView95Ci(goeva: goeva, selection: 1)))
//                        .popoverTip(tipUnitButtonLink95Ci())
                } header: {
                    Text("スイカ回数、CZ アスカvsレイ回数")
                }
                
                // //// 変異
                Section {
                    HStack {
                        // 小役変異
                        unitCountButtonVerticalPercent(title: "小役変異", count: $goeva.normalHenniKoyakuCount, color: .personalSummerLightBlue, bigNumber: $goeva.normalHenniCountSum, numberofDicimal: 1, minusBool: $goeva.minusCheck)
                        // 増殖変異
                        unitCountButtonVerticalPercent(title: "増殖変異", count: $goeva.normalHenniZoshokuCount, color: .personalSpringLightYellow, bigNumber: $goeva.normalHenniCountSum, numberofDicimal: 1, minusBool: $goeva.minusCheck, flushColor: Color.yellow)
                        // 宇宙変異
                        unitCountButtonVerticalPercent(title: "宇宙変異", count: $goeva.normalHenniUchuCount, color: .personalSummerLightRed, bigNumber: $goeva.normalHenniCountSum, numberofDicimal: 1, minusBool: $goeva.minusCheck)
                        // 活性化
                        unitCountButtonVerticalPercent(title: "活性化", count: $goeva.normalHenniKasseikaCount, color: .personalSummerLightPurple, bigNumber: $goeva.normalHenniCountSum, numberofDicimal: 1, minusBool: $goeva.minusCheck)
                    }
                    // 参考情報リンク
                    unitLinkButton(title: "変異の内訳", exview: AnyView(goevaExViewHenni()))
                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(Ci95view: AnyView(goevaView95Ci(goeva: goeva, selection: 4)))
//                        .popoverTip(tipUnitButtonLink95Ci())
                } header: {
                    Text ("変異の内訳")
                }
                
                // //// メニュー画面
                Section {
                    unitLinkButton(title: "メニュー画面示唆", exview: AnyView(unitExView5body2image(title: "メニュー画面示唆", image1: Image("goevaMenuScreen"))))
                } header: {
                    Text("メニュー画面")
                }
                if orientation.isPortrait || (orientation.isFlat && lastOrientation.isPortrait) {
                    unitClearScrollSection(spaceHeight: 150)
                } else {
                    
                }
            }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ゴジラvsエヴァンゲリオン",
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
                // デバイスの向きの変更を監視する
                NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: .main) { _ in
                    self.orientation = UIDevice.current.orientation
                    // 向きがフラットでなければlastOrientationの値を更新
                    if self.orientation.isFlat {
                        
                    }
                    else {
                        self.lastOrientation = self.orientation
                    }
                }
            }
            .onDisappear {
                // ビューが非表示になるときに監視を解除
                NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
            }
            .navigationTitle("通常時のCZ、変異")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    HStack {
                        unitButtonMinusCheck(minusCheck: $goeva.minusCheck)
                        unitButtonReset(isShowAlert: $isShowAlert, action: goeva.resetNormalSuika, message: "このページのデータをリセットします")
                            .popoverTip(tipUnitButtonReset())
                    }
                }
            }
//        }
//        .navigationTitle("通常時のCZ、変異")
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItem(placement: .automatic) {
//                HStack {
//                    unitButtonMinusCheck(minusCheck: $goeva.minusCheck)
//                    unitButtonReset(isShowAlert: $isShowAlert, action: goeva.resetNormalSuika, message: "このページのデータをリセットします")
//                }
//            }
//        }
    }
}


// /////////////////////////////
// ビュー：参考情報　スイカからのCZ当選
// /////////////////////////////
struct goevaExViewNormalSuika: View {
    var body: some View {
        unitExView5body2image(title: "スイカからのCZ アスカvsレイ", textBody1: "・スイカからのCZ アスカvsレイの当選率に設定差あり", image1: Image("goevaNormalSuika"))
    }
}


// /////////////////////////
// ビュー：参考情報　変異の内訳
// /////////////////////////
struct goevaExViewHenni: View {
    var body: some View {
        unitExView5body2image(title: "変異の内訳", textBody1: "・変異の内訳に設定差があるという噂あり", textBody2: "・高設定ほど上位の変異が出やすいという噂", textBody3: "→設定1の数値を下回らないのがいい台かも", image1: Image("goevaNormalHenni"))
    }
}

#Preview {
    goevaNormalSuika(goeva: Goeva())
}
