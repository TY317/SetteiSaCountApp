//
//  endScreenVVV.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/12.
//

import SwiftUI

// //////////////////////
// 変数
// //////////////////////
class VVVendScreenVar: ObservableObject {
    // //// 画像の選択状態
    @Published var isSelectedScreen = ""
    let w2Selectedkey = "w2"
    let w3Selectedkey = "w3"
    let w4Selectedkey = "w4"
    let pManSelectedkey = "pMan"
    let pMizugiSelectedkey = "pMizugi"
    let r5Selectedkey = "r5"
    let r6Selectedkey = "r6"
    let gSelectedkey = "g"
    
    // //// カウント回数
    @AppStorage("VVVendScreenW2Count") var w2Count = 0     // 白枠2人のカウント回数
    @AppStorage("VVVendScreenW3Count") var w3Count = 0     // 白枠3人のカウント回数
    @AppStorage("VVVendScreenW4Count") var w4Count = 0     // 白枠4人のカウント回数
    @AppStorage("VVVendScreenPManCount") var pManCount = 0     // 紫枠男性集合のカウント回数
    @AppStorage("VVVendScreenPMizugiCount") var pMizugiCount = 0     // 紫枠水着のカウント回数
    @AppStorage("VVVendScreenR5Count") var r5Count = 0     // 赤枠5人のカウント回数
    @AppStorage("VVVendScreenR6Count") var r6Count = 0     // 赤枠6人のカウント回数
    @AppStorage("VVVendScreenGCount") var gCount = 0     // 金枠のカウント回数
    
    @AppStorage("vvvScreenMinusCheck") var minusCheck = false      // マイナスボタンのチェック状態
    @Published var w2select = false
    
    // //// 出現確率％を算出
    // 全画面の合計カウント
    var countSum: Int {
        return w2Count+w3Count+w4Count+pManCount+pMizugiCount+r5Count+r6Count+gCount
    }
    // 白枠2人
    var w2Ratio: Double {
        let ratio = Double(w2Count) / Double(countSum) * 100
        return countSum > 0 ? ratio : 0.0
    }
    // 白枠3人
    var w3Ratio: Double {
        let ratio = Double(w3Count) / Double(countSum) * 100
        return countSum > 0 ? ratio : 0.0
    }
    // 白枠4人
    var w4Ratio: Double {
        let ratio = Double(w4Count) / Double(countSum) * 100
        return countSum > 0 ? ratio : 0.0
    }
    // 紫枠男性集合
    var pManRatio: Double {
        let ratio = Double(pManCount) / Double(countSum) * 100
        return countSum > 0 ? ratio : 0.0
    }
    // 紫枠水着集合
    var pMizugiRatio: Double {
        let ratio = Double(pMizugiCount) / Double(countSum) * 100
        return countSum > 0 ? ratio : 0.0
    }
    // 赤枠5人
    var r5Ratio: Double {
        let ratio = Double(r5Count) / Double(countSum) * 100
        return countSum > 0 ? ratio : 0.0
    }
    // 赤枠6人
    var r6Ratio: Double {
        let ratio = Double(r6Count) / Double(countSum) * 100
        return countSum > 0 ? ratio : 0.0
    }
    // 金枠
    var gRatio: Double {
        let ratio = Double(gCount) / Double(countSum) * 100
        return countSum > 0 ? ratio : 0.0
    }
    
    // Tips
    var fisttip = VVVTipEndScreenFirstTap()
    var secondTip = VVVTipEndScreenSecondTap()
}

// ///////////////////////
// ビュー：メインビュー
// ///////////////////////
struct VVVendScreenView: View {
    @ObservedObject var VVVendScreen = VVVendScreenVar()
    @State var isShowAlert = false
    @State var isShowexView = false
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
//    private var tip = VVVendScreenTip()
    
    var body: some View {
//        NavigationView {
            List {
                Section ("画面選択ボタン"){
                    // //// 終了画面選択＆カウントボタン
                    VVVscreenChoiceView(VVVendScreen: VVVendScreen)
                        .listRowBackground(Color.clear)
                }
//                .popoverTip(tip)
                
                // //// 結果表示
                Section("カウント結果"){
                    // 白枠2人
                    ZStack {
                        Rectangle()
                            .backgroundFlashModifier(trigger: VVVendScreen.w2Count, color: .gray)
                        HStack {
                            Text("デフォルト")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            HStack {
                                Text("\(VVVendScreen.w2Count)")
                                    .frame(maxWidth: .infinity, alignment: .center)
                                Text("(\(String(format: "%.1f", VVVendScreen.w2Ratio))%)")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    // 白枠3人
                    ZStack {
                        Rectangle()
                            .backgroundFlashModifier(trigger: VVVendScreen.w3Count, color: .blue)
                        HStack {
                            Text("奇数設定示唆")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            HStack {
                                Text("\(VVVendScreen.w3Count)")
                                    .frame(maxWidth: .infinity, alignment: .center)
                                Text("(\(String(format: "%.1f", VVVendScreen.w3Ratio))%)")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    // 白枠3人
                    ZStack {
                        Rectangle()
                            .backgroundFlashModifier(trigger: VVVendScreen.w4Count, color: .green)
                        HStack {
                            Text("偶数設定示唆")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            HStack {
                                Text("\(VVVendScreen.w4Count)")
                                    .frame(maxWidth: .infinity, alignment: .center)
                                Text("(\(String(format: "%.1f", VVVendScreen.w4Ratio))%)")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    // 紫枠男性集合
                    ZStack {
                        Rectangle()
                            .backgroundFlashModifier(trigger: VVVendScreen.pManCount, color: .pink)
                        HStack {
                            Text("高設定示唆 弱")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            HStack {
                                Text("\(VVVendScreen.pManCount)")
                                    .frame(maxWidth: .infinity, alignment: .center)
                                Text("(\(String(format: "%.1f", VVVendScreen.pManRatio))%)")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    // 紫枠水着集合
                    ZStack {
                        Rectangle()
                            .backgroundFlashModifier(trigger: VVVendScreen.pMizugiCount, color: .purple)
                        HStack {
                            Text("高設定示唆 強")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            HStack {
                                Text("\(VVVendScreen.pMizugiCount)")
                                    .frame(maxWidth: .infinity, alignment: .center)
                                Text("(\(String(format: "%.1f", VVVendScreen.pMizugiRatio))%)")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    // 赤枠5人
                    ZStack {
                        Rectangle()
                            .backgroundFlashModifier(trigger: VVVendScreen.r5Count, color: .orange)
                        HStack {
                            Text("設定2以上濃厚")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            HStack {
                                Text("\(VVVendScreen.r5Count)")
                                    .frame(maxWidth: .infinity, alignment: .center)
                                Text("(\(String(format: "%.1f", VVVendScreen.r5Ratio))%)")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    // 赤枠6人
                    ZStack {
                        Rectangle()
                            .backgroundFlashModifier(trigger: VVVendScreen.r6Count, color: .red)
                        HStack {
                            Text("設定4以上濃厚")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            HStack {
                                Text("\(VVVendScreen.r6Count)")
                                    .frame(maxWidth: .infinity, alignment: .center)
                                Text("(\(String(format: "%.1f", VVVendScreen.r6Ratio))%)")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    // 金枠
                    ZStack {
                        Rectangle()
                            .backgroundFlashModifier(trigger: VVVendScreen.gCount, color: .yellow)
                        HStack {
                            Text("設定6濃厚")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            HStack {
                                Text("\(VVVendScreen.gCount)")
                                    .frame(maxWidth: .infinity, alignment: .center)
                                Text("(\(String(format: "%.1f", VVVendScreen.gRatio))%)")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                }
                // //// 画面タップで画面選択状態をリセット
                .onTapGesture {
                    VVVendScreen.isSelectedScreen = ""
                }
                
                Section {
                    // //// 参考情報リンク：終了画面について
                    Button(action: {
                        isShowexView.toggle()
                    }, label: {
                        Text(">> 終了画面について")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    })
                    .sheet(isPresented: $isShowexView, content: {
                        VVVexViewEndScreen()
                            .presentationDetents([.medium])
                    })
                }
                .listRowBackground(Color.clear)
                if orientation.isPortrait || (orientation.isFlat && lastOrientation.isPortrait) {
                    unitClearScrollSection(spaceHeight: 220)
                } else {
                    
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
            .navigationTitle("CZ,ボーナス終了画面")
            .navigationBarTitleDisplayMode(.inline)
            
            // //// ツールバーボタン
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    HStack {
                        // 画面選択リセット
                        unitButtonToolbarScreenSelectReset(currentKeyword: $VVVendScreen.isSelectedScreen)
                            .popoverTip(tipUnitButtonScreenChoiceClear())
                        // マイナスボタン
                        Button(action: {
                            VVVendScreen.minusCheck.toggle()
                        }, label: {
                            if VVVendScreen.minusCheck {
                                Image(systemName: "minus.circle.fill")
                                    .foregroundColor(Color.red)
                            } else {
                                Image(systemName: "minus.circle")
                            }
                        })
                        // データリセットボタン
                        Button("リセット", systemImage: "arrow.clockwise.square") {
                            isShowAlert = true
                        }
                        .alert("データリセット", isPresented: $isShowAlert) {
                            Button("キャンセル", role: .cancel) {
                                
                            }
                            Button("リセット", role: .destructive) {
                                VVVfuncResetEndScreen(VVVendScreen: VVVendScreen)
                                UINotificationFeedbackGenerator().notificationOccurred(.warning)
                            }
                        } message: {
                            Text("ページ内のデータは完全に消去されます")
                        }
                    }
                }
            }
//        }
//        .navigationTitle("CZ,ボーナス終了画面")
//        .navigationBarTitleDisplayMode(.inline)
//        
//        // //// ツールバーボタン
//        .toolbar {
//            ToolbarItem(placement: .automatic) {
//                HStack {
//                    // マイナスボタン
//                    Button(action: {
//                        VVVendScreen.minusCheck.toggle()
//                    }, label: {
//                        if VVVendScreen.minusCheck {
//                            Image(systemName: "minus.circle.fill")
//                                .foregroundColor(Color.red)
//                        } else {
//                            Image(systemName: "minus.circle")
//                        }
//                    })
//                    // データリセットボタン
//                    Button("リセット", systemImage: "arrow.clockwise.square") {
//                        isShowAlert = true
//                    }
//                    .alert("データリセット", isPresented: $isShowAlert) {
//                        Button("キャンセル", role: .cancel) {
//                            
//                        }
//                        Button("リセット", role: .destructive) {
//                            VVVfuncResetEndScreen(VVVendScreen: VVVendScreen)
//                            UINotificationFeedbackGenerator().notificationOccurred(.warning)
//                        }
//                    } message: {
//                        Text("ページ内のデータは完全に消去されます")
//                    }
//                }
//            }
//        }
    }
}


// /////////////////////
// ビュー：画面選択部分
// /////////////////////
struct VVVscreenChoiceView: View {
    @ObservedObject var VVVendScreen = VVVendScreenVar()
//    private var fisttip = VVVendScreenfistTip()
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 20) {
                // //// 白枠2人の選択ボタン
                Button(action: {
                    if VVVendScreen.isSelectedScreen == VVVendScreen.w2Selectedkey {
                        if VVVendScreen.minusCheck {
                            // 選択中＆マイナスチェックONの場合：カウントダウン処理
                            if VVVendScreen.w2Count > 0 {
                                VVVendScreen.w2Count -= 1
                                VVVendScreen.isSelectedScreen = ""
                                UINotificationFeedbackGenerator().notificationOccurred(.warning)
                            } else {
                                VVVendScreen.isSelectedScreen = ""
                            }
                            
                        }
                        // 選択中＆マイナスチェックOFFの場合：カウントアップ処理
                        else {
                            VVVendScreen.w2Count += 1
                            VVVendScreen.isSelectedScreen = ""
                            UINotificationFeedbackGenerator().notificationOccurred(.warning)
                        }
                    }
                    // 未選択時
                    else {
                        VVVendScreen.isSelectedScreen = VVVendScreen.w2Selectedkey
                    }
                }, label: {
                    // 選択中の表示
                    if VVVendScreen.isSelectedScreen == VVVendScreen.w2Selectedkey {
                        // 選択中＆マイナスチェックON時の表示
                        if VVVendScreen.minusCheck {
                            ZStack {
                                Image("endScreen1VVV")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .opacity(0.5)
                                    .border(Color.red, width: 10)
                                    .cornerRadius(10)
                                Image(systemName: "minus.circle")
                                    .foregroundColor(Color.red)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .background(Color.white)
                                    .cornerRadius(30)
                            }
                        }
                        // 選択中＆マイナスチェックOFF時の表示
                        else {
                            ZStack {
                                Image("endScreen1VVV")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .opacity(0.5)
                                    .border(Color.green, width: 10)
                                    .cornerRadius(10)
                                    .popoverTip(VVVendScreen.secondTip)
                                Image(systemName: "plus.circle")
                                    .foregroundColor(Color.green)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .background(Color.white)
                                    .cornerRadius(30)
                            }
                        }
                    }
                    // 未選択時の表示
                    else {
                        Image("endScreen1VVV")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                            .popoverTip(VVVendScreen.fisttip)
                    }
                })
                
                // //// 白枠3人の選択ボタン
                Button(action: {
                    if VVVendScreen.isSelectedScreen == VVVendScreen.w3Selectedkey {
                        if VVVendScreen.minusCheck {
                            // 選択中＆マイナスチェックONの場合：カウントダウン処理
                            if VVVendScreen.w3Count > 0 {
                                VVVendScreen.w3Count -= 1
                                VVVendScreen.isSelectedScreen = ""
                                UINotificationFeedbackGenerator().notificationOccurred(.warning)
                            } else {
                                VVVendScreen.isSelectedScreen = ""
                            }
                            
                        }
                        // 選択中＆マイナスチェックOFFの場合：カウントアップ処理
                        else {
                            VVVendScreen.w3Count += 1
                            VVVendScreen.isSelectedScreen = ""
                            UINotificationFeedbackGenerator().notificationOccurred(.warning)
                        }
                    }
                    // 未選択時
                    else {
                        VVVendScreen.isSelectedScreen = VVVendScreen.w3Selectedkey
                    }
                }, label: {
                    // 選択中の表示
                    if VVVendScreen.isSelectedScreen == VVVendScreen.w3Selectedkey {
                        // 選択中＆マイナスチェックON時の表示
                        if VVVendScreen.minusCheck {
                            ZStack {
                                Image("endScreen2VVV")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .opacity(0.5)
                                    .border(Color.red, width: 10)
                                    .cornerRadius(10)
                                Image(systemName: "minus.circle")
                                    .foregroundColor(Color.red)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .background(Color.white)
                                    .cornerRadius(30)
                            }
                        }
                        // 選択中＆マイナスチェックOFF時の表示
                        else {
                            ZStack {
                                Image("endScreen2VVV")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .opacity(0.5)
                                    .border(Color.green, width: 10)
                                    .cornerRadius(10)
                                Image(systemName: "plus.circle")
                                    .foregroundColor(Color.green)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .background(Color.white)
                                    .cornerRadius(30)
                            }
                        }
                    }
                    // 未選択時の表示
                    else {
                        Image("endScreen2VVV")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                    }
                })
                
                // //// 白枠4人の選択ボタン
                Button(action: {
                    if VVVendScreen.isSelectedScreen == VVVendScreen.w4Selectedkey {
                        if VVVendScreen.minusCheck {
                            // 選択中＆マイナスチェックONの場合：カウントダウン処理
                            if VVVendScreen.w4Count > 0 {
                                VVVendScreen.w4Count -= 1
                                VVVendScreen.isSelectedScreen = ""
                                UINotificationFeedbackGenerator().notificationOccurred(.warning)
                            } else {
                                VVVendScreen.isSelectedScreen = ""
                            }
                            
                        }
                        // 選択中＆マイナスチェックOFFの場合：カウントアップ処理
                        else {
                            VVVendScreen.w4Count += 1
                            VVVendScreen.isSelectedScreen = ""
                            UINotificationFeedbackGenerator().notificationOccurred(.warning)
                        }
                    }
                    // 未選択時
                    else {
                        VVVendScreen.isSelectedScreen = VVVendScreen.w4Selectedkey
                    }
                }, label: {
                    // 選択中の表示
                    if VVVendScreen.isSelectedScreen == VVVendScreen.w4Selectedkey {
                        // 選択中＆マイナスチェックON時の表示
                        if VVVendScreen.minusCheck {
                            ZStack {
                                Image("endScreen3VVV")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .opacity(0.5)
                                    .border(Color.red, width: 10)
                                    .cornerRadius(10)
                                Image(systemName: "minus.circle")
                                    .foregroundColor(Color.red)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .background(Color.white)
                                    .cornerRadius(30)
                            }
                        }
                        // 選択中＆マイナスチェックOFF時の表示
                        else {
                            ZStack {
                                Image("endScreen3VVV")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .opacity(0.5)
                                    .border(Color.green, width: 10)
                                    .cornerRadius(10)
                                Image(systemName: "plus.circle")
                                    .foregroundColor(Color.green)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .background(Color.white)
                                    .cornerRadius(30)
                            }
                        }
                    }
                    // 未選択時の表示
                    else {
                        Image("endScreen3VVV")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                    }
                })
                
                // //// 紫枠男性集合の選択ボタン
                Button(action: {
                    if VVVendScreen.isSelectedScreen == VVVendScreen.pManSelectedkey {
                        if VVVendScreen.minusCheck {
                            // 選択中＆マイナスチェックONの場合：カウントダウン処理
                            if VVVendScreen.pManCount > 0 {
                                VVVendScreen.pManCount -= 1
                                VVVendScreen.isSelectedScreen = ""
                                UINotificationFeedbackGenerator().notificationOccurred(.warning)
                            } else {
                                VVVendScreen.isSelectedScreen = ""
                            }
                            
                        }
                        // 選択中＆マイナスチェックOFFの場合：カウントアップ処理
                        else {
                            VVVendScreen.pManCount += 1
                            VVVendScreen.isSelectedScreen = ""
                            UINotificationFeedbackGenerator().notificationOccurred(.warning)
                        }
                    }
                    // 未選択時
                    else {
                        VVVendScreen.isSelectedScreen = VVVendScreen.pManSelectedkey
                    }
                }, label: {
                    // 選択中の表示
                    if VVVendScreen.isSelectedScreen == VVVendScreen.pManSelectedkey {
                        // 選択中＆マイナスチェックON時の表示
                        if VVVendScreen.minusCheck {
                            ZStack {
                                Image("endScreen6VVV")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .opacity(0.5)
                                    .border(Color.red, width: 10)
                                    .cornerRadius(10)
                                Image(systemName: "minus.circle")
                                    .foregroundColor(Color.red)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .background(Color.white)
                                    .cornerRadius(30)
                            }
                        }
                        // 選択中＆マイナスチェックOFF時の表示
                        else {
                            ZStack {
                                Image("endScreen6VVV")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .opacity(0.5)
                                    .border(Color.green, width: 10)
                                    .cornerRadius(10)
                                Image(systemName: "plus.circle")
                                    .foregroundColor(Color.green)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .background(Color.white)
                                    .cornerRadius(30)
                            }
                        }
                    }
                    // 未選択時の表示
                    else {
                        Image("endScreen6VVV")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                    }
                })
                
                // //// 紫枠水着の選択ボタン
                Button(action: {
                    if VVVendScreen.isSelectedScreen == VVVendScreen.pMizugiSelectedkey {
                        if VVVendScreen.minusCheck {
                            // 選択中＆マイナスチェックONの場合：カウントダウン処理
                            if VVVendScreen.pMizugiCount > 0 {
                                VVVendScreen.pMizugiCount -= 1
                                VVVendScreen.isSelectedScreen = ""
                                UINotificationFeedbackGenerator().notificationOccurred(.warning)
                            } else {
                                VVVendScreen.isSelectedScreen = ""
                            }
                            
                        }
                        // 選択中＆マイナスチェックOFFの場合：カウントアップ処理
                        else {
                            VVVendScreen.pMizugiCount += 1
                            VVVendScreen.isSelectedScreen = ""
                            UINotificationFeedbackGenerator().notificationOccurred(.warning)
                        }
                    }
                    // 未選択時
                    else {
                        VVVendScreen.isSelectedScreen = VVVendScreen.pMizugiSelectedkey
                    }
                }, label: {
                    // 選択中の表示
                    if VVVendScreen.isSelectedScreen == VVVendScreen.pMizugiSelectedkey {
                        // 選択中＆マイナスチェックON時の表示
                        if VVVendScreen.minusCheck {
                            ZStack {
                                Image("endScreen7VVV")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .opacity(0.5)
                                    .border(Color.red, width: 10)
                                    .cornerRadius(10)
                                Image(systemName: "minus.circle")
                                    .foregroundColor(Color.red)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .background(Color.white)
                                    .cornerRadius(30)
                            }
                        }
                        // 選択中＆マイナスチェックOFF時の表示
                        else {
                            ZStack {
                                Image("endScreen7VVV")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .opacity(0.5)
                                    .border(Color.green, width: 10)
                                    .cornerRadius(10)
                                Image(systemName: "plus.circle")
                                    .foregroundColor(Color.green)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .background(Color.white)
                                    .cornerRadius(30)
                            }
                        }
                    }
                    // 未選択時の表示
                    else {
                        Image("endScreen7VVV")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                    }
                })
                
                // //// 赤枠5人の選択ボタン
                Button(action: {
                    if VVVendScreen.isSelectedScreen == VVVendScreen.r5Selectedkey {
                        if VVVendScreen.minusCheck {
                            // 選択中＆マイナスチェックONの場合：カウントダウン処理
                            if VVVendScreen.r5Count > 0 {
                                VVVendScreen.r5Count -= 1
                                VVVendScreen.isSelectedScreen = ""
                                UINotificationFeedbackGenerator().notificationOccurred(.warning)
                            } else {
                                VVVendScreen.isSelectedScreen = ""
                            }
                            
                        }
                        // 選択中＆マイナスチェックOFFの場合：カウントアップ処理
                        else {
                            VVVendScreen.r5Count += 1
                            VVVendScreen.isSelectedScreen = ""
                            UINotificationFeedbackGenerator().notificationOccurred(.warning)
                        }
                    }
                    // 未選択時
                    else {
                        VVVendScreen.isSelectedScreen = VVVendScreen.r5Selectedkey
                    }
                }, label: {
                    // 選択中の表示
                    if VVVendScreen.isSelectedScreen == VVVendScreen.r5Selectedkey {
                        // 選択中＆マイナスチェックON時の表示
                        if VVVendScreen.minusCheck {
                            ZStack {
                                Image("endScreen4VVV")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .opacity(0.5)
                                    .border(Color.red, width: 10)
                                    .cornerRadius(10)
                                Image(systemName: "minus.circle")
                                    .foregroundColor(Color.red)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .background(Color.white)
                                    .cornerRadius(30)
                            }
                        }
                        // 選択中＆マイナスチェックOFF時の表示
                        else {
                            ZStack {
                                Image("endScreen4VVV")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .opacity(0.5)
                                    .border(Color.green, width: 10)
                                    .cornerRadius(10)
                                Image(systemName: "plus.circle")
                                    .foregroundColor(Color.green)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .background(Color.white)
                                    .cornerRadius(30)
                            }
                        }
                    }
                    // 未選択時の表示
                    else {
                        Image("endScreen4VVV")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                    }
                })
                
                // //// 赤枠6人の選択ボタン
                Button(action: {
                    if VVVendScreen.isSelectedScreen == VVVendScreen.r6Selectedkey {
                        if VVVendScreen.minusCheck {
                            // 選択中＆マイナスチェックONの場合：カウントダウン処理
                            if VVVendScreen.r6Count > 0 {
                                VVVendScreen.r6Count -= 1
                                VVVendScreen.isSelectedScreen = ""
                                UINotificationFeedbackGenerator().notificationOccurred(.warning)
                            } else {
                                VVVendScreen.isSelectedScreen = ""
                            }
                            
                        }
                        // 選択中＆マイナスチェックOFFの場合：カウントアップ処理
                        else {
                            VVVendScreen.r6Count += 1
                            VVVendScreen.isSelectedScreen = ""
                            UINotificationFeedbackGenerator().notificationOccurred(.warning)
                        }
                    }
                    // 未選択時
                    else {
                        VVVendScreen.isSelectedScreen = VVVendScreen.r6Selectedkey
                    }
                }, label: {
                    // 選択中の表示
                    if VVVendScreen.isSelectedScreen == VVVendScreen.r6Selectedkey {
                        // 選択中＆マイナスチェックON時の表示
                        if VVVendScreen.minusCheck {
                            ZStack {
                                Image("endScreen5VVV")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .opacity(0.5)
                                    .border(Color.red, width: 10)
                                    .cornerRadius(10)
                                Image(systemName: "minus.circle")
                                    .foregroundColor(Color.red)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .background(Color.white)
                                    .cornerRadius(30)
                            }
                        }
                        // 選択中＆マイナスチェックOFF時の表示
                        else {
                            ZStack {
                                Image("endScreen5VVV")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .opacity(0.5)
                                    .border(Color.green, width: 10)
                                    .cornerRadius(10)
                                Image(systemName: "plus.circle")
                                    .foregroundColor(Color.green)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .background(Color.white)
                                    .cornerRadius(30)
                            }
                        }
                    }
                    // 未選択時の表示
                    else {
                        Image("endScreen5VVV")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                    }
                })
                
                // //// 金枠の選択ボタン
                Button(action: {
                    if VVVendScreen.isSelectedScreen == VVVendScreen.gSelectedkey {
                        if VVVendScreen.minusCheck {
                            // 選択中＆マイナスチェックONの場合：カウントダウン処理
                            if VVVendScreen.gCount > 0 {
                                VVVendScreen.gCount -= 1
                                VVVendScreen.isSelectedScreen = ""
                                UINotificationFeedbackGenerator().notificationOccurred(.warning)
                            } else {
                                VVVendScreen.isSelectedScreen = ""
                            }
                            
                        }
                        // 選択中＆マイナスチェックOFFの場合：カウントアップ処理
                        else {
                            VVVendScreen.gCount += 1
                            VVVendScreen.isSelectedScreen = ""
                            UINotificationFeedbackGenerator().notificationOccurred(.warning)
                        }
                    }
                    // 未選択時
                    else {
                        VVVendScreen.isSelectedScreen = VVVendScreen.gSelectedkey
                    }
                }, label: {
                    // 選択中の表示
                    if VVVendScreen.isSelectedScreen == VVVendScreen.gSelectedkey {
                        // 選択中＆マイナスチェックON時の表示
                        if VVVendScreen.minusCheck {
                            ZStack {
                                Image("endScreen8VVV")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .opacity(0.5)
                                    .border(Color.red, width: 10)
                                    .cornerRadius(10)
                                Image(systemName: "minus.circle")
                                    .foregroundColor(Color.red)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .background(Color.white)
                                    .cornerRadius(30)
                            }
                        }
                        // 選択中＆マイナスチェックOFF時の表示
                        else {
                            ZStack {
                                Image("endScreen8VVV")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .opacity(0.5)
                                    .border(Color.green, width: 10)
                                    .cornerRadius(10)
                                Image(systemName: "plus.circle")
                                    .foregroundColor(Color.green)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .background(Color.white)
                                    .cornerRadius(30)
                            }
                        }
                    }
                    // 未選択時の表示
                    else {
                        Image("endScreen8VVV")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                    }
                })
            }
        }
        .frame(height: 120)
    }
}


// //////////////////////
// 関数：全リセット
// //////////////////////
func VVVfuncResetEndScreen(VVVendScreen: VVVendScreenVar) {
    
    VVVendScreen.w2Count = 0
    VVVendScreen.w3Count = 0
    VVVendScreen.w4Count = 0
    VVVendScreen.pManCount = 0
    VVVendScreen.pMizugiCount = 0
    VVVendScreen.r5Count = 0
    VVVendScreen.r6Count = 0
    VVVendScreen.gCount = 0
    VVVendScreen.isSelectedScreen = ""
    VVVendScreen.minusCheck = false
}

#Preview {
    VVVendScreenView()
}
