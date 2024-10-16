//
//  ContentView.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/06.
//

import SwiftUI
import GoogleMobileAds
import UIKit
import TipKit

// /////////////////////////
// 変数：お気に入り機種設定用の変数
// /////////////////////////
class favoriteSetVar: ObservableObject {
    @AppStorage("isSelectedJuglerSeries") var isSelectedJuglerSeries = true
    @AppStorage("isSelectedFavoriteVVV") var isSelectedFavoriteVVV = true
    @AppStorage("isSelectedHanahanaSeries") var isSelectedHanahanaSeries = true
    @AppStorage("isSelectedFavoriteMT5") var isSelectedFavoriteMT5 = true
    @AppStorage("isSelectedFavoriteGoeva") var isSelectedFavoriteGoeva = true
    @AppStorage("isSelectedFavoriteKabaneri") var isSelectedFavoriteKabaneri = true
    @AppStorage("isSelectedFavoriteToloveru") var isSelectedFavoriteToloveru = true
    @AppStorage("isSelectedFavoriteHokuto") var isSelectedFavoriteHokuto = true
    @AppStorage("isSelectedFavoriteGodeater") var isSelectedFavoriteGodeater = true
    @AppStorage("isSelectedFavoriteSympho") var isSelectedFavoriteSympho = true
    @AppStorage("isSelectedFavoriteKarakuri") var isSelectedFavoriteKarakuri = true
}


// /////////////////////////
// 変数：コモン
// /////////////////////////
class commonVar: ObservableObject {
    
}


// //////////////////
// Tip：機種追加
// //////////////////
struct tipAddGodeaterSympho: Tip {
    var title: Text {
        Text("機種追加しました！")
    }
    var message: Text? {
        Text("ゴッドイーター、シンフォギア、からくりサーカスを追加")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


// /////////////////////////
// ビュー：メインビュー
// /////////////////////////
struct ContentView: View {
    @ObservedObject var favoriteSet = favoriteSetVar()
    let displayMode = ["お気に入り", "全機種"]     // 機種リストの表示モード選択肢
    @State var isSelectedDisplayMode = "お気に入り"
    @State var isShowFavoriteSettingView = false
    @State private var isKeyboardVisible = false  // キーボード表示状態を追跡
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationStack {
                ZStack {
                    // //// 機種リスト表示部分
                    List {
                        Section {
                            // //// ジャグラーシリーズ
                            if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedJuglerSeries == false {
                                // 非表示
                            } else {
                                machineListJuglerSeries()
                            }
                            
                            // //// ハナハナシリーズ
                            if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedHanahanaSeries == false {
                                // 非表示
                            } else {
                                machineListHanahanaSeries()
                            }
                            
                            // //// シンフォギア 正義の歌、24年7月
                            if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteSympho == false {
                                // 非表示
                            } else {
                                unitMachinListLink(linkView: AnyView(symphoViewTop()), iconImage: Image("symphoMachineIcon"), machineName: "戦姫絶唱シンフォギア 正義の歌", makerName: "SANKYO", releaseYear: 2024, releaseMonth: 7)
                                    .popoverTip(tipAddGodeaterSympho())
                            }
                            
                            // //// ゴッドイーター リザレクション、24年7月
                            if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteGodeater == false {
                                // 非表示
                            } else {
                                unitMachinListLink(linkView: AnyView(godeaterViewTop()), iconImage: Image("godeaterMachinIcon"), machineName: "ゴッドイーター リザレクション", makerName: "セブンリーグ", releaseYear: 2024, releaseMonth: 7)
                            }
                            // //// ToLOVEるダークネス、24年6月
                            if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteToloveru == false {
                                // 非表示
                            } else {
                                unitMachinListLink(linkView: AnyView(toloveruViewTop()), iconImage: Image("toloveruMachineIcon"), machineName: "ToLOVEるダークネス", makerName: "オリンピアエステート", releaseYear: 2024, releaseMonth: 6)
//                                    .popoverTip(tipAddToloveru())
                            }
                            
                            // //// ゴジラvsエヴァンゲリオン、24年2月
                            if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteGoeva == false {
                                // 非表示
                            } else {
                                unitMachinListLink(linkView: AnyView(goevaViewTop()), iconImage: Image("machinIconGoeva"), machineName: "ゴジラvsエヴァンゲリオン", makerName: "ビスティ", releaseYear: 2024, releaseMonth: 2)
                            }
                            
                            // //// モンキーターン５、23年12月
                            if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteMT5 == false {
                                // 非表示
                            } else {
                                unitMachinListLink(linkView: AnyView(mt5ViewTop()), iconImage: Image("machineIconMT5"), machineName: "モンキーターン5", makerName: "山佐", releaseYear: 2023, releaseMonth: 12)
                            }
                            
                            // //// からくりサーカス、23年7月
                            if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteKarakuri == false {
                                // 非表示
                            } else {
                                unitMachinListLink(linkView: AnyView(karakuriViewTop()), iconImage: Image("karakuriMachineIcon"), machineName: "からくりサーカス", makerName: "SANKYO", releaseYear: 2023, releaseMonth: 7)
                            }
                            
                            // //// 北斗の拳、23年4月
                            if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteHokuto == false {
                                // 非表示
                            } else {
                                unitMachinListLink(linkView: AnyView(hokutoViewTop()), iconImage: Image("machineIconHokuto"), machineName: "北斗の拳", makerName: "サミー", releaseYear: 2023, releaseMonth: 4)
//                                    .popoverTip(tipAddHokuto())
                            }
                            
                            // //// ヴァルヴレイヴ、22年11月
                            if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteVVV == false {
                                // 非表示
                            } else {
                                unitMachinListLink(linkView: AnyView(VVV_Top()), iconImage: Image("machineIconVVV"), machineName: "革命機ヴァルヴレイヴ", makerName: "SANKYO", releaseYear: 2022, releaseMonth: 11)
                            }
                            
                            // //// カバネリ、22年7月
                            if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteKabaneri == false {
                                // 非表示
                            } else {
                                unitMachinListLink(linkView: AnyView(kabaneriViewTop()), iconImage: Image("machineIconKabaneri"), machineName: "甲鉄城のカバネリ", makerName: "サミー", releaseYear: 2022, releaseMonth: 7)
                            }
                            
                        } header: {
                            VStack {
                                Text("")
                                Text("")
                            }
                        }
                    }
                    // //// モード選択ピッカー
                    VStack {
                        Picker("", selection: $isSelectedDisplayMode) {
                            ForEach(displayMode, id: \.self) { mode in
//                                Text($0)
                                Text(mode)
                            }
                        }
                        .background(Color(UIColor.systemGroupedBackground))
                        .pickerStyle(.segmented)
                        Spacer()
                    }
                }
                .navigationTitle("機種選択")
                .toolbarTitleDisplayMode(.inline)
                
                // //// ツールバーボタン
                .toolbar {
                    ToolbarItem(placement: .automatic) {
                        Button(action: {
                            isShowFavoriteSettingView.toggle()
                        }, label: {
                            Image(systemName: "gearshape.fill")
                        })
                        .sheet(isPresented: $isShowFavoriteSettingView, content: {
                            favoriteSettingView()
                        })
                    }
                }
            }
            // バナー広告の常時表示。キーボード出現時は非表示にする。
            if !isKeyboardVisible {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color(UIColor.systemGroupedBackground))
                        .ignoresSafeArea()
                        .frame(height: 50)
                    AdMobBannerView()
                        .frame(width: 320,height: 50)     // 320*50が基本サイズ？50だといい感じ
                }
            }
        }
        
        // キーボードの状態を受け取り
        // ビューが表示されたときに、キーボードの表示/非表示を監視するために NotificationCenter を使用して通知を受け取る設定を行います。
        // onDisappear では通知の登録を解除しています。
        .onAppear {
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { _ in
                isKeyboardVisible = true
            }
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                isKeyboardVisible = false
            }
        }
        .onDisappear {
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    }
}


// ///////////////////////
// ビュー：お気に入り設定画面
// ///////////////////////
struct favoriteSettingView: View {
    @ObservedObject var favoriteSet = favoriteSetVar()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            List {
                // ジャグラーシリーズ
                Toggle("ジャグラーシリーズ", isOn: $favoriteSet.isSelectedJuglerSeries)
                // ハナハナシリーズ
                Toggle("ハナハナシリーズ", isOn: $favoriteSet.isSelectedHanahanaSeries)
                // //// シンフォギア、24年7月
                Toggle("戦姫絶唱シンフォギア 正義の歌", isOn: $favoriteSet.isSelectedFavoriteSympho)
                // //// ゴッドイーターリザレクション、24年7月
                Toggle("ゴッドイーター リザレクション", isOn: $favoriteSet.isSelectedFavoriteGodeater)
                // //// ToLOVEるダークネス、24年6月
                Toggle("ToLOVEるダークネス", isOn: $favoriteSet.isSelectedFavoriteToloveru)
                // ゴジラvsエヴァンゲリオン、24年2月
                Toggle("ゴジラvsエヴァンゲリオン", isOn: $favoriteSet.isSelectedFavoriteGoeva)
                // モンキーターン５　23年12月
                Toggle("モンキーターン5", isOn: $favoriteSet.isSelectedFavoriteMT5)
                // からくりサーカス、23年7月
                Toggle("からくりサーカス", isOn: $favoriteSet.isSelectedFavoriteKarakuri)
                // スマスロ北斗の拳、23年4月
                Toggle("北斗の拳", isOn: $favoriteSet.isSelectedFavoriteHokuto)
                // ヴァルヴレイヴ　22年11月
                Toggle("革命機ヴァルヴレイヴ", isOn: $favoriteSet.isSelectedFavoriteVVV)
                // カバネリ、22年7月
                Toggle("甲鉄城のカバネリ", isOn: $favoriteSet.isSelectedFavoriteKabaneri)
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


// ////////////////////////////
// ゴジラvsエヴァンゲリオン、24年2月
// ////////////////////////////
struct machineListGoeva: View {
    var body: some View {
        NavigationLink(destination: goevaViewTop()) {
            HStack {
                Image("machinIconGoeva")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40.0)
                    .cornerRadius(8)
                VStack(alignment: .leading) {
                    Text("ゴジラvsエヴァンゲリオン")
                    Text("ビスティ , 2024年 2月")
                        .font(.caption)
                        .foregroundColor(Color.gray)
                        .padding(.leading)
                }
                .padding(.leading)
            }
        }
    }
}


// ////////////////////////
// ビュー：革命機ヴァルヴレイヴ
// ////////////////////////
struct machineListVVV: View {
    var body: some View {
        NavigationLink(destination: VVV_Top()) {
            HStack {
                Image("machineIconVVV")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40.0)
                    .cornerRadius(8)
                VStack(alignment: .leading) {
                    Text("革命機ヴァルヴレイヴ")
                    Text("SANKYO , 2022年 11月")
                        .font(.caption)
                        .foregroundColor(Color.gray)
                        .padding(.leading)
                }
                .padding(.leading)
            }
        }
    }
}


// ////////////////////////
// ビュー：カバネリ、22年7月
// ////////////////////////
struct machineListKabaneri: View {
    var body: some View {
        NavigationLink(destination: kabaneriViewTop()) {
            HStack {
                Image("machineIconKabaneri")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40.0)
                    .cornerRadius(8)
                VStack(alignment: .leading) {
                    Text("甲鉄城のカバネリ")
                    Text("サミー , 2022年 7月")
                        .font(.caption)
                        .foregroundColor(Color.gray)
                        .padding(.leading)
                }
                .padding(.leading)
            }
        }
    }
}

// ////////////////////////
// ビュー：ジャグラーシリーズ
// ////////////////////////
struct machineListJuglerSeries: View {
    var body: some View {
        NavigationLink(destination: JuglerSeriesViewTop()) {
            HStack {
                Image("machineIconJuglerSeries")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40.0)
                    .cornerRadius(8)
                VStack(alignment: .leading) {
                    Text("ジャグラーシリーズ")
                    Text("")
                        .font(.caption)
                        .foregroundColor(Color.gray)
                        .padding(.leading)
                }
                .padding(.leading)
            }
        }
    }
}


// ////////////////////////
// ビュー：ハナハナシリーズ
// ////////////////////////
struct machineListHanahanaSeries: View {
    var body: some View {
        NavigationLink(destination: hanahanaSeriesViewTop()) {
            HStack {
                Image("machineIconHanahanaSeries")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40.0)
                    .cornerRadius(8)
                VStack(alignment: .leading) {
                    Text("ハナハナシリーズ")
                    Text("")
                        .font(.caption)
                        .foregroundColor(Color.gray)
                        .padding(.leading)
                }
                .padding(.leading)
            }
        }
    }
}


// ////////////////////////
// ビュー：モンキーターン５、23年　12月
// ////////////////////////
struct machineListMT5: View {
    var body: some View {
        NavigationLink(destination: mt5ViewTop()) {
            HStack {
                Image("machineIconMT5")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40.0)
                    .cornerRadius(8)
                VStack(alignment: .leading) {
                    Text("モンキーターン5")
                    Text("山佐 , 2023年 12月")
                        .font(.caption)
                        .foregroundColor(Color.gray)
                        .padding(.leading)
                }
                .padding(.leading)
            }
        }
    }
}



// ////////////////////
// バナー広告の設定
// ////////////////////
struct AdMobBannerView: UIViewRepresentable {
    func makeUIView(context: Context) -> GADBannerView {
        let banner = GADBannerView(adSize: GADAdSizeBanner) // インスタンスを生成
        // 諸々の設定をしていく
//        banner.adUnitID = "ca-app-pub-3940256099942544/2934735716" // テスト用広告ID
        banner.adUnitID = "ca-app-pub-2339669527176370/9695161925" // 本番用広告ID
        banner.rootViewController = getRootViewController() // 修正部分
        banner.load(GADRequest())
        return banner // 最終的にインスタンスを返す
    }

    func updateUIView(_ uiView: GADBannerView, context: Context) {
        // 特にないのでメソッドだけ用意
    }

    private func getRootViewController() -> UIViewController? {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            return windowScene.windows.filter { $0.isKeyWindow }.first?.rootViewController
        }
        return nil
    }
}

#Preview {
    ContentView()
}
