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
import StoreKit
import AppTrackingTransparency
import PDFKit

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
    @AppStorage("isSelectedFavoriteKaguya") var isSelectedFavoriteKaguya = true
    @AppStorage("isSelectedFavoriteRezero2") var isSelectedFavoriteRezero2 = true
    @AppStorage("isSelectedFavoriteBangdream") var isSelectedFavoriteBangdream = true
    @AppStorage("isSelectedFavoriteMhr") var isSelectedFavoriteMhr = true
    @AppStorage("isSelectedFavoriteInuyasha2") var isSelectedFavoriteInuyasha2 = true
    @AppStorage("isSelectedFavoriteLupin") var isSelectedFavoriteLupin = true
    @AppStorage("isSelectedFavoriteDanvine") var isSelectedFavoriteDanvine = true
    @AppStorage("isSelectedFavoriteDumbbell") var isSelectedFavoriteDumbbell = true
    @AppStorage("isSelectedFavoriteAccelerator") var isSelectedFavoriteAccelerator = true
    @AppStorage("isSelectedFavoriteSbj") var isSelectedFavoriteSbj = true
    @AppStorage("isSelectedFavoriteSevenSwords") var isSelectedFavoriteSevenSwords = true
    @AppStorage("isSelectedFavoriteTokyoGhoul") var isSelectedFavoriteTokyoGhoul = true
    @AppStorage("isSelectedFavoriteShamanKing") var isSelectedFavoriteShamanKing = true
    @AppStorage("isSelectedFavoriteArifure") var isSelectedFavoriteArifure = true
    @AppStorage("isSelectedFavoriteBio") var isSelectedFavoriteBio = true
    @AppStorage("isSelectedFavoriteKaiji") var isSelectedFavoriteKaiji = true
}


// /////////////////////////
// 変数：コモン
// /////////////////////////
class commonVar: ObservableObject {
    @AppStorage("contentViewIconDisplayMode") var iconDisplayMode = true      // アイコン表示の切り替え
    let lazyVGridSize: CGFloat = 70
    let lazyVGridSpacing: CGFloat = 20
    let lazyVGridColumnsPortlait: Int = 4
    let lazyVGridColumnsLandscape: Int = 7
    
    // ///////////////////////
    // 起動回数カウント
    // ///////////////////////
    @AppStorage("commonAppLaunchCount") var appLaunchCount: Int = 0
    @AppStorage("commonAppLaunchCountUpLastDateDouble") var appLaunchCountUpLastDateDouble: Double = 0.0
    
    // //// 1日1回アプリ起動回数をカウントアップさせる
    func appLaunchCountUp() {
        // 現在時の取得
        let nowDate = Date()
        let nowDateDouble = nowDate.timeIntervalSince1970
        // 最終カウントアップ時から20時間経過していたらカウントアップさせる
        if (nowDateDouble - appLaunchCountUpLastDateDouble) > 72000 {
            appLaunchCount += 1
            appLaunchCountUpLastDateDouble = nowDateDouble
            print("カウントアップ： \(appLaunchCount) 回")
        } else {
            print("カウントアップなし")
        }
    }
    @Environment(\.requestReview) var requestReview
    @AppStorage("commonTrackingRequested") var trackingRequested: Bool = false
}

// /////////////////////////
// ビュー：メインビュー
// /////////////////////////
struct ContentView: View {
    @ObservedObject var ver240 = Ver240()
    @ObservedObject var ver250 = Ver250()
    @ObservedObject var favoriteSet = favoriteSetVar()
    @ObservedObject var common = commonVar()
    let displayMode = ["お気に入り", "全機種"]     // 機種リストの表示モード選択肢
    @State var isSelectedDisplayMode = "お気に入り"
    @State var isShowFavoriteSettingView = false
    @State private var isKeyboardVisible = false  // キーボード表示状態を追跡
    @State var lazyVGridColumns: Int = 4
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationStack {
                ZStack {
                    // //// アイコン表示モード
                    if common.iconDisplayMode {
                        ScrollView {
                            Rectangle()
                                .frame(height: 40)
                                .foregroundStyle(Color.clear)
                            LazyVGrid(columns: Array(repeating: GridItem(.fixed(common.lazyVGridSize), spacing: common.lazyVGridSpacing), count: self.lazyVGridColumns), spacing: common.lazyVGridSpacing) {
                                // //// ジャグラーシリーズ
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedJuglerSeries == false {
                                    // 非表示
                                } else {
                                    unitMachineIconLink(
                                        linkView: AnyView(JuglerSeriesViewTop()),
                                        iconImage: Image("machineIconJuglerSeries"),
                                        machineName: "ジャグラー"
//                                        badgeStatus: ver210.ver210JugTopNewBadgeStatus
                                    )
                                }
                                
                                // //// ハナハナシリーズ
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedHanahanaSeries == false {
                                    // 非表示
                                } else {
                                    unitMachineIconLink(
                                        linkView: AnyView(hanahanaSeriesViewTop()),
                                        iconImage: Image("machineIconHanahanaSeries"),
                                        machineName: "ハナハナ"
                                    )
                                }
                                
                                // //// バイオハザード５、25年3月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteBio == false {
                                    
                                } else {
                                    unitMachineIconLink(
                                        linkView: AnyView(bioViewTop()),
                                        iconImage: Image("bioMachineIcon"),
                                        machineName: "バイオ5",
                                        badgeStatus: ver250.bioMachineIconBadgeStatus
                                    )
                                        .popoverTip(tipVer250MachineAdd())
                                }
                                
                                // //// カイジ、25年3月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteKaiji == false {
                                    
                                } else {
                                    unitMachineIconLink(
                                        linkView: AnyView(kaijiViewTop()),
                                        iconImage: Image("kaijiMachineIcon"),
                                        machineName: "カイジ狂宴",
                                        badgeStatus: ver250.kaijiMachineIconBadgeStatus
                                    )
                                }
                                
                                // //// ありふれた職業、25年2月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteArifure == false {
                                    
                                } else {
                                    unitMachineIconLink(
                                        linkView: AnyView(arifureViewTop()),
                                        iconImage: Image("arifureMachineIcon"),
                                        machineName: "ありふれ",
                                        badgeStatus: ver250.arifureMachineIconBadgeStatus
                                    )
//                                        .popoverTip(tipVer240MachineAdd())
                                }
                                
                                // //// 東京グール、25年2月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteTokyoGhoul == false {
                                    
                                } else {
                                    unitMachineIconLink(
                                        linkView: AnyView(tokyoGhoulViewTop()),
                                        iconImage: Image("tokyoGhoulMachineIcon"),
                                        machineName: "東京喰種",
                                        badgeStatus: ver250.ghoulMachineIconBadgeStatus
                                    )
//                                        .popoverTip(tipVer230MachineAdd())
                                }
                                
                                // //// シャーマンキング、25年2月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteShamanKing == false {
                                    
                                } else {
                                    unitMachineIconLink(
                                        linkView: AnyView(shamanKingViewTop()),
                                        iconImage: Image("shamanKingMachineIcon"),
                                        machineName: "シャーマンキング"
//                                        badgeStatus: ver230.shamanKingNewBadgeStatus
                                    )
                                }
                                
                                // //// スーパーブラックジャック、25年2月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteSbj == false {
                                    
                                } else {
                                    unitMachineIconLink(
                                        linkView: AnyView(sbjViewTop()),
                                        iconImage: Image("sbjMachineIcon"),
                                        machineName: "SBJ",
                                        badgeStatus: ver240.sbjMachineIconBadgeStatus
                                    )
                                }
                                
                                // //// 七つの魔剣が支配する、25年1月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteSevenSwords == false {
                                    
                                } else {
                                    unitMachineIconLink(
                                        linkView: AnyView(sevenSwordsViewTop()),
                                        iconImage: Image("sevenSwordsMachineIcon"),
                                        machineName: "七つの魔剣が支配する"
                                    )
                                }
                                
                                // //// 一方通行、24年12月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteAccelerator == false {
                                    
                                } else {
                                    unitMachineIconLink(linkView: AnyView(acceleratorViewTop()), iconImage: Image("acceleratorMachineIcon"), machineName: "一方通行")
                                }
                                
                                // //// ダンベル、24年12月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteDumbbell == false {
                                    
                                } else {
                                    unitMachineIconLink(linkView: AnyView(dumbbellViewTop()), iconImage: Image("dumbbellMachineIcon"), machineName: "ダンベル")
                                }
                                
                                // //// ダンバイン、24年12月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteDanvine == false {
                                    
                                } else {
                                    unitMachineIconLink(linkView: AnyView(danvineViewTop()), iconImage: Image("danvineMachineIcone"), machineName: "ダンバイン")
                                }
                                
                                // //// ルパン大航海者の秘宝、24年12月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteLupin == false {
                                    
                                } else {
                                    unitMachineIconLink(linkView: AnyView(lupinViewTop()), iconImage: Image("lupinMachineIcon"), machineName: "ルパン大航海者")
                                }
                                // //// 犬夜叉2、24年12月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteInuyasha2 == false {
                                    
                                } else {
                                    unitMachineIconLink(linkView: AnyView(inuyasha2ViewTop()), iconImage: Image("inuyasha2MachineIcon"), machineName: "犬夜叉2")
                                }
                                
                                // //// モンスターハンターライズ、24年11月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteMhr == false {
                                    
                                } else {
                                    unitMachineIconLink(linkView: AnyView(mhrViewTop()), iconImage: Image("mhrMachineIcon"), machineName: "モンハンライズ")
                                }
                                
                                // //// バンドリ、24年11月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteBangdream == false {
                                    
                                } else {
                                    unitMachineIconLink(linkView: AnyView(bangdreamViewTop()), iconImage: Image("bangdreamMachinIcon"), machineName: "バンドリ!")
                                }
                                
                                // //// リゼロ2、24年10月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteRezero2 == false {
                                    
                                } else {
                                    unitMachineIconLink(linkView: AnyView(rezero2ViewTop()), iconImage: Image("rezero2MachineIcon"), machineName: "Re:ゼロ2")
                                }
                                
                                // //// かぐや様、24年9月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteKaguya == false {
                                    
                                } else {
                                    unitMachineIconLink(linkView: AnyView(kaguyaViewTop()), iconImage: Image("kaguyaMachineIcon"), machineName: "かぐや様")
                                }
                                
                                // //// シンフォギア 正義の歌、24年7月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteSympho == false {
                                    // 非表示
                                } else {
                                    unitMachineIconLink(linkView: AnyView(symphoViewTop()), iconImage: Image("symphoMachineIcon"), machineName: "シンフォギア")
                                }
                                
                                // //// ゴッドイーター リザレクション、24年7月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteGodeater == false {
                                    // 非表示
                                } else {
                                    unitMachineIconLink(
                                        linkView: AnyView(godeaterViewTop()),
                                        iconImage: Image("godeaterMachinIcon"),
                                        machineName: "ゴッドイーター"
                                    )
                                }
                                
                                // //// ToLOVEるダークネス、24年6月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteToloveru == false {
                                    // 非表示
                                } else {
                                    unitMachineIconLink(linkView: AnyView(toloveruViewTop()), iconImage: Image("toloveruMachineIcon"), machineName: "ToLoveる")
                                }
                                
                                // //// ゴジラvsエヴァンゲリオン、24年2月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteGoeva == false {
                                    // 非表示
                                } else {
                                    unitMachineIconLink(linkView: AnyView(goevaViewTop()), iconImage: Image("machinIconGoeva"), machineName: "ゴジエヴァ")
                                }
                                
                                // //// モンキーターン５、23年12月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteMT5 == false {
                                    // 非表示
                                } else {
                                    unitMachineIconLink(linkView: AnyView(mt5ViewTop()), iconImage: Image("mt5MachineIconWhite"), machineName: "モンキー5")
                                }
                                
                                // //// からくりサーカス、23年7月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteKarakuri == false {
                                    // 非表示
                                } else {
                                    unitMachineIconLink(linkView: AnyView(karakuriViewTop()), iconImage: Image("karakuriMachineIcon"), machineName: "からくりサーカス")
                                }
                                
                                // //// 北斗の拳、23年4月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteHokuto == false {
                                    // 非表示
                                } else {
                                    unitMachineIconLink(linkView: AnyView(hokutoViewTop()), iconImage: Image("machineIconHokuto"), machineName: "北斗の拳")
                                }
                                
                                // //// ヴァルヴレイヴ、22年11月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteVVV == false {
                                    // 非表示
                                } else {
                                    unitMachineIconLink(linkView: AnyView(VVV_Top()), iconImage: Image("machineIconVVV"), machineName: "ヴヴヴ")
                                }
                                
                                // //// カバネリ、22年7月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteKabaneri == false {
                                    // 非表示
                                } else {
                                    unitMachineIconLink(linkView: AnyView(kabaneriViewTop()), iconImage: Image("machineIconKabaneri"), machineName: "カバネリ")
                                }
                            }
                        }
                        .background(Color(UIColor.systemGroupedBackground))
                    }
                    
                    // リスト表示モード
                    else {
                        // //// 機種リスト表示部分
                        List {
                            Section {
                                // //// ジャグラーシリーズ
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedJuglerSeries == false {
                                    // 非表示
                                } else {
                                    unitMachinListLink(
                                        linkView: AnyView(JuglerSeriesViewTop()),
                                        iconImage: Image("machineIconJuglerSeries"),
                                        machineName: "ジャグラーシリーズ",
                                        makerName: "北電子",
                                        releaseYear: 96,
                                        releaseMonth: 12
//                                        badgeStatus: ver210.ver210JugTopNewBadgeStatus
                                    )
                                }
                                
                                // //// ハナハナシリーズ
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedHanahanaSeries == false {
                                    // 非表示
                                } else {
                                    unitMachinListLink(
                                        linkView: AnyView(hanahanaSeriesViewTop()),
                                        iconImage: Image("machineIconHanahanaSeries"),
                                        machineName: "ハナハナ",
                                        makerName: "パイオニア",
                                        releaseYear: 2001,
                                        releaseMonth: 5
                                    )
                                }
                                
                                // //// バイオ５、25年3月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteBio == false {
                                    
                                } else {
                                    unitMachinListLink(
                                        linkView: AnyView(bioViewTop()),
                                        iconImage: Image("bioMachineIcon"),
                                        machineName: "バイオハザード5",
                                        makerName: "エンターライズ",
                                        releaseYear: 2025,
                                        releaseMonth: 3,
                                        badgeStatus: ver250.bioMachineIconBadgeStatus
                                    )
                                    .popoverTip(tipVer250MachineAdd())
                                }
                                
                                // //// カイジ、25年3月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteKaiji == false {
                                    
                                } else {
                                    unitMachinListLink(
                                        linkView: AnyView(kaijiViewTop()),
                                        iconImage: Image("kaijiMachineIcon"),
                                        machineName: "回胴黙示録カイジ 狂宴",
                                        makerName: "サミー",
                                        releaseYear: 2025,
                                        releaseMonth: 3,
                                        badgeStatus: ver250.kaijiMachineIconBadgeStatus
                                    )
                                }
                                
                                // //// ありふれた職業、25年2月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteArifure == false {
                                    
                                } else {
                                    unitMachinListLink(
                                        linkView: AnyView(arifureViewTop()),
                                        iconImage: Image("arifureMachineIcon"),
                                        machineName: "ありふれた職業で世界最強",
                                        makerName: "SANKYO",
                                        releaseYear: 2025,
                                        releaseMonth: 2,
                                        badgeStatus: ver250.arifureMachineIconBadgeStatus
                                    )
//                                    .popoverTip(tipVer240MachineAdd())
                                }
                                
                                // //// 東京グール、25年2月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteTokyoGhoul == false {
                                    
                                } else {
                                    unitMachinListLink(
                                        linkView: AnyView(tokyoGhoulViewTop()),
                                        iconImage: Image("tokyoGhoulMachineIcon"),
                                        machineName: "東京喰種",
                                        makerName: "Spiky",
                                        releaseYear: 2025,
                                        releaseMonth: 2,
                                        badgeStatus: ver250.ghoulMachineIconBadgeStatus
//                                        badgeStatus: "update"
                                    )
//                                    .popoverTip(tipVer230MachineAdd())
                                }
                                
                                // //// シャーマンキング、25年2月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteTokyoGhoul == false {
                                    
                                } else {
                                    unitMachinListLink(
                                        linkView: AnyView(shamanKingViewTop()),
                                        iconImage: Image("shamanKingMachineIcon"),
                                        machineName: "シャーマンキング",
                                        makerName: "UNIVERSAL",
                                        releaseYear: 2025,
                                        releaseMonth: 2
//                                        badgeStatus: ver230.shamanKingNewBadgeStatus
                                    )
                                }
                                
                                // //// スーパーブラックジャック、25年2月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteSbj == false {
                                    
                                } else {
                                    unitMachinListLink(
                                        linkView: AnyView(sbjViewTop()),
                                        iconImage: Image("sbjMachineIcon"),
                                        machineName: "スーパーブラックジャック",
                                        makerName: "山佐",
                                        releaseYear: 2025,
                                        releaseMonth: 2,
                                        badgeStatus: ver240.sbjMachineIconBadgeStatus
                                    )
                                }
                                
                                // //// 七つの魔剣が支配する、25年1月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteSevenSwords == false {
                                    
                                } else {
                                    unitMachinListLink(
                                        linkView: AnyView(sevenSwordsViewTop()),
                                        iconImage: Image("sevenSwordsMachineIcon"),
                                        machineName: "七つの魔剣が支配する",
                                        makerName: "コナミ",
                                        releaseYear: 2025,
                                        releaseMonth: 1
                                    )
                                }
                                
                                // //// 一方通行、24年12月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteAccelerator == false {
                                    
                                } else {
                                    unitMachinListLink(
                                        linkView: AnyView(acceleratorViewTop()),
                                        iconImage: Image("acceleratorMachineIcon"),
                                        machineName: "一方通行 とある魔術の禁書目録",
                                        makerName: "藤商事",
                                        releaseYear: 2024,
                                        releaseMonth: 12
                                    )
                                }
                                
                                // //// ダンベル、24年12月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteDumbbell == false {
                                    
                                } else {
                                    unitMachinListLink(
                                        linkView: AnyView(dumbbellViewTop()),
                                        iconImage: Image("dumbbellMachineIcon"),
                                        machineName: "ダンベル何キロ持てる？",
                                        makerName: "SANKYO",
                                        releaseYear: 2024,
                                        releaseMonth: 12
                                    )
                                }
                                
                                // //// ダンバイン、24年12月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteDanvine == false {
                                    
                                } else {
                                    unitMachinListLink(
                                        linkView: AnyView(danvineViewTop()),
                                        iconImage: Image("danvineMachineIcone"),
                                        machineName: "ダンバイン",
                                        makerName: "サミー",
                                        releaseYear: 2024,
                                        releaseMonth: 12
                                    )
                                }
                                
                                // //// ルパン大航海者の秘宝、24年12月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteLupin == false {
                                    
                                } else {
                                    unitMachinListLink(
                                        linkView: AnyView(lupinViewTop()),
                                        iconImage: Image("lupinMachineIcon"),
                                        machineName: "ルパン3世 大航海者の秘宝",
                                        makerName: "平和",
                                        releaseYear: 2024,
                                        releaseMonth: 12
                                    )
                                }
                                
                                // //// 犬夜叉2、24年12月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteInuyasha2 == false {
                                    
                                } else {
                                    unitMachinListLink(
                                        linkView: AnyView(inuyasha2ViewTop()),
                                        iconImage: Image("inuyasha2MachineIcon"),
                                        machineName: "犬夜叉2",
                                        makerName: "Spiky",
                                        releaseYear: 2024,
                                        releaseMonth: 12
                                    )
                                }
                                
                                // //// モンスターハンターライズ、24年11月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteMhr == false {
                                    
                                } else {
                                    unitMachinListLink(
                                        linkView: AnyView(mhrViewTop()),
                                        iconImage: Image("mhrMachineIcon"),
                                        machineName: "モンスターハンター ライズ",
                                        makerName: "アデリオン",
                                        releaseYear: 2024,
                                        releaseMonth: 11
                                    )
                                }
                                
                                // //// バンドリ、24年11月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteBangdream == false {
                                    
                                } else {
                                    unitMachinListLink(linkView: AnyView(bangdreamViewTop()), iconImage: Image("bangdreamMachinIcon"), machineName: "バンドリ!", makerName: "平和", releaseYear: 2024, releaseMonth: 11)
                                }
                                
                                // //// リゼロ2、24年10月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteRezero2 == false {
                                    
                                } else {
                                    unitMachinListLink(linkView: AnyView(rezero2ViewTop()), iconImage: Image("rezero2MachineIcon"), machineName: "Re:ゼロ season2", makerName: "大都技研", releaseYear: 2024, releaseMonth: 10)
                                    
                                }
                                
                                // //// かぐや様、24年9月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteKaguya == false {
                                    
                                } else {
                                    unitMachinListLink(linkView: AnyView(kaguyaViewTop()), iconImage: Image("kaguyaMachineIcon"), machineName: "かぐや様は告らせたい", makerName: "SANKYO", releaseYear: 2024, releaseMonth: 9)
                                }
                                // //// シンフォギア 正義の歌、24年7月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteSympho == false {
                                    // 非表示
                                } else {
                                    unitMachinListLink(linkView: AnyView(symphoViewTop()), iconImage: Image("symphoMachineIcon"), machineName: "戦姫絶唱シンフォギア 正義の歌", makerName: "SANKYO", releaseYear: 2024, releaseMonth: 7)
                                }
                                
                                // //// ゴッドイーター リザレクション、24年7月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteGodeater == false {
                                    // 非表示
                                } else {
                                    unitMachinListLink(
                                        linkView: AnyView(godeaterViewTop()),
                                        iconImage: Image("godeaterMachinIcon"),
                                        machineName: "ゴッドイーター リザレクション",
                                        makerName: "山佐",
                                        releaseYear: 2024,
                                        releaseMonth: 7
                                    )
                                }
                                // //// ToLOVEるダークネス、24年6月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteToloveru == false {
                                    // 非表示
                                } else {
                                    unitMachinListLink(linkView: AnyView(toloveruViewTop()), iconImage: Image("toloveruMachineIcon"), machineName: "ToLOVEるダークネス", makerName: "平和", releaseYear: 2024, releaseMonth: 6)
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
                .navigationTitle("機種選択")
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
                                        .popoverTip(tipUnitButtonIconDisplayMode())
                                }
                            }
                            
                            // お気に入り設定ボタン
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
            }
            // バナー広告の常時表示。キーボード出現時は非表示にする。
            if !isKeyboardVisible {
                //                ZStack {
                //                    Rectangle()
                //                        .foregroundStyle(Color(UIColor.systemGroupedBackground))
                //                        .ignoresSafeArea()
                //                        .frame(height: 50)
                //                    AdMobBannerView()
                //                        .frame(width: 320,height: 50)     // 320*50が基本サイズ？50だといい感じ
                //                }
                GeometryReader { geometry in
                    let adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(geometry.size.width)
                    
                    ZStack {
                        Rectangle()
                            .foregroundStyle(Color(UIColor.systemGroupedBackground))
                            .ignoresSafeArea()
                        BannerView(adSize)
                            .frame(height: adSize.size.height)
                    }
                    .frame(height: adSize.size.height)
                }
                .frame(height: GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(UIScreen.main.bounds.width).size.height)
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
            // トラッキング許可のポップアップを出す
            if common.trackingRequested == false {
                ATTrackingManager.requestTrackingAuthorization() {_ in
                    GADMobileAds.sharedInstance().start(completionHandler: nil)
                }
                common.trackingRequested = true
            }
        }
        .onDisappear {
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        }
        // //// アプリがアクティブになったことを確認してトラッキング許可のポップアップを出す
//        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
//            ATTrackingManager.requestTrackingAuthorization() {_ in
//                GADMobileAds.sharedInstance().start(completionHandler: nil)
//            }
//        }
//        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
//            // トラッキングの許諾ダイアログメッセージを表示
//            Task {
//                let result = await ATTrackingManager.requestTrackingAuthorization()
//                if result == .authorized {
//                    GADMobileAds.sharedInstance().start(completionHandler: nil)
//                }
//            }
//        }
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
                // //// バイオ５、25年3月
                Toggle("バイオハザード5", isOn: $favoriteSet.isSelectedFavoriteBio)
                // //// カイジ、25年3月
                Toggle("回胴黙示録カイジ 狂宴", isOn: $favoriteSet.isSelectedFavoriteKaiji)
                // //// ありふれた職業、25年2月
                Toggle("ありふれた職業で世界最強", isOn: $favoriteSet.isSelectedFavoriteArifure)
                // //// 東京グール、25年2月
                Toggle("東京喰種", isOn: $favoriteSet.isSelectedFavoriteTokyoGhoul)
                // //// シャーマンキング、25年2月
                Toggle("シャーマンキング", isOn: $favoriteSet.isSelectedFavoriteShamanKing)
                // //// スーパーブラックジャック、25年2月
                Toggle("スーパーブラックジャック", isOn: $favoriteSet.isSelectedFavoriteSbj)
                // //// 7つの魔剣が支配する、25年1月
                Toggle("七つの魔剣が支配する", isOn: $favoriteSet.isSelectedFavoriteSevenSwords)
                // //// 一方通行、24年12月
                Toggle("一方通行 とある魔術の禁書目録", isOn: $favoriteSet.isSelectedFavoriteAccelerator)
                // //// ダンベル、24年12月
                Toggle("ダンベル何キロ持てる？", isOn: $favoriteSet.isSelectedFavoriteDumbbell)
                // //// ダンバイン、24年12月
                Toggle("ダンバイン", isOn: $favoriteSet.isSelectedFavoriteDanvine)
                // //// ルパン大航海者の秘宝、24年12月
                Toggle("ルパン3世 大航海者の秘宝", isOn: $favoriteSet.isSelectedFavoriteLupin)
                // //// 犬夜叉2、24年12月
                Toggle("犬夜叉2", isOn: $favoriteSet.isSelectedFavoriteInuyasha2)
                // //// モンハンライズ、24年11月
                Toggle("モンスターハンター ライズ", isOn: $favoriteSet.isSelectedFavoriteMhr)
                // //// バンドリ、24年11月
                Toggle("バンドリ!", isOn: $favoriteSet.isSelectedFavoriteBangdream)
                // //// リゼロ2、24年10月
                Toggle("Re:ゼロ season2", isOn: $favoriteSet.isSelectedFavoriteRezero2)
                // //// かぐや様、24年9月
                Toggle("かぐや様は告らせたい", isOn: $favoriteSet.isSelectedFavoriteKaguya)
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
//                        .foregroundColor(Color.gray)
                        .foregroundStyle(Color.gray)
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
//                        .foregroundColor(Color.gray)
                        .foregroundStyle(Color.gray)
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
//struct AdMobBannerView: UIViewRepresentable {
//    func makeUIView(context: Context) -> GADBannerView {
//        let banner = GADBannerView(adSize: GADAdSizeBanner) // インスタンスを生成
//        // 諸々の設定をしていく
//        banner.adUnitID = "ca-app-pub-3940256099942544/2934735716" // テスト用広告ID
////        banner.adUnitID = "ca-app-pub-3940256099942544/2435281174" // テスト用広告ID2
////        banner.adUnitID = "ca-app-pub-2339669527176370/9695161925" // 本番用広告ID
//        banner.rootViewController = getRootViewController() // 修正部分
//        banner.load(GADRequest())
//        return banner // 最終的にインスタンスを返す
//    }
//
//    func updateUIView(_ uiView: GADBannerView, context: Context) {
//        // 特にないのでメソッドだけ用意
//    }
//
//    private func getRootViewController() -> UIViewController? {
//        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
//            return windowScene.windows.filter { $0.isKeyWindow }.first?.rootViewController
//        }
//        return nil
//    }
//}


// [START create_banner_view]
private struct BannerView: UIViewRepresentable {
    let adSize: GADAdSize
    
    init(_ adSize: GADAdSize) {
        self.adSize = adSize
    }
    
    func makeUIView(context: Context) -> UIView {
        // Wrap the GADBannerView in a UIView. GADBannerView automatically reloads a new ad when its
        // frame size changes; wrapping in a UIView container insulates the GADBannerView from size
        // changes that impact the view returned from makeUIView.
        let view = UIView()
        view.addSubview(context.coordinator.bannerView)
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        context.coordinator.bannerView.adSize = adSize
    }
    
    func makeCoordinator() -> BannerCoordinator {
        return BannerCoordinator(self)
    }
    // [END create_banner_view]
    
    // [START create_banner]
    class BannerCoordinator: NSObject, GADBannerViewDelegate {
        
        private(set) lazy var bannerView: GADBannerView = {
            let banner = GADBannerView(adSize: parent.adSize)
            // [START load_ad]
//            banner.adUnitID = "ca-app-pub-3940256099942544/2435281174"     // テスト用
            banner.adUnitID = "ca-app-pub-2339669527176370/9695161925"     // 本番用
            
            // 広告リクエストを作成
            let adRequest = GADRequest()
            // カスタムキーワードを設定
//            adRequest.keywords = ["パチスロ", "パチンコ", "ギャンブル", "遊技場", "スマスロ", "スマパチ", "スロット"]
            adRequest.keywords = ["パチスロ", "パチンコ", "遊技場", "スマスロ", "スマパチ", "スロット"]
            
            //            banner.load(GADRequest())
            banner.load(adRequest)
            // [END load_ad]
            // [START set_delegate]
            banner.delegate = self
            // [END set_delegate]
            return banner
        }()
        
        let parent: BannerView
        
        init(_ parent: BannerView) {
            self.parent = parent
        }
        // [END create_banner]
        
        // MARK: - GADBannerViewDelegate methods
        
        func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
            print("DID RECEIVE AD.")
        }
        
        func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
            print("FAILED TO RECEIVE AD: \(error.localizedDescription)")
        }
    }
}


// ///////////////////
// PDFファイルを表示するためのビューを定義
// ///////////////////
struct PDFKitView: UIViewRepresentable {
    private let url: URL

    init(urlString: String) {
        self.url = Bundle.main.url(forResource: urlString, withExtension: "pdf")!
    }

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: url)
        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {}
}

#Preview {
    ContentView()
}
