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
    
}


// //////////////////////
// ビュー：メインビュー
// //////////////////////
struct hanahanaSeriesViewTop: View {
    @ObservedObject var favoriteSet = hanahanaSeriesfavoriteSetVar()
    let displayMode = ["お気に入り", "全機種"]     // 機種リストの表示モード選択肢
    @State var isSelectedDisplayMode = "お気に入り"
    @State var isShowFavoriteSettingView = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // //// 機種リスト表示部分
                List {
                    Section {
                        // //// ドラゴンハナハナ, 23年12月
                        if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedDragonHanahanaSenkoh == false {
                            // 非表示
                        } else {
                            machineListDragonHanahanaSenkoh()
                        }
                        
                        // //// キングハナハナ, 23年3月
                        if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedKingHanahana == false {
                            // 非表示
                        } else {
                            machineListKingHanahana()
                        }
                        
                        // //// ハナハナ鳳凰天翔, 22年1月
                        if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedHanaTensho == false {
                            // 非表示
                        } else {
                            unitMachinListLink(linkView: AnyView(hanaTenshoViewTop()), iconImage: Image("hanatenshoMachineIcon"), machineName: "ハナハナ鳳凰天翔", makerName: "パイオニア", releaseYear: 2022, releaseMonth: 1)
//                                .popoverTip(tipAddHanahanaTensho())
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
            .navigationTitle("ハナハナ機種選択")
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
                        hanahanaSeriesfavoriteSettingView()
                    })
                }
            }
        }
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
    var body: some View {
        NavigationLink(destination: draHanaSenkohViewTop()) {
            HStack {
                ZStack {
                    Image("machineImageDragonHanahanaSenkoh2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40.0)
                        .cornerRadius(8)
                    Image(systemName: "bolt")
                        .foregroundColor(.secondary)
                }
                VStack(alignment: .leading) {
                    Text("ドラゴンハナハナ閃光")
                    Text("パイオニア , 2023年 12月")
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
// ビュー：機種リスト、キングハナハナ, 23年3月
// ////////////////////////
struct machineListKingHanahana: View {
    var body: some View {
        NavigationLink(destination: kingHanaViewTop()) {
            HStack {
                ZStack {
                    Rectangle()
                        .foregroundStyle(Color(hue: 1.0, saturation: 0.683, brightness: 0.797).gradient.opacity(0.8))
                        .frame(width: 40.0, height: 40.0)
                        .cornerRadius(8)
                    Image(systemName: "crown.fill")
                        .foregroundColor(.secondary)
                }
                VStack(alignment: .leading) {
                    Text("キングハナハナ")
                    Text("パイオニア , 2023年 3月")
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
    hanahanaSeriesViewTop()
}
