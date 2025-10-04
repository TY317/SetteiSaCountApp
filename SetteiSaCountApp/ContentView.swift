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
import FirebaseAnalytics

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
    @AppStorage("isSelectedFavoriteRsl") var isSelectedFavoriteRsl = true
    @AppStorage("isSelectedFavoriteMagia") var isSelectedFavoriteMagia = true
    @AppStorage("isSelectedFavoriteGodzilla") var isSelectedFavoriteGodzilla = true
    @AppStorage("isSelectedFavoriteMahjong") var isSelectedFavoriteMahjong = true
    @AppStorage("isSelectedFavoriteYoshimune") var isSelectedFavoriteYoshimune = true
    @AppStorage("isSelectedFavoriteIdolMaster") var isSelectedFavoriteIdolMaster = true
    @AppStorage("isSelectedFavoriteMidoriDon") var isSelectedFavoriteMidoriDon = true
    @AppStorage("isSelectedFavoriteGundamSeed") var isSelectedFavoriteGundamSeed = true
    @AppStorage("isSelectedFavoriteToloveru87") var isSelectedFavoriteToloveru87 = true
    @AppStorage("isSelectedFavoriteIzaBancho") var isSelectedFavoriteIzaBancho = true
    @AppStorage("isSelectedFavoriteDmc5") var isSelectedFavoriteDmc5 = true
    @AppStorage("isSelectedFavoriteGuiltyCrown2") var isSelectedFavoriteGuiltyCrown2 = true
    @AppStorage("isSelectedFavoriteEvaYakusoku") var isSelectedFavoriteEvaYakusoku = true
    @AppStorage("isSelectedFavoriteWatakon") var isSelectedFavoriteWatakon = true
    @AppStorage("isSelectedFavoriteDarling") var isSelectedFavoriteDarling = true
    @AppStorage("isSelectedFavoriteReSword") var isSelectedFavoriteReSword = true
    @AppStorage("isSelectedFavoriteEnen") var isSelectedFavoriteEnen = true
    @AppStorage("isSelectedFavoriteAzurLane") var isSelectedFavoriteAzurLane = true
    @AppStorage("isSelectedFavoriteToreve") var isSelectedFavoriteToreve = true
    @AppStorage("isSelectedFavoriteCrea") var isSelectedFavoriteCrea = true
}


// /////////////////////////
// 変数：コモン
// /////////////////////////
//class commonVar: ObservableObject {
//    @AppStorage("contentViewIconDisplayMode") var iconDisplayMode = true      // アイコン表示の切り替え
//    let lazyVGridSize: CGFloat = 70
//    let lazyVGridSpacing: CGFloat = 20
//    let lazyVGridColumnsPortlait: Int = 4
//    let lazyVGridColumnsLandscape: Int = 7
//    
//    // ///////////////////////
//    // 起動回数カウント
//    // ///////////////////////
//    @AppStorage("commonAppLaunchCount") var appLaunchCount: Int = 0
//    @AppStorage("commonAppLaunchCountUpLastDateDouble") var appLaunchCountUpLastDateDouble: Double = 0.0
//    
//    // //// 1日1回アプリ起動回数をカウントアップさせる
//    func appLaunchCountUp() {
//        // 現在時の取得
//        let nowDate = Date()
//        let nowDateDouble = nowDate.timeIntervalSince1970
//        // 最終カウントアップ時から20時間経過していたらカウントアップさせる
//        if (nowDateDouble - appLaunchCountUpLastDateDouble) > 72000 {
//            appLaunchCount += 1
//            appLaunchCountUpLastDateDouble = nowDateDouble
//            print("カウントアップ： \(appLaunchCount) 回")
//        } else {
//            print("カウントアップなし")
//        }
//    }
//    @Environment(\.requestReview) var requestReview
//    @AppStorage("commonTrackingRequested") var trackingRequested: Bool = false
//    
//    // ////////////////
//    // ver3.5.1で追加
//    // 初回起動時のバージョン情報を保存しておく
//    // ////////////////
//    @AppStorage("commonFirstLaunchAppVersion") var firstLaunchAppVersion: String?
////    @AppStorage("commonLastLaunchAppVersion") var lastLaunchAppVersion: String?
//    
//    func saveInitialVersionIfNeeded() {
//        // すでに保存されていたら何もしない
//        guard firstLaunchAppVersion == nil else { return }
//        
//        // 現在のバージョンを取得
//        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
//            firstLaunchAppVersion = version
//            print("初回起動バージョンを保存: \(version)")
//        }
//    }
////    func saveAppVersions() {
////        // 現在のバージョンを取得
////        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
////            
////            // 初回起動バージョンは一度だけ保存
////            if firstLaunchAppVersion == nil {
////                firstLaunchAppVersion = version
////                print("初回起動バージョンを保存: \(version)")
////            }
////            
////            // 最新起動バージョンは毎回更新
////            lastLaunchAppVersion = version
////            print("最新起動バージョンを更新: \(version)")
////        }
////    }
//}

// /////////////////////////
// ビュー：メインビュー
// /////////////////////////
struct ContentView: View {
    @StateObject var ver320 = Ver320()
//    @StateObject var ver390 = Ver390()
//    @StateObject var ver391 = Ver391()
    @StateObject var bayes = Bayes()
    @StateObject var viewModel = InterstitialViewModel()
    @ObservedObject var favoriteSet = favoriteSetVar()
//    @ObservedObject var common: commonVar
    @EnvironmentObject var common: commonVar
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
                TipView(tipVer3100UpdateInfo())
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
                                        linkView: AnyView(JuglerSeriesViewTop(
//                                            ver391: ver391,
                                            bayes: bayes,
                                            viewModel: viewModel,
                                        )),
                                        iconImage: Image("machineIconJuglerSeries"),
                                        machineName: "ジャグラー",
                                        badgeStatus: common.jugSeriesBadge,
                                    )
                                }
                                
                                // //// ハナハナシリーズ
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedHanahanaSeries == false {
                                    // 非表示
                                } else {
                                    unitMachineIconLink(
                                        linkView: AnyView(hanahanaSeriesViewTop(
//                                            ver391: ver391,
                                            bayes: bayes,
                                            viewModel: viewModel,
//                                            common: common,
                                        )),
                                        iconImage: Image("machineIconHanahanaSeries"),
                                        machineName: "ハナハナ",
//                                        badgeStatus: ver391.hanaSeriesBadge,
                                    )
                                }
                                
                                // //// クレアの秘宝伝、25年9月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteCrea == false {
                                    
                                } else {
                                    unitMachineIconLink(
                                        linkView: AnyView(creaViewTop(
                                            bayes: bayes,
                                            viewModel: viewModel,
                                        )),
                                        iconImage: Image("creaMachineIcon"),
                                        machineName: "クレアBT",
                                        badgeStatus: common.creaMachineIconBadge,
                                        btBadgeBool: true,
                                    )
                                }
                                
                                // //// 東京リベンジャーズ、25年9月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteToreve == false {
                                    
                                } else {
                                    unitMachineIconLink(
                                        linkView: AnyView(toreveViewTop(
//                                            ver390: ver390,
//                                            ver391: ver391,
                                            bayes: bayes,
                                            viewModel: viewModel,
                                        )),
                                        iconImage: Image("toreveMachineIcon"),
                                        machineName: "東リベ",
                                        badgeStatus: common.toreveMachineIconBadge,
                                    )
                                }
                                
                                // //// アズールレーン、25年8月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteAzurLane == false {
                                    
                                } else {
                                    unitMachineIconLink(
                                        linkView: AnyView(azurLaneViewTop(
//                                            ver391: ver391,
                                            bayes: bayes,
                                            viewModel: viewModel,
                                        )),
                                        iconImage: Image("azurLaneMachineIcon"),
                                        machineName: "アズレン",
//                                        badgeStatus: ver391.azurLaneMachineIconBadge,
                                    )
                                }
                                
                                // //// ダーリンインザフランキス、25年8月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteDarling == false {
                                    
                                } else {
                                    unitMachineIconLink(
                                        linkView: AnyView(darlingViewTop(
//                                            ver380: ver380,
//                                            ver390: ver390,
                                            bayes: bayes,
                                            viewModel: viewModel,
                                        )),
                                        iconImage: Image("darlingMachineIcon"),
                                        machineName: "ダリフラ",
//                                        badgeStatus: ver390.darlingMachineIconBadge,
                                    )
                                }
                                
                                // //// 転生したら剣でした、25年8月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteReSword == false {
                                    
                                } else {
                                    unitMachineIconLink(
                                        linkView: AnyView(reSwordViewTop(
//                                            ver360: ver360,
//                                            ver361: ver361,
                                        )),
                                        iconImage: Image("reSwordMachineIcon"),
                                        machineName: "転剣",
//                                        badgeStatus: ver361.reSwordMachineIconBadge,
                                    )
                                }
                                
                                // //// エヴァ約束の扉、25年7月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteEvaYakusoku == false {
                                    
                                } else {
                                    unitMachineIconLink(
                                        linkView: AnyView(evaYakusokuViewTop(
//                                            ver380: ver380,
                                            bayes: bayes,
                                            viewModel: viewModel,
                                        )),
                                        iconImage: Image("evaYakusokuMachineIcon"),
                                        machineName: "ヱヴァ約束",
                                        badgeStatus: common.evaYakusokuMachineIconBadge,
                                        btBadgeBool: true,
                                    )
                                }
                                
                                // //// 私の幸せな結婚、25年7月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteWatakon == false {
                                    
                                } else {
                                    unitMachineIconLink(
                                        linkView: AnyView(watakonViewTop(
//                                            ver350: ver350,
//                                            ver351: ver351,
                                        )),
                                        iconImage: Image("watakonMachineIcon"),
                                        machineName: "わた婚",
//                                        badgeStatus: ver351.watakonMachineIconBadgeStaus,
                                    )
                                }
                                
                                // //// ギルティクラウン、25年6月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteGuiltyCrown2 == false {
                                    
                                } else {
                                    unitMachineIconLink(
                                        linkView: AnyView(guiltyCrown2ViewTop(
//                                            ver360: ver360,
                                        )),
                                        iconImage: Image("guiltyCrown2MachineIcon"),
                                        machineName: "ギルクラ2",
//                                        badgeStatus: ver360.guiltyCrown2MachineIconBadge,
                                    )
                                }
                                
                                // //// デビルメイクライ、25年6月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteDmc5 == false {
                                    
                                } else {
                                    unitMachineIconLink(
                                        linkView: AnyView(dmc5ViewTop(
//                                            ver350: ver350,
//                                            ver351: ver351,
//                                            ver352: ver352,
                                        )),
                                        iconImage: Image("dmc5MachineIcon"),
                                        machineName: "DevilMayCry5",
//                                        badgeStatus: ver352.dmc5MachineIconBadge,
                                    )
                                }
                                
                                // //// いざ番長、25年6月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteIzaBancho == false {
                                    
                                } else {
                                    unitMachineIconLink(
                                        linkView: AnyView(izaBanchoViewTop(
//                                            ver350: ver350,
//                                            ver340: ver340,
                                        )),
                                        iconImage: Image("izaBanchoMachineIcon"),
                                        machineName: "いざ！番長",
                                        badgeStatus: common.izaBanchoMachineIconBadge,
                                    )
                                }
                                
                                // //// ToLOVEるTrance87、25年5月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteToloveru87 == false {
                                    
                                } else {
                                    unitMachineIconLink(
                                        linkView: AnyView(toloveru87ViewTop(
//                                            ver320: ver320
                                        )),
                                        iconImage: Image("toloveru87MachineIcon"),
                                        machineName: "ToLOVEるver8.7"
//                                        badgeStatus: ver320.toloveru87MachineIconBadgeStaus
                                    )
                                }
                                
                                // //// ガンダムSEED、25年5月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteGundamSeed == false {
                                    
                                } else {
                                    unitMachineIconLink(
                                        linkView: AnyView(gundamSeedViewTop(
//                                            ver310: ver310
                                        )),
                                        iconImage: Image("gundamSeedMachineIcon"),
                                        machineName: "SEED"
//                                        badgeStatus: ver310.gundamSeedMachineIconBadgeStatus
                                    )
                                }
                                
                                // //// 緑ドン、25年5月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteMidoriDon == false {
                                    
                                } else {
                                    unitMachineIconLink(
                                        linkView: AnyView(midoriDonViewTop(
//                                            ver340: ver340
//                                            ver310: ver310
                                        )),
                                        iconImage: Image("midoriDonMachineIcon"),
                                        machineName: "緑ドン",
//                                        badgeStatus: ver340.midoriDonMachineIconBadgeStatus
                                    )
                                }
                                
                                // //// アイマス、25年4月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteIdolMaster == false {
                                    
                                } else {
                                    unitMachineIconLink(
                                        linkView: AnyView(idolMasterViewTop(
//                                            ver330: ver330
                                        )),
                                        iconImage: Image("idolMasterMachineIcon"),
                                        machineName: "アイマス",
//                                        badgeStatus: ver330.idolMasterMachineIconBadgeStaus
                                    )
//                                        .popoverTip(tipVer300MachineAdd())
                                }
                                
                                // //// 吉宗、25年4月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteYoshimune == false {
                                    
                                } else {
                                    unitMachineIconLink(
                                        linkView: AnyView(yoshimuneViewTop(
//                                            ver360: ver360,
                                        )),
                                        iconImage: Image("yoshimuneMachineIcon"),
                                        machineName: "吉宗",
//                                        badgeStatus: ver360.yoshimuneMachineIconBadge,
                                    )
                                }
                                
                                // //// 麻雀物語、25年4月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteMahjong == false {
                                    
                                } else {
                                    unitMachineIconLink(
                                        linkView: AnyView(mahjongViewTop(
//                                            ver300: ver300
                                        )),
                                        iconImage: Image("mahjongMachineIcon"),
                                        machineName: "麻雀物語"
//                                        badgeStatus: ver300.mahjongMachineIconBadgeStatus
                                    )
//                                        .popoverTip(tipVer280MachineAdd())
                                }
                                
                                // //// ゴジラ、25年4月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteGodzilla == false {
                                    
                                } else {
                                    unitMachineIconLink(
                                        linkView: AnyView(godzillaViewTop()),
                                        iconImage: Image("godzillaMachineIcon"),
                                        machineName: "ゴジラ"
//                                        badgeStatus: ver280.godzillaMachineIconBadgeStatus
                                    )
//                                        .popoverTip(tipVer280MachineAdd())
                                }
                                
                                // //// 間ギアレコード、25年4月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteMagia == false {
                                    
                                } else {
                                    unitMachineIconLink(
                                        linkView: AnyView(magiaViewTop(
//                                            ver390: ver390,
                                            bayes: bayes,
                                            viewModel: viewModel,
                                        )),
                                        iconImage: Image("magiaMachineIcon"),
                                        machineName: "マギレコ",
//                                        badgeStatus: ver390.magiaMachineIconBadge,
                                    )
                                }
                                
                                // //// レビュースタァライト、25年3月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteRsl == false {
                                    
                                } else {
                                    unitMachineIconLink(
                                        linkView: AnyView(rslViewTop(
//                                            ver330: ver330
                                        )),
                                        iconImage: Image("rslMachineIcon"),
                                        machineName: "レビュースタァライト",
//                                        badgeStatus: ver330.rslMachineIconBadgeStaus
                                    )
//                                        .popoverTip(tipVer260MachineAdd())
                                }
                                
                                // //// バイオハザード５、25年3月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteBio == false {
                                    
                                } else {
                                    unitMachineIconLink(
                                        linkView: AnyView(bioViewTop(
//                                            ver370: ver370
                                        )),
                                        iconImage: Image("bioMachineIcon"),
                                        machineName: "バイオ5",
//                                        badgeStatus: ver370.bioMachineIconBadge,
                                    )
                                }
                                
                                // //// カイジ、25年3月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteKaiji == false {
                                    
                                } else {
                                    unitMachineIconLink(
                                        linkView: AnyView(kaijiViewTop(
//                                            ver300: ver300
                                        )),
                                        iconImage: Image("kaijiMachineIcon"),
                                        machineName: "カイジ狂宴"
//                                        badgeStatus: ver300.kaijiMachineIconBadgeStatus
                                    )
                                }
                                
                                // //// ありふれた職業、25年2月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteArifure == false {
                                    
                                } else {
                                    unitMachineIconLink(
                                        linkView: AnyView(arifureViewTop()),
                                        iconImage: Image("arifureMachineIcon"),
                                        machineName: "ありふれ"
//                                        badgeStatus: ver250.arifureMachineIconBadgeStatus
                                    )
//                                        .popoverTip(tipVer240MachineAdd())
                                }
                                
                                // //// 東京グール、25年2月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteTokyoGhoul == false {
                                    
                                } else {
                                    unitMachineIconLink(
                                        linkView: AnyView(tokyoGhoulViewTop(
//                                            ver380: ver380,
                                            bayes: bayes,
                                            viewModel: viewModel,
                                        )),
                                        iconImage: Image("tokyoGhoulMachineIcon"),
                                        machineName: "東京喰種",
//                                        badgeStatus: ver380.tokyoGhoulMachineIconBadge,
                                    )
                                }
                                
                                // //// シャーマンキング、25年2月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteShamanKing == false {
                                    
                                } else {
                                    unitMachineIconLink(
                                        linkView: AnyView(shamanKingViewTop()),
                                        iconImage: Image("shamanKingMachineIcon"),
                                        machineName: "シャーマンキング"
//                                        badgeStatus: ver270.shamanKingMachineIconBadgeStatus
                                    )
                                }
                                
                                // //// スーパーブラックジャック、25年2月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteSbj == false {
                                    
                                } else {
                                    unitMachineIconLink(
                                        linkView: AnyView(sbjViewTop(
//                                            ver310: ver310
                                        )),
                                        iconImage: Image("sbjMachineIcon"),
                                        machineName: "SBJ"
//                                        badgeStatus: ver310.sbjMachineIconBadgeStatus
                                    )
                                }
                                
                                // //// 七つの魔剣が支配する、25年1月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteSevenSwords == false {
                                    
                                } else {
                                    unitMachineIconLink(
                                        linkView: AnyView(sevenSwordsViewTop()),
                                        iconImage: Image("sevenSwordsMachineIcon"),
                                        machineName: "七つの魔剣が支配する"
//                                        badgeStatus: ver270.sevenSwordsMachineIconBadgeStatus
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
                                    unitMachineIconLink(
                                        linkView: AnyView(
                                            mhrViewTop(
//                                                ver390: ver390,
                                                bayes: bayes,
                                                viewModel: viewModel,
                                            )),
                                        iconImage: Image("mhrMachineIcon"),
                                        machineName: "モンハンライズ",
//                                        badgeStatus:ver390.mhrMachineIconBadge,
                                    )
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
                                    unitMachineIconLink(
                                        linkView: AnyView(kaguyaViewTop(
//                                            ver390: ver390,
                                            bayes: bayes,
                                            viewModel: viewModel,
                                        )),
                                        iconImage: Image("kaguyaMachineIcon"),
                                        machineName: "かぐや様",
//                                        badgeStatus: ver390.kaguyaMachineIconBadge
                                    )
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
                                        linkView: AnyView(godeaterViewTop(
//                                            ver380: ver380,
                                            bayes: bayes,
                                            viewModel: viewModel,
                                        )),
                                        iconImage: Image("godeaterMachinIcon"),
                                        machineName: "ゴッドイーター",
//                                        badgeStatus: ver380.godeaterMachineIconBadge,
                                    )
                                }
                                
                                // //// ToLOVEるダークネス、24年6月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteToloveru == false {
                                    // 非表示
                                } else {
                                    unitMachineIconLink(
                                        linkView: AnyView(
                                            toloveruViewTop(
//                                                ver320: ver320
                                            )),
                                        iconImage: Image("toloveruMachineIcon"),
                                        machineName: "ToLoveる"
//                                        badgeStatus: ver320.toloveruMachineIconBadgeStaus
                                    )
                                }
                                
                                // //// スマスロ炎炎の消防隊、24年5月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteEnen == false {
                                    
                                } else {
                                    unitMachineIconLink(
                                        linkView: AnyView(enenViewTop(
//                                            ver391: ver391,
                                            bayes: bayes,
                                            viewModel: viewModel,
                                        )),
                                        iconImage: Image("enenMachineIcon"),
                                        machineName: "スマスロ炎炎",
//                                        badgeStatus: ver391.enenMachineIconBadge,
                                    )
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
                                    unitMachineIconLink(
                                        linkView: AnyView(
                                            mt5ViewTop(
//                                                ver370: ver370,
                                                bayes: bayes,
                                                viewModel: viewModel,
                                            )
                                        ),
                                        iconImage: Image("mt5MachineIconWhite"),
                                        machineName: "モンキー5",
//                                        badgeStatus: ver370.mt5MachineIconBadge,
                                    )
                                }
                                
                                // //// からくりサーカス、23年7月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteKarakuri == false {
                                    // 非表示
                                } else {
                                    unitMachineIconLink(
                                        linkView: AnyView(
                                            karakuriViewTop(
//                                                ver380: ver380,
                                                bayes: bayes,
                                                viewModel: viewModel,
                                            )
                                        ),
                                        iconImage: Image("karakuriMachineIcon"),
                                        machineName: "からくりサーカス",
//                                        badgeStatus: ver380.karakuriMachineIconBadge,
                                    )
                                }
                                
                                // //// 北斗の拳、23年4月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteHokuto == false {
                                    // 非表示
                                } else {
                                    unitMachineIconLink(
                                        linkView: AnyView(
                                            hokutoViewTop(
//                                                ver380: ver380,
                                                bayes: bayes,
                                                viewModel: viewModel,
                                            )),
                                        iconImage: Image("machineIconHokuto"),
                                        machineName: "北斗の拳",
//                                        badgeStatus: ver380.hokutoMachineIconBadge,
                                    )
                                }
                                
                                // //// ヴァルヴレイヴ、22年11月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteVVV == false {
                                    // 非表示
                                } else {
                                    unitMachineIconLink(
                                        linkView: AnyView(VVV_Top(
//                                            ver391: ver391,
                                            bayes: bayes,
                                            viewModel: viewModel,
                                        )),
                                        iconImage: Image("machineIconVVV"),
                                        machineName: "ヴヴヴ",
//                                        badgeStatus: ver391.vvvMachineIconBadge,
                                    )
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
                                        linkView: AnyView(JuglerSeriesViewTop(
//                                            ver391: ver391,
                                            bayes: bayes,
                                            viewModel: viewModel,
//                                            common: common,
                                        )),
                                        iconImage: Image("machineIconJuglerSeries"),
                                        machineName: "ジャグラーシリーズ",
                                        makerName: "北電子",
                                        releaseYear: 96,
                                        releaseMonth: 12,
                                        badgeStatus: common.jugSeriesBadge,
                                    )
                                }
                                
                                // //// ハナハナシリーズ
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedHanahanaSeries == false {
                                    // 非表示
                                } else {
                                    unitMachinListLink(
                                        linkView: AnyView(hanahanaSeriesViewTop(
//                                            ver391: ver391,
                                            bayes: bayes,
                                            viewModel: viewModel,
//                                            common: common,
                                        )),
                                        iconImage: Image("machineIconHanahanaSeries"),
                                        machineName: "ハナハナ",
                                        makerName: "パイオニア",
                                        releaseYear: 2001,
                                        releaseMonth: 5,
//                                        badgeStatus: ver391.hanaSeriesBadge,
                                    )
                                }
                                
                                // //// クレアの秘宝伝、25年9月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteCrea == false {
                                    
                                } else {
                                    unitMachinListLink(
                                        linkView: AnyView(creaViewTop(
                                            bayes: bayes,
                                            viewModel: viewModel,
                                        )),
                                        iconImage: Image("creaMachineIcon"),
                                        machineName: "クレアの秘宝伝BT",
                                        makerName: "大都技研",
                                        releaseYear: 2025,
                                        releaseMonth: 9,
                                        badgeStatus: common.creaMachineIconBadge,
                                        btBadgeBool: true,
                                    )
                                }
                                
                                // //// 東京リベンジャーズ、25年9月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteToreve == false {
                                    
                                } else {
                                    unitMachinListLink(
                                        linkView: AnyView(toreveViewTop(
//                                            ver390: ver390,
//                                            ver391: ver391,
                                            bayes: bayes,
                                            viewModel: viewModel,
                                        )),
                                        iconImage: Image("toreveMachineIcon"),
                                        machineName: "東京リベンジャーズ",
                                        makerName: "サミー",
                                        releaseYear: 2025,
                                        releaseMonth: 9,
                                        badgeStatus: common.toreveMachineIconBadge,
                                    )
                                }
                                
                                // //// アズールレーン、25年8月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteAzurLane == false {
                                    
                                } else {
                                    unitMachinListLink(
                                        linkView: AnyView(azurLaneViewTop(
//                                            ver391: ver391,
                                            bayes: bayes,
                                            viewModel: viewModel,
                                        )),
                                        iconImage: Image("azurLaneMachineIcon"),
                                        machineName: "アズールレーン",
//                                        machineNameFont: .subheadline,
                                        makerName: "京楽",
                                        releaseYear: 2025,
                                        releaseMonth: 8,
//                                        badgeStatus: ver391.azurLaneMachineIconBadge,
                                    )
                                }
                                
                                // //// ダーリンインザフランキス、25年8月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteDarling == false {
                                    
                                } else {
                                    unitMachinListLink(
                                        linkView: AnyView(darlingViewTop(
//                                            ver380: ver380,
//                                            ver390: ver390,
                                            bayes: bayes,
                                            viewModel: viewModel,
                                        )),
                                        iconImage: Image("darlingMachineIcon"),
                                        machineName: "ダーリン・イン・ザ・フランキス",
                                        machineNameFont: .subheadline,
                                        makerName: "Spiky",
                                        releaseYear: 2025,
                                        releaseMonth: 8,
//                                        badgeStatus: ver390.darlingMachineIconBadge,
                                    )
                                }
                                
                                // //// 転生したら剣でした、25年8月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteReSword == false {
                                    
                                } else {
                                    unitMachinListLink(
                                        linkView: AnyView(reSwordViewTop(
//                                            ver360: ver360,
//                                            ver361: ver361,
                                        )),
                                        iconImage: Image("reSwordMachineIcon"),
                                        machineName: "転生したら剣でした",
                                        makerName: "コナミ",
                                        releaseYear: 2025,
                                        releaseMonth: 8,
//                                        badgeStatus: ver361.reSwordMachineIconBadge,
                                    )
                                }
                                
                                // //// エヴァ約束、25年7月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteEvaYakusoku == false {
                                    
                                } else {
                                    unitMachinListLink(
                                        linkView: AnyView(evaYakusokuViewTop(
//                                            ver380: ver380,
                                            bayes: bayes,
                                            viewModel: viewModel,
                                        )),
                                        iconImage: Image("evaYakusokuMachineIcon"),
                                        machineName: "ヱヴァンゲリヲン〜約束の扉〜",
                                        makerName: "SANKYO",
                                        releaseYear: 2025,
                                        releaseMonth: 7,
                                        badgeStatus: common.evaYakusokuMachineIconBadge,
                                        btBadgeBool: true,
                                    )
                                }
                                
                                // //// 私の幸せな結婚、25年7月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteWatakon == false {
                                    
                                } else {
                                    unitMachinListLink(
                                        linkView: AnyView(watakonViewTop(
//                                            ver350: ver350,
//                                            ver351: ver351,
                                        )),
                                        iconImage: Image("watakonMachineIcon"),
                                        machineName: "わたしの幸せな結婚",
                                        makerName: "コナミ",
                                        releaseYear: 2025,
                                        releaseMonth: 7,
//                                        badgeStatus: ver351.watakonMachineIconBadgeStaus,
                                    )
                                }
                                
                                // //// ギルティクラウン、25年6月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteGuiltyCrown2 == false {
                                    
                                } else {
                                    unitMachinListLink(
                                        linkView: AnyView(guiltyCrown2ViewTop(
//                                            ver360: ver360,
                                        )),
                                        iconImage: Image("guiltyCrown2MachineIcon"),
                                        machineName: "ギルティクラウン2",
                                        makerName: "UNIVERSAL",
                                        releaseYear: 2025,
                                        releaseMonth: 6,
//                                        badgeStatus: ver360.guiltyCrown2MachineIconBadge,
                                    )
                                }
                                
                                // //// デビルメイクライ、25年6月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteDmc5 == false {
                                    
                                } else {
                                    unitMachinListLink(
                                        linkView: AnyView(dmc5ViewTop(
//                                            ver350: ver350,
//                                            ver351: ver351,
//                                            ver352: ver352,
                                        )),
                                        iconImage: Image("dmc5MachineIcon"),
                                        machineName: "Devil May Cry5",
                                        makerName: "エンターライズ",
                                        releaseYear: 2025,
                                        releaseMonth: 6,
//                                        badgeStatus: ver352.dmc5MachineIconBadge,
                                    )
                                }
                                
                                // //// いざ！番長、25年6月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteIzaBancho == false {
                                    
                                } else {
                                    unitMachinListLink(
                                        linkView: AnyView(izaBanchoViewTop(
//                                            ver350: ver350,
//                                            ver340: ver340
                                        )),
                                        iconImage: Image("izaBanchoMachineIcon"),
                                        machineName: "いざ！番長",
                                        makerName: "大都技研",
                                        releaseYear: 2025,
                                        releaseMonth: 6,
                                        badgeStatus: common.izaBanchoMachineIconBadge,
                                    )
                                }
                                
                                // //// ToLOVEるトランスver8.7、25年5月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteToloveru87 == false {
                                    
                                } else {
                                    unitMachinListLink(
                                        linkView: AnyView(toloveru87ViewTop(
//                                            ver320: ver320
                                        )),
                                        iconImage: Image("toloveru87MachineIcon"),
                                        machineName: "ToLOVEる TRANCE ver.8.7",
                                        makerName: "平和",
                                        releaseYear: 2025,
                                        releaseMonth: 5
//                                        badgeStatus: ver320.toloveru87MachineIconBadgeStaus
                                    )
                                }
                                
                                // //// ガンダムSEED、25年5月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteGundamSeed == false {
                                    
                                } else {
                                    unitMachinListLink(
                                        linkView: AnyView(gundamSeedViewTop(
//                                            ver310: ver310
                                        )),
                                        iconImage: Image("gundamSeedMachineIcon"),
                                        machineName: "ガンダムSEED",
                                        makerName: "SANKYO",
                                        releaseYear: 2025,
                                        releaseMonth: 5
//                                        badgeStatus: ver310.gundamSeedMachineIconBadgeStatus
                                    )
                                }
                                
                                // //// 緑ドン、25年5月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteMidoriDon == false {
                                    
                                } else {
                                    unitMachinListLink(
                                        linkView: AnyView(midoriDonViewTop(
//                                            ver340: ver340
//                                            ver310: ver310
                                        )),
                                        iconImage: Image("midoriDonMachineIcon"),
                                        machineName: "緑ドン VIVA情熱南米編",
                                        makerName: "UNIVERSAL",
                                        releaseYear: 2025,
                                        releaseMonth: 5,
//                                        badgeStatus: ver340.midoriDonMachineIconBadgeStatus
                                    )
//                                    .popoverTip(tipVer300MachineAdd())
                                }
                                
                                // //// アイマス、25年4月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteIdolMaster == false {
                                    
                                } else {
                                    unitMachinListLink(
                                        linkView: AnyView(idolMasterViewTop(
//                                            ver330: ver330
                                        )),
                                        iconImage: Image("idolMasterMachineIcon"),
                                        machineName: "アイドルマスター",
                                        makerName: "山佐",
                                        releaseYear: 2025,
                                        releaseMonth: 4,
//                                        badgeStatus: ver330.idolMasterMachineIconBadgeStaus
                                    )
//                                    .popoverTip(tipVer300MachineAdd())
                                }
                                
                                // //// 吉宗、25年4月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteYoshimune == false {
                                    
                                } else {
                                    unitMachinListLink(
                                        linkView: AnyView(yoshimuneViewTop(
//                                            ver360: ver360,
                                        )),
                                        iconImage: Image("yoshimuneMachineIcon"),
                                        machineName: "吉宗",
                                        makerName: "大都技研",
                                        releaseYear: 2025,
                                        releaseMonth: 4,
//                                        badgeStatus: ver360.yoshimuneMachineIconBadge,
                                    )
//                                    .popoverTip(tipVer280MachineAdd())
                                }
                                
                                // //// 麻雀物語、25年4月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteMahjong == false {
                                    
                                } else {
                                    unitMachinListLink(
                                        linkView: AnyView(mahjongViewTop(
//                                            ver300: ver300
                                        )),
                                        iconImage: Image("mahjongMachineIcon"),
                                        machineName: "麻雀物語",
                                        makerName: "平和",
                                        releaseYear: 2025,
                                        releaseMonth: 4
//                                        badgeStatus: ver300.mahjongMachineIconBadgeStatus
                                    )
//                                    .popoverTip(tipVer280MachineAdd())
                                }
                                
                                // //// ゴジラ、25年4月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteGodzilla == false {
                                    
                                } else {
                                    unitMachinListLink(
                                        linkView: AnyView(godzillaViewTop()),
                                        iconImage: Image("godzillaMachineIcon"),
                                        machineName: "ゴジラ",
                                        makerName: "ニューギン",
                                        releaseYear: 2025,
                                        releaseMonth: 4
//                                        badgeStatus: ver280.godzillaMachineIconBadgeStatus
                                    )
//                                    .popoverTip(tipVer280MachineAdd())
                                }
                                
                                // //// マギアレコード、25年4月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteMagia == false {
                                    
                                } else {
                                    unitMachinListLink(
                                        linkView: AnyView(magiaViewTop(
//                                            ver390: ver390,
                                            bayes: bayes,
                                            viewModel: viewModel,
                                        )),
                                        iconImage: Image("magiaMachineIcon"),
                                        machineName: "マギアレコード",
                                        makerName: "UNIVERSAL",
                                        releaseYear: 2025,
                                        releaseMonth: 4,
//                                        badgeStatus: ver390.magiaMachineIconBadge,
                                    )
                                }
                                
                                // //// レビュースタァライト、25年3月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteRsl == false {
                                    
                                } else {
                                    unitMachinListLink(
                                        linkView: AnyView(rslViewTop(
//                                            ver330: ver330
                                        )),
                                        iconImage: Image("rslMachineIcon"),
                                        machineName: "レビュースタァライト",
                                        makerName: "オーイズミ",
                                        releaseYear: 2025,
                                        releaseMonth: 3,
//                                        badgeStatus: ver330.rslMachineIconBadgeStaus
                                    )
//                                    .popoverTip(tipVer260MachineAdd())
                                }
                                
                                // //// バイオ５、25年3月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteBio == false {
                                    
                                } else {
                                    unitMachinListLink(
                                        linkView: AnyView(bioViewTop(
//                                            ver370: ver370
                                        )),
                                        iconImage: Image("bioMachineIcon"),
                                        machineName: "バイオハザード5",
                                        makerName: "エンターライズ",
                                        releaseYear: 2025,
                                        releaseMonth: 3,
//                                        badgeStatus: ver370.bioMachineIconBadge,
                                    )
                                }
                                
                                // //// カイジ、25年3月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteKaiji == false {
                                    
                                } else {
                                    unitMachinListLink(
                                        linkView: AnyView(kaijiViewTop(
//                                            ver300: ver300
                                        )),
                                        iconImage: Image("kaijiMachineIcon"),
                                        machineName: "回胴黙示録カイジ 狂宴",
                                        makerName: "サミー",
                                        releaseYear: 2025,
                                        releaseMonth: 3
//                                        badgeStatus: ver300.kaijiMachineIconBadgeStatus
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
                                        releaseMonth: 2
//                                        badgeStatus: ver250.arifureMachineIconBadgeStatus
                                    )
//                                    .popoverTip(tipVer240MachineAdd())
                                }
                                
                                // //// 東京グール、25年2月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteTokyoGhoul == false {
                                    
                                } else {
                                    unitMachinListLink(
                                        linkView: AnyView(tokyoGhoulViewTop(
//                                            ver380: ver380,
                                            bayes: bayes,
                                            viewModel: viewModel,
                                        )),
                                        iconImage: Image("tokyoGhoulMachineIcon"),
                                        machineName: "東京喰種",
                                        makerName: "Spiky",
                                        releaseYear: 2025,
                                        releaseMonth: 2,
//                                        badgeStatus: ver380.tokyoGhoulMachineIconBadge,
                                    )
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
//                                        badgeStatus: ver270.shamanKingMachineIconBadgeStatus
                                    )
                                }
                                
                                // //// スーパーブラックジャック、25年2月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteSbj == false {
                                    
                                } else {
                                    unitMachinListLink(
                                        linkView: AnyView(sbjViewTop(
//                                            ver310: ver310
                                        )),
                                        iconImage: Image("sbjMachineIcon"),
                                        machineName: "スーパーブラックジャック",
                                        makerName: "山佐",
                                        releaseYear: 2025,
                                        releaseMonth: 2
//                                        badgeStatus: ver310.sbjMachineIconBadgeStatus
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
//                                        badgeStatus: ver270.sevenSwordsMachineIconBadgeStatus
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
                                        linkView: AnyView(mhrViewTop(
//                                            ver390: ver390,
                                            bayes: bayes,
                                            viewModel: viewModel,
                                        )),
                                        iconImage: Image("mhrMachineIcon"),
                                        machineName: "モンスターハンター ライズ",
                                        makerName: "アデリオン",
                                        releaseYear: 2024,
                                        releaseMonth: 11,
//                                        badgeStatus: ver390.mhrMachineIconBadge,
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
                                    unitMachinListLink(
                                        linkView: AnyView(kaguyaViewTop(
//                                            ver390: ver390,
                                            bayes: bayes,
                                            viewModel: viewModel,
                                        )),
                                        iconImage: Image("kaguyaMachineIcon"),
                                        machineName: "かぐや様は告らせたい",
                                        makerName: "SANKYO",
                                        releaseYear: 2024,
                                        releaseMonth: 9,
//                                        badgeStatus: ver390.kaguyaMachineIconBadge,
                                    )
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
                                        linkView: AnyView(godeaterViewTop(
//                                            ver380: ver380,
                                            bayes: bayes,
                                            viewModel: viewModel,
                                        )),
                                        iconImage: Image("godeaterMachinIcon"),
                                        machineName: "ゴッドイーター リザレクション",
                                        makerName: "山佐",
                                        releaseYear: 2024,
                                        releaseMonth: 7,
//                                        badgeStatus: ver380.godeaterMachineIconBadge,
                                    )
                                }
                                // //// ToLOVEるダークネス、24年6月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteToloveru == false {
                                    // 非表示
                                } else {
                                    unitMachinListLink(
                                        linkView: AnyView(toloveruViewTop(
//                                            ver320: ver320
                                        )),
                                        iconImage: Image("toloveruMachineIcon"),
                                        machineName: "ToLOVEるダークネス",
                                        makerName: "平和",
                                        releaseYear: 2024,
                                        releaseMonth: 6
//                                        badgeStatus: ver320.toloveruMachineIconBadgeStaus
                                    )
                                }
                                
                                // //// スマスロ炎炎の消防隊、24年5月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteEnen == false {
                                    
                                } else {
                                    unitMachinListLink(
                                        linkView: AnyView(enenViewTop(
//                                            ver391: ver391,
                                            bayes: bayes,
                                            viewModel: viewModel,
                                        )),
                                        iconImage: Image("enenMachineIcon"),
                                        machineName: "スマスロ炎炎ノ消防隊",
                                        machineNameFont: .subheadline,
                                        makerName: "SANKYO",
                                        releaseYear: 2024,
                                        releaseMonth: 5,
//                                        badgeStatus: ver391.enenMachineIconBadge,
                                    )
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
                                    unitMachinListLink(
                                        linkView: AnyView(
                                            mt5ViewTop(
//                                                ver370: ver370,
                                                bayes: bayes,
                                                viewModel: viewModel,
                                            )
                                        ),
                                        iconImage: Image("machineIconMT5"),
                                        machineName: "モンキーターン5",
                                        makerName: "山佐",
                                        releaseYear: 2023,
                                        releaseMonth: 12,
//                                        badgeStatus: ver370.mt5MachineIconBadge,
                                    )
                                }
                                
                                // //// からくりサーカス、23年7月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteKarakuri == false {
                                    // 非表示
                                } else {
                                    unitMachinListLink(
                                        linkView: AnyView(
                                            karakuriViewTop(
//                                                ver380: ver380,
                                                bayes: bayes,
                                                viewModel: viewModel,
                                            )
                                        ),
                                        iconImage: Image("karakuriMachineIcon"),
                                        machineName: "からくりサーカス",
                                        makerName: "SANKYO",
                                        releaseYear: 2023,
                                        releaseMonth: 7,
//                                        badgeStatus: ver380.karakuriMachineIconBadge,
                                    )
                                }
                                
                                // //// 北斗の拳、23年4月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteHokuto == false {
                                    // 非表示
                                } else {
                                    unitMachinListLink(
                                        linkView: AnyView(
                                            hokutoViewTop(
//                                                ver380: ver380,
                                                bayes: bayes,
                                                viewModel: viewModel,
                                            )
                                        ),
                                        iconImage: Image("machineIconHokuto"),
                                        machineName: "北斗の拳",
                                        makerName: "サミー",
                                        releaseYear: 2023,
                                        releaseMonth: 4,
//                                        badgeStatus: ver380.hokutoMachineIconBadge,
                                    )
                                }
                                
                                // //// ヴァルヴレイヴ、22年11月
                                if isSelectedDisplayMode == "お気に入り" && favoriteSet.isSelectedFavoriteVVV == false {
                                    // 非表示
                                } else {
                                    unitMachinListLink(
                                        linkView: AnyView(VVV_Top(
//                                            ver391: ver391,
                                            bayes: bayes,
                                            viewModel: viewModel,
                                        )),
                                        iconImage: Image("machineIconVVV"),
                                        machineName: "革命機ヴァルヴレイヴ",
                                        makerName: "SANKYO",
                                        releaseYear: 2022,
                                        releaseMonth: 11,
//                                        badgeStatus: ver391.vvvMachineIconBadge,
                                    )
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
                    
                    // //// プライバシーポリシー改訂の案内
                    // アプリ起動回数が2回以上の人には引き続き改訂の案内
                    if common.appLaunchCount > 1 {
                        if ver320.isShowPrivacyPolicy {
                            ZStack {
                                Rectangle()
                                    .foregroundStyle(Color.white)
                                    .opacity(0.8)
                                GroupBox {
                                    VStack {
                                        Text("プライバシーポリシー改訂のお知らせ")
                                            .font(.title3)
                                            .fontWeight(.bold)
                                        VStack {
                                            Text("ver3.2.0より\n・機種ごとの利用頻度\n・エラー発生状況　など\n個人を特定しない匿名の利用データを収集する場合があります。それに伴いプライバシーポリシーを改訂しました。")
                                            Link(destination: URL(string: "http://kotakoworks.mods.jp/privacy_policy.html")!) {
                                                Text("プライバシーポリシーはこちら")
                                                    .padding(.vertical)
                                            }
                                            Button {
                                                ver320.isShowPrivacyPolicy.toggle()
                                            } label: {
                                                Text("承諾して閉じる")
                                                    .fontWeight(.bold)
                                            }
                                            .buttonStyle(BorderedProminentButtonStyle())
                                        }
                                        .padding(.horizontal)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        } else {
                            
                        }
                    }
                }
                // 開発用
//                .onAppear {
//                    if ver320.isShowPrivacyPolicy == false {
//                        ver320.isShowPrivacyPolicy.toggle()
//                    }
//                }
                // //// firebaseログ
                .onAppear {
                    let screenClass = String(describing: Self.self)
                    logEventFirebaseScreen(
                        screenName: "機種選択",
                        screenClass: screenClass
                    )
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
//                                        .popoverTip(tipUnitButtonIconDisplayMode())
                                }
                            }
//                            .popoverTip(tipUnitButtonIconDisplayMode())
                            
//                            // お気に入り設定ボタン
//                            Button(action: {
//                                isShowFavoriteSettingView.toggle()
//                            }, label: {
//                                Image(systemName: "gearshape.fill")
//                            })
//                            .sheet(isPresented: $isShowFavoriteSettingView, content: {
//                                favoriteSettingView()
//                            })
                        }
                    }
//                    ToolbarSpacer()
                    ToolbarItem(placement: .automatic) {
                        HStack {
                            // 表示モード切り替えボタン
//                            Button {
//                                common.iconDisplayMode.toggle()
//                            } label: {
//                                if common.iconDisplayMode {
//                                    Image(systemName: "list.bullet")
//                                }
//                                else {
//                                    Image(systemName: "rectangle.grid.2x2")
////                                        .popoverTip(tipUnitButtonIconDisplayMode())
//                                }
//                            }
////                            .popoverTip(tipUnitButtonIconDisplayMode())
                            
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
        // //// 起動回数が1以下の場合は初回起動とみなす。ver3.3.0以降の初回起動としてプライバシーポリシーの案内は出さない
        .onAppear {
            if common.appLaunchCount <= 1 {
                ver320.isShowPrivacyPolicy = false
            }
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
                // クレアの秘宝伝
                Toggle("クレアの秘宝伝BT", isOn: $favoriteSet.isSelectedFavoriteCrea)
                // 東京リベンジャーズ
                Toggle("東京リベンジャーズ", isOn: $favoriteSet.isSelectedFavoriteToreve)
                // アズールレーン
                Toggle("アズールレーン", isOn: $favoriteSet.isSelectedFavoriteAzurLane)
                // ダーリンインザフランキス
                Toggle("ダーリン・イン・ザ・フランキス", isOn: $favoriteSet.isSelectedFavoriteDarling)
                // 転生したら剣でした
                Toggle("転生したら剣でした", isOn: $favoriteSet.isSelectedFavoriteReSword)
                // //// エヴァ約束の扉
                Toggle("ヱヴァンゲリヲン〜約束の扉〜", isOn: $favoriteSet.isSelectedFavoriteEvaYakusoku)
                // //// 私の幸せな結婚
                Toggle("わたしの幸せな結婚", isOn: $favoriteSet.isSelectedFavoriteWatakon)
                // //// ギルティクラウン2
                Toggle("ギルティクラウン2", isOn: $favoriteSet.isSelectedFavoriteGuiltyCrown2)
                // //// デビルメイクライ５
                Toggle("Devil May Cry5", isOn: $favoriteSet.isSelectedFavoriteDmc5)
                // //// いざ番長
                Toggle("いざ！番長", isOn: $favoriteSet.isSelectedFavoriteIzaBancho)
                // //// ToLOVEるトランスver8.7
                Toggle("ToLOVEる TRANCE ver.8.7", isOn: $favoriteSet.isSelectedFavoriteToloveru87)
                // //// ガンダムSEED、25年5月
                Toggle("ガンダムSEED", isOn: $favoriteSet.isSelectedFavoriteGundamSeed)
                // //// 緑ドン、25年5月
                Toggle("緑ドン VIVA情熱南米編", isOn: $favoriteSet.isSelectedFavoriteMidoriDon)
                // //// アイマス、25年4月
                Toggle("アイドルマスター", isOn: $favoriteSet.isSelectedFavoriteIdolMaster)
                // //// 吉宗、25年4月
                Toggle("吉宗", isOn: $favoriteSet.isSelectedFavoriteYoshimune)
                // //// 麻雀物語、25年4月
                Toggle("麻雀物語", isOn: $favoriteSet.isSelectedFavoriteMahjong)
                // //// ゴジラ、25年4月
                Toggle("ゴジラ", isOn: $favoriteSet.isSelectedFavoriteGodzilla)
                // //// マギアレコード、25年4月
                Toggle("マギアレコード", isOn: $favoriteSet.isSelectedFavoriteMagia)
                // //// レビュースターライト、25年3月
                Toggle("レビュースタァライト", isOn: $favoriteSet.isSelectedFavoriteRsl)
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
                // //// スマスロ炎炎の消防隊、24年5月
                Toggle("スマスロ炎炎ノ消防隊", isOn: $favoriteSet.isSelectedFavoriteEnen)
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
//struct machineListJuglerSeries: View {
//    var body: some View {
//        NavigationLink(destination: JuglerSeriesViewTop()) {
//            HStack {
//                Image("machineIconJuglerSeries")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 40.0)
//                    .cornerRadius(8)
//                VStack(alignment: .leading) {
//                    Text("ジャグラーシリーズ")
//                    Text("")
//                        .font(.caption)
////                        .foregroundColor(Color.gray)
//                        .foregroundStyle(Color.gray)
//                        .padding(.leading)
//                }
//                .padding(.leading)
//            }
//        }
//    }
//}


// ////////////////////////
// ビュー：ハナハナシリーズ
// ////////////////////////
//struct machineListHanahanaSeries: View {
//    var body: some View {
//        NavigationLink(destination: hanahanaSeriesViewTop()) {
//            HStack {
//                Image("machineIconHanahanaSeries")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 40.0)
//                    .cornerRadius(8)
//                VStack(alignment: .leading) {
//                    Text("ハナハナシリーズ")
//                    Text("")
//                        .font(.caption)
////                        .foregroundColor(Color.gray)
//                        .foregroundStyle(Color.gray)
//                        .padding(.leading)
//                }
//                .padding(.leading)
//            }
//        }
//    }
//}


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
//private struct BannerView: UIViewRepresentable {
struct BannerView: UIViewRepresentable {
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
            banner.adUnitID = "ca-app-pub-3940256099942544/2435281174"     // テスト用
//            banner.adUnitID = "ca-app-pub-2339669527176370/9695161925"     // 本番用
            
            // 広告リクエストを作成
            let adRequest = GADRequest()
            // カスタムキーワードを設定
//            adRequest.keywords = ["パチスロ", "パチンコ", "ギャンブル", "遊技場", "スマスロ", "スマパチ", "スロット"]
//            adRequest.keywords = ["パチスロ", "パチンコ", "遊技場", "スマスロ", "スマパチ", "スロット"]
            
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
    ContentView(
//        common: commonVar()
    )
    .environmentObject(commonVar())
}
