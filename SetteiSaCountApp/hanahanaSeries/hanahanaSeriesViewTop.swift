//
//  hanahanaSeriesViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/16.
//

import SwiftUI
import TipKit


// /////////////////////////
// 変数：お気に入り機種設定用の変数
// /////////////////////////
class hanahanaSeriesfavoriteSetVar: ObservableObject {
    @AppStorage("isSelectedDragonHanahanaSenkoh") var isSelectedDragonHanahanaSenkoh = true
    @AppStorage("isSelectedKingHanahana") var isSelectedKingHanahana = true
    @AppStorage("isSelectedHanaTensho") var isSelectedHanaTensho = true
    @AppStorage("isSelectedStarHana") var isSelectedStarHana = true
    
}


// //////////////////////
// ビュー：メインビュー
// //////////////////////
struct hanahanaSeriesViewTop: View {
//    @ObservedObject var ver391: Ver391
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @ObservedObject var favoriteSet = hanahanaSeriesfavoriteSetVar()
    let displayMode = ["お気に入り", "全機種"]     // 機種リストの表示モード選択肢
    @State var isSelectedDisplayMode = "お気に入り"
    @State var isShowFavoriteSettingView = false
    @EnvironmentObject var common: commonVar
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
                            // //// スターハナハナ、25年1月
                            if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedStarHana == false {
                                // 非表示
                            } else {
                                unitMachineIconLinkWithSfsymbol(
                                    linkView: AnyView(starHanaViewTop(
                                        bayes: bayes,
                                        viewModel: viewModel,
                                    )),
                                    iconImage: Image("starHanaMachineIcon"),
                                    machineName: "スターハナハナ",
                                    sfSymbolName: "star.fill",
                                )
                            }
                            
                            // //// ドラゴンハナハナ, 23年12月
                            if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedDragonHanahanaSenkoh == false {
                                // 非表示
                            } else {
                                unitMachineIconLinkWithSfsymbol(
                                    linkView: AnyView(draHanaSenkohVer2ViewTop(
                                        bayes: bayes,
                                        viewModel: viewModel,
                                    )),
                                    iconImage: Image("machineImageDragonHanahanaSenkoh2"),
                                    machineName: "ドラゴン閃光",
                                    sfSymbolName: "bolt.fill",
                                )
//                                NavigationLink(destination: draHanaSenkohVer2ViewTop(
//                                    bayes: bayes,
//                                    viewModel: viewModel,
//                                )) {
//                                    VStack {
//                                        ZStack {
//                                            Image("machineImageDragonHanahanaSenkoh2")
//                                                .resizable()
//                                                .aspectRatio(contentMode: .fit)
//                                                .cornerRadius(13.0)
//                                                .padding(.horizontal, 4.0)
//                                            Image(systemName: "bolt")
//                                                .foregroundStyle(Color.gray)
//                                                .font(.largeTitle)
//                                        }
//                                        Text("ドラゴン閃光")
//                                            .font(.caption)
//                                            .lineLimit(1)
//                                            .foregroundStyle(Color.primary)
//                                    }
//                                }
                            }
                            
                            // //// キングハナハナ, 23年3月
                            if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedKingHanahana == false {
                                // 非表示
                            } else {
                                unitMachineIconLinkWithSfsymbol(
                                    linkView: AnyView(kingHanaVer2ViewTop(
                                        bayes: bayes,
                                        viewModel: viewModel,
                                    )),
                                    iconImage: Image("kingHanaMachineIcon"),
                                    machineName: "キングハナハナ",
                                    sfSymbolName: "crown.fill",
                                )
//                                NavigationLink(destination: kingHanaVer2ViewTop(
////                                    ver391: ver391,
//                                    bayes: bayes,
//                                    viewModel: viewModel,
//                                )) {
//                                    VStack {
//                                        ZStack {
//                                            Rectangle()
//                                                .foregroundStyle(Color(hue: 1.0, saturation: 0.683, brightness: 0.797).gradient.opacity(0.8))
//                                                .cornerRadius(13.0)
//                                                .padding(.horizontal, 4.0)
//                                            Image(systemName: "crown.fill")
//                                                .foregroundStyle(Color.secondary)
//                                                .font(.largeTitle)
//                                        }
//                                        Text("キングハナハナ")
//                                            .font(.caption)
//                                            .lineLimit(1)
//                                            .foregroundStyle(Color.primary)
//                                    }
//                                }
                            }
                            
                            // //// ハナハナ鳳凰天翔, 22年1月
                            if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedHanaTensho == false {
                                // 非表示
                            } else {
                                unitMachineIconLink(
                                    linkView: AnyView(hanaTenshoVer2ViewTop(
//                                        ver391: ver391,
                                        bayes: bayes,
                                        viewModel: viewModel,
                                    )),
                                    iconImage: Image("hanatenshoMachineIcon"),
                                    machineName: "鳳凰 天翔",
//                                    badgeStatus: ver391.hanaTenshoMachineIconBadge,
                                )
                            }
                        }
                    }
                    .background(Color(UIColor.systemGroupedBackground))
                }
                // //// リスト表示モード
                else {
                    // //// 機種リスト表示部分
                    List {
                        Section {
                            // //// スターハナハナ、25年1月
                            if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedStarHana == false {
                                // 非表示
                            } else {
                                unitMachinListLinkWithSfsymbol(
                                    linkView: AnyView(starHanaViewTop(
                                        bayes: bayes,
                                        viewModel: viewModel,
                                    )),
                                    iconImage: Image("starHanaMachineIcon"),
                                    machineName: "スターハナハナ",
                                    makerName: "パイオニア",
                                    releaseYear: 2025,
                                    releaseMonth: 1,
//                                    badgeStatus: ver391.starHanaMachineIconBadge,
                                    sfSymbolName: "star.fill"
                                )
                            }
                            
                            // //// ドラゴンハナハナ, 23年12月
                            if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedDragonHanahanaSenkoh == false {
                                // 非表示
                            } else {
                                unitMachinListLinkWithSfsymbol(
                                    linkView: AnyView(draHanaSenkohVer2ViewTop(
                                        bayes: bayes,
                                        viewModel: viewModel,
                                    )),
                                    iconImage: Image("machineImageDragonHanahanaSenkoh2"),
                                    machineName: "ドラゴン閃光",
                                    makerName: "パイオニア",
                                    releaseYear: 2023,
                                    releaseMonth: 12,
//                                    badgeStatus: ver391.starHanaMachineIconBadge,
                                    sfSymbolName: "bolt.fill"
                                )
//                                machineListDragonHanahanaSenkoh(
////                                    ver391: ver391,
//                                    bayes: bayes,
//                                    viewModel: viewModel,
//                                )
                            }
                            
                            // //// キングハナハナ, 23年3月
                            if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedKingHanahana == false {
                                // 非表示
                            } else {
                                unitMachinListLinkWithSfsymbol(
                                    linkView: AnyView(kingHanaVer2ViewTop(
                                        bayes: bayes,
                                        viewModel: viewModel,
                                    )),
                                    iconImage: Image("kingHanaMachineIcon"),
                                    machineName: "キングハナハナ",
                                    makerName: "パイオニア",
                                    releaseYear: 2023,
                                    releaseMonth: 3,
//                                    badgeStatus: ver391.starHanaMachineIconBadge,
                                    sfSymbolName: "crown.fill"
                                )
//                                machineListKingHanahana(
////                                    ver391: ver391,
//                                    bayes: bayes,
//                                    viewModel: viewModel,
//                                )
                            }
                            
                            // //// ハナハナ鳳凰天翔, 22年1月
                            if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedHanaTensho == false {
                                // 非表示
                            } else {
                                unitMachinListLink(
                                    linkView: AnyView(hanaTenshoVer2ViewTop(
//                                        ver391: ver391,
                                        bayes: bayes,
                                        viewModel: viewModel,
                                    )),
                                    iconImage: Image("hanatenshoMachineIcon"),
                                    machineName: "ハナハナ鳳凰天翔",
                                    makerName: "パイオニア",
                                    releaseYear: 2022,
                                    releaseMonth: 1,
//                                    badgeStatus: ver391.hanaTenshoMachineIconBadge,
                                )
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
            // //// バッジのリセット
            .resetBadgeOnAppear($common.hanaSeriesBadge)
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
            .navigationTitle("ハナハナ機種選択")
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
                            hanahanaSeriesfavoriteSettingView()
                        })
                    }
                }
            }
        }
//        .onAppear {
//            if ver220.hanaSerieseNewBadgeStatus != "none" {
//                ver220.hanaSerieseNewBadgeStatus = "none"
//            }
//        }
    }
}


// ///////////////////////
// ビュー：お気に入り設定画面
// ///////////////////////
struct hanahanaSeriesfavoriteSettingView: View {
    @ObservedObject var favoriteSet = hanahanaSeriesfavoriteSetVar()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            List {
                // スターハナハナ、25年1月
                Toggle("スターハナハナ", isOn: $favoriteSet.isSelectedStarHana)
                // ドラゴンハナハナ, 23年12月
                Toggle("ドラゴンハナハナ閃光", isOn: $favoriteSet.isSelectedDragonHanahanaSenkoh)
                // キングハナハナ, 23年3月
                Toggle("キングハナハナ", isOn: $favoriteSet.isSelectedKingHanahana)
                // ハナハナ鳳凰天翔、22年1月
                Toggle("ハナハナ鳳凰天翔", isOn: $favoriteSet.isSelectedHanaTensho)
                
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
// ビュー：機種リスト、ドラゴンハナハナ閃光, 23年12月
// ////////////////////////
struct machineListDragonHanahanaSenkoh: View {
//    @ObservedObject var ver391: Ver391
    @ObservedObject var bayes: Bayes
    @StateObject var viewModel: InterstitialViewModel
    
    var body: some View {
        NavigationLink(destination: draHanaSenkohVer2ViewTop(
//            ver391: ver391,
            bayes: bayes,
            viewModel: viewModel,
        )) {
            HStack {
                ZStack {
                    Image("machineImageDragonHanahanaSenkoh2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40.0)
                        .cornerRadius(8)
                    Image(systemName: "bolt")
//                        .foregroundColor(.secondary)
                        .foregroundStyle(Color.secondary)
                }
                VStack(alignment: .leading) {
                    Text("ドラゴンハナハナ閃光")
                    Text("パイオニア , 2023年 12月")
                        .font(.caption)
//                        .foregroundColor(Color.gray)
                        .foregroundStyle(Color.secondary)
                        .padding(.leading)
                }
                .padding(.leading)
            }
        }
    }
}


// ////////////////////////
// ビュー：機種リスト、キングハナハナ, 23年3月
// ////////////////////////
struct machineListKingHanahana: View {
//    @ObservedObject var ver391: Ver391
    @ObservedObject var bayes: Bayes
    @StateObject var viewModel: InterstitialViewModel
    
    var body: some View {
        NavigationLink(destination: kingHanaVer2ViewTop(
            bayes: bayes,
            viewModel: viewModel,
        )) {
            HStack {
                ZStack {
                    Rectangle()
                        .foregroundStyle(Color(hue: 1.0, saturation: 0.683, brightness: 0.797).gradient.opacity(0.8))
                        .frame(width: 40.0, height: 40.0)
                        .cornerRadius(8)
                    Image(systemName: "crown.fill")
                        .foregroundStyle(Color.secondary)
                }
                VStack(alignment: .leading) {
                    Text("キングハナハナ")
                    Text("パイオニア , 2023年 3月")
                        .font(.caption)
                        .foregroundStyle(Color.gray)
                        .padding(.leading)
                }
                .padding(.leading)
            }
        }
    }
}

#Preview {
    hanahanaSeriesViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
