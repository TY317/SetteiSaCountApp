//
//  kabaneriViewIkoma.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/31.
//

import SwiftUI

struct kabaneriViewIkoma: View {
//    @ObservedObject var kabaneri = Kabaneri()
    @ObservedObject var kabaneri: Kabaneri
    @State var isShowAlert = false
    @State var icomaLifeSelected = "ライフ2"
    let icomaLifeSelectList = ["ライフ3", "ライフ2", "ライフ1"]
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    
    var body: some View {
//        NavigationView {
            List {
                // ハズレでのライフ減少率
                Section {
                    Picker("", selection: $icomaLifeSelected) {
                        ForEach(icomaLifeSelectList, id: \.self) { select in
//                            Text($0)
                            Text(select)
                        }
                    }
                    .pickerStyle(.segmented)
                    // //// カウントボタン
                    // ライフ3
                    if icomaLifeSelected == "ライフ3" {
                        HStack {
                            // 減少
                            unitCountButtonVerticalWithoutRatio(title: "L3減少", count: $kabaneri.icomaLife3DamageCount, color: .personalSummerLightBlue, minusBool: $kabaneri.minusCheck)
                            // 減少なし
                            unitCountButtonVerticalWithoutRatio(title: "L3減少なし", count: $kabaneri.icomaLife3NoDamageCount, color: .blue, minusBool: $kabaneri.minusCheck)
                        }
                    }
                    // ライフ2
                    else if icomaLifeSelected == "ライフ2" {
                        HStack {
                            // 減少
                            unitCountButtonVerticalWithoutRatio(title: "L2減少", count: $kabaneri.icomaLife2DamageCount, color: .personalSpringLightYellow, minusBool: $kabaneri.minusCheck)
                            // 減少なし
                            unitCountButtonVerticalWithoutRatio(title: "L2減少なし", count: $kabaneri.icomaLife2NoDamageCount, color: .yellow, minusBool: $kabaneri.minusCheck)
                        }
                    }
                    // ライフ1
                    else {
                        HStack {
                            // 減少
                            unitCountButtonVerticalWithoutRatio(title: "L1減少", count: $kabaneri.icomaLife1DamageCount, color: .personalSummerLightGreen, minusBool: $kabaneri.minusCheck)
                            // 減少なし
                            unitCountButtonVerticalWithoutRatio(title: "L1減少なし", count: $kabaneri.icomaLife1NoDamageCount, color: .green, minusBool: $kabaneri.minusCheck)
                        }
                    }
                    // //// 結果の表示
                    HStack {
                        unitResultRatioPercent2Line(title: "ライフ3\n減少率", color: .grayBack, count: $kabaneri.icomaLife3DamageCount, bigNumber: $kabaneri.icomaLife3CountSum, numberofDicimal: 0)
                        unitResultRatioPercent2Line(title: "ライフ2\n減少率", color: .grayBack, count: $kabaneri.icomaLife2DamageCount, bigNumber: $kabaneri.icomaLife2CountSum, numberofDicimal: 0)
                        unitResultRatioPercent2Line(title: "ライフ1\n減少率", color: .grayBack, count: $kabaneri.icomaLife1DamageCount, bigNumber: $kabaneri.icomaLife1CountSum, numberofDicimal: 0)
                    }
                    // 参考情報リンク
                    unitLinkButton(title: "ハズレでのライフ減少について", exview: AnyView(unitExView5body2image(title: "ハズレでのライフ減少", textBody1: "・表示上はライフ3までだが、内部的にはライフ5の状態でスタートしている", textBody2: "・ライフ4の時もハズレで減少しない可能性があるため、最初はライフ3なのかライフ4なのかを完全に見抜くことは難しい", textBody3: "・一度ライフが2以下になってからカウントをスタートするのが無難か",textBody4: "（ライフが2以下になってから子役でライフ回復した場合はライフ3がほぼ確定。チャンス目成立時は内部的にライフが8or21になる可能性があるため注意）", image1: Image("kabaneriIcomaLifeAll"))))
                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(Ci95view: AnyView(kabaneriView95Ci(kabaneri: kabaneri, selection: 6)))
//                        .popoverTip(tipUnitButtonLink95Ci())
                } header: {
                    Text("ハズレでのライフ減少率")
                }
                if orientation.isPortrait || (orientation.isFlat && lastOrientation.isPortrait) {
                    unitClearScrollSection(spaceHeight: 280)
                } else {
                    
                }
                // 一旦作ったけど没にした部分
//                // //// ライフ３での減少率
//                Section {
//                    HStack {
//                        // 減少
//                        unitCountButtonVerticalWithoutRatio(title: "減少", count: $kabaneri.icomaLife3DamageCount, color: .personalSummerLightBlue, minusBool: $kabaneri.minusCheck)
//                        // 減少なし
//                        unitCountButtonVerticalWithoutRatio(title: "減少なし", count: $kabaneri.icomaLife3NoDamageCount, color: .personalSpringLightYellow, minusBool: $kabaneri.minusCheck)
//                        // 減少率
//                        unitResultRatioPercent2Line(title: "ライフ3\n減少率", color: .grayBack, count: $kabaneri.icomaLife3DamageCount, bigNumber: $kabaneri.icomaLife3CountSum, numberofDicimal: 0)
//                            .padding(.vertical)
//                    }
//                    // 参考情報リンク
//                    unitLinkButton(title: "ライフ3での減少率", exview: AnyView(unitExView5body2image(title: "ライフ3での減少率", textBody1: "・表示上はライフ3までだが、内部的にはライフ5の状態でスタートしている", textBody2: "・ライフ4の時もハズレで減少しない可能性があるため、最初はライフ3なのかライフ4なのかを完全に見抜くことは難しい", textBody3: "・一度ライフが2以下になってからカウントをスタートするのが無難か",textBody4: "（ライフが2以下になってから子役でライフ回復した場合はライフ3がほぼ確定。チャンス目成立時は内部的にライフが8or21になる可能性があるため注意）", image1: Image("kabaneriIcomaLife3"))))
//                } header: {
//                    Text("ライフ3 ハズレでのライフ減少率")
//                }
//                // //// ライフ2での減少率
//                Section {
//                    HStack {
//                        // 減少
//                        unitCountButtonVerticalWithoutRatio(title: "減少", count: $kabaneri.icomaLife2DamageCount, color: .personalSummerLightBlue, minusBool: $kabaneri.minusCheck)
//                        // 減少なし
//                        unitCountButtonVerticalWithoutRatio(title: "減少なし", count: $kabaneri.icomaLife2NoDamageCount, color: .personalSummerLightGreen, minusBool: $kabaneri.minusCheck)
//                        // 減少率
//                        unitResultRatioPercent2Line(title: "ライフ2\n減少率", color: .grayBack, count: $kabaneri.icomaLife2DamageCount, bigNumber: $kabaneri.icomaLife2CountSum, numberofDicimal: 0)
//                            .padding(.vertical)
//                    }
//                    // 参考情報リンク
//                    unitLinkButton(title: "ライフ2での減少率", exview: AnyView(unitExView5body2image(title: "ライフ2での減少率", image1: Image("kabaneriIcomaLife2"))))
//                } header: {
//                    Text("ライフ2 ハズレでのライフ減少率")
//                }
//                // //// ライフ1での減少率
//                Section {
//                    HStack {
//                        // 減少
//                        unitCountButtonVerticalWithoutRatio(title: "減少", count: $kabaneri.icomaLife1DamageCount, color: .personalSummerLightBlue, minusBool: $kabaneri.minusCheck)
//                        // 減少なし
//                        unitCountButtonVerticalWithoutRatio(title: "減少なし", count: $kabaneri.icomaLife1NoDamageCount, color: .personalSummerLightRed, minusBool: $kabaneri.minusCheck)
//                        // 減少率
//                        unitResultRatioPercent2Line(title: "ライフ1\n減少率", color: .grayBack, count: $kabaneri.icomaLife1DamageCount, bigNumber: $kabaneri.icomaLife1CountSum, numberofDicimal: 0)
//                            .padding(.vertical)
//                    }
//                    // 参考情報リンク
//                    unitLinkButton(title: "ライフ1での減少率", exview: AnyView(unitExView5body2image(title: "ライフ1での減少率", image1: Image("kabaneriIcomaLife1"))))
//                } header: {
//                    Text("ライフ1 ハズレでのライフ減少率")
//                }
            }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "甲鉄城のカバネリ",
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
            .navigationTitle("生駒CZ")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    HStack {
                        unitButtonMinusCheck(minusCheck: $kabaneri.minusCheck)
                        unitButtonReset(isShowAlert: $isShowAlert, action: kabaneri.resetIcoma)
                            .popoverTip(tipUnitButtonReset())
                    }
                }
            }
//        }
//        .navigationTitle("生駒CZ")
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItem(placement: .automatic) {
//                HStack {
//                    unitButtonMinusCheck(minusCheck: $kabaneri.minusCheck)
//                    unitButtonReset(isShowAlert: $isShowAlert, action: kabaneri.resetIcoma)
//                        .popoverTip(tipUnitButtonReset())
//                }
//            }
//        }
    }
}

#Preview {
    kabaneriViewIkoma(kabaneri: Kabaneri())
}
