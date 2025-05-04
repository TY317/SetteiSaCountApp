//
//  karakuriViewStage.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/10/03.
//

import SwiftUI

struct karakuriViewStage: View {
//    @ObservedObject var karakuri = Karakuri()
    @ObservedObject var karakuri: Karakuri
    @State var isShowAlert: Bool = false
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    @State var spaceHeight = 200.0
    
    var body: some View {
        List {
            // //// AT開始時のステージ
            Section {
                HStack {
                    unitCountButtonVerticalPercent(title: "鳴海", count: $karakuri.stageCountNarumi, color: .blue, bigNumber: $karakuri.stageCountFirstSum, numberofDicimal: 0, minusBool: $karakuri.minusCheck)
                    unitCountButtonVerticalPercent(title: "勝", count: $karakuri.stageCountMasaru, color: .yellow, bigNumber: $karakuri.stageCountFirstSum, numberofDicimal: 0, minusBool: $karakuri.minusCheck)
                }
                unitLinkButton(title: "ステージ示唆（AT開始時）", exview: AnyView(unitExView5body2image(title: "ステージ示唆（AT開始時）", textBody1: "・AT中のステージは勝、鳴海の2種類があり移行順番で設定を示唆", textBody2: "・激情ジャッジ成功でステージ移行", textBody3: "・AT開始時のステージで奇偶を示唆", image1: Image("karakuriStageStart"))))
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(Ci95view: AnyView(karakuriView95Ci(karakuri: karakuri, selection: 2)))
                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("AT開始時のステージ")
            }
            
            // //// 激情ジャッジ成功2回後
            Section {
                HStack {
                    // テーブル１
                    unitCountButtonVerticalPercent(title: "テーブル\n1", count: $karakuri.stageCountTable1, color: .personalSummerLightBlue, bigNumber: $karakuri.stageCountTableSum, numberofDicimal: 0, minusBool: $karakuri.minusCheck)
                    // テーブル２
                    unitCountButtonVerticalPercent(title: "テーブル\n2", count: $karakuri.stageCountTable2, color: .personalSpringLightYellow, bigNumber: $karakuri.stageCountTableSum, numberofDicimal: 0, minusBool: $karakuri.minusCheck, flushColor: Color.yellow)
                    // テーブル3
                    unitCountButtonVerticalPercent(title: "テーブル\n3", count: $karakuri.stageCountTable3, color: .personalSummerLightGreen, bigNumber: $karakuri.stageCountTableSum, numberofDicimal: 0, minusBool: $karakuri.minusCheck)
                    // テーブル4
                    unitCountButtonVerticalPercent(title: "テーブル\n4", count: $karakuri.stageCountTable4, color: .personalSummerLightRed, bigNumber: $karakuri.stageCountTableSum, numberofDicimal: 0, minusBool: $karakuri.minusCheck)
                }
                // //// 参考情報リンク
                unitLinkButton(title: "ステージ示唆（激情成功2回後）", exview: AnyView(unitExView5body2image(title: "ステージ示唆（激情ジャッジ成功2回後）", textBody1: "・AT中のステージは勝、鳴海の2種類があり移行順番で設定を示唆", textBody2: "・激情ジャッジ成功でステージ移行", textBody3: "・ステージ移行先で高設定を示唆", image1: Image("karakuriTable"))))
            } header: {
                Text("激情ジャッジ成功2回後")
            }
            unitClearScrollSectionBinding(spaceHeight: $spaceHeight)
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
                self.spaceHeight = 0
            } else {
                self.spaceHeight = 200.0
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
                    self.spaceHeight = 0
                } else {
                    self.spaceHeight = 200.0
                }
            }
        }
        .onDisappear {
            // ビューが非表示になるときに監視を解除
            NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
        }
        .navigationTitle("AT中のステージ")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    unitButtonMinusCheck(minusCheck: $karakuri.minusCheck)
                    unitButtonReset(isShowAlert: $isShowAlert, action: karakuri.resetStage)
                }
            }
        }
    }
}

#Preview {
    karakuriViewStage(karakuri: Karakuri())
}
