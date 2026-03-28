//
//  ContentView.swift
//  SCPreview
//
//  Created by 横田徹 on 2025/12/20.
//

import SwiftUI
//internal import UniformTypeIdentifiers
//import Combine
//
//// 機種情報をまとめる構造体
//struct Machine: Identifiable, Codable {
//    var id: String      // 一意のID
//    var name: String    // 表示名
//    var onHome: Bool    // ホーム画面への表示
//    var iconName: String // 画像名
//    var btBadge: Bool     // BTバッジ
//}
//
//// 叩き台となるNewContentView
struct ContentView: View {
//    // 実際にはこれを AppStorage や JSON で保存するようにします
//    @State private var machines: [Machine] = [
//        Machine(id: "5555", name: "ジャグラー", onHome: true, iconName: "machineIconJuglerSeries", btBadge: false),
//        Machine(id: "4301", name: "北斗", onHome: true, iconName: "machineIconHokuto", btBadge: false),
//        Machine(id: "4930", name: "カバネリ海門", onHome: true, iconName: "kabaneriUnatoMachineIcon", btBadge: false),
//        Machine(id: "4893", name: "シェイクBT", onHome: true, iconName: "shakeMachineIcon", btBadge: true),
//    ]
//    
//    @State private var isEditingMode = false // 編集モード（プルプル）の状態
//    @State private var draggedItem: Machine? // 現在ドラッグ中のアイテム
//
//    let columns = [
//        GridItem(.adaptive(minimum: 80))
//    ]
//
    var body: some View {
//        NavigationStack {
//            ScrollView {
//                LazyVGrid(columns: columns, spacing: 20) {
////                    ForEach(machines) { machine in
////                        VStack {
////                            // アイコン部分（ここを既存のunitLabelMachineIconLinkに置き換えるイメージ）
////                            ZStack(alignment: .topLeading) {
////                                Image(machine.iconName)
////                                    .resizable()
////                                    .frame(width: 70, height: 70)
////                                    .overlay(alignment: .topLeading) {
////                                        if machine.btBadge {
////                                            unitIconBtTriangleShape()
////                                                .fill(Color.orange)
////                                                .frame(width: 35, height: 35)
////                                            Text("BT")
////                                                .font(.subheadline)
////                                                .foregroundStyle(Color.white)
////                                                .fontWeight(.bold)
////                                                .rotationEffect(.degrees(-45))
////                                                .offset(x: -6, y: -6)
////                                        }
////                                    }
////                                    .cornerRadius(16.0)
////                                
////                                // 編集モード中の「✕」ボタン
////                                if isEditingMode {
////                                    Image(systemName: "minus.circle.fill")
////                                        .font(.title)
////                                        .foregroundColor(.red)
////                                        .background(Circle().fill(.white))
////                                        .offset(x: -10, y: -10)
////                                }
////                            }
////                            Text(machine.name)
////                                .font(.caption)
////                        }
////                        // プルプルアニメーションを適用
////                        .modifier(JitterModifier(isEditing: isEditingMode))
////                        
////                        // ドラッグ＆ドロップの設定（iOS 16+）
////                        .onDrag {
////                            self.draggedItem = machine
////                            return NSItemProvider(object: machine.id as NSString)
////                        }
////                        .onDrop(of: [.text], delegate: MachineDropDelegate(
////                            item: machine,
////                            items: $machines,
////                            draggedItem: $draggedItem
////                        ))
////                    }
//                    ForEach(machines) { machine in
//                        ZStack(alignment: .topLeading) {
//                            // 1. 既存のロック付きアイコンコンポーネントを呼び出す
//                            unitMachineIconLinkWithLock(
//                                linkView: getLinkView(for: machine.id), // IDから遷移先を取得
//                                iconImage: Image(machine.iconName),
//                                machineName: machine.name,
//                                // 一旦 constant(true) で渡しますが、本来は AppStorage 等のフラグを渡します
//                                isUnLocked: .constant(true),
//                                tempUnlockDateDouble: .constant(0.0),
//                                btBadgeBool: machine.btBadge
//                            )
//                            // 編集モード中はタップ（遷移）を無効化して、ドラッグ操作を優先
//                            .disabled(isEditingMode)
//                            
//                            // 2. 編集モード中の「✕」ボタン
//                            if isEditingMode {
//                                Button(action: {
//                                    if let index = machines.firstIndex(where: { $0.id == machine.id }) {
//                                        withAnimation {
//                                            machines.remove(at: index)
//                                        }
//                                    }
//                                }) {
//                                    Image(systemName: "minus.circle.fill")
//                                        .foregroundColor(.red)
//                                        .background(Circle().fill(.white))
//                                        .font(.title3)
//                                }
//                                .offset(x: -2, y: -2)
//                            }
//                        }
//                        .modifier(JitterModifier(isEditing: isEditingMode))
//                        .onDrag {
//                            self.draggedItem = machine
//                            return NSItemProvider(object: machine.id as NSString)
//                        }
//                        .onDrop(of: [.text], delegate: MachineDropDelegate(
//                            item: machine,
//                            items: $machines,
//                            draggedItem: $draggedItem
//                        ))
//                    }
//                }
//                .padding()
//            }
//            .navigationTitle("機種選択")
//            .toolbarTitleDisplayMode(.inline)
//            .toolbar {
//                Button(isEditingMode ? "完了" : "編集") {
//                    withAnimation {
//                        isEditingMode.toggle()
//                    }
//                }
//            }
//        }
    }
}
//
//// プルプル揺れるアニメーション用
//struct JitterModifier: ViewModifier {
//    var isEditing: Bool
//    @State private var isFullSpeed = false
//    
//    func body(content: Content) -> some View {
//        content
//        // 角度を isFullSpeed の状態によって切り替える（2.0度〜-2.0度）
//            .rotationEffect(.degrees(isEditing ? (isFullSpeed ? 2.0 : -2.0) : 0))
//        // isFullSpeed の値が変化したときにアニメーションを適用する
//            .animation(
//                isEditing ?
//                    .linear(duration: 0.12).repeatForever(autoreverses: true) :
//                        .default,
//                value: isFullSpeed
//            )
//        // 編集モードが ON になった瞬間に isFullSpeed を変化させてアニメーションを開始
//            .onChange(of: isEditing, { oldValue, newValue in
//                if newValue {
//                    isFullSpeed = true
//                } else {
//                    isFullSpeed = false
//                }
//            })
//            .onAppear {
//                // 画面表示時にすでに編集モードなら開始
//                if isEditing {
//                    isFullSpeed = true
//                }
//            }
//    }
//    
//    // IDに基づいて遷移先のViewを返す関数
//    func getLinkView(for id: String) -> AnyView {
//        switch id {
//        case "5555":
//            return AnyView(iconTestView1()) // ジャグラーシリーズのView名に合わせて変更してください
//        case "4301":
//            return AnyView(iconTestView2()) // 北斗のView名に合わせて変更してください
//        case "4930":
//            return AnyView(iconTestView3()) // カバネリのView名
//        case "4893":
//            return AnyView(iconTestView4()) // シェイクのView名
//        default:
//            // 該当がない場合の予備（既存の unitReelDefault など）
//            return AnyView(Text("準備中"))
//        }
//    }
//}
//
//// 並び替えのロジックを管理するデリゲート
//struct MachineDropDelegate: DropDelegate {
//    let item: Machine
//    @Binding var items: [Machine]
//    @Binding var draggedItem: Machine?
//
//    func dropUpdated(info: DropInfo) -> DropProposal? {
//        return DropProposal(operation: .move)
//    }
//
//    func performDrop(info: DropInfo) -> Bool {
//        self.draggedItem = nil
//        return true
//    }
//
//    func dropEntered(info: DropInfo) {
//        guard let draggedItem = draggedItem,
//              draggedItem.id != item.id,
//              let from = items.firstIndex(where: { $0.id == draggedItem.id }),
//              let to = items.firstIndex(where: { $0.id == item.id }) else { return }
//
//        if items[to].id != draggedItem.id {
//            withAnimation {
//                items.move(fromOffsets: IndexSet(integer: from), toOffset: to > from ? to + 1 : to)
//            }
//        }
//    }
//}
//
//#Preview {
//    ContentView()
//}
