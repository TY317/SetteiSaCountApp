//
//  happyJugV3ViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/15.
//

import SwiftUI


// /////////////////////
// 変数
// /////////////////////
class happyJugV3Var: ObservableObject {
    @AppStorage("happyJugV3BellCount") var bellCount = 0
    @AppStorage("happyJugV3AloneBigCount") var aloneBigCount = 0
    @AppStorage("happyJugV3CherryBigCount") var cherryBigCount = 0
    @AppStorage("happyJugV3AloneRegCount") var aloneRegCount = 0
    @AppStorage("happyJugV3CherryRegCount") var cherryRegCount = 0
    @AppStorage("happyJugV3StartGames") var startGames = 0
    @AppStorage("happyJugV3CurrentGames") var currentGames = 0
    @Published var minusCheck = false
    
    // レギュラー合算回数
    var totalRegCount: Int {
        return aloneRegCount + cherryRegCount
    }
    
    // ビッグ合算回数
    var totalBigCount: Int {
        return aloneBigCount + cherryBigCount
    }
    
    // ボーナス合算回数
    var totalBonusCount: Int {
        return totalBigCount + totalRegCount
    }
    
    // 消化ゲーム数の算出
    var playGames: Int {
        let games = currentGames - startGames
        return games > 0 ? games : 0
    }
    
    // //// 確率分母の算出
    // ベル
    var bellDenominator: Double {
        let denominator = Double(playGames) / Double(bellCount)
        return bellCount > 0 ? denominator : 0.0
    }
    // 単独ビッグ
    var aloneBigDenominator: Double {
        let denominator = Double(playGames) / Double(aloneBigCount)
        return aloneBigCount > 0 ? denominator : 0.0
    }
    // チェリー重複ビッグ
    var cherryBigDenominator: Double {
        let denominator = Double(playGames) / Double(cherryBigCount)
        return cherryBigCount > 0 ? denominator : 0.0
    }
    // 単独レギュラー
    var aloneRegDenominator: Double {
        let denominator = Double(playGames) / Double(aloneRegCount)
        return aloneRegCount > 0 ? denominator : 0.0
    }
    // チェリーレギュラー
    var cherryRegDenominator: Double {
        let denominator = Double(playGames) / Double(cherryRegCount)
        return cherryRegCount > 0 ? denominator : 0.0
    }
    // レギュラー合算
    var totalRegDenominator: Double {
        let denominator = Double(playGames) / Double(totalRegCount)
        return totalRegCount > 0 ? denominator : 0.0
    }
    // ビッグ合算
    var totalBigDenominator: Double {
        let denominator = Double(playGames) / Double(totalBigCount)
        return totalBigCount > 0 ? denominator : 0.0
    }
    // ボーナス合算
    var totalBonusDenominator: Double {
        let denominator = Double(playGames) / Double(totalBonusCount)
        return totalBonusCount > 0 ? denominator : 0.0
    }
    
    // Tips
    var tipKeybordHidden = commonTipKeybordHidden()
}


// //////////////////////
// ビュー：メインビュー
// //////////////////////
struct happyJugV3ViewTop: View {
    @ObservedObject var jug = happyJugV3Var()
    @FocusState private var isFocused: Bool
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    @State var isShowAlert = false
    @State var isShowExView = false
    
    var body: some View {
//        NavigationView {
            // //// 縦・横で配置を変える、画面の縦横比を取得しそれで条件分岐させる
            GeometryReader { geometry in
                List {
                    Section {
                        // //// カウント部分の縦画面用
                        if orientation.isPortrait || (orientation.isFlat && lastOrientation.isPortrait) {
//                        if orientation.isPortrait || orientation.isFlat {
//                        if orientation.isPortrait {
                            // ぶどう＋合算確率
                            HStack {
                                happyJugV3SubViewBellCount(jug: jug)
                                happyJugV3SubViewTotalBigRatio(jug: jug)
                                    .padding(.vertical)
                                happyJugV3SubViewTotalRegRatio(jug: jug)
                                    .padding(.vertical)
                                //                                happyJugV3SubViewAloneBigCount(jug: jug)
                                //                                happyJugV3SubViewAloneRegCount(jug: jug)
                                //                                happyJugV3SubViewCherryRegCount(jug: jug)
                            }
                            // ボーナスカウント部分
                            HStack {
                                happyJugV3SubViewAloneBigCount(jug: jug)
                                happyJugV3SubViewCherryBigCount(jug: jug)
                                happyJugV3SubViewAloneRegCount(jug: jug)
                                happyJugV3SubViewCherryRegCount(jug: jug)
                            }
                            // 合算確率表示
                            HStack {
                                
                                happyJugV3SubViewTotalBonusRatio(jug: jug)
                            }
                        }
                        
                        // //// カウント部分の横画面用
//                        else if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
                        else {
                            HStack {
                                happyJugV3SubViewBellCount(jug: jug)
                                happyJugV3SubViewAloneBigCount(jug: jug)
                                happyJugV3SubViewCherryBigCount(jug: jug)
                                happyJugV3SubViewAloneRegCount(jug: jug)
                                happyJugV3SubViewCherryRegCount(jug: jug)
                                happyJugV3SubViewTotalBigRatio(jug: jug)
                                    .padding(.vertical)
                                happyJugV3SubViewTotalRegRatio(jug: jug)
                                    .padding(.vertical)
                            }
                            happyJugV3SubViewTotalBonusRatio(jug: jug)
                        }
                        Button(action: {
                            isShowExView.toggle()
                        }, label: {
                            Text(">> 設定差情報")
                                .foregroundColor(Color.blue)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        })
                        .sheet(isPresented: $isShowExView, content: {
                            happyJugV3exView()
                                .presentationDetents([.medium])
                        })
                    }
//                    .onTapGesture {
//                        isFocused = false
//                    }
                    
                    // //// ゲーム数入力部分
                    Section {
                        // 打ち始めゲーム数入力
                        HStack {
                            Text("打ち始め")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            TextField("打ち始め", value: $jug.startGames, format: .number)
                                .keyboardType(.numberPad)
                                .focused($isFocused)
                                .multilineTextAlignment(.center)
                                .toolbar {
                                    ToolbarItem(placement: .keyboard) {
                                        HStack {
                                            Spacer()
                                            Button(action: {
                                                isFocused = false
                                            }, label: {
                                                Text("完了")
                                                    .fontWeight(.bold)
                                            })
                                        }
                                    }
                                }
                        }
                        // 現在ゲーム数
                        HStack {
                            Text("現在")
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                            TextField("現在", value: $jug.currentGames, format: .number)
                                .keyboardType(.numberPad)
                                .focused($isFocused)
                                .multilineTextAlignment(.center)
                        }
                        // 消化ゲーム数
                        HStack {
                            Text("消化ゲーム数")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("\(jug.playGames)")
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    } header: {
                        Text("ゲーム数入力")
                    }
                    if orientation.isPortrait || (orientation.isFlat && lastOrientation.isPortrait) {
                        unitClearScrollSection(spaceHeight: 120)
                    } else {
                        
                    }
                }
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
            }
            .navigationTitle("ハッピージャグラーV3")
            .navigationBarTitleDisplayMode(.inline)
            
            // //// ツールバーボタン
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    HStack {
                        // マイナスボタン
                        Button(action: {
                            jug.minusCheck.toggle()
                        }, label: {
                            if jug.minusCheck == true{
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
                                happyJugV3funcReset(jug: jug)
                                UINotificationFeedbackGenerator().notificationOccurred(.warning)
                            }
                        } message: {
                            Text("ページ内のデータは完全に消去されます")
                        }
                    }
                }
            }
//        }
//        .navigationTitle("ハッピージャグラーV3")
//        .navigationBarTitleDisplayMode(.inline)
//        
//        // //// ツールバーボタン
//        .toolbar {
//            ToolbarItem(placement: .automatic) {
//                HStack {
//                    // マイナスボタン
//                    Button(action: {
//                        jug.minusCheck.toggle()
//                    }, label: {
//                        if jug.minusCheck == true{
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
//                            happyJugV3funcReset(jug: jug)
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


// //////////////////////
// ビュー：ベルのカウント部分
// //////////////////////
struct happyJugV3SubViewBellCount: View {
    @ObservedObject var jug = happyJugV3Var()
    
    var body: some View {
        ZStack {
            // 背景フラッシュ部分
            Rectangle()
//                .backgroundFlashModifier(trigger: jug.bellCount, color: Color("personalSpringLightYellow"))
                .backgroundFlashModifier(trigger: jug.bellCount, color: Color(.yellow))
            // //// ボタンと表示部分
            VStack(spacing: 5) {
                // タイトル
                Text("ぶどう")
                // 確率
                Text("\(jug.bellCount > 0 ? 1 : 0)/\(String(format:"%.2f",jug.bellDenominator))")
                    .fontWeight(.bold)
                    .lineLimit(1)
                // 回数
                if jug.bellCount < 1000 {
                    Text("\(jug.bellCount)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .lineLimit(1)
                } else {
                    Text("\(jug.bellCount)")
                        .font(.title3)
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .padding(.vertical, 8.0)
                }
                // カウントボタン
                Button(action: {
                    jug.bellCount = countUpDown(minusCheck: jug.minusCheck, count: jug.bellCount)
                }, label: {
                    Text("")
                })
                .buttonStyle(CountButtonStyle(color: Color("personalSpringLightYellow"), MinusBool: jug.minusCheck))
            }
        }
    }
}


// //////////////////////
// ビュー：単独ビッグのカウント部分
// //////////////////////
struct happyJugV3SubViewAloneBigCount: View {
    @ObservedObject var jug = happyJugV3Var()
    
    var body: some View {
        ZStack {
            // 背景フラッシュ部分
            Rectangle()
                .backgroundFlashModifier(trigger: jug.aloneBigCount, color: Color("personalSummerLightRed"))
            // //// ボタンと表示部分
            VStack(spacing: 5) {
                // タイトル
                Text("単独BIG")
                    .lineLimit(1)
                // 確率
                Text("\(jug.aloneBigCount > 0 ? 1 : 0)/\(String(format:"%.0f",jug.aloneBigDenominator))")
                    .fontWeight(.bold)
                    .lineLimit(1)
                // 回数
                Text("\(jug.aloneBigCount)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .lineLimit(1)
                // カウントボタン
                Button(action: {
                    jug.aloneBigCount = countUpDown(minusCheck: jug.minusCheck, count: jug.aloneBigCount)
                }, label: {
                    Text("")
                })
                .buttonStyle(CountButtonStyle(color: Color("personalSummerLightRed"), MinusBool: jug.minusCheck))
            }
        }
    }
}


// //////////////////////
// ビュー：チェリー重複ビッグのカウント部分
// //////////////////////
struct happyJugV3SubViewCherryBigCount: View {
    @ObservedObject var jug = happyJugV3Var()
    
    var body: some View {
        ZStack {
            // 背景フラッシュ部分
            Rectangle()
                .backgroundFlashModifier(trigger: jug.cherryBigCount, color: Color("personalSummerLightGreen"))
            // //// ボタンと表示部分
            VStack(spacing: 5) {
                // タイトル
                Text("🍒BIG")
                    .lineLimit(1)
                // 確率
                Text("\(jug.cherryBigCount > 0 ? 1 : 0)/\(String(format:"%.0f",jug.cherryBigDenominator))")
                    .fontWeight(.bold)
                    .lineLimit(1)
                // 回数
                Text("\(jug.cherryBigCount)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .lineLimit(1)
                // カウントボタン
                Button(action: {
                    jug.cherryBigCount = countUpDown(minusCheck: jug.minusCheck, count: jug.cherryBigCount)
                }, label: {
                    Text("")
                })
                .buttonStyle(CountButtonStyle(color: Color("personalSummerLightGreen"), MinusBool: jug.minusCheck))
            }
        }
    }
}


// //////////////////////
// ビュー：単独レギュラーのカウント部分
// //////////////////////
struct happyJugV3SubViewAloneRegCount: View {
    @ObservedObject var jug = happyJugV3Var()
    
    var body: some View {
        ZStack {
            // 背景フラッシュ部分
            Rectangle()
                .backgroundFlashModifier(trigger: jug.aloneRegCount, color: Color("personalSummerLightBlue"))
            // //// ボタンと表示部分
            VStack(spacing: 5) {
                // タイトル
                Text("単独REG")
                    .lineLimit(1)
//                    .font(.footnote)
                // 確率
                Text("\(jug.aloneRegCount > 0 ? 1 : 0)/\(String(format:"%.0f",jug.aloneRegDenominator))")
                    .fontWeight(.bold)
                    .lineLimit(1)
                // 回数
                Text("\(jug.aloneRegCount)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .lineLimit(1)
                // カウントボタン
                Button(action: {
                    jug.aloneRegCount = countUpDown(minusCheck: jug.minusCheck, count: jug.aloneRegCount)
                }, label: {
                    Text("")
                })
                .buttonStyle(CountButtonStyle(color: Color("personalSummerLightBlue"), MinusBool: jug.minusCheck))
            }
        }
    }
}


// //////////////////////
// ビュー：チェリー重複レギュラーのカウント部分
// //////////////////////
struct happyJugV3SubViewCherryRegCount: View {
    @ObservedObject var jug = happyJugV3Var()
    
    var body: some View {
        ZStack {
            // 背景フラッシュ部分
            Rectangle()
                .backgroundFlashModifier(trigger: jug.cherryRegCount, color: Color("personalSummerLightPurple"))
            // //// ボタンと表示部分
            VStack(spacing: 5) {
                // タイトル
                Text("🍒REG")
                // 確率
                Text("\(jug.cherryRegCount > 0 ? 1 : 0)/\(String(format:"%.0f",jug.cherryRegDenominator))")
                    .fontWeight(.bold)
                    .lineLimit(1)
                // 回数
                Text("\(jug.cherryRegCount)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .lineLimit(1)
                // カウントボタン
                Button(action: {
                    jug.cherryRegCount = countUpDown(minusCheck: jug.minusCheck, count: jug.cherryRegCount)
                }, label: {
                    Text("")
                })
                .buttonStyle(CountButtonStyle(color: Color("personalSummerLightPurple"), MinusBool: jug.minusCheck))
            }
        }
    }
}


// /////////////////////
// ビュー：レギュラー合算確率
// /////////////////////
struct happyJugV3SubViewTotalRegRatio: View {
    @ObservedObject var jug = happyJugV3Var()
    
    var body: some View {
        ZStack {
            // 背景用
            HStack {
                Spacer()
                Rectangle()
                    .foregroundColor(Color("grayBack"))
                    .cornerRadius(15)
                Spacer()
            }
            VStack {
                Text("REG合算")
                    Text("\(jug.totalRegCount > 0 ? 1 : 0) /")
                    .font(.title3)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    Text("\(String(format: "%.0f", jug.totalRegDenominator))")
                        .font(.title)
                        .fontWeight(.bold)
                        .lineLimit(1)
            }
        }
    }
}


// /////////////////////
// ビュー：ビッグ合算確率
// /////////////////////
struct happyJugV3SubViewTotalBigRatio: View {
    @ObservedObject var jug = happyJugV3Var()
    
    var body: some View {
        ZStack {
            // 背景用
            HStack {
                Spacer()
                Rectangle()
                    .foregroundColor(Color("grayBack"))
                    .cornerRadius(15)
                Spacer()
            }
            VStack {
                Text("BIG合算")
                    Text("\(jug.totalBigCount > 0 ? 1 : 0) /")
                    .font(.title3)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    Text("\(String(format: "%.0f", jug.totalBigDenominator))")
                        .font(.title)
                        .fontWeight(.bold)
                        .lineLimit(1)
            }
        }
    }
}


// /////////////////////
// ビュー：ボーナス合算確率
// /////////////////////
struct happyJugV3SubViewTotalBonusRatio: View {
    @ObservedObject var jug = happyJugV3Var()
    
    var body: some View {
        ZStack {
            // 背景用
            HStack {
                Spacer()
                Rectangle()
                    .foregroundColor(Color("grayBack"))
                    .cornerRadius(15)
                Spacer()
            }
            VStack {
                Text("ボーナス合算")
                    .multilineTextAlignment(.center)
                Text("\(jug.totalBonusCount > 0 ? 1 : 0) / \(String(format: "%.0f", jug.totalBonusDenominator))")
                    .font(.title)
                    .fontWeight(.bold)
                    .lineLimit(1)
//                Text("\(String(format: "%.0f", jug.totalBonusDenominator))")
//                    .font(.title)
//                    .fontWeight(.bold)
//                    .lineLimit(1)
            }
        }
    }
}


// //////////////////////
// 関数：全リセット
// //////////////////////
func happyJugV3funcReset(jug: happyJugV3Var) {
    jug.bellCount = 0
    jug.aloneBigCount = 0
    jug.cherryBigCount = 0
    jug.aloneRegCount = 0
    jug.cherryRegCount = 0
    jug.startGames = 0
    jug.currentGames = 0
    jug.minusCheck = false
}



#Preview {
    happyJugV3ViewTop()
}
