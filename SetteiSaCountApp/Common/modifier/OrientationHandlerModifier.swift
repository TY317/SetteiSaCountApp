//
//  OrientationHandlerModifier.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/24.
//

import Foundation
import SwiftUI

struct OrientationHandlerModifier: ViewModifier {
    @Binding var orientation: UIDeviceOrientation
    @Binding var lastOrientation: UIDeviceOrientation
    @Binding var scrollViewHeight: Double
    @Binding var spaceHeight: Double
    @Binding var lazyVGridCount: Int

    let scrollViewHeightPortrait: Double
    let scrollViewHeightLandscape: Double
    let spaceHeightPortrait: Double
    let spaceHeightLandscape: Double
    let lazyVGridCountPortrait: Int
    let lazyVGridCountLandscape: Int

    func body(content: Content) -> some View {
        content
            .onAppear {
                orientation = UIDevice.current.orientation
                if !orientation.isFlat {
                    lastOrientation = orientation
                }
                updateLayout()

                NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: .main) { _ in
                    orientation = UIDevice.current.orientation
                    if !orientation.isFlat {
                        lastOrientation = orientation
                    }
                    updateLayout()
                }
            }
            .onDisappear {
                NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
            }
    }

    private func updateLayout() {
        if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
            scrollViewHeight = scrollViewHeightLandscape
            spaceHeight = spaceHeightLandscape
            lazyVGridCount = lazyVGridCountLandscape
        } else {
            scrollViewHeight = scrollViewHeightPortrait
            spaceHeight = spaceHeightPortrait
            lazyVGridCount = lazyVGridCountPortrait
        }
    }
}

extension View {
    func applyOrientationHandling(
        orientation: Binding<UIDeviceOrientation>,
        lastOrientation: Binding<UIDeviceOrientation>,
        scrollViewHeight: Binding<Double>,
        spaceHeight: Binding<Double>,
        lazyVGridCount: Binding<Int>,
        scrollViewHeightPortrait: Double,
        scrollViewHeightLandscape: Double,
        spaceHeightPortrait: Double,
        spaceHeightLandscape: Double,
        lazyVGridCountPortrait: Int,
        lazyVGridCountLandscape: Int
    ) -> some View {
        self.modifier(OrientationHandlerModifier(
            orientation: orientation,
            lastOrientation: lastOrientation,
            scrollViewHeight: scrollViewHeight,
            spaceHeight: spaceHeight,
            lazyVGridCount: lazyVGridCount,
            scrollViewHeightPortrait: scrollViewHeightPortrait,
            scrollViewHeightLandscape: scrollViewHeightLandscape,
            spaceHeightPortrait: spaceHeightPortrait,
            spaceHeightLandscape: spaceHeightLandscape,
            lazyVGridCountPortrait: lazyVGridCountPortrait,
            lazyVGridCountLandscape: lazyVGridCountLandscape
        ))
    }
}
