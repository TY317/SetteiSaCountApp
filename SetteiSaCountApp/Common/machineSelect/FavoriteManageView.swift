//
//  FavoriteManageView.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/21.
//

import SwiftUI

// ホーム画面への表示・非表示設定
struct FavoriteManageView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var machines: [Machine]
    
    // ピッカーの選択肢用
    enum FilterType: String, CaseIterable, Identifiable {
        case all = "全て"
        case showing = "表示中"
        case hidden = "非表示"
        var id: Self { self }
    }
    
    @State private var selectedFilter: FilterType = .all
    
    // フィルター条件に基づいて表示する機種を絞り込む
    var filteredMachines: [Binding<Machine>] {
        $machines.filter { $machine in
            switch selectedFilter {
            case .all:
                return true
            case .showing:
                return machine.onHome
            case .hidden:
                return !machine.onHome
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                // セグメントスタイルのピッカー
                Picker("表示設定", selection: $selectedFilter) {
                    ForEach(FilterType.allCases) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                List {
                    ForEach(filteredMachines) { $machine in
                        HStack {
                            // アイコンと名前を表示（分かりやすさのため）
                            Image(machine.iconName)
                                .resizable()
                                .frame(width: 30, height: 30)
                                .cornerRadius(8)
                            
                            Toggle(machine.fullName, isOn: $machine.onHome)
                        }
                    }
                }
            }
            .navigationTitle("機種の表示設定")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("完了") {
                        dismiss()
                    }
                }
            }
        }
    }
}

//#Preview {
//    FavoriteManageView()
//}
