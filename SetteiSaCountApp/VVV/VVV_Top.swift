//
//  VVV_Top.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/06.
//

import SwiftUI

// //// メモリー1
class VvvMemory1: ObservableObject {
    @AppStorage("vvvSelectedMemory") var selectedMemory = "メモリー1"
    @AppStorage("VVVharakiriBefore1020CountMemory1") var before1020Count = 0
    @AppStorage("VVVharakiriBeforeDriveCountMemory1") var beforeDriveCount = 0
    @AppStorage("VVVharakiriAfter1020CountMemory1") var after1020Count = 0
    @AppStorage("VVVharakiriAfterDriveCountMemory1") var afterDriveCount = 0
    @AppStorage("VVVmarieCountMemory1") var marieCount = 0
    @AppStorage("VVVendScreenW2CountMemory1") var w2Count = 0
    @AppStorage("VVVendScreenW3CountMemory1") var w3Count = 0
    @AppStorage("VVVendScreenW4CountMemory1") var w4Count = 0
    @AppStorage("VVVendScreenPManCountMemory1") var pManCount = 0
    @AppStorage("VVVendScreenPMizugiCountMemory1") var pMizugiCount = 0
    @AppStorage("VVVendScreenR5CountMemory1") var r5Count = 0
    @AppStorage("VVVendScreenR6CountMemory1") var r6Count = 0
    @AppStorage("VVVendScreenGCountMemory1") var gCount = 0
    @AppStorage("zoneArrayCzVVVMemory1") var zoneArrayCzVVVData: Data?
    @AppStorage("characterArrayCzVVVMemory1") var characterArrayCzVVVData: Data?
    @AppStorage("resultArrayCzVVVMemory1") var resultArrayCzVVVData: Data?
    @AppStorage("vvvKakumeiCountMemory1") var kakumeiCount = 0
    @AppStorage("vvvKessenCountMemory1") var kessenCount = 0
    @AppStorage("vvvBonusCountSumMemory1") var bonusCountSum = 0
    @AppStorage("vvvMemoMemory1") var memo = ""
    @AppStorage("vvvDateMemory1") var dateDouble = 0.0
    @AppStorage("VVVendScreenCountSumMemory1") var screenCountSum = 0
    @AppStorage("VVVharakiriAfterSetCountSumMemory1") var afterSetCountSum = 0
    @AppStorage("VVVharakiriAllDriveCountSumMemory1") var allDriveCountSum = 0
    @AppStorage("VVVharakiriAllSetCountSumMemory1") var allSetCountSum = 0
}

// //// メモリー2
class VvvMemory2: ObservableObject {
    @AppStorage("VVVharakiriBefore1020CountMemory2") var before1020Count = 0
    @AppStorage("VVVharakiriBeforeDriveCountMemory2") var beforeDriveCount = 0
    @AppStorage("VVVharakiriAfter1020CountMemory2") var after1020Count = 0
    @AppStorage("VVVharakiriAfterDriveCountMemory2") var afterDriveCount = 0
    @AppStorage("VVVmarieCountMemory2") var marieCount = 0
    @AppStorage("VVVendScreenW2CountMemory2") var w2Count = 0
    @AppStorage("VVVendScreenW3CountMemory2") var w3Count = 0
    @AppStorage("VVVendScreenW4CountMemory2") var w4Count = 0
    @AppStorage("VVVendScreenPManCountMemory2") var pManCount = 0
    @AppStorage("VVVendScreenPMizugiCountMemory2") var pMizugiCount = 0
    @AppStorage("VVVendScreenR5CountMemory2") var r5Count = 0
    @AppStorage("VVVendScreenR6CountMemory2") var r6Count = 0
    @AppStorage("VVVendScreenGCountMemory2") var gCount = 0
    @AppStorage("zoneArrayCzVVVMemory2") var zoneArrayCzVVVData: Data?
    @AppStorage("characterArrayCzVVVMemory2") var characterArrayCzVVVData: Data?
    @AppStorage("resultArrayCzVVVMemory2") var resultArrayCzVVVData: Data?
    @AppStorage("vvvKakumeiCountMemory2") var kakumeiCount = 0
    @AppStorage("vvvKessenCountMemory2") var kessenCount = 0
    @AppStorage("vvvBonusCountSumMemory2") var bonusCountSum = 0
    @AppStorage("vvvMemoMemory2") var memo = ""
    @AppStorage("vvvDateMemory2") var dateDouble = 0.0
    @AppStorage("VVVendScreenCountSumMemory2") var screenCountSum = 0
    @AppStorage("VVVharakiriAfterSetCountSumMemory2") var afterSetCountSum = 0
    @AppStorage("VVVharakiriAllDriveCountSumMemory2") var allDriveCountSum = 0
    @AppStorage("VVVharakiriAllSetCountSumMemory2") var allSetCountSum = 0
}

// //// メモリー3
class VvvMemory3: ObservableObject {
    @AppStorage("VVVharakiriBefore1020CountMemory3") var before1020Count = 0
    @AppStorage("VVVharakiriBeforeDriveCountMemory3") var beforeDriveCount = 0
    @AppStorage("VVVharakiriAfter1020CountMemory3") var after1020Count = 0
    @AppStorage("VVVharakiriAfterDriveCountMemory3") var afterDriveCount = 0
    @AppStorage("VVVmarieCountMemory3") var marieCount = 0
    @AppStorage("VVVendScreenW2CountMemory3") var w2Count = 0
    @AppStorage("VVVendScreenW3CountMemory3") var w3Count = 0
    @AppStorage("VVVendScreenW4CountMemory3") var w4Count = 0
    @AppStorage("VVVendScreenPManCountMemory3") var pManCount = 0
    @AppStorage("VVVendScreenPMizugiCountMemory3") var pMizugiCount = 0
    @AppStorage("VVVendScreenR5CountMemory3") var r5Count = 0
    @AppStorage("VVVendScreenR6CountMemory3") var r6Count = 0
    @AppStorage("VVVendScreenGCountMemory3") var gCount = 0
    @AppStorage("zoneArrayCzVVVMemory3") var zoneArrayCzVVVData: Data?
    @AppStorage("characterArrayCzVVVMemory3") var characterArrayCzVVVData: Data?
    @AppStorage("resultArrayCzVVVMemory3") var resultArrayCzVVVData: Data?
    @AppStorage("vvvKakumeiCountMemory2") var kakumeiCount = 0
    @AppStorage("vvvKessenCountMemory2") var kessenCount = 0
    @AppStorage("vvvBonusCountSumMemory2") var bonusCountSum = 0
    @AppStorage("vvvMemoMemory3") var memo = ""
    @AppStorage("vvvDateMemory3") var dateDouble = 0.0
    @AppStorage("VVVendScreenCountSumMemory3") var screenCountSum = 0
    @AppStorage("VVVharakiriAfterSetCountSumMemory3") var afterSetCountSum = 0
    @AppStorage("VVVharakiriAllDriveCountSumMemory3") var allDriveCountSum = 0
    @AppStorage("VVVharakiriAllSetCountSumMemory3") var allSetCountSum = 0
}

struct VVV_Top: View {
    @State var isShowAlert = false
//    @ObservedObject var cz = czVar()
    @ObservedObject var VVVendScreen = VVVendScreenVar()
    @ObservedObject var VVVmarie = VVVmarieVar()
    @ObservedObject var VVVharakiri = VVVharakiriVar()
    @ObservedObject var vvv = vvvCzHistory()
    @ObservedObject var vvvMemory1 = VvvMemory1()
    @ObservedObject var vvvMemory2 = VvvMemory2()
    @ObservedObject var vvvMemory3 = VvvMemory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // CZ当選履歴
                    NavigationLink(destination: vvvViewCzHistoryVer2()) {//VVV_CZ()) {
                        unitLabelMenu(imageSystemName: "pencil.and.list.clipboard", textBody: "CZ,ボーナス当選履歴")
                    }
                    
                    // CZ,ボーナス終了画面
                    NavigationLink(destination: VVVendScreenView()) {
                        unitLabelMenu(imageSystemName: "photo.stack", textBody: "CZ,ボーナス終了画面")
                    }
                    
                    // 革命ボーナス中のマリエ覚醒
                    NavigationLink(destination: VVVmarieView()) {
                        unitLabelMenu(imageSystemName: "infinity", textBody: "革命ボーナス中のマリエ覚醒")
                    }
                    
                    // ハラキリドライブ
                    NavigationLink(destination: VVVharakiriDriveView()) {
                        unitLabelMenu(imageSystemName: "50.square", textBody: "ハラキリドライブ")
                    }
                } header: {
                    HStack {
                        Spacer()
                        Text("革命機ヴァルヴレイヴ")
                            .font(.title)
                            .fontWeight(.bold)
//                            .foregroundColor(.primary)
                            .foregroundStyle(Color.primary)
                        Spacer()
                    }
                    
                }
                // 設定推測グラフ
                NavigationLink(destination: vvvView95Ci()) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
                .popoverTip(tipVer16095CiAdd())
                Section {
                    Text("")
                }
                .listRowBackground(Color.clear)
            }
            .navigationTitle("メニュー")
            .navigationBarTitleDisplayMode(.inline)
            
            // //// ツールバーボタン
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    HStack {
                        HStack {
                            // //// データ読み出し
                            unitButtonLoadMemory(loadView: AnyView(vvvViewLoadMemory()))
                            // //// データ保存
                            unitButtonSaveMemory(saveView: AnyView(vvvViewSaveMemory()))
                        }
                        .popoverTip(tipUnitButtonMemory())
                        // データリセットボタン
                        Button("リセット", systemImage: "arrow.clockwise.square") {
                            isShowAlert = true
                        }
                        .alert("データリセット", isPresented: $isShowAlert) {
                            Button("キャンセル", role: .cancel) {
                                
                            }
                            Button("リセット", role: .destructive) {
//                                VVVfuncResetCz(cz: cz)
                                VVVfuncResetEndScreen(VVVendScreen: VVVendScreen)
                                VVVfuncResetMarie(VVVmarie: VVVmarie)
                                VVVfuncResetDrive(VVVharakiri: VVVharakiri)
                                vvv.resetHistory()
                                
                                UINotificationFeedbackGenerator().notificationOccurred(.warning)
                            }
                        } message: {
                            Text("この機種の全ページのデータは完全に消去されます")
                        }
                    }
                }
            }
        }
    }
}


// /////////////////////////////
// メモリーセーブ画面
// /////////////////////////////
struct vvvViewSaveMemory: View {
//    @ObservedObject var cz = czVar()
    @ObservedObject var VVVendScreen = VVVendScreenVar()
    @ObservedObject var VVVmarie = VVVmarieVar()
    @ObservedObject var VVVharakiri = VVVharakiriVar()
    @ObservedObject var vvv = vvvCzHistory()
    @ObservedObject var vvvMemory1 = VvvMemory1()
    @ObservedObject var vvvMemory2 = VvvMemory2()
    @ObservedObject var vvvMemory3 = VvvMemory3()
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "革命機ヴァルヴレイヴ",
            selectedMemory: $vvvMemory1.selectedMemory,
            memoMemory1: $vvvMemory1.memo,
            dateDoubleMemory1: $vvvMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $vvvMemory2.memo,
            dateDoubleMemory2: $vvvMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $vvvMemory3.memo,
            dateDoubleMemory3: $vvvMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        vvvMemory1.before1020Count = VVVharakiri.before1020Count
        vvvMemory1.beforeDriveCount = VVVharakiri.beforeDriveCount
        vvvMemory1.after1020Count = VVVharakiri.after1020Count
        vvvMemory1.afterDriveCount = VVVharakiri.afterDriveCount
        vvvMemory1.marieCount = VVVmarie.marieCount
        vvvMemory1.w2Count = VVVendScreen.w2Count
        vvvMemory1.w3Count = VVVendScreen.w3Count
        vvvMemory1.w4Count = VVVendScreen.w4Count
        vvvMemory1.pManCount = VVVendScreen.pManCount
        vvvMemory1.pMizugiCount = VVVendScreen.pMizugiCount
        vvvMemory1.r5Count = VVVendScreen.r5Count
        vvvMemory1.r6Count = VVVendScreen.r6Count
        vvvMemory1.gCount = VVVendScreen.gCount
        vvvMemory1.zoneArrayCzVVVData = vvv.zoneArrayCzVVVData
        vvvMemory1.characterArrayCzVVVData = vvv.characterArrayCzVVVData
        vvvMemory1.resultArrayCzVVVData = vvv.resultArrayCzVVVData
        vvvMemory1.kakumeiCount = vvv.kakumeiCount
        vvvMemory1.kessenCount = vvv.kessenCount
        vvvMemory1.bonusCountSum = vvv.bonusCountSum
        vvvMemory1.screenCountSum = VVVendScreen.screenCountSum
        vvvMemory1.afterSetCountSum = VVVharakiri.afterSetCountSum
        vvvMemory1.allDriveCountSum = VVVharakiri.allDriveCountSum
        vvvMemory1.allSetCountSum = VVVharakiri.allSetCountSum
    }
    func saveMemory2() {
        vvvMemory2.before1020Count = VVVharakiri.before1020Count
        vvvMemory2.beforeDriveCount = VVVharakiri.beforeDriveCount
        vvvMemory2.after1020Count = VVVharakiri.after1020Count
        vvvMemory2.afterDriveCount = VVVharakiri.afterDriveCount
        vvvMemory2.marieCount = VVVmarie.marieCount
        vvvMemory2.w2Count = VVVendScreen.w2Count
        vvvMemory2.w3Count = VVVendScreen.w3Count
        vvvMemory2.w4Count = VVVendScreen.w4Count
        vvvMemory2.pManCount = VVVendScreen.pManCount
        vvvMemory2.pMizugiCount = VVVendScreen.pMizugiCount
        vvvMemory2.r5Count = VVVendScreen.r5Count
        vvvMemory2.r6Count = VVVendScreen.r6Count
        vvvMemory2.gCount = VVVendScreen.gCount
        vvvMemory2.zoneArrayCzVVVData = vvv.zoneArrayCzVVVData
        vvvMemory2.characterArrayCzVVVData = vvv.characterArrayCzVVVData
        vvvMemory2.resultArrayCzVVVData = vvv.resultArrayCzVVVData
        vvvMemory2.kakumeiCount = vvv.kakumeiCount
        vvvMemory2.kessenCount = vvv.kessenCount
        vvvMemory2.bonusCountSum = vvv.bonusCountSum
        vvvMemory2.screenCountSum = VVVendScreen.screenCountSum
        vvvMemory2.afterSetCountSum = VVVharakiri.afterSetCountSum
        vvvMemory2.allDriveCountSum = VVVharakiri.allDriveCountSum
        vvvMemory2.allSetCountSum = VVVharakiri.allSetCountSum
    }
    func saveMemory3() {
        vvvMemory3.before1020Count = VVVharakiri.before1020Count
        vvvMemory3.beforeDriveCount = VVVharakiri.beforeDriveCount
        vvvMemory3.after1020Count = VVVharakiri.after1020Count
        vvvMemory3.afterDriveCount = VVVharakiri.afterDriveCount
        vvvMemory3.marieCount = VVVmarie.marieCount
        vvvMemory3.w2Count = VVVendScreen.w2Count
        vvvMemory3.w3Count = VVVendScreen.w3Count
        vvvMemory3.w4Count = VVVendScreen.w4Count
        vvvMemory3.pManCount = VVVendScreen.pManCount
        vvvMemory3.pMizugiCount = VVVendScreen.pMizugiCount
        vvvMemory3.r5Count = VVVendScreen.r5Count
        vvvMemory3.r6Count = VVVendScreen.r6Count
        vvvMemory3.gCount = VVVendScreen.gCount
        vvvMemory3.zoneArrayCzVVVData = vvv.zoneArrayCzVVVData
        vvvMemory3.characterArrayCzVVVData = vvv.characterArrayCzVVVData
        vvvMemory3.resultArrayCzVVVData = vvv.resultArrayCzVVVData
        vvvMemory3.kakumeiCount = vvv.kakumeiCount
        vvvMemory3.kessenCount = vvv.kessenCount
        vvvMemory3.bonusCountSum = vvv.bonusCountSum
        vvvMemory3.screenCountSum = VVVendScreen.screenCountSum
        vvvMemory3.afterSetCountSum = VVVharakiri.afterSetCountSum
        vvvMemory3.allDriveCountSum = VVVharakiri.allDriveCountSum
        vvvMemory3.allSetCountSum = VVVharakiri.allSetCountSum
    }
}


// /////////////////////////////
// メモリーロード画面
// /////////////////////////////
struct vvvViewLoadMemory: View {
//    @ObservedObject var cz = czVar()
    @ObservedObject var VVVendScreen = VVVendScreenVar()
    @ObservedObject var VVVmarie = VVVmarieVar()
    @ObservedObject var VVVharakiri = VVVharakiriVar()
    @ObservedObject var vvv = vvvCzHistory()
    @ObservedObject var vvvMemory1 = VvvMemory1()
    @ObservedObject var vvvMemory2 = VvvMemory2()
    @ObservedObject var vvvMemory3 = VvvMemory3()
    @State var isShowLoadAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: "革命機ヴァルヴレイヴ",
            selectedMemory: $vvvMemory1.selectedMemory,
            memoMemory1: vvvMemory1.memo,
            dateDoubleMemory1: vvvMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: vvvMemory2.memo,
            dateDoubleMemory2: vvvMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: vvvMemory3.memo,
            dateDoubleMemory3: vvvMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowLoadAlert
        )
    }
    func loadMemory1() {
        VVVharakiri.before1020Count = vvvMemory1.before1020Count
        VVVharakiri.beforeDriveCount = vvvMemory1.beforeDriveCount
        VVVharakiri.after1020Count = vvvMemory1.after1020Count
        VVVharakiri.afterDriveCount = vvvMemory1.afterDriveCount
        VVVmarie.marieCount = vvvMemory1.marieCount
        VVVendScreen.w2Count = vvvMemory1.w2Count
        VVVendScreen.w3Count = vvvMemory1.w3Count
        VVVendScreen.w4Count = vvvMemory1.w4Count
        VVVendScreen.pManCount = vvvMemory1.pManCount
        VVVendScreen.pMizugiCount = vvvMemory1.pMizugiCount
        VVVendScreen.r5Count = vvvMemory1.r5Count
        VVVendScreen.r6Count = vvvMemory1.r6Count
        VVVendScreen.gCount = vvvMemory1.gCount
        vvv.zoneArrayCzVVVData = vvvMemory1.zoneArrayCzVVVData
        vvv.characterArrayCzVVVData = vvvMemory1.characterArrayCzVVVData
        vvv.resultArrayCzVVVData = vvvMemory1.resultArrayCzVVVData
        vvv.kakumeiCount = vvvMemory1.kakumeiCount
        vvv.kessenCount = vvvMemory1.kessenCount
        vvv.bonusCountSum = vvvMemory1.bonusCountSum
        VVVendScreen.screenCountSum = vvvMemory1.screenCountSum
        VVVharakiri.afterSetCountSum = vvvMemory1.afterSetCountSum
        VVVharakiri.allDriveCountSum = vvvMemory1.allDriveCountSum
        VVVharakiri.allSetCountSum = vvvMemory1.allSetCountSum
    }
    func loadMemory2() {
        VVVharakiri.before1020Count = vvvMemory2.before1020Count
        VVVharakiri.beforeDriveCount = vvvMemory2.beforeDriveCount
        VVVharakiri.after1020Count = vvvMemory2.after1020Count
        VVVharakiri.afterDriveCount = vvvMemory2.afterDriveCount
        VVVmarie.marieCount = vvvMemory2.marieCount
        VVVendScreen.w2Count = vvvMemory2.w2Count
        VVVendScreen.w3Count = vvvMemory2.w3Count
        VVVendScreen.w4Count = vvvMemory2.w4Count
        VVVendScreen.pManCount = vvvMemory2.pManCount
        VVVendScreen.pMizugiCount = vvvMemory2.pMizugiCount
        VVVendScreen.r5Count = vvvMemory2.r5Count
        VVVendScreen.r6Count = vvvMemory2.r6Count
        VVVendScreen.gCount = vvvMemory2.gCount
        vvv.zoneArrayCzVVVData = vvvMemory2.zoneArrayCzVVVData
        vvv.characterArrayCzVVVData = vvvMemory2.characterArrayCzVVVData
        vvv.resultArrayCzVVVData = vvvMemory2.resultArrayCzVVVData
        vvv.kakumeiCount = vvvMemory2.kakumeiCount
        vvv.kessenCount = vvvMemory2.kessenCount
        vvv.bonusCountSum = vvvMemory2.bonusCountSum
        VVVendScreen.screenCountSum = vvvMemory2.screenCountSum
        VVVharakiri.afterSetCountSum = vvvMemory2.afterSetCountSum
        VVVharakiri.allDriveCountSum = vvvMemory2.allDriveCountSum
        VVVharakiri.allSetCountSum = vvvMemory2.allSetCountSum
    }
    func loadMemory3() {
        VVVharakiri.before1020Count = vvvMemory3.before1020Count
        VVVharakiri.beforeDriveCount = vvvMemory3.beforeDriveCount
        VVVharakiri.after1020Count = vvvMemory3.after1020Count
        VVVharakiri.afterDriveCount = vvvMemory3.afterDriveCount
        VVVmarie.marieCount = vvvMemory3.marieCount
        VVVendScreen.w2Count = vvvMemory3.w2Count
        VVVendScreen.w3Count = vvvMemory3.w3Count
        VVVendScreen.w4Count = vvvMemory3.w4Count
        VVVendScreen.pManCount = vvvMemory3.pManCount
        VVVendScreen.pMizugiCount = vvvMemory3.pMizugiCount
        VVVendScreen.r5Count = vvvMemory3.r5Count
        VVVendScreen.r6Count = vvvMemory3.r6Count
        VVVendScreen.gCount = vvvMemory3.gCount
        vvv.zoneArrayCzVVVData = vvvMemory3.zoneArrayCzVVVData
        vvv.characterArrayCzVVVData = vvvMemory3.characterArrayCzVVVData
        vvv.resultArrayCzVVVData = vvvMemory3.resultArrayCzVVVData
        vvv.kakumeiCount = vvvMemory3.kakumeiCount
        vvv.kessenCount = vvvMemory3.kessenCount
        vvv.bonusCountSum = vvvMemory3.bonusCountSum
        VVVendScreen.screenCountSum = vvvMemory3.screenCountSum
        VVVharakiri.afterSetCountSum = vvvMemory3.afterSetCountSum
        VVVharakiri.allDriveCountSum = vvvMemory3.allDriveCountSum
        VVVharakiri.allSetCountSum = vvvMemory3.allSetCountSum
    }
}

#Preview {
    VVV_Top()
}
