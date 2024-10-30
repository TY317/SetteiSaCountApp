//
//  myJug5ViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/15.
//

import SwiftUI

// /////////////////////
// 変数
// /////////////////////
class myJug5Var: ObservableObject {
    @AppStorage("myJug5BellCount") var bellCount = 0
    @AppStorage("myJug5BigCount") var bigCount = 0
    @AppStorage("myJug5AloneRegCount") var aloneRegCount = 0
    @AppStorage("myJug5CherryRegCount") var cherryRegCount = 0
    @AppStorage("myJug5StartGames") var startGames = 0
    @AppStorage("myJug5CurrentGames") var currentGames = 0
    @Published var minusCheck = false
    
    // レギュラー合算回数
    var totalRegCount: Int {
        return aloneRegCount + cherryRegCount
    }
    
    // ボーナス合算回数
    var totalBonusCount: Int {
        return bigCount + totalRegCount
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
    // ビッグ
    var bigDenominator: Double {
        let denominator = Double(playGames) / Double(bigCount)
        return bigCount > 0 ? denominator : 0.0
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
    // ボーナス合算
    var totalBonusDenominator: Double {
        let denominator = Double(playGames) / Double(totalBonusCount)
        return totalBonusCount > 0 ? denominator : 0.0
    }
    
    // Tips
    var tipKeybordHidden = commonTipKeybordHidden()
    
    @AppStorage("myJug5SelectedMemory") var selectedMemory = "メモリー1"
}

// //// メモリー1
class myJug5Memory1: ObservableObject {
    @AppStorage("myJug5BellCountMemory1") var bellCount = 0
    @AppStorage("myJug5BigCountMemory1") var bigCount = 0
    @AppStorage("myJug5AloneRegCountMemory1") var aloneRegCount = 0
    @AppStorage("myJug5CherryRegCountMemory1") var cherryRegCount = 0
    @AppStorage("myJug5StartGamesMemory1") var startGames = 0
    @AppStorage("myJug5CurrentGamesMemory1") var currentGames = 0
    @AppStorage("myJug5MemoMemory1") var memo = ""
    @AppStorage("myJug5DateMemory1") var dateDouble = 0.0
}

// //// メモリー2
class myJug5Memory2: ObservableObject {
    @AppStorage("myJug5BellCountMemory2") var bellCount = 0
    @AppStorage("myJug5BigCountMemory2") var bigCount = 0
    @AppStorage("myJug5AloneRegCountMemory2") var aloneRegCount = 0
    @AppStorage("myJug5CherryRegCountMemory2") var cherryRegCount = 0
    @AppStorage("myJug5StartGamesMemory2") var startGames = 0
    @AppStorage("myJug5CurrentGamesMemory2") var currentGames = 0
    @AppStorage("myJug5MemoMemory2") var memo = ""
    @AppStorage("myJug5DateMemory2") var dateDouble = 0.0
}

// //// メモリー3
class myJug5Memory3: ObservableObject {
    @AppStorage("myJug5BellCountMemory3") var bellCount = 0
    @AppStorage("myJug5BigCountMemory3") var bigCount = 0
    @AppStorage("myJug5AloneRegCountMemory3") var aloneRegCount = 0
    @AppStorage("myJug5CherryRegCountMemory3") var cherryRegCount = 0
    @AppStorage("myJug5StartGamesMemory3") var startGames = 0
    @AppStorage("myJug5CurrentGamesMemory3") var currentGames = 0
    @AppStorage("myJug5MemoMemory3") var memo = ""
    @AppStorage("myJug5DateMemory3") var dateDouble = 0.0
}


// ///////////////////////
// ビュー：メインビュー
// ///////////////////////
struct myJug5ViewTop: View {
    @ObservedObject var common = commonVar()
    @ObservedObject var jug = myJug5Var()
    @ObservedObject var jugMemory1 = myJug5Memory1()
    @ObservedObject var jugMemory2 = myJug5Memory2()
    @ObservedObject var jugMemory3 = myJug5Memory3()
    @FocusState private var isFocused: Bool
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    @State var isShowAlert = false
    @State var isShowExView = false
    
    var body: some View {
//        NavigationView {
            // //// 縦・横で配置を変える、画面の縦横比を取得しそれで条件分岐させる
//            GeometryReader { geometry in
                List {
                    Section {
                        // //// カウント部分の縦画面用
                        if orientation.isPortrait || (orientation.isFlat && lastOrientation.isPortrait) {
                            // カウント部分
                            HStack {
                                myJug5SubViewBellCount(jug: jug)
                                myJug5SubViewBigCount(jug: jug)
                                myJug5SubViewAloneRegCount(jug: jug)
                                myJug5SubViewCherryRegCount(jug: jug)
                            }
                            // 合算確率表示
                            HStack {
                                myJug5SubViewTotalBonusRatio(jug: jug)
                                myJug5SubViewTotalRegRatio(jug: jug)
                            }
                        }
                        
                        // //// カウント部分の横画面用
//                        else if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
                        else {
                            HStack {
                                myJug5SubViewBellCount(jug: jug)
                                myJug5SubViewBigCount(jug: jug)
                                myJug5SubViewAloneRegCount(jug: jug)
                                myJug5SubViewCherryRegCount(jug: jug)
                                myJug5SubViewTotalRegRatio(jug: jug)
                                    .padding(.vertical)
                                myJug5SubViewTotalBonusRatio(jug: jug)
                                    .padding(.vertical)
                            }
                        }
                        Button(action: {
                            isShowExView.toggle()
                        }, label: {
                            Text(">> 設定差情報")
                                .foregroundColor(Color.blue)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        })
                        .sheet(isPresented: $isShowExView, content: {
                            myJug5exView()
                                .presentationDetents([.medium])
                        })
                    }
//                    .background(Color.clear) // これで背景をタップ可能にする
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
                    .background(Color.clear) // これで背景をタップ可能にする
                    .onTapGesture {
                        isFocused = false
                    }
                    if orientation.isPortrait || (orientation.isFlat && lastOrientation.isPortrait) {
                        unitClearScrollSection(spaceHeight: 140)
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
                .navigationTitle("マイジャグラー5")
                .navigationBarTitleDisplayMode(.inline)
                
                // //// ツールバーボタン
                .toolbar {
                    ToolbarItem(placement: .automatic) {
                        HStack {
                            HStack {
                                // //// メモリー読み出し
                                unitButtonLoadMemory(loadView: AnyView(myJug5ViewLoadMemory(jug: jug, jugMemory1: jugMemory1, jugMemory2: jugMemory2, jugMemory3: jugMemory3)))
                                // //// メモリー保存
                                unitButtonSaveMemory(saveView: AnyView(myJug5ViewSaveMemory(jug: jug, jugMemory1: jugMemory1, jugMemory2: jugMemory2, jugMemory3: jugMemory3)))
                            }
                            .popoverTip(tipUnitButtonMemory())
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
                                    myJug5funcReset(jug: jug)
                                    UINotificationFeedbackGenerator().notificationOccurred(.warning)
                                }
                            } message: {
                                Text("ページ内のデータは完全に消去されます")
                            }
                        }
                    }
                }
//        }
//        .navigationTitle("マイジャグラー5")
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
//                            myJug5funcReset(jug: jug)
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
struct myJug5SubViewBellCount: View {
    @ObservedObject var jug = myJug5Var()
    
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
// ビュー：ビッグのカウント部分
// //////////////////////
struct myJug5SubViewBigCount: View {
    @ObservedObject var jug = myJug5Var()
    
    var body: some View {
        ZStack {
            // 背景フラッシュ部分
            Rectangle()
                .backgroundFlashModifier(trigger: jug.bigCount, color: Color("personalSummerLightRed"))
            // //// ボタンと表示部分
            VStack(spacing: 5) {
                // タイトル
                Text("ビッグ")
                // 確率
                Text("\(jug.bigCount > 0 ? 1 : 0)/\(String(format:"%.0f",jug.bigDenominator))")
                    .fontWeight(.bold)
                    .lineLimit(1)
                // 回数
                Text("\(jug.bigCount)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .lineLimit(1)
                // カウントボタン
                Button(action: {
                    jug.bigCount = countUpDown(minusCheck: jug.minusCheck, count: jug.bigCount)
                }, label: {
                    Text("")
                })
                .buttonStyle(CountButtonStyle(color: Color("personalSummerLightRed"), MinusBool: jug.minusCheck))
            }
        }
    }
}


// //////////////////////
// ビュー：単独レギュラーのカウント部分
// //////////////////////
struct myJug5SubViewAloneRegCount: View {
    @ObservedObject var jug = myJug5Var()
    
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
struct myJug5SubViewCherryRegCount: View {
    @ObservedObject var jug = myJug5Var()
    
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
struct myJug5SubViewTotalRegRatio: View {
    @ObservedObject var jug = myJug5Var()
    
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
// ビュー：ボーナス合算確率
// /////////////////////
struct myJug5SubViewTotalBonusRatio: View {
    @ObservedObject var jug = myJug5Var()
    
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
                Text("ボナ合算")
                    .multilineTextAlignment(.center)
                Text("\(jug.totalBonusCount > 0 ? 1 : 0) /")
                    .font(.title3)
                    .fontWeight(.bold)
                    .lineLimit(1)
                Text("\(String(format: "%.0f", jug.totalBonusDenominator))")
                    .font(.title)
                    .fontWeight(.bold)
                    .lineLimit(1)
            }
        }
    }
}


// /////////////////////
// ビュー：ゲーム数入力部分
// /////////////////////
struct myJug5SubViewInputGames: View {
    var body: some View {
        Text("aaa")
    }
}


// //////////////////////
// 関数：全リセット
// //////////////////////
func myJug5funcReset(jug: myJug5Var) {
    jug.bellCount = 0
    jug.bigCount = 0
    jug.aloneRegCount = 0
    jug.cherryRegCount = 0
    jug.startGames = 0
    jug.currentGames = 0
    jug.minusCheck = false
}


// /////////////////////////////
// メモリーセーブ画面
// /////////////////////////////
struct myJug5ViewSaveMemory: View {
    @ObservedObject var jug: myJug5Var
    @ObservedObject var jugMemory1: myJug5Memory1
    @ObservedObject var jugMemory2: myJug5Memory2
    @ObservedObject var jugMemory3: myJug5Memory3
    @State var isShowSaveAlert: Bool = false
    var body: some View {
        unitViewSaveMemory(
            machineName: "マイジャグラー5",
            selectedMemory: $jug.selectedMemory,
            memoMemory1: $jugMemory1.memo,
            dateDoubleMemory1: $jugMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $jugMemory2.memo,
            dateDoubleMemory2: $jugMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $jugMemory3.memo,
            dateDoubleMemory3: $jugMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        jugMemory1.bellCount = jug.bellCount
        jugMemory1.bigCount = jug.bigCount
        jugMemory1.aloneRegCount = jug.aloneRegCount
        jugMemory1.cherryRegCount = jug.cherryRegCount
        jugMemory1.startGames = jug.startGames
        jugMemory1.currentGames = jug.currentGames
    }
    func saveMemory2() {
        jugMemory2.bellCount = jug.bellCount
        jugMemory2.bigCount = jug.bigCount
        jugMemory2.aloneRegCount = jug.aloneRegCount
        jugMemory2.cherryRegCount = jug.cherryRegCount
        jugMemory2.startGames = jug.startGames
        jugMemory2.currentGames = jug.currentGames
    }
    func saveMemory3() {
        jugMemory3.bellCount = jug.bellCount
        jugMemory3.bigCount = jug.bigCount
        jugMemory3.aloneRegCount = jug.aloneRegCount
        jugMemory3.cherryRegCount = jug.cherryRegCount
        jugMemory3.startGames = jug.startGames
        jugMemory3.currentGames = jug.currentGames
    }
}


// /////////////////////////////
// メモリーセーブ画面
// /////////////////////////////
struct myJug5ViewLoadMemory: View {
    @ObservedObject var jug: myJug5Var
    @ObservedObject var jugMemory1: myJug5Memory1
    @ObservedObject var jugMemory2: myJug5Memory2
    @ObservedObject var jugMemory3: myJug5Memory3
    @State var isShowLoadAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: "マイジャグラー5",
            selectedMemory: $jug.selectedMemory,
            memoMemory1: jugMemory1.memo,
            dateDoubleMemory1: jugMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: jugMemory2.memo,
            dateDoubleMemory2: jugMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: jugMemory3.memo,
            dateDoubleMemory3: jugMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowLoadAlert
        )
    }
    func loadMemory1() {
        jug.bellCount = jugMemory1.bellCount
        jug.bigCount = jugMemory1.bigCount
        jug.aloneRegCount = jugMemory1.aloneRegCount
        jug.cherryRegCount = jugMemory1.cherryRegCount
        jug.startGames = jugMemory1.startGames
        jug.currentGames = jugMemory1.currentGames
    }
    func loadMemory2() {
        jug.bellCount = jugMemory2.bellCount
        jug.bigCount = jugMemory2.bigCount
        jug.aloneRegCount = jugMemory2.aloneRegCount
        jug.cherryRegCount = jugMemory2.cherryRegCount
        jug.startGames = jugMemory2.startGames
        jug.currentGames = jugMemory2.currentGames
    }
    func loadMemory3() {
        jug.bellCount = jugMemory3.bellCount
        jug.bigCount = jugMemory3.bigCount
        jug.aloneRegCount = jugMemory3.aloneRegCount
        jug.cherryRegCount = jugMemory3.cherryRegCount
        jug.startGames = jugMemory3.startGames
        jug.currentGames = jugMemory3.currentGames
    }
}

#Preview {
    myJug5ViewTop()
}
