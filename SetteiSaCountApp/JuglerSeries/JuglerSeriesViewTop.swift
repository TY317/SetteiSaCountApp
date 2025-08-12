//
//  JuglerSeriesViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/15.
//

import SwiftUI


// /////////////////////////
// 変数：お気に入り機種設定用の変数
// /////////////////////////
class JuglerSeriesfavoriteSetVar: ObservableObject {
    @AppStorage("isSelectedMyJug5") var isSelectedMyJug5 = true
    @AppStorage("isSelectedHappyJugV3") var isSelectedHappyJugV3 = true
    @AppStorage("isSelectedImJugEx") var isSelectedImJugEx = true
    @AppStorage("isSelectedGoJug3") var isSelectedGoJug3 = true
    @AppStorage("isSelectedMrJug") var isSelectedMrJug = true
    @AppStorage("isSelectedFunky2") var isSelectedFunky2 = true
    @AppStorage("isSelectedGirlsSS") var isSelectedGirlsSS = true
}


// /////////////////////////
// ビュー：メインビュー
// /////////////////////////
struct JuglerSeriesViewTop: View {
//    @ObservedObject var ver210 = Ver210()
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @ObservedObject var favoriteSet = JuglerSeriesfavoriteSetVar()
    let displayMode = ["お気に入り", "全機種"]     // 機種リストの表示モード選択肢
    @State var isSelectedDisplayMode = "お気に入り"
    @State var isShowFavoriteSettingView = false
//    @ObservedObject var common = commonVar()
    @ObservedObject var common: commonVar
    @State var lazyVGridColumns: Int = 4
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    
    var body: some View {
        NavigationStack {
            ZStack {
                if common.iconDisplayMode {
                    ScrollView {
                        Rectangle()
                            .frame(height: 40)
                            .foregroundStyle(Color.clear)
                        LazyVGrid(columns: Array(repeating: GridItem(.fixed(common.lazyVGridSize), spacing: common.lazyVGridSpacing), count: self.lazyVGridColumns), spacing: common.lazyVGridSpacing) {
                            // //// ミスタージャグラー、2024年　7月
                            if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedMrJug == false {
                                // 非表示
                            } else {
                                unitMachineIconLink(
                                    linkView: AnyView(mrJugViewTop()),
                                    iconImage: Image("mrJugMachineIcon"),
                                    machineName: "ミスター"
//                                    badgeStatus: ver210.ver210MrJugNewBadgeStatus
                                )
                            }
                            
                            // //// ジャグラーガールズ、2024年　4月
                            if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedGirlsSS == false {
                                // 非表示
                            } else {
                                unitMachineIconLink(
                                    linkView: AnyView(girlsSSViewTop()),
                                    iconImage: Image("girlsSSMachineIcon"),
                                    machineName: "ガールズSS"
//                                    badgeStatus: ver210.ver210GirlsSSNewBadgeStatus
                                )
                            }
                            
                            // //// ゴーゴージャグラー3、2023年 7月
                            if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedGoJug3 == false {
                                // 非表示
                            } else {
                                unitMachineIconLink(
                                    linkView: AnyView(goJug3Ver2ViewTop()),
                                    iconImage: Image("goJug3MachineIcon"),
                                    machineName: "ゴージャグ3"
                                )
                            }
                            
                            // //// ハッピージャグラー
                            if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedHappyJugV3 == false {
                                // 非表示
                            } else {
                                unitMachineIconLink(linkView: AnyView(happyJugV3Ver2ViewTop()), iconImage: Image("machineIconHappyJugV3"), machineName: "ハッピーV3")
                            }
                            
                            // //// マイジャグラー５
                            if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedMyJug5 == false {
                                // 非表示
                            } else {
                                unitMachineIconLink(linkView: AnyView(myJug5Ver2ViewTop(
                                    bayes: bayes,
                                    viewModel: viewModel,
                                )), iconImage: Image("machineIconMyJug5"), machineName: "マイジャグ5")
                            }
                            
                            // //// ファンキージャグラー、2021年10月
                            if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFunky2 == false {
                                // 非表示
                            } else {
                                unitMachineIconLink(
                                    linkView: AnyView(funky2Ver2ViewTop()),
                                    iconImage: Image("funky2MachineIcon"),
                                    machineName: "ファンキー2"
//                                    badgeStatus: ver210.ver210Funky2NewBadgeStatus
                                )
                            }
                            
                            // //// アイムジャグラーEX
                            if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedImJugEx == false {
                                // 非表示
                            } else {
                                unitMachineIconLink(linkView: AnyView(imJugExVer2ViewTop()), iconImage: Image("imJugExMachinIcon"), machineName: "アイムEX")
                            }
                        }
                    }
                    .background(Color(UIColor.systemGroupedBackground))
                }
                // リスト表示モード
                else {
                    // //// 機種リスト表示部分
                    List {
                        Section {
                            // //// ミスタージャグラー、2024年 7月
                            if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedMrJug == false {
                                // 非表示
                            } else {
                                unitMachinListLink(
                                    linkView: AnyView(mrJugViewTop()),
                                    iconImage: Image("mrJugMachineIcon"),
                                    machineName: "ミスタージャグラー",
                                    makerName: "北電子",
                                    releaseYear: 2024,
                                    releaseMonth: 7
//                                    badgeStatus: ver210.ver210MrJugNewBadgeStatus
                                )
                            }
                            
                            // //// ジャグラーガールズ、2024年 4月
                            if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedGirlsSS == false {
                                // 非表示
                            } else {
                                unitMachinListLink(
                                    linkView: AnyView(girlsSSViewTop()),
                                    iconImage: Image("girlsSSMachineIcon"),
                                    machineName: "ジャグラーガールズSS",
                                    makerName: "北電子",
                                    releaseYear: 2024,
                                    releaseMonth: 4
//                                    badgeStatus: ver210.ver210GirlsSSNewBadgeStatus
                                )
                            }
                            
                            // //// ゴーゴージャグラー3、2023年 7月
                            if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedGoJug3 == false {
                                // 非表示
                            } else {
                                unitMachinListLink(
                                    linkView: AnyView(goJug3Ver2ViewTop()),
                                    iconImage: Image("goJug3MachineIcon"),
                                    machineName: "ゴーゴージャグラー3",
                                    makerName: "北電子",
                                    releaseYear: 2023,
                                    releaseMonth: 7
                                )
                            }
                            
                            // //// ハッピージャグラーV3
                            if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedHappyJugV3 == false {
                                // 非表示
                            } else {
                                unitMachinListLink(linkView: AnyView(happyJugV3Ver2ViewTop()), iconImage: Image("machineIconHappyJugV3"), machineName: "ハッピージャグラーV3", makerName: "北電子", releaseYear: 2022, releaseMonth: 10)
                            }
                            
                            // //// マイジャグラー５
                            if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedMyJug5 == false {
                                // 非表示
                            } else {
                                unitMachinListLink(linkView: AnyView(myJug5Ver2ViewTop(
                                    bayes: bayes,
                                    viewModel: viewModel,
                                )), iconImage: Image("machineIconMyJug5"), machineName: "マイジャグラー5", makerName: "北電子", releaseYear: 2021, releaseMonth: 12)
                            }
                            
                            // //// ファンキージャグラー2
                            if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFunky2 == false {
                                // 非表示
                            } else {
                                unitMachinListLink(
                                    linkView: AnyView(funky2Ver2ViewTop()),
                                    iconImage: Image("funky2MachineIcon"),
                                    machineName: "ファンキージャグラー2",
                                    makerName: "北電子",
                                    releaseYear: 2021,
                                    releaseMonth: 10
//                                    badgeStatus: ver210.ver210Funky2NewBadgeStatus
                                )
                            }
                            
                            // //// アイムジャグラーEX
                            if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedImJugEx == false {
                                // 非表示
                            } else {
                                unitMachinListLink(linkView: AnyView(imJugExVer2ViewTop()), iconImage: Image("imJugExMachinIcon"), machineName: "アイムジャグラーEX", makerName: "北電子", releaseYear: 2020, releaseMonth: 12)
                            }
                            
                        } header: {
                            VStack {
                                Text("")
                                Text("")
                            }
                        }
                    }
                }
                // //// モード選択ピッカー
                VStack {
                    Picker("", selection: $isSelectedDisplayMode) {
                        ForEach(displayMode, id: \.self) { mode in
                            Text(mode)
                        }
                    }
                    .background(Color(UIColor.systemGroupedBackground))
                    .pickerStyle(.segmented)
                    Spacer()
                }
            }
            // //// firebaseログ
            .onAppear {
                let screenClass = String(describing: Self.self)
                logEventFirebaseScreen(
                    screenName: "機種選択",
                    screenClass: screenClass
                )
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
                    self.lazyVGridColumns = common.lazyVGridColumnsLandscape
                } else {
                    self.lazyVGridColumns = common.lazyVGridColumnsPortlait
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
                        self.lazyVGridColumns = common.lazyVGridColumnsLandscape
                    } else {
                        self.lazyVGridColumns = common.lazyVGridColumnsPortlait
                    }
                }
            }
            .onDisappear {
                // ビューが非表示になるときに監視を解除
                NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
            }
            .navigationTitle("ジャグラー機種選択")
            .toolbarTitleDisplayMode(.inline)
            
            // //// ツールバーボタン
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    HStack {
                        // 表示モード切り替えボタン
                        Button {
                            common.iconDisplayMode.toggle()
                        } label: {
                            if common.iconDisplayMode {
                                Image(systemName: "list.bullet")
                            }
                            else {
                                Image(systemName: "rectangle.grid.2x2")
//                                    .popoverTip(tipUnitButtonIconDisplayMode())
                            }
                        }
                        // お気に入り設定ボタン
                        Button(action: {
                            isShowFavoriteSettingView.toggle()
                        }, label: {
                            Image(systemName: "gearshape.fill")
                        })
                        .sheet(isPresented: $isShowFavoriteSettingView, content: {
                            juglerSeriesfavoriteSettingView()
                        })
                    }
                }
            }
        }
//        .onAppear {
//            if ver210.ver210JugTopNewBadgeStatus != "none" {
//                ver210.ver210JugTopNewBadgeStatus = "none"
//            }
//        }
    }
}


// ///////////////////////
// ビュー：お気に入り設定画面
// ///////////////////////
struct juglerSeriesfavoriteSettingView: View {
    @ObservedObject var favoriteSet = JuglerSeriesfavoriteSetVar()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            List {
                // //// ミスタージャグラー、2024年　7月
                Toggle("ミスタージャグラー", isOn: $favoriteSet.isSelectedMrJug)
                // //// ガールズSS、2024年4月
                Toggle("ジャグラーガールズSS", isOn: $favoriteSet.isSelectedGirlsSS)
                // //// ゴーゴージャグラー3、2023年 7月
                Toggle("ゴーゴージャグラー3", isOn: $favoriteSet.isSelectedGoJug3)
                // ハッピージャグラーV3, 22年10月
                Toggle("ハッピージャグラーV3", isOn: $favoriteSet.isSelectedHappyJugV3)
                // マイジャグラー　21年12月
                Toggle("マイジャグラー5", isOn: $favoriteSet.isSelectedMyJug5)
                // ファンキージャグラー、21年10月
                Toggle("ファンキージャグラー2", isOn: $favoriteSet.isSelectedFunky2)
                // アイムジャグラー
                Toggle("アイムジャグラーEX", isOn: $favoriteSet.isSelectedImJugEx)
            }
            .navigationTitle("お気に入り機種設定")
            .toolbarTitleDisplayMode(.inline)
            // //// ツールバー
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("閉じる")
                            .fontWeight(.bold)
                    })
                }
            }
        }
    }
}


// ////////////////////////
// ビュー：ハッピージャグラーV3, 22年10月
// ////////////////////////
struct machineListHappyJugV3: View {
    var body: some View {
        NavigationLink(destination: happyJugV3ViewTop()) {
            HStack {
                Image("machineIconHappyJugV3")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40.0)
                    .cornerRadius(8)
                VStack(alignment: .leading) {
                    Text("ハッピージャグラーV3")
                    Text("北電子 , 2022年 10月")
                        .font(.caption)
//                        .foregroundColor(Color.gray)
                        .foregroundStyle(Color.gray)
                        .padding(.leading)
                }
                .padding(.leading)
            }
        }
    }
}


// ////////////////////////
// ビュー：マイジャグラー５
// ////////////////////////
struct machineListMyJug5: View {
    var body: some View {
        NavigationLink(destination: myJug5ViewTop()) {
            HStack {
                Image("machineIconMyJug5")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40.0)
                    .cornerRadius(8)
                VStack(alignment: .leading) {
                    Text("マイジャグラー5")
                    Text("北電子 , 2021年 12月")
                        .font(.caption)
//                        .foregroundColor(Color.gray)
                        .foregroundStyle(Color.gray)
                        .padding(.leading)
                }
                .padding(.leading)
            }
        }
    }
}

#Preview {
    JuglerSeriesViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
        common: commonVar(),
    )
}
