//
//  ContentViewVer2.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/17.
//


import SwiftUI
internal import UniformTypeIdentifiers
import Combine
import GoogleMobileAds
import UIKit
import TipKit
import StoreKit
import AppTrackingTransparency
import PDFKit
import FirebaseAnalytics


struct ContentViewVer2: View {
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var rewardViewModel: RewardedViewModel
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 250.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 250.0
    let lazyVGridCountPortrait: Int = 4
    let lazyVGridCountLandscape: Int = 8
    @State var lazyVGridCount: Int = 4
    
    @State private var isEditingMode = false // 編集モード（プルプル）の状態
    @State private var draggedItem: Machine? // 現在ドラッグ中のアイテム
    @State private var showingDeleteAlert = false // アラート表示フラグ
    @State private var machineToDelete: Machine? // 削除対象を一時保存
    @State private var isShowingFavoriteSheet = false // シート表示用フラグ
    
    // ライト・ダークモードの切り替え用
    @AppStorage("appearanceMode") private var appearanceModeRaw: Int = AppearanceMode.system.rawValue
    private var appearanceMode: AppearanceMode {
        get { AppearanceMode(rawValue: appearanceModeRaw) ?? .system }
        set { appearanceModeRaw = newValue.rawValue }
    }
    
    @State private var isKeyboardVisible = false  // キーボード表示状態を追跡
    
    let columns = [
        GridItem(.adaptive(minimum: 80))
    ]
    
    @State private var isFullSpeed = false
    
    var body: some View {
        VStack(spacing: 0) {
            // ホーム画面
            NavigationStack {
                ScrollView {
                    LazyVGrid(
                        columns: Array(
                            repeating: GridItem(.fixed(common.lazyVGridSize),
                                                spacing: common.lazyVGridSpacing),
                            count: self.lazyVGridCount
                        ),
                        spacing: common.lazyVGridSpacing) {
                            ForEach($common.machines) { $machine in
                                if machine.onHome {
                                    ZStack(alignment: .topLeading) {
                                        // 1. 既存のロック付きアイコンコンポーネントを呼び出す
                                        unitMachineIconLinkWithLock(
                                            linkView: getLinkView(for: machine.id), // IDから遷移先を取得
                                            iconImage: Image(machine.iconName),
                                            machineName: machine.name,
                                            isUnLocked: $machine.isUnlocked,
                                            tempUnlockDateDouble: $machine.unlockDate,
                                            badgeStatus: machine.badgeStatus,
                                            btBadgeBool: machine.btBadge,
                                        )
                                        // 編集モード中はタップ（遷移）を無効化して、ドラッグ操作を優先
                                        .disabled(isEditingMode)
                                        
                                        // 2. 編集モード中の「✕」ボタン
                                        if isEditingMode {
                                            Button(action: {
                                                // 削除対象をセットしてアラートを表示
                                                machineToDelete = machine
                                                showingDeleteAlert = true
                                            }) {
                                                Image(systemName: "minus.circle.fill")
                                                    .foregroundColor(.red)
                                                    .background(Circle().fill(.white))
                                                    .font(.title2)
                                            }
                                            .offset(x: -4, y: -4)
                                        }
                                    }
                                    .id(machine.id) // SwiftUIに同一のビューであることを保証する
                                    .modifier(JitterModifier(isEditing: isEditingMode))
                                    // ★if extension を使って、isEditingMode が true の時だけ onDrag を付与する
                                        .if(isEditingMode) { view in
                                            view.onDrag {
                                                self.draggedItem = machine
                                                return NSItemProvider(object: machine.id as NSString)
                                            }
                                        }
                                    .onDrop(of: [.text], delegate: MachineDropDelegate(
                                        item: machine,
                                        items: $common.machines,
                                        draggedItem: $draggedItem
                                    ))
                                }
                            }
                        }
                        .padding()
                }
                .background(Color(UIColor.systemGroupedBackground))
                .navigationTitle("機種選択")
                .toolbarTitleDisplayMode(.inline)
                // //// 画面の向き情報の取得部分
                .applyOrientationHandling(
                    orientation: self.$orientation,
                    lastOrientation: self.$lastOrientation,
                    scrollViewHeight: self.$scrollViewHeight,
                    spaceHeight: self.$spaceHeight,
                    lazyVGridCount: self.$lazyVGridCount,
                    scrollViewHeightPortrait: self.scrollViewHeightPortrait,
                    scrollViewHeightLandscape: self.scrollViewHeightLandscape,
                    spaceHeightPortrait: self.spaceHeightPortrait,
                    spaceHeightLandscape: self.spaceHeightLandscape,
                    lazyVGridCountPortrait: common.lazyVGridColumnsPortlait,
                    lazyVGridCountLandscape: common.lazyVGridColumnsLandscape,
                )
                .toolbar {
                    // 外観切り替えボタン（システム/ライト/ダーク）
                    ToolbarItem(placement: .automatic) {
                        Menu {
                            Button {
                                self.appearanceModeRaw = 0
                            } label: {
                                Label("システムに合わせる", systemImage: self.appearanceModeRaw == 0 ? "checkmark" : "gearshape")
                            }
                            Button {
                                self.appearanceModeRaw = 1
                            } label: {
                                Label("ライト", systemImage: self.appearanceModeRaw == 1 ? "checkmark" : "sun.max")
                            }
                            Button {
                                self.appearanceModeRaw = 2
                            } label: {
                                Label("ダーク", systemImage: self.appearanceModeRaw == 2 ? "checkmark" : "moon.fill")
                            }
                        } label: {
                            Image(systemName: "circle.lefthalf.filled")
                        }
                    }
                    // ホーム編集
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
                    // ホーム画面表示
                    ToolbarItem(placement: .automatic) {
                        Button {
                            isShowingFavoriteSheet = true
                        } label: {
                            Image(systemName: "heart")
                        }
                    }
                }
                // シートの呼び出し
                .sheet(isPresented: $isShowingFavoriteSheet) {
                    FavoriteManageView(machines: $common.machines)
                }
            }
            // 削除確認アラートの実装
            .alert("'\(machineToDelete?.name ?? "")'を取り除きますか？", isPresented: $showingDeleteAlert, presenting: machineToDelete) { machine in
                Button("キャンセル", role: .cancel) {
                    machineToDelete = nil
                }
                Button("取り除く", role: .destructive) {
                    // 配列内の該当機種の onHome を false に更新
                    if let index = common.machines.firstIndex(where: { $0.id == machine.id }) {
                        withAnimation {
                            common.machines[index].onHome = false
                        }
                    }
                    machineToDelete = nil
                }
            } message: { _ in
                Text("ホーム画面から取り除きます。\n（いつでも右上の♡から復活させることができます）")
            }
            // バナー広告の常時表示。キーボード出現時は非表示にする。
            if !isKeyboardVisible {
                GeometryReader { geometry in
                    let adSize = currentOrientationAnchoredAdaptiveBanner(width: geometry.size.width)
                    
                    ZStack {
                        Rectangle()
                            .foregroundStyle(Color(UIColor.systemGroupedBackground))
                            .ignoresSafeArea()
                        BannerAdView(adSize)
                            .frame(height: adSize.size.height)
                    }
                    .frame(height: adSize.size.height)
                }
                .frame(height: currentOrientationAnchoredAdaptiveBanner(width: UIScreen.main.bounds.width).size.height)
            }
        }
        // リワード広告のロード
        .onAppear {
            Task { await rewardViewModel.loadAd() }
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
            // トラッキング許可のポップアップを出す
            ATTrackingManager.requestTrackingAuthorization() {_ in
                MobileAds.shared.start(completionHandler: nil)
            }
            common.trackingRequested = true
        }
        .onDisappear {
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    }
    
    // IDに基づいて遷移先のViewを返す関数
    func getLinkView(for id: String) -> AnyView {
        switch id {
        case "5555": return AnyView(
            JuglerSeriesViewTop(
                bayes: bayes,
                viewModel: viewModel
            )
        )
        case "8787": return AnyView(
            hanahanaSeriesViewTop(
                bayes: bayes,
                viewModel: viewModel
            )
        )
        case "4943": return AnyView(
            thunderViewTop(
                bayes: bayes,
                viewModel: viewModel
            )
        )
        case "4930": return AnyView(
            kabaneriUnatoViewTop(
                bayes: bayes,
                viewModel: viewModel
            )
        )
        case "4950": return AnyView(
            gobsla2ViewTop(
                bayes: bayes,
                viewModel: viewModel
            )
        )
        case "4928": return AnyView(
            hanabiViewTop(
                bayes: bayes,
                viewModel: viewModel
            )
        )
        case "4926": return AnyView(
            enen2ViewTop(
                bayes: bayes,
                viewModel: viewModel
            )
        )
        case "4931": return AnyView(
            kokakukidotaiViewTop(
                bayes: bayes,
                viewModel: viewModel
            )
        )
        case "4913": return AnyView(
            tekken6ViewTop(
                bayes: bayes,
                viewModel: viewModel
            )
        )
        case "4909": return AnyView(
            hokutoTenseiViewTop(
                bayes: bayes,
                viewModel: viewModel
            )
        )
        case "4924": return AnyView(
            mushotenViewTop(
                bayes: bayes,
                viewModel: viewModel
            )
        )
        case "4929": return AnyView(
            hihodenViewTop(
                bayes: bayes,
                viewModel: viewModel
            )
        )
        case "4898": return AnyView(bakemonoViewTop(bayes: bayes,viewModel: viewModel))
        case "4873": return AnyView(neoplaViewTop(bayes: bayes,viewModel: viewModel))
        case "4892": return AnyView(railgunViewTop(bayes: bayes,viewModel: viewModel))
        case "4885": return AnyView(vvv2ViewTop(bayes: bayes,viewModel: viewModel))
        case "4893": return AnyView(shakeViewTop(bayes: bayes,viewModel: viewModel))
        case "4880": return AnyView(newOni3ViewTop(bayes: bayes,viewModel: viewModel))
        case "4877": return AnyView(zeni5ViewTop(bayes: bayes,viewModel: viewModel))
        case "4860": return AnyView(creaViewTop(bayes: bayes,viewModel: viewModel))
        case "4849": return AnyView(toreveViewTop(bayes: bayes,viewModel: viewModel))
        case "4847": return AnyView(azurLaneViewTop(bayes: bayes,viewModel: viewModel))
        case "4855": return AnyView(darlingViewTop(bayes: bayes,viewModel: viewModel))
        case "4843": return AnyView(reSwordViewTop())
        case "4830": return AnyView(evaYakusokuViewTop(bayes: bayes,viewModel: viewModel))
        case "4803": return AnyView(watakonViewTop())
        case "4790": return AnyView(guiltyCrown2ViewTop())
        case "4814": return AnyView(dmc5ViewTop())
        case "4805": return AnyView(izaBanchoViewTop())
        case "4806": return AnyView(toloveru87ViewTop())
        case "4788": return AnyView(gundamSeedViewTop())
        case "4763": return AnyView(midoriDonViewTop())
        case "4778": return AnyView(yoshimuneViewTop())
        case "4777": return AnyView(mahjongViewTop())
        case "4752": return AnyView(godzillaViewTop())
        case "4745": return AnyView(magiaViewTop(bayes: bayes,viewModel: viewModel))
        case "4706": return AnyView(rslViewTop())
        case "4754": return AnyView(bioViewTop())
        case "4734": return AnyView(kaijiViewTop())
        case "4715": return AnyView(arifureViewTop())
        case "4742": return AnyView(tokyoGhoulViewTop(bayes: bayes,viewModel: viewModel))
        case "4719": return AnyView(shamanKingViewTop(bayes: bayes,viewModel: viewModel))
        case "4712": return AnyView(sbjViewTop())
        case "4709": return AnyView(sevenSwordsViewTop())
        case "4686": return AnyView(acceleratorViewTop())
        case "4669": return AnyView(dumbbellViewTop())
        case "4681": return AnyView(danvineViewTop())
        case "4689": return AnyView(lupinViewTop())
        case "4676": return AnyView(mhrViewTop(bayes: bayes,viewModel: viewModel))
        case "4641": return AnyView(bangdreamViewTop())
        case "4658": return AnyView(rezero2ViewTop())
        case "4618": return AnyView(kaguyaViewTop(bayes: bayes,viewModel: viewModel))
        case "4579": return AnyView(symphoViewTop())
        case "4602": return AnyView(godeaterViewTop(bayes: bayes,viewModel: viewModel))
        case "4571": return AnyView(toloveruViewTop())
        case "4555": return AnyView(enenViewTop(bayes: bayes,viewModel: viewModel))
        case "4501": return AnyView(goevaViewTop())
        case "4450": return AnyView(mt5ViewTop(bayes: bayes,viewModel: viewModel))
        case "4360": return AnyView(karakuriViewTop(bayes: bayes,viewModel: viewModel))
        case "4301": return AnyView(hokutoViewTop(bayes: bayes,viewModel: viewModel))
        case "4244": return AnyView(VVV_Top(bayes: bayes,viewModel: viewModel))
        case "4160": return AnyView(kabaneriViewTop())
        default: return AnyView(Text("準備中"))
        }
    }
}


extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

#Preview {
    ContentViewVer2()
        .environmentObject(commonVar())
        .environmentObject(RewardedViewModel())
        .environmentObject(Bayes())
        .environmentObject(InterstitialViewModel())
}
