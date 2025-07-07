//
//  watakonViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/25.
//

import SwiftUI

struct watakonViewTop: View {
    @ObservedObject var ver350: Ver350
    @StateObject var watakon = Watakon()
    @State var isShowAlert: Bool = false
    @StateObject var watakonMemory1 = WatakonMemory1()
    @StateObject var watakonMemory2 = WatakonMemory2()
    @StateObject var watakonMemory3 = WatakonMemory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("e-slot+の利用を前提としています\n遊技前にe-slot+を開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(machineName: watakon.machineName)
                }
                
                Section {
                    // 通常時
                    NavigationLink(destination: watakonViewNormal(
                        watakon: watakon,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時"
                        )
                    }
                    
                    // 初当り
                    NavigationLink(destination: watakonViewFirstHit(
                        watakon: watakon,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り"
                        )
                    }
                    
                    // AT終了画面
                    NavigationLink(destination: watakonViewScreen(
                        watakon: watakon,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "AT終了画面"
                        )
                    }
                }
                
                // 設定推測グラフ
//                NavigationLink(destination: watakonView95Ci(
//                    watakon: watakon,
//                    selection: 1
//                )) {
//                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
//                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4803"
                )
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($ver350.watakonMachineIconBadgeStaus)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: watakon.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(watakonSubViewLoadMemory(
                        watakon: watakon,
                        watakonMemory1: watakonMemory1,
                        watakonMemory2: watakonMemory2,
                        watakonMemory3: watakonMemory3
                    )))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(watakonSubViewSaveMemory(
                        watakon: watakon,
                        watakonMemory1: watakonMemory1,
                        watakonMemory2: watakonMemory2,
                        watakonMemory3: watakonMemory3
                    )))
                }
//                .popoverTip(tipUnitButtonMemory())
                // データリセット
                unitButtonReset(isShowAlert: $isShowAlert, action: watakon.resetAll, message: "この機種のデータを全てリセットします")
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct watakonSubViewSaveMemory: View {
    @ObservedObject var watakon: Watakon
    @ObservedObject var watakonMemory1: WatakonMemory1
    @ObservedObject var watakonMemory2: WatakonMemory2
    @ObservedObject var watakonMemory3: WatakonMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: watakon.machineName,
            selectedMemory: $watakon.selectedMemory,
            memoMemory1: $watakonMemory1.memo,
            dateDoubleMemory1: $watakonMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $watakonMemory2.memo,
            dateDoubleMemory2: $watakonMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $watakonMemory3.memo,
            dateDoubleMemory3: $watakonMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        watakonMemory1.screenCountDefault = watakon.screenCountDefault
        watakonMemory1.screenCountGusu = watakon.screenCountGusu
        watakonMemory1.screenCountHigh = watakon.screenCountHigh
        watakonMemory1.screenCountOver2 = watakon.screenCountOver2
        watakonMemory1.screenCountOver4 = watakon.screenCountOver4
        watakonMemory1.screenCountOver6 = watakon.screenCountOver6
        watakonMemory1.screenCountSum = watakon.screenCountSum
    }
    func saveMemory2() {
        watakonMemory2.screenCountDefault = watakon.screenCountDefault
        watakonMemory2.screenCountGusu = watakon.screenCountGusu
        watakonMemory2.screenCountHigh = watakon.screenCountHigh
        watakonMemory2.screenCountOver2 = watakon.screenCountOver2
        watakonMemory2.screenCountOver4 = watakon.screenCountOver4
        watakonMemory2.screenCountOver6 = watakon.screenCountOver6
        watakonMemory2.screenCountSum = watakon.screenCountSum
    }
    func saveMemory3() {
        watakonMemory3.screenCountDefault = watakon.screenCountDefault
        watakonMemory3.screenCountGusu = watakon.screenCountGusu
        watakonMemory3.screenCountHigh = watakon.screenCountHigh
        watakonMemory3.screenCountOver2 = watakon.screenCountOver2
        watakonMemory3.screenCountOver4 = watakon.screenCountOver4
        watakonMemory3.screenCountOver6 = watakon.screenCountOver6
        watakonMemory3.screenCountSum = watakon.screenCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct watakonSubViewLoadMemory: View {
    @ObservedObject var watakon: Watakon
    @ObservedObject var watakonMemory1: WatakonMemory1
    @ObservedObject var watakonMemory2: WatakonMemory2
    @ObservedObject var watakonMemory3: WatakonMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: watakon.machineName,
            selectedMemory: $watakon.selectedMemory,
            memoMemory1: watakonMemory1.memo,
            dateDoubleMemory1: watakonMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: watakonMemory2.memo,
            dateDoubleMemory2: watakonMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: watakonMemory3.memo,
            dateDoubleMemory3: watakonMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        watakon.screenCountDefault = watakonMemory1.screenCountDefault
        watakon.screenCountGusu = watakonMemory1.screenCountGusu
        watakon.screenCountHigh = watakonMemory1.screenCountHigh
        watakon.screenCountOver2 = watakonMemory1.screenCountOver2
        watakon.screenCountOver4 = watakonMemory1.screenCountOver4
        watakon.screenCountOver6 = watakonMemory1.screenCountOver6
        watakon.screenCountSum = watakonMemory1.screenCountSum
    }
    func loadMemory2() {
        watakon.screenCountDefault = watakonMemory2.screenCountDefault
        watakon.screenCountGusu = watakonMemory2.screenCountGusu
        watakon.screenCountHigh = watakonMemory2.screenCountHigh
        watakon.screenCountOver2 = watakonMemory2.screenCountOver2
        watakon.screenCountOver4 = watakonMemory2.screenCountOver4
        watakon.screenCountOver6 = watakonMemory2.screenCountOver6
        watakon.screenCountSum = watakonMemory2.screenCountSum
    }
    func loadMemory3() {
        watakon.screenCountDefault = watakonMemory3.screenCountDefault
        watakon.screenCountGusu = watakonMemory3.screenCountGusu
        watakon.screenCountHigh = watakonMemory3.screenCountHigh
        watakon.screenCountOver2 = watakonMemory3.screenCountOver2
        watakon.screenCountOver4 = watakonMemory3.screenCountOver4
        watakon.screenCountOver6 = watakonMemory3.screenCountOver6
        watakon.screenCountSum = watakonMemory3.screenCountSum
    }
}

#Preview {
    watakonViewTop(
        ver350: Ver350(),
    )
}
