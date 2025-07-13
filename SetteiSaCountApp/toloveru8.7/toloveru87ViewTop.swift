//
//  toloveru87ViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/19.
//

import SwiftUI
import FirebaseAnalytics

struct toloveru87ViewTop: View {
//    @ObservedObject var ver320: Ver320
    @StateObject var toloveru87 = Toloveru87()
    @State var isShowAlert: Bool = false
    @StateObject var toloveru87Memory1 = Toloveru87Memory1()
    @StateObject var toloveru87Memory2 = Toloveru87Memory2()
    @StateObject var toloveru87Memory3 = Toloveru87Memory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("打-WINの利用を前提としています\n遊技前に打-WINを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(machineName: "ToLOVEる TRANCE ver.8.7")
                }
                
                Section {
                    // ドキドキポイント
                    NavigationLink(destination: toloveru87ViewDokidokiPt(
                        toloveru87: toloveru87
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bolt.heart",
                            textBody: "どきどきポイント"
                        )
                    }
                    // 初当り
                    NavigationLink(destination: toloveru87ViewFirstHit(
                        
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "AT初当り"
                        )
                    }
                    // 終了画面
                    NavigationLink(destination: toloveru87ViewEndScreen()) {
                        unitLabelMenu(imageSystemName: "photo.on.rectangle", textBody: "ST終了画面")
                    }
                    // ハーレムモード
                    NavigationLink(destination: toloveru87ViewHarlem(
                        toloveru87: toloveru87
                    )) {
                        unitLabelMenu(
                            imageSystemName: "beach.umbrella",
                            textBody: "ハーレムモード"
                        )
                    }
                    // 隠れ凪
                    NavigationLink(destination: commonViewKakureNagi()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "隠れ凪"
                        )
                    }
                }
                
                // 設定推測グラフ
                NavigationLink(destination: toloveru87View95Ci(toloveru87: toloveru87)) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4806")
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ToLOVEるver8.7",
                screenClass: screenClass
            )
        }
//        // 画面ログイベントの収集
//        .onAppear {
//            // Viewが表示されたタイミングでログを送信します
//            Analytics.logEvent(AnalyticsEventScreenView, parameters: [
//                AnalyticsParameterScreenName: "ToLOVEるver.8.7", // この画面の名前を識別できるように設定
//                AnalyticsParameterScreenClass: "toloveru87ViewTop" // 通常はViewのクラス名（構造体名）を設定
//                // その他、この画面に関連するパラメータを追加できます
//            ])
//            print("Firebase Analytics: toloveru87ViewTop appeared.") // デバッグ用にログ出力
//        }
//        .onAppear {
//            if ver320.toloveru87MachineIconBadgeStaus != "none" {
//                ver320.toloveru87MachineIconBadgeStaus = "none"
//            }
//        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(toloveru87SubViewLoadMemory(
                        toloveru87: toloveru87,
                        toloveru87Memory1: toloveru87Memory1,
                        toloveru87Memory2: toloveru87Memory2,
                        toloveru87Memory3: toloveru87Memory3
                    )))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(toloveru87SubViewSaveMemory(
                        toloveru87: toloveru87,
                        toloveru87Memory1: toloveru87Memory1,
                        toloveru87Memory2: toloveru87Memory2,
                        toloveru87Memory3: toloveru87Memory3
                    )))
                }
//                .popoverTip(tipUnitButtonMemory())
                // データリセット
                unitButtonReset(isShowAlert: $isShowAlert, action: toloveru87.resetAll, message: "この機種のデータを全てリセットします")
//                    .popoverTip(tipUnitButtonReset())
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct toloveru87SubViewSaveMemory: View {
    @ObservedObject var toloveru87: Toloveru87
    @ObservedObject var toloveru87Memory1: Toloveru87Memory1
    @ObservedObject var toloveru87Memory2: Toloveru87Memory2
    @ObservedObject var toloveru87Memory3: Toloveru87Memory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "ToLOVEる TRANCE ver.8.7",
            selectedMemory: $toloveru87.selectedMemory,
            memoMemory1: $toloveru87Memory1.memo,
            dateDoubleMemory1: $toloveru87Memory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $toloveru87Memory2.memo,
            dateDoubleMemory2: $toloveru87Memory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $toloveru87Memory3.memo,
            dateDoubleMemory3: $toloveru87Memory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        toloveru87Memory1.dokiPtLeft = toloveru87.dokiPtLeft
        toloveru87Memory1.dokiPtCenter = toloveru87.dokiPtCenter
        toloveru87Memory1.dokiPtRight = toloveru87.dokiPtRight
        toloveru87Memory1.harlemWhisperCount = toloveru87.harlemWhisperCount
        toloveru87Memory1.harlemAisplush = toloveru87.harlemAisplush
        toloveru87Memory1.harlemCountSum = toloveru87.harlemCountSum
    }
    func saveMemory2() {
        toloveru87Memory2.dokiPtLeft = toloveru87.dokiPtLeft
        toloveru87Memory2.dokiPtCenter = toloveru87.dokiPtCenter
        toloveru87Memory2.dokiPtRight = toloveru87.dokiPtRight
        toloveru87Memory2.harlemWhisperCount = toloveru87.harlemWhisperCount
        toloveru87Memory2.harlemAisplush = toloveru87.harlemAisplush
        toloveru87Memory2.harlemCountSum = toloveru87.harlemCountSum
    }
    func saveMemory3() {
        toloveru87Memory3.dokiPtLeft = toloveru87.dokiPtLeft
        toloveru87Memory3.dokiPtCenter = toloveru87.dokiPtCenter
        toloveru87Memory3.dokiPtRight = toloveru87.dokiPtRight
        toloveru87Memory3.harlemWhisperCount = toloveru87.harlemWhisperCount
        toloveru87Memory3.harlemAisplush = toloveru87.harlemAisplush
        toloveru87Memory3.harlemCountSum = toloveru87.harlemCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct toloveru87SubViewLoadMemory: View {
    @ObservedObject var toloveru87: Toloveru87
    @ObservedObject var toloveru87Memory1: Toloveru87Memory1
    @ObservedObject var toloveru87Memory2: Toloveru87Memory2
    @ObservedObject var toloveru87Memory3: Toloveru87Memory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: "ToLOVEる TRANCE ver.8.7",
            selectedMemory: $toloveru87.selectedMemory,
            memoMemory1: toloveru87Memory1.memo,
            dateDoubleMemory1: toloveru87Memory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: toloveru87Memory2.memo,
            dateDoubleMemory2: toloveru87Memory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: toloveru87Memory3.memo,
            dateDoubleMemory3: toloveru87Memory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        toloveru87.dokiPtLeft = toloveru87Memory1.dokiPtLeft
        toloveru87.dokiPtCenter = toloveru87Memory1.dokiPtCenter
        toloveru87.dokiPtRight = toloveru87Memory1.dokiPtRight
        toloveru87.harlemWhisperCount = toloveru87Memory1.harlemWhisperCount
        toloveru87.harlemAisplush = toloveru87Memory1.harlemAisplush
        toloveru87.harlemCountSum = toloveru87Memory1.harlemCountSum
    }
    func loadMemory2() {
        toloveru87.dokiPtLeft = toloveru87Memory2.dokiPtLeft
        toloveru87.dokiPtCenter = toloveru87Memory2.dokiPtCenter
        toloveru87.dokiPtRight = toloveru87Memory2.dokiPtRight
        toloveru87.harlemWhisperCount = toloveru87Memory2.harlemWhisperCount
        toloveru87.harlemAisplush = toloveru87Memory2.harlemAisplush
        toloveru87.harlemCountSum = toloveru87Memory2.harlemCountSum
    }
    func loadMemory3() {
        toloveru87.dokiPtLeft = toloveru87Memory3.dokiPtLeft
        toloveru87.dokiPtCenter = toloveru87Memory3.dokiPtCenter
        toloveru87.dokiPtRight = toloveru87Memory3.dokiPtRight
        toloveru87.harlemWhisperCount = toloveru87Memory3.harlemWhisperCount
        toloveru87.harlemAisplush = toloveru87Memory3.harlemAisplush
        toloveru87.harlemCountSum = toloveru87Memory3.harlemCountSum
    }
}

#Preview {
    toloveru87ViewTop(
//        ver320: Ver320(),
        toloveru87: Toloveru87()
    )
}
