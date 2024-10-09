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
}


// /////////////////////////
// ビュー：メインビュー
// /////////////////////////
struct JuglerSeriesViewTop: View {
    @ObservedObject var favoriteSet = JuglerSeriesfavoriteSetVar()
    let displayMode = ["お気に入り", "全機種"]     // 機種リストの表示モード選択肢
    @State var isSelectedDisplayMode = "お気に入り"
    @State var isShowFavoriteSettingView = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // //// 機種リスト表示部分
                List {
                    Section {
                        // //// ハッピージャグラーV3
                        if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedHappyJugV3 == false {
                            // 非表示
                        } else {
                            unitMachinListLink(linkView: AnyView(happyJugV3ViewTop()), iconImage: Image("machineIconHappyJugV3"), machineName: "ハッピージャグラーV3", makerName: "北電子", releaseYear: 2022, releaseMonth: 10)
                        }
                        
                        // //// マイジャグラー５
                        if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedMyJug5 == false {
                            // 非表示
                        } else {
                            unitMachinListLink(linkView: AnyView(myJug5ViewTop()), iconImage: Image("machineIconMyJug5"), machineName: "マイジャグラー5", makerName: "北電子", releaseYear: 2021, releaseMonth: 12)
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
                            Text(mode)
                        }
                    }
                    .background(Color(UIColor.systemGroupedBackground))
                    .pickerStyle(.segmented)
                    Spacer()
                }
            }
            .navigationTitle("ジャグラー機種選択")
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
                        juglerSeriesfavoriteSettingView()
                    })
                }
            }
        }
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
                // ハッピージャグラーV3, 22年10月
                Toggle("ハッピージャグラーV3", isOn: $favoriteSet.isSelectedHappyJugV3)
                // マイジャグラー　21年12月
                Toggle("マイジャグラー5", isOn: $favoriteSet.isSelectedMyJug5)
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
                        .foregroundColor(Color.gray)
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
                        .foregroundColor(Color.gray)
                        .padding(.leading)
                }
                .padding(.leading)
            }
        }
    }
}

#Preview {
    JuglerSeriesViewTop()
}
