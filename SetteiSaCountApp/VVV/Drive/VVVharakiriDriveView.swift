//
//  VVVharakiriDriveView.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/13.
//

import SwiftUI


// ///////////////////////
// 変数
// ///////////////////////
class VVVharakiriVar: ObservableObject {
    @AppStorage("VVVharakiriBefore1020Count") var before1020Count = 0 {
        didSet {
            allSetCountSum = countSum(before1020Count, beforeDriveCount, after1020Count, afterDriveCount)
        }
    }
    @AppStorage("VVVharakiriBeforeDriveCount") var beforeDriveCount = 0 {
        didSet {
            allDriveCountSum = countSum(beforeDriveCount, afterDriveCount)
            allSetCountSum = countSum(before1020Count, beforeDriveCount, after1020Count, afterDriveCount)
        }
    }
    @AppStorage("VVVharakiriAfter1020Count") var after1020Count = 0 {
        didSet {
            afterSetCountSum = countSum(after1020Count, afterDriveCount)
            allSetCountSum = countSum(before1020Count, beforeDriveCount, after1020Count, afterDriveCount)
        }
    }
        @AppStorage("VVVharakiriAfterDriveCount") var afterDriveCount = 0 {
            didSet {
                afterSetCountSum = countSum(after1020Count, afterDriveCount)
                allDriveCountSum = countSum(beforeDriveCount, afterDriveCount)
                allSetCountSum = countSum(before1020Count, beforeDriveCount, after1020Count, afterDriveCount)
            }
        }
    @AppStorage("VVVharakiriAfterSetCountSum") var afterSetCountSum = 0
    @AppStorage("VVVharakiriAllDriveCountSum") var allDriveCountSum = 0
    @AppStorage("VVVharakiriAllSetCountSum") var allSetCountSum = 0
    
    
    // //// 有利切断前のドライブ確率算出
    // カウントの合計
    var beforeCountSum: Int {
        return before1020Count + beforeDriveCount
    }
    // 確率分母
    var beforeDriveDenominator: Double {
        let denominator = Double(beforeCountSum) / Double(beforeDriveCount)
//        return beforeDriveCount > 0 ? denominator : Double(beforeCountSum)   // ドライブ0の時は分母も0になるように修正
        return beforeDriveCount > 0 ? denominator : 0.0
    }
    
    // //// 有利切断後のドライブ確率算出
    // カウントの合計
    var afterCountSum: Int {
        return after1020Count + afterDriveCount
    }
    // 確率分母
    var afterDriveDenominator: Double {
        let denominator = Double(afterCountSum) / Double(afterDriveCount)
//        return afterDriveCount > 0 ? denominator : Double(afterCountSum)   // ドライブ0の時は分母も０になるように修正
        return afterDriveCount > 0 ? denominator : 0.0
    }
    
    // //// トータル確率の算出
    // 全カウント合計
    var totalSum: Int {
        return beforeCountSum + afterCountSum
    }
    // ドライブカウント合計
    var totalDriveSum: Int {
        return beforeDriveCount + afterDriveCount
    }
    // 確率分母
    var totalDriveDenomination: Double {
        let denomination = Double(totalSum) / Double(totalDriveSum)
//        return totalDriveSum > 0 ? denomination : Double(totalSum)    // ドライブ０の時は分母も０になるように修正
        return totalDriveSum > 0 ? denomination : 0.0
    }
    
    @AppStorage("vvvDriveMinusCheck") var minusCheck = false
    
    // Tips
    var tipDriveBefore = VVVTipDriveBefore()
    var tipDrive1020Button = VVVTipDrive1020Button()
    var tipDriveDriveButton = VVVTipDriveDriveButton()
}


// ///////////////////////
// ビュー：メインビュー
// ///////////////////////
struct VVVharakiriDriveView: View {
    @ObservedObject var VVVharakiri = VVVharakiriVar()
    @State var isShowAlert = false
    @State var isShowExviewDrive = false
    @State var isShowExViewRoundScreen = false
//    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    var body: some View {
//        NavigationView {
            // //// 縦・横で配置を変える、画面の縦横比を取得しそれで条件分岐させる
            GeometryReader { geometry in
                // //// 縦画面
                if geometry.size.height > geometry.size.width {
                    List {
                        // //// 有利区間切断前のカウント
                        Section {
                            VVVharakiriDriveSubBeforeCutCountView(VVVharakiri: VVVharakiri)
                        } header: {
                            Text("有利区間切断前")
                        }
                        .popoverTip(VVVharakiri.tipDriveBefore)
                        
                        // //// 有利区間切断後のカウント
                        Section {
                            VVVharakiriDriveSubAfterCutCountView(VVVharakiri: VVVharakiri)
                        } header: {
                            Text("有利区間切断後")
                        }
                        
                        // //// トータルのカウント結果
                        Section {
                            VVVharakiriDriveSubTotalView()
                        } header: {
                            Text("トータル")
                        }
                        
                        // //// 参考情報のリンク
                        Section {
                            // ハラキリの説明リンク
                            Button(action: {
                                isShowExviewDrive.toggle()
                            }, label: {
                                Text(">> ハラキリドライブについて")
                                    .frame(maxWidth: .infinity, alignment: .trailing)
//                                    .foregroundColor(.blue)
                                    .foregroundStyle(Color.blue)
                            })
                            .sheet(isPresented: $isShowExviewDrive, content: {
                                VVVexViewDrive()
                                    .presentationDetents([.medium])
                            })
                            
                            // ラウンド開始画面の示唆
                            Button(action: {
                                isShowExViewRoundScreen.toggle()
                            }, label: {
                                Text(">> ラウンド開始画面の示唆")
                                    .frame(maxWidth: .infinity, alignment: .trailing)
//                                    .foregroundColor(.blue)
                                    .foregroundStyle(Color.blue)
                            })
                            .sheet(isPresented: $isShowExViewRoundScreen, content: {
                                VVVexViewRoundScreen()
                                    .presentationDetents([.medium])
                            })
                            // //// 95%信頼区間グラフへのリンク
                            unitNaviLink95Ci(Ci95view: AnyView(vvvView95Ci(selection: 6)))
                                .popoverTip(tipUnitButtonLink95Ci())
                        } header: {
                            
                        }
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        unitClearScrollSection(spaceHeight: 200)
                        
                    }
                }
                
                // //// 横画面
                else {
                    List {
                        Section {
                            HStack {
                                // //// 有利区間切断前のカウント
                                VStack {
                                    Text("    有利区間切断前")
                                        .font(.caption)
//                                        .foregroundColor(.secondary)
                                        .foregroundStyle(Color.secondary)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    ZStack {
                                        Rectangle()
//                                            .foregroundColor(Color(UIColor.systemBackground))
                                            .foregroundStyle(Color(UIColor.systemBackground))
                                            .cornerRadius(15)
                                        VVVharakiriDriveSubBeforeCutCountView(VVVharakiri: VVVharakiri)
                                            .padding(.all)
                                    }
                                }
                                // //// 有利区間切断後のカウント
                                VStack {
                                    Text("    有利区間切断後")
                                        .font(.caption)
//                                        .foregroundColor(.secondary)
                                        .foregroundStyle(Color.secondary)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    ZStack {
                                        Rectangle()
//                                            .foregroundColor(Color(UIColor.systemBackground))
                                            .foregroundStyle(Color(UIColor.systemBackground))
                                            .cornerRadius(15)
                                        VVVharakiriDriveSubAfterCutCountView(VVVharakiri: VVVharakiri)
                                            .padding(.all)
                                    }
                                }
                            }
                        }
                        .listRowBackground(Color.clear)
                        
                        // //// トータルのカウント結果
                        Section {
                            VVVharakiriDriveSubTotalView()
                        } header: {
                            Text("トータル")
                        }
                        
                        // //// 参考情報のリンク
                        Section {
                            // ハラキリの説明リンク
                            Button(action: {
                                isShowExviewDrive.toggle()
                            }, label: {
                                Text(">> ハラキリドライブについて")
                                    .frame(maxWidth: .infinity, alignment: .trailing)
//                                    .foregroundColor(.blue)
                                    .foregroundStyle(Color.blue)
                            })
                            .sheet(isPresented: $isShowExviewDrive, content: {
                                VVVexViewDrive()
                                    .presentationDetents([.medium])
                            })
                            
                            // ラウンド開始画面の示唆
                            Button(action: {
                                isShowExViewRoundScreen.toggle()
                            }, label: {
                                Text(">> ラウンド開始画面の示唆")
                                    .frame(maxWidth: .infinity, alignment: .trailing)
//                                    .foregroundColor(.blue)
                                    .foregroundStyle(Color.blue)
                            })
                            .sheet(isPresented: $isShowExViewRoundScreen, content: {
                                VVVexViewRoundScreen()
                                    .presentationDetents([.medium])
                            })
                            // //// 95%信頼区間グラフへのリンク
                            unitNaviLink95Ci(Ci95view: AnyView(vvvView95Ci(selection: 6)))
                                .popoverTip(tipUnitButtonLink95Ci())
                        } header: {
                            
                        }
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        
                        
                    }
                }
            }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "革命機ヴァルヴレイヴ",
                screenClass: screenClass
            )
        }
            .navigationTitle("ハラキリドライブ")
            .navigationBarTitleDisplayMode(.inline)
            
            // //// ツールバーボタン
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    HStack {
                        // マイナスボタン
                        Button(action: {
                            VVVharakiri.minusCheck.toggle()
                        }, label: {
                            if VVVharakiri.minusCheck == true{
                                Image(systemName: "minus.circle.fill")
//                                    .foregroundColor(Color.red)
                                    .foregroundStyle(Color.red)
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
                                VVVfuncResetDrive(VVVharakiri: VVVharakiri)
                                UINotificationFeedbackGenerator().notificationOccurred(.warning)
                            }
                        } message: {
                            Text("ページ内のデータは完全に消去されます")
                        }
                    }
                }
            }
//        }
//        .navigationTitle("ハラキリドライブ")
//        .navigationBarTitleDisplayMode(.inline)
//        
//        // //// ツールバーボタン
//        .toolbar {
//            ToolbarItem(placement: .automatic) {
//                HStack {
//                    // マイナスボタン
//                    Button(action: {
//                        VVVharakiri.minusCheck.toggle()
//                    }, label: {
//                        if VVVharakiri.minusCheck == true{
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
//                            VVVfuncResetDrive(VVVharakiri: VVVharakiri)
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


// ////////////////////////////
// ビュー：有利区間切断前のカウント用
// ////////////////////////////
struct VVVharakiriDriveSubBeforeCutCountView: View {
    @ObservedObject var VVVharakiri = VVVharakiriVar()
    
    var body: some View {
        HStack {
            // //// 10G,20Gのカウント
            ZStack {
                // 背景フラッシュ用
                Rectangle()
                    .backgroundFlashModifier(trigger: VVVharakiri.before1020Count, color: Color("personalSummerLightBlue"))
                
                // ボタン＆回数表示
                VStack(spacing: 5) {
                    Text("10,20G")
                    Text("\(VVVharakiri.before1020Count)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Button(action: {
                        VVVharakiri.before1020Count = countUpDown(minusCheck: VVVharakiri.minusCheck, count: VVVharakiri.before1020Count)
                    }, label: {
                        Text("")
                    })
                    .buttonStyle(CountButtonStyle(color: Color("personalSummerLightBlue"), MinusBool: VVVharakiri.minusCheck))
                    .popoverTip(VVVharakiri.tipDrive1020Button)
                }
            }
            .frame(maxWidth: .infinity)
            // //// ハラキリドライブのカウント
            ZStack {
                // 背景フラッシュ用
                Rectangle()
                    .backgroundFlashModifier(trigger: VVVharakiri.beforeDriveCount, color: Color("personalSummerLightGreen"))
                
                // ボタン＆回数表示
                VStack(spacing: 5) {
                    Text("ドライブ")
                    Text("\(VVVharakiri.beforeDriveCount)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Button(action: {
                        VVVharakiri.beforeDriveCount = countUpDown(minusCheck: VVVharakiri.minusCheck, count: VVVharakiri.beforeDriveCount)
                    }, label: {
                        Text("")
                    })
                    .buttonStyle(CountButtonStyle(color: Color("personalSummerLightGreen"), MinusBool: VVVharakiri.minusCheck))
//                    .popoverTip(VVVharakiri.tipDriveDriveButton)
                }
            }
            .frame(maxWidth: .infinity)
            
            // //// ドライブ確率の表示
            ZStack {
                // 背景用
                Rectangle()
//                    .foregroundColor(Color("personalSummerLightRed"))
                    .foregroundStyle(Color.personalSummerLightRed)
                    .cornerRadius(15)
                // 確率表示
                VStack {
                    Text("ドライブ\n確率")
                        .multilineTextAlignment(.center)
                        .padding(.top, 7.0)
                    Spacer()
                    Text("\(VVVharakiri.beforeDriveCount > 0 ? 1 : 0) /")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("\(String(format: "%.1f", VVVharakiri.beforeDriveDenominator))")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}


// ////////////////////////////
// ビュー：有利区間切断前のカウント用
// ////////////////////////////
struct VVVharakiriDriveSubAfterCutCountView: View {
    @ObservedObject var VVVharakiri = VVVharakiriVar()
    
    var body: some View {
        HStack {
            // //// 10G,20Gのカウント
            ZStack {
                // 背景フラッシュ用
                Rectangle()
                    .backgroundFlashModifier(trigger: VVVharakiri.after1020Count, color: Color("personalSummerLightBlue"))
                
                // ボタン＆回数表示
                VStack(spacing: 5) {
                    Text("10,20G")
                    Text("\(VVVharakiri.after1020Count)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Button(action: {
                        VVVharakiri.after1020Count = countUpDown(minusCheck: VVVharakiri.minusCheck, count: VVVharakiri.after1020Count)
                    }, label: {
                        Text("")
                    })
                    .buttonStyle(CountButtonStyle(color: Color("personalSummerLightBlue"), MinusBool: VVVharakiri.minusCheck))
                }
            }
            .frame(maxWidth: .infinity)
            // //// ハラキリドライブのカウント
            ZStack {
                // 背景フラッシュ用
                Rectangle()
                    .backgroundFlashModifier(trigger: VVVharakiri.afterDriveCount, color: Color("personalSummerLightGreen"))
                
                // ボタン＆回数表示
                VStack(spacing: 5) {
                    Text("ドライブ")
                    Text("\(VVVharakiri.afterDriveCount)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Button(action: {
                        VVVharakiri.afterDriveCount = countUpDown(minusCheck: VVVharakiri.minusCheck, count: VVVharakiri.afterDriveCount)
                    }, label: {
                        Text("")
                    })
                    .buttonStyle(CountButtonStyle(color: Color("personalSummerLightGreen"), MinusBool: VVVharakiri.minusCheck))
                }
            }
            .frame(maxWidth: .infinity)
            
            // //// ドライブ確率の表示
            ZStack {
                // 背景用
                Rectangle()
//                    .foregroundColor(Color("personalSummerLightRed"))
                    .foregroundStyle(Color.personalSummerLightRed)
                    .cornerRadius(15)
                // 確率表示
                VStack {
                    Text("ドライブ\n確率")
                        .multilineTextAlignment(.center)
                        .padding(.top, 7.0)
                    Spacer()
                    Text("\(VVVharakiri.afterDriveCount > 0 ? 1 : 0) /")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("\(String(format: "%.1f", VVVharakiri.afterDriveDenominator))")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}


// ////////////////////////
// ビュー：トータル確率
// ////////////////////////
struct VVVharakiriDriveSubTotalView: View {
    @ObservedObject var VVVharakiri = VVVharakiriVar()
    
    var body: some View {
        ZStack {
            // 背景用
            HStack {
                Spacer()
                Rectangle()
//                    .foregroundColor(Color("personalSummerLightRed"))
                    .foregroundStyle(Color.personalSummerLightRed)
                    .cornerRadius(15)
                Spacer()
            }
            VStack {
                Text("Totalドライブ確率")
                Text("\(VVVharakiri.totalDriveSum > 0 ? 1 : 0) / \(String(format: "%.1f", VVVharakiri.totalDriveDenomination))")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
        }
    }
}


// //////////////////////
// 関数：全リセット
// //////////////////////
func VVVfuncResetDrive(VVVharakiri: VVVharakiriVar) {
    VVVharakiri.before1020Count = 0
    VVVharakiri.beforeDriveCount = 0
    VVVharakiri.after1020Count = 0
    VVVharakiri.afterDriveCount = 0
    VVVharakiri.minusCheck = false
}

#Preview {
    VVVharakiriDriveView()
}
