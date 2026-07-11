//
//  izaBanchoViewZeccho.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct izaBanchoViewZeccho: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var izaBancho: IzaBancho
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
            // 楽曲変化
            Section {
                // 説明
                Text("絶頂開始時にミーモ斬シングが流れれば当該＋3セット以上継続濃厚かつ設定3・5・6示唆")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // 楽曲変化
                HStack(spacing: 0) {
                    unitTableSettingIndex()
                    unitTablePercent(
                        columTitle: "楽曲変化",
                        percentList: [6,6,10,6,16,16]
                    )
                }
                .frame(maxWidth: .infinity, alignment: .center)
            } header: {
                Text("楽曲変化 発生率")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.izaBanchoMenuZecchoBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: izaBancho.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("絶頂中")
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
    }
}

#Preview {
    izaBanchoViewZeccho(
        izaBancho: IzaBancho(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
