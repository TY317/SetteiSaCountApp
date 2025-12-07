//
//  unitToolbarButtonAutoGameCount.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/07.
//

import SwiftUI

struct unitToolbarButtonAutoGameCount: View {
    @Binding var autoBool: Bool
    @Binding var nextAutoCountDate: Date?
    @EnvironmentObject var common: commonVar
    var body: some View {
        Button {
            self.autoBool.toggle()
        } label: {
            Image(systemName: self.autoBool ? "pause.circle" : "play.circle")
                .foregroundStyle(self.autoBool ? Color.green : Color.primary)
        }
        .onChange(of: self.autoBool) { oldValue, newValue in
            if newValue {
                self.nextAutoCountDate = Date().addingTimeInterval(common.autoGameInterval)
            } else {
                self.nextAutoCountDate = nil
            }
        }
    }
}

#Preview {
    @Previewable @State var test: Bool = false
    @Previewable @State var date: Date? = nil
    unitToolbarButtonAutoGameCount(
        autoBool: $test,
        nextAutoCountDate: $date,
    )
    .environmentObject(commonVar())
}
