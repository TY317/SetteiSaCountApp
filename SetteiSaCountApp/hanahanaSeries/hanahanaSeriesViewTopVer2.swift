//
//  hanahanaSeriesViewTopVer2.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/06/21.
//

import SwiftUI

// ハナハナ機種選択（ホーム=ContentViewVer2と同じ並び替えグリッド方式）
// 編集モードでプルプル＋ドラッグ並び替え＋「−」で非表示、♡で再表示。全機種ライブラリは無し。
// アイコンは id で出し分け：ニューキングのみ Lock（リワード）、他は自己完結アイコンの通常表示。
// 今後の新機種は default で unitMachineIconLinkWithLock（Machine自身の値）で描画。
struct hanahanaSeriesViewTopVer2: View {
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar

    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait
    @State private var lazyVGridColumns: Int = 4

    // 編集モード関連
    @State private var isEditingMode = false
    @State private var draggedItem: Machine?
    @State private var showingDeleteAlert = false
    @State private var machineToDelete: Machine?
    @State private var isShowingFavoriteSheet = false

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
                    ForEach($common.hanahanaMachines) { $machine in
                        if machine.onHome {
                            ZStack(alignment: .topLeading) {
                                hanaIcon($machine)
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
                                items: $common.hanahanaMachines,
                                draggedItem: $draggedItem
                            ))
                        }
                    }
                }
                .padding()
            }
            .background(Color(UIColor.systemGroupedBackground))
            .navigationTitle("ハナハナ機種選択")
            .toolbarTitleDisplayMode(.inline)
            // 削除（非表示）確認アラート
            .alert("'\(machineToDelete?.name ?? "")'を取り除きますか？", isPresented: $showingDeleteAlert, presenting: machineToDelete) { machine in
                Button("キャンセル", role: .cancel) {
                    machineToDelete = nil
                }
                Button("取り除く", role: .destructive) {
                    if let index = common.hanahanaMachines.firstIndex(where: { $0.id == machine.id }) {
                        withAnimation {
                            common.hanahanaMachines[index].onHome = false
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
                FavoriteManageView(machines: $common.hanahanaMachines)
            }
            // バッジのリセット
            .resetBadgeOnAppear($common.hanaSeriesBadge)
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

    // アイコン部品の出し分け（既存idは旧部品、defaultは標準のLock部品）
    @ViewBuilder
    private func hanaIcon(_ machine: Binding<Machine>) -> some View {
        let m = machine.wrappedValue
        let dest = hanaDestination(for: m.id)
        switch m.id {
        case "4912":
            // ニューキング：リワードロック＋BTバッジ
            unitMachineIconLinkWithLock(
                linkView: dest,
                iconImage: Image(m.iconName),
                machineName: m.name,
                isUnLocked: $common.newKingHanaisUnlocked,
                tempUnlockDateDouble: $common.newKingHanaTempUnlockDateDouble,
                badgeStatus: hanaBadge(for: m.id),
                btBadgeBool: m.btBadge
            )
        case "4680", "4453", "4311", "4014":
            // 自己完結アイコンに差し替え済みのためSFシンボル重ねは廃止。通常アイコン表示。
            unitMachineIconLink(linkView: dest, iconImage: Image(m.iconName), machineName: m.name, badgeStatus: hanaBadge(for: m.id))
        default:
            // 今後の新機種：標準のLock部品。Machine自身の値を使用
            unitMachineIconLinkWithLock(
                linkView: dest,
                iconImage: Image(m.iconName),
                machineName: m.name,
                isUnLocked: machine.isUnlocked,
                tempUnlockDateDouble: machine.unlockDate,
                badgeStatus: m.badgeStatus,
                btBadgeBool: m.btBadge
            )
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

    // id（DMM下4桁）→ 既存の@AppStorageバッジ（新機種はMachine.badgeStatus側を使うので "none"）
    private func hanaBadge(for id: String) -> String {
        switch id {
        case "4912": return common.newKingHanaMachineIconBadge
        case "4680": return common.starHanaMachineIconBadge
        case "4453": return common.draHanaSenkohMachineIconBadge
        case "4311": return common.kingHanaMachineIconBadge
        case "4014": return common.hanaTenshoMachineIconBadge
        default: return "none"
        }
    }

    // id（DMM下4桁）→ 遷移先ViewTop
    private func hanaDestination(for id: String) -> AnyView {
        switch id {
        case "4912": return AnyView(newKingHanaViewTop(bayes: bayes, viewModel: viewModel))
        case "4680": return AnyView(starHanaViewTop(bayes: bayes, viewModel: viewModel))
        case "4453": return AnyView(draHanaSenkohVer2ViewTop(bayes: bayes, viewModel: viewModel))
        case "4311": return AnyView(kingHanaVer2ViewTop(bayes: bayes, viewModel: viewModel))
        case "4014": return AnyView(hanaTenshoVer2ViewTop(bayes: bayes, viewModel: viewModel))
        default: return AnyView(EmptyView())
        }
    }
}

#Preview {
    hanahanaSeriesViewTopVer2(bayes: Bayes(), viewModel: InterstitialViewModel())
        .environmentObject(commonVar())
}
