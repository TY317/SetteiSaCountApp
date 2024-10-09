//
//  VVV_Top.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/06.
//

import SwiftUI

struct VVV_Top: View {
    @State var isShowAlert = false
    @ObservedObject var cz = czVar()
    @ObservedObject var VVVendScreen = VVVendScreenVar()
    @ObservedObject var VVVmarie = VVVmarieVar()
    @ObservedObject var VVVharakiri = VVVharakiriVar()
    @ObservedObject var vvv = vvvCzHistory()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // CZ当選履歴
                    NavigationLink(destination: vvvViewCzHistoryVer2()) {//VVV_CZ()) {
                        unitLabelMenu(imageSystemName: "pencil.and.list.clipboard", textBody: "CZ,ボーナス当選履歴")
//                        Image(systemName: "pencil.and.list.clipboard")
//                            .foregroundColor(Color.gray)
//                            .font(.title2)
//                        Text("CZ,ボーナス当選履歴")
                    }
                    
                    // CZ,ボーナス終了画面
                    NavigationLink(destination: VVVendScreenView()) {
                        unitLabelMenu(imageSystemName: "photo.stack", textBody: "CZ,ボーナス終了画面")
//                        Image(systemName: "photo.stack")
//                            .foregroundColor(Color.purple)
//                            .font(.title2)
//                        Text("CZ,ボーナス終了画面")
                    }
                    
                    // 革命ボーナス中のマリエ覚醒
                    NavigationLink(destination: VVVmarieView()) {
                        unitLabelMenu(imageSystemName: "infinity", textBody: "革命ボーナス中のマリエ覚醒")
//                        Image(systemName: "infinity")
//                            .foregroundColor(Color.red)
//                            .font(.title3)
//                        Text("革命ボーナス中のマリエ覚醒")
                    }
                    
                    // ハラキリドライブ
                    NavigationLink(destination: VVVharakiriDriveView()) {
                        unitLabelMenu(imageSystemName: "50.square", textBody: "ハラキリドライブ")
//                        Image(systemName: "50.square")
//                            .foregroundColor(Color.gray)
//                            .font(.title2)
//                        Text("ハラキリドライブ")
                    }
                } header: {
                    HStack {
                        Spacer()
                        Text("革命機ヴァルヴレイヴ")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    
                }
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
                    // データリセットボタン
                    Button("リセット", systemImage: "arrow.clockwise.square") {
                        isShowAlert = true
                    }
                    .alert("データリセット", isPresented: $isShowAlert) {
                        Button("キャンセル", role: .cancel) {
                            
                        }
                        Button("リセット", role: .destructive) {
                            VVVfuncResetCz(cz: cz)
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

#Preview {
    VVV_Top()
}
