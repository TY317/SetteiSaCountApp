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
    @State private var homeTab = 0   // 0:ホーム 1:アプリライブラリ
    
    // ライト・ダークモードの切り替え用
    @AppStorage("appearanceMode") private var appearanceModeRaw: Int = AppearanceMode.system.rawValue
    private var appearanceMode: AppearanceMode {
        get { AppearanceMode(rawValue: appearanceModeRaw) ?? .system }
        set { appearanceModeRaw = newValue.rawValue }
    }

    // バナーサイズ：縦＝ラージアンカー（高単価/動画デマンド狙い）、横＝インライン高さ50（大きすぎ回避）
    private func bannerAdSize(width: CGFloat) -> AdSize {
        let isLandscape = orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape)
        return isLandscape
            ? inlineAdaptiveBanner(width: width, maxHeight: 50)
            : largeAnchoredAdaptiveBanner(width: width)
    }
    
    @State private var isKeyboardVisible = false  // キーボード表示状態を追跡
    
    let columns = [
        GridItem(.adaptive(minimum: 80))
    ]
    
    @State private var isFullSpeed = false
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationStack {
                TipView(tipVer410UpdateInfo())
                TabView(selection: $homeTab) {
                // ホーム画面（1ページ目）
    //            NavigationStack {
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
                                                linkView: machineDestination(for: machine.id), // IDから遷移先を取得（外観モード適用）
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
                                        .modifier(JitterModifier(isEditing: isEditingMode, seed: jitterSeed(for: machine.id)))
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
//                    .background(Color(UIColor.systemGroupedBackground))
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
                                    applyAppInterfaceStyle(.system)
                                } label: {
                                    Label("システムに合わせる", systemImage: self.appearanceModeRaw == 0 ? "checkmark" : "gearshape")
                                }
                                Button {
                                    self.appearanceModeRaw = 1
                                    applyAppInterfaceStyle(.light)
                                } label: {
                                    Label("ライト", systemImage: self.appearanceModeRaw == 1 ? "checkmark" : "sun.max")
                                }
                                Button {
                                    self.appearanceModeRaw = 2
                                    applyAppInterfaceStyle(.dark)
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
    //            }
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
                .tag(0)

                // アプリライブラリ（2ページ目）
                appLibraryPage
                    .tag(1)
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .indexViewStyle(.page(backgroundDisplayMode: .interactive))
                .background(Color(UIColor.systemGroupedBackground))
                // //// firebaseログ
                .onAppear {
                    let screenClass = String(describing: Self.self)
                    logEventFirebaseScreen(
                        screenName: "機種選択",
                        screenClass: screenClass
                    )
                }
            }
            .background(Color(UIColor.systemGroupedBackground))

            // バナー広告の常時表示。キーボード出現時は非表示にする。
            if !isKeyboardVisible {
                GeometryReader { geometry in
                    let adSize = bannerAdSize(width: geometry.size.width)
                    
                    ZStack {
                        Rectangle()
                            .foregroundStyle(Color(UIColor.systemGroupedBackground))
                            .ignoresSafeArea()
                        BannerAdView(adSize)
                            .frame(height: adSize.size.height)
                    }
                    .frame(height: adSize.size.height)
                }
                .frame(height: bannerAdSize(width: UIScreen.main.bounds.width).size.height)
            }
        }
        .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea())
        // ver4.0.0 新ホーム画面の使い方オンボーディング（初回起動で一度だけ）
        .overlay {
            if !common.homeOnboardingDone {
                unitViewHomeOnboarding()
            }
        }
//        // //// firebaseログ
//        .onAppear {
//            let screenClass = String(describing: Self.self)
//            logEventFirebaseScreen(
//                screenName: "機種選択",
//                screenClass: screenClass
//            )
//        }
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
    // アイコンIDから安定した揺れ位相(0..1)を生成（プルプルの同期を崩す）
    private func jitterSeed(for id: String) -> Double {
        let sum = id.unicodeScalars.reduce(0) { $0 + Int($1.value) }
        return Double(sum % 100) / 100.0
    }

    // MARK: - アプリライブラリ（2ページ目）

    // ライブラリ用の合成カタログ：ホーム機種（集約のジャグラー5555/ハナハナ8787は除外）＋
    // ジャグラー個別機種＋ハナハナ個別機種。onHomeは無視（全機種アクセスの方針）。
    private func libraryMachines() -> [Machine] {
        common.machines.filter { $0.id != "5555" && $0.id != "8787" }
            + common.juglerMachines
            + common.hanahanaMachines
    }
    private func libraryMachine(id: String) -> Machine? {
        common.machines.first { $0.id == id }
            ?? common.juglerMachines.first { $0.id == id }
            ?? common.hanahanaMachines.first { $0.id == id }
    }

    // メーカー別グルーピング（機種数が多い順、同数はメーカー名昇順）
    private func makerGroups() -> [(maker: String, ids: [String])] {
        var dict: [String: [String]] = [:]
        for m in libraryMachines() {
            let mk = m.maker.isEmpty ? "その他" : m.maker
            dict[mk, default: []].append(m.id)
        }
        return dict.map { (maker: $0.key, ids: $0.value) }
            .sorted { a, b in
                a.ids.count != b.ids.count ? a.ids.count > b.ids.count : a.maker < b.maker
            }
    }

    @ViewBuilder
    private var appLibraryPage: some View {
        NavigationStack {
            GeometryReader { geo in
//                let cols = 2
                let outerPad: CGFloat = 16
                let colSpacing: CGFloat = 16
//                let tile = max(60, (geo.size.width - outerPad * 2 - colSpacing * CGFloat(cols - 1)) / CGFloat(cols))
                let tile: CGFloat = 162
                ScrollView {
//                    LazyVGrid(columns: Array(repeating: GridItem(.fixed(tile), spacing: colSpacing), count: cols), spacing: 22) {
                    LazyVGrid(columns: Array(repeating: GridItem(.fixed(tile), spacing: colSpacing), count: (self.lazyVGridCount/2)), spacing: 22) {
                        ForEach(makerGroups(), id: \.maker) { group in
                            NavigationLink {
                                makerDetailView(maker: group.maker)
                            } label: {
                                makerFolder(maker: group.maker, ids: group.ids, size: tile)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, outerPad)
                    .padding(.vertical, 20)
                }
                .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea())
                .navigationTitle("全機種ライブラリ")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }

    // メーカーのフォルダ（固定サイズの2x2プレビュー＋メーカー名）
    @ViewBuilder
    private func makerFolder(maker: String, ids: [String], size: CGFloat) -> some View {
        VStack(spacing: 6) {
            folderPreview(ids: ids, size: size)
            Text(maker)
                .font(.caption)
                .lineLimit(1)
                .foregroundStyle(.primary)
        }
    }

    // フォルダ内の2x2アイコンプレビュー（固定サイズ＝再レイアウトで縮まない）
    @ViewBuilder
    private func folderPreview(ids: [String], size: CGFloat) -> some View {
        let cells = Array(ids.prefix(4))
//        let pad: CGFloat = 10
//        let inner: CGFloat = 6
        let inner: CGFloat = 10
//        let iconSide = max(10, (size - pad * 2 - inner) / 2)
        VStack(spacing: inner) {
            ForEach(0..<2, id: \.self) { row in
                HStack(spacing: inner) {
                    ForEach(0..<2, id: \.self) { col in
                        let idx = row * 2 + col
                        ZStack {
                            if idx < cells.count, let m = libraryMachine(id: cells[idx]) {
                                Image(m.iconName)
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(RoundedRectangle(cornerRadius: 16.0))
                                if idx == 3 && ids.count > 4 {
                                    RoundedRectangle(cornerRadius: 17).fill(.black.opacity(0.45))
                                    Text("+\(ids.count - 3)").font(.caption2).bold().foregroundStyle(.white)
                                }
                            } else {
                                Color.clear
                            }
                        }
//                        .frame(width: iconSide, height: iconSide)
                        .frame(width: 64, height: 64)
                    }
                }
            }
        }
        .frame(width: size, height: size)
//        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20))
        .background(Color(UIColor.systemGray5), in: RoundedRectangle(cornerRadius: 25))
    }

    // メーカーの全機種（ライブラリのナビゲーションにpush＝シートではなく通常遷移）
    @ViewBuilder
    private func makerDetailView(maker: String) -> some View {
        let ids = libraryMachines().filter { ($0.maker.isEmpty ? "その他" : $0.maker) == maker }.map { $0.id }
        ScrollView {
//            LazyVGrid(columns: Array(repeating: GridItem(.fixed(common.lazyVGridSize), spacing: common.lazyVGridSpacing), count: 4), spacing: common.lazyVGridSpacing) {
            LazyVGrid(columns: Array(repeating: GridItem(.fixed(common.lazyVGridSize), spacing: common.lazyVGridSpacing), count: self.lazyVGridCount), spacing: common.lazyVGridSpacing) {
                ForEach(ids, id: \.self) { id in
                    libraryIcon(id: id)
                }
            }
            .padding()
        }
        .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea())
        .navigationTitle(maker)
        .navigationBarTitleDisplayMode(.inline)
    }

    // ライブラリ内の1アイコン（ロック維持・タップで遷移）。3配列(ホーム/ジャグラー/ハナハナ)に対応。
    @ViewBuilder
    private func libraryIcon(id: String) -> some View {
        if let i = common.machines.firstIndex(where: { $0.id == id }) {
            let m = common.machines[i]
            unitMachineIconLinkWithLock(
                linkView: machineDestination(for: m.id),
                iconImage: Image(m.iconName),
                machineName: m.name,
                isUnLocked: $common.machines[i].isUnlocked,
                tempUnlockDateDouble: $common.machines[i].unlockDate,
                badgeStatus: m.badgeStatus,
                btBadgeBool: m.btBadge
            )
        } else if let i = common.juglerMachines.firstIndex(where: { $0.id == id }) {
            let m = common.juglerMachines[i]
            unitMachineIconLinkWithLock(
                linkView: machineDestination(for: m.id),
                iconImage: Image(m.iconName),
                machineName: m.name,
                isUnLocked: $common.juglerMachines[i].isUnlocked,
                tempUnlockDateDouble: $common.juglerMachines[i].unlockDate,
                badgeStatus: m.badgeStatus,
                btBadgeBool: m.btBadge
            )
        } else if let i = common.hanahanaMachines.firstIndex(where: { $0.id == id }) {
            let m = common.hanahanaMachines[i]
            if m.id == "4912" {
                // ニューキング：ロックは専用@AppStorageを使用して維持
                unitMachineIconLinkWithLock(
                    linkView: machineDestination(for: m.id),
                    iconImage: Image(m.iconName),
                    machineName: m.name,
                    isUnLocked: $common.newKingHanaisUnlocked,
                    tempUnlockDateDouble: $common.newKingHanaTempUnlockDateDouble,
                    badgeStatus: m.badgeStatus,
                    btBadgeBool: m.btBadge
                )
            } else {
                unitMachineIconLinkWithLock(
                    linkView: machineDestination(for: m.id),
                    iconImage: Image(m.iconName),
                    machineName: m.name,
                    isUnLocked: $common.hanahanaMachines[i].isUnlocked,
                    tempUnlockDateDouble: $common.hanahanaMachines[i].unlockDate,
                    badgeStatus: m.badgeStatus,
                    btBadgeBool: m.btBadge
                )
            }
        }
    }

    // 機種ページ遷移先に外観モードを適用（各機種ページは独自NavigationStackを持ち、
    // ルートのpreferredColorSchemeやウィンドウ上書きが届かないため個別に当てる）
    private func machineDestination(for id: String) -> AnyView {
        AnyView(
            getLinkView(for: id)
                .preferredColorScheme(appearanceMode.colorScheme)
                // 機種ページ（独自NavigationStack）が表示された瞬間に全VCへスタイルを強制適用
                // push直後のレイアウト確定後にも当たるよう、わずかに遅延しても再適用する
                .onAppear {
                    applyAppInterfaceStyle(appearanceMode)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                        applyAppInterfaceStyle(appearanceMode)
                    }
                }
        )
    }

    func getLinkView(for id: String) -> AnyView {
        switch id {
        case "5010": return AnyView(sencole6ViewTop())
        case "5019": return AnyView(karakuri2ViewTop())
        case "5555": return AnyView(JuglerSeriesViewTopVer2(bayes: bayes, viewModel: viewModel))
        case "8787": return AnyView(hanahanaSeriesViewTopVer2(bayes: bayes, viewModel: viewModel))
        case "5009": return AnyView(otome5ViewTop(bayes: bayes,viewModel: viewModel))
        case "5025": return AnyView(sao2ViewTop(bayes: bayes,viewModel: viewModel))
        case "4961": return AnyView(godKisekiViewTop(bayes: bayes,viewModel: viewModel))
        case "4974": return AnyView(bioRe3ViewTop(bayes: bayes,viewModel: viewModel))
        case "4984": return AnyView(rioAceViewTop(bayes: bayes,viewModel: viewModel))
        case "4970": return AnyView(jormungandViewTop(bayes: bayes,viewModel: viewModel))
        case "4983": return AnyView(shinYoshiViewTop(bayes: bayes,viewModel: viewModel))
        case "4956": return AnyView(akudamaViewTop(bayes: bayes,viewModel: viewModel))
        case "4943": return AnyView(thunderViewTop(bayes: bayes, viewModel: viewModel))
        case "4930": return AnyView(kabaneriUnatoViewTop(bayes: bayes, viewModel: viewModel))
        case "4950": return AnyView(gobsla2ViewTop(bayes: bayes, viewModel: viewModel))
        case "4928": return AnyView(hanabiViewTop(bayes: bayes, viewModel: viewModel))
        case "4926": return AnyView(enen2ViewTop(bayes: bayes, viewModel: viewModel))
        case "4931": return AnyView(kokakukidotaiViewTop(bayes: bayes, viewModel: viewModel))
        case "4913": return AnyView(tekken6ViewTop(bayes: bayes, viewModel: viewModel))
        case "4909": return AnyView(hokutoTenseiViewTop(bayes: bayes, viewModel: viewModel))
        case "4924": return AnyView(mushotenViewTop(bayes: bayes, viewModel: viewModel))
        case "4929": return AnyView(hihodenViewTop(bayes: bayes, viewModel: viewModel))
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
        // ジャグラー系サブ機種（ライブラリ表示用）
        case "4683": return AnyView(urmiraViewTop(bayes: bayes, viewModel: viewModel))
        case "4588": return AnyView(mrJugViewTop(bayes: bayes, viewModel: viewModel))
        case "4540": return AnyView(girlsSSViewTop(bayes: bayes, viewModel: viewModel))
        case "4375": return AnyView(goJug3Ver2ViewTop(bayes: bayes, viewModel: viewModel))
        case "4230": return AnyView(happyJugV3Ver2ViewTop(bayes: bayes, viewModel: viewModel))
        case "4029": return AnyView(myJug5Ver2ViewTop(bayes: bayes, viewModel: viewModel))
        case "3961": return AnyView(funky2Ver2ViewTop(bayes: bayes, viewModel: viewModel))
        case "3626": return AnyView(imJugExVer2ViewTop(bayes: bayes, viewModel: viewModel))
        // ハナハナ系サブ機種（ライブラリ表示用）
        case "4912": return AnyView(newKingHanaViewTop(bayes: bayes, viewModel: viewModel))
        case "4680": return AnyView(starHanaViewTop(bayes: bayes, viewModel: viewModel))
        case "4453": return AnyView(draHanaSenkohVer2ViewTop(bayes: bayes, viewModel: viewModel))
        case "4311": return AnyView(kingHanaVer2ViewTop(bayes: bayes, viewModel: viewModel))
        case "4014": return AnyView(hanaTenshoVer2ViewTop(bayes: bayes, viewModel: viewModel))
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
