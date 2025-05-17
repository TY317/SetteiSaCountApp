//
//  midoriDonViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/04.
//

import SwiftUI

struct midoriDonViewFirstHit: View {
    @ObservedObject var ver310: Ver310
    @ObservedObject var midoriDon: MidoriDon
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
    
    var body: some View {
        List {
            Section {
                Text("現在値はユニメモを確認してください")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // 参考情報）初当り確率
                unitLinkButton(
                    title: "初当り確率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "初当り確率",
                            tableView: AnyView(midoriDonTableFirstHit(midoriDon: midoriDon))
                        )
                    )
                )
                // 参考情報）リーチ目リプレイ確率
                unitLinkButton(
                    title: "リーチ目リプレイ確率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "リーチ目リプレイ",
                            tableView: AnyView(midoriDonTableReachReplay())
                        )
                    )
                )
                .popoverTip(tipVer310MidoriDonReachReplay())
            }
        }
        .onAppear {
            if ver310.midoriDonMenuFirstHitBadgeStatus != "none" {
                ver310.midoriDonMenuFirstHitBadgeStatus = "none"
            }
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
        .navigationTitle("ボーナス,AT 初当り")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
//                    unitButtonMinusCheck(minusCheck: $midoriDon.minusCheck)
                    // リセットボタン
//                    unitButtonReset(isShowAlert: $isShowAlert, action: midoriDon.resetFirstHit)
                }
            }
        }
    }
}

#Preview {
    midoriDonViewFirstHit(
        ver310: Ver310(),
        midoriDon: MidoriDon()
    )
}
