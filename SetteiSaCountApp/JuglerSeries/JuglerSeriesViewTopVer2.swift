//
//  JuglerSeriesViewTopVer2.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/06/21.
//

import SwiftUI

// ジャグラー機種選択（ホーム=ContentViewVer2と同じ並び替えグリッド方式）
// 編集モードでプルプル＋ドラッグ並び替え＋「−」で非表示、♡で再表示。全機種ライブラリは無し。
struct JuglerSeriesViewTopVer2: View {
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar

    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait
    @State private var lazyVGridColumns: Int = 4

    // 編集モード関連
    @State private var isEditingMode = false          // プルプル編集状態
    @State private var draggedItem: Machine?           // ドラッグ中
    @State private var showingDeleteAlert = false
    @State private var machineToDelete: Machine?
    @State private var isShowingFavoriteSheet = false  // ♡表示設定シート

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(
                    columns: Array(
                        repeating: GridItem(.fixed(common.lazyVGridSize), spacing: common.lazyVGridSpacing),
                        count: lazyVGridColumns
                    ),
                    spacing: common.lazyVGridSpacing
                ) {
                    ForEach($common.juglerMachines) { $machine in
                        if machine.onHome {
                            ZStack(alignment: .topLeading) {
                                unitMachineIconLink(
                                    linkView: juglerDestination(for: machine.id),
                                    iconImage: Image(machine.iconName),
                                    machineName: machine.name,
                                    badgeStatus: juglerBadge(for: machine.id)
                                )
                                // 編集中はタップ（遷移）を無効化してドラッグを優先
                                .disabled(isEditingMode)

                                // 編集モード中の「−」ボタン（この画面から非表示）
                                if isEditingMode {
                                    Button {
                                        machineToDelete = machine
                                        showingDeleteAlert = true
                                    } label: {
                                        Image(systemName: "minus.circle.fill")
                                            .foregroundColor(.red)
                                            .background(Circle().fill(.white))
                                            .font(.title2)
                                    }
                                    .offset(x: -4, y: -4)
                                }
                            }
                            .id(machine.id)
                            .modifier(JitterModifier(isEditing: isEditingMode, seed: jitterSeed(for: machine.id)))
                            // 編集中のみドラッグ可能に
                            .if(isEditingMode) { view in
                                view.onDrag {
                                    self.draggedItem = machine
                                    return NSItemProvider(object: machine.id as NSString)
                                }
                            }
                            .onDrop(of: [.text], delegate: MachineDropDelegate(
                                item: machine,
                                items: $common.juglerMachines,
                                draggedItem: $draggedItem
                            ))
                        }
                    }
                }
                .padding()
            }
            .background(Color(UIColor.systemGroupedBackground))
            .navigationTitle("ジャグラー機種選択")
            .toolbarTitleDisplayMode(.inline)
            // 削除（非表示）確認アラート
            .alert("'\(machineToDelete?.name ?? "")'を取り除きますか？", isPresented: $showingDeleteAlert, presenting: machineToDelete) { machine in
                Button("キャンセル", role: .cancel) {
                    machineToDelete = nil
                }
                Button("取り除く", role: .destructive) {
                    if let index = common.juglerMachines.firstIndex(where: { $0.id == machine.id }) {
                        withAnimation {
                            common.juglerMachines[index].onHome = false
                        }
                    }
                    machineToDelete = nil
                }
            } message: { _ in
                Text("この画面から取り除きます。\n（いつでも右上の♡から復活させることができます）")
            }
            // ツールバー
            .toolbar {
                // 編集（並び替え）
                ToolbarItem(placement: .automatic) {
                    Button {
                        withAnimation {
                            isEditingMode.toggle()
                        }
                    } label: {
                        Image(systemName: "apps.iphone")
                            .foregroundColor(isEditingMode ? .red : .primary)
                    }
                }
                // 表示設定（♡）
                ToolbarItem(placement: .automatic) {
                    Button {
                        isShowingFavoriteSheet = true
                    } label: {
                        Image(systemName: "heart")
                    }
                }
            }
            .sheet(isPresented: $isShowingFavoriteSheet) {
                FavoriteManageView(machines: $common.juglerMachines)
            }
            // バッジのリセット
            .resetBadgeOnAppear($common.jugSeriesBadge)
            // firebaseログ
            .onAppear {
                let screenClass = String(describing: Self.self)
                logEventFirebaseScreen(
                    screenName: "機種選択",
                    screenClass: screenClass
                )
            }
            // 画面の向きで列数を切り替え
            .onAppear {
                self.orientation = UIDevice.current.orientation
                if !self.orientation.isFlat {
                    self.lastOrientation = self.orientation
                }
                updateColumns()
                NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: .main) { _ in
                    self.orientation = UIDevice.current.orientation
                    if !self.orientation.isFlat {
                        self.lastOrientation = self.orientation
                    }
                    updateColumns()
                }
            }
            .onDisappear {
                NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
            }
        }
    }

    // 向きに応じた列数
    private func updateColumns() {
        if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
            self.lazyVGridColumns = common.lazyVGridColumnsLandscape
        } else {
            self.lazyVGridColumns = common.lazyVGridColumnsPortlait
        }
    }

    // アイコンIDから安定した揺れ位相(0..1)を生成（プルプルの同期を崩す）
    private func jitterSeed(for id: String) -> Double {
        let sum = id.unicodeScalars.reduce(0) { $0 + Int($1.value) }
        return Double(sum % 100) / 100.0
    }

    // id（DMM下4桁）→ 既存の@AppStorageバッジを返す
    private func juglerBadge(for id: String) -> String {
        switch id {
        case "4683": return common.urmiraMachineIconBadge
        case "4588": return common.mrJugMachineIconBadge
        case "4540": return common.girlsSSMachineIconBadge
        case "4375": return common.goJug3MachineIconBadge
        case "4230": return common.happyJugV3MachineIconBadge
        case "4029": return common.myJug5MachineIconBadge
        case "3961": return common.funky2MachineIconBadge
        case "3626": return common.imJugExMachineIconBadge
        default: return "none"
        }
    }

    // id（DMM下4桁）→ 遷移先ViewTop
    private func juglerDestination(for id: String) -> AnyView {
        switch id {
        case "4683": return AnyView(urmiraViewTop(bayes: bayes, viewModel: viewModel))
        case "4588": return AnyView(mrJugViewTop(bayes: bayes, viewModel: viewModel))
        case "4540": return AnyView(girlsSSViewTop(bayes: bayes, viewModel: viewModel))
        case "4375": return AnyView(goJug3Ver2ViewTop(bayes: bayes, viewModel: viewModel))
        case "4230": return AnyView(happyJugV3Ver2ViewTop(bayes: bayes, viewModel: viewModel))
        case "4029": return AnyView(myJug5Ver2ViewTop(bayes: bayes, viewModel: viewModel))
        case "3961": return AnyView(funky2Ver2ViewTop(bayes: bayes, viewModel: viewModel))
        case "3626": return AnyView(imJugExVer2ViewTop(bayes: bayes, viewModel: viewModel))
        default: return AnyView(EmptyView())
        }
    }
}

#Preview {
    JuglerSeriesViewTopVer2(bayes: Bayes(), viewModel: InterstitialViewModel())
        .environmentObject(commonVar())
}
