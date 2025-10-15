//
//  VVVmarie.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/13.
//

import SwiftUI


// //////////////////////
// 変数
// //////////////////////
class VVVmarieVar: ObservableObject {
    @ObservedObject var cz = czVar()
    @AppStorage("VVVmarieCount") var marieCount = 0
    @AppStorage("vvvMarieMinusCheck") var minusCheck = false
    
    // マリエ覚醒確率の算出
    var marieRatio: Double {
        let ratio = Double(marieCount) / Double(cz.kakumeiCount) * 100
        return cz.kakumeiCount > 0 ? ratio : 0.0
    }
    
    // Tips
    var marieTip = VVVTipMarieCount()
}

// /////////////////////
// ビュー：メインビュー
// /////////////////////
struct VVVmarieView: View {
//    @ObservedObject var ver391: Ver391
    @ObservedObject var VVVendScreen: VVVendScreenVar
    @ObservedObject var VVVmarie: VVVmarieVar
    @ObservedObject var VVVharakiri: VVVharakiriVar
    @ObservedObject var vvv: vvvCzHistory
    @ObservedObject var cz = czVar()
//    @ObservedObject var VVVmarie = VVVmarieVar()
    @State var isShowAlert = false
    @State var isShowExView = false
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    
    var body: some View {
//        NavigationView {
            List {
                Section("マリエ覚醒") {
                    VVVmarieSubCountView(cz: cz, VVVmarie: VVVmarie)
                    
                    // 革命ボーナス回数表示
                    HStack {
                        Text("革命ボーナス        \(cz.kakumeiCount) 回")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    // 参考情報へのリンク：マリエ覚醒
                    Button(action: {
                        isShowExView.toggle()
                    }, label: {
                        Text(">> マリエ覚醒について")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    })
                    .sheet(isPresented: $isShowExView, content: {
                        VVVexViewMarie()
                            .presentationDetents([.medium])
                    })
                    // //// 95%信頼区間グラフへのリンク
                    unitNaviLink95Ci(Ci95view: AnyView(vvvView95Ci(selection: 5)))
                    // //// 設定期待値へのリンク
                    unitNaviLinkBayes {
                        VVVViewBayes(
//                            ver391: ver391,
                            VVVendScreen: VVVendScreen,
                            VVVmarie: VVVmarie,
                            VVVharakiri: VVVharakiri,
                            vvv: vvv,
                            bayes: bayes,
                            viewModel: viewModel,
                        )
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
            .navigationTitle("マリエ覚醒")
            .navigationBarTitleDisplayMode(.inline)
            
            // //// ツールバーボタン
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    HStack {
                        // マイナスボタン
                        Button(action: {
                            VVVmarie.minusCheck.toggle()
                        }, label: {
                            if VVVmarie.minusCheck == true{
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
                                VVVfuncResetMarie(VVVmarie: VVVmarie)
                                UINotificationFeedbackGenerator().notificationOccurred(.warning)
                            }
                        } message: {
                            Text("ページ内のデータは完全に消去されます")
                        }
                    }
                }
            }
//        }
//        .navigationTitle("マリエ覚醒")
//        .navigationBarTitleDisplayMode(.inline)
//        
//        // //// ツールバーボタン
//        .toolbar {
//            ToolbarItem(placement: .automatic) {
//                HStack {
//                    // マイナスボタン
//                    Button(action: {
//                        VVVmarie.minusCheck.toggle()
//                    }, label: {
//                        if VVVmarie.minusCheck == true{
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
//                            VVVfuncResetMarie(VVVmarie: VVVmarie)
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
// ビュー：マリエ覚醒カウントと革命回数、比率の表示
// ////////////////////////////
struct VVVmarieSubCountView: View {
    @ObservedObject var cz = czVar()
    @ObservedObject var VVVmarie: VVVmarieVar
    
    var body: some View {
        ZStack {
            // 背景フラッシュ用
            Rectangle()
                .backgroundFlashModifier(trigger: VVVmarie.marieCount, color: Color("personalSummerLightRed"))
            
            // 表示＆ボタンのブロック
            HStack {
                // ボタン
                Button(action: {
                    // カウントアップ処理
                    if VVVmarie.minusCheck == false {
                        VVVmarie.marieCount += 1
                        UINotificationFeedbackGenerator().notificationOccurred(.warning)
                    }
                    // カウントダウン処理
                    else {
                        if VVVmarie.marieCount > 0 {
                            VVVmarie.marieCount -= 1
                            UINotificationFeedbackGenerator().notificationOccurred(.warning)
                        }
                        else {
                            
                        }
                    }
                }, label: {
                    Text("")
                })
                .buttonStyle(CountButtonStyle(color: Color("personalSummerLightRed"),minusColor: .red, MinusBool: VVVmarie.minusCheck))
                .frame(maxWidth: .infinity)
                .popoverTip(VVVmarie.marieTip)
                
                // 回数
                ZStack {
                    Rectangle()
//                        .foregroundColor(Color("grayBack"))
                        .foregroundStyle(Color.grayBack)
                        .cornerRadius(15)
                    VStack {
                        Text("回数")
                            .font(.title3)
                            .padding(.top, 3.0)
                        Spacer()
                    }
                    VStack {
                        Spacer()
                        Text("\(VVVmarie.marieCount)")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.top)
                        Spacer()
                    }
                }
                .frame(maxWidth: .infinity)
                // 確率
                ZStack {
                    Rectangle()
//                        .foregroundColor(Color("personalSummerLightRed"))
                        .foregroundStyle(Color.personalSummerLightRed)
                        .cornerRadius(15)
                    VStack {
                        Text("確率")
                            .font(.title3)
                        //                                            .fontWeight(.bold)
                            .padding(.top, 3.0)
                        Spacer()
                    }
                    VStack {
                        Spacer()
                        Text("\(String(format: "%.0f", VVVmarie.marieRatio))%")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.top)
                        Spacer()
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .frame(height: 80)
    }
}


// //////////////////////
// 関数：全リセット
// //////////////////////
func VVVfuncResetMarie(VVVmarie: VVVmarieVar) {
    VVVmarie.minusCheck = false
    VVVmarie.marieCount = 0
}


#Preview {
    VVVmarieView(
//        ver391: Ver391(),
        VVVendScreen: VVVendScreenVar(),
        VVVmarie: VVVmarieVar(),
        VVVharakiri: VVVharakiriVar(),
        vvv: vvvCzHistory(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
