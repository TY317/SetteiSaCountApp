//
//  unitButtonRecordKenToStart.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/18.
//

import SwiftUI

struct unitButtonRecordKenToStart: View {
    @Binding var isShowAlertRecord: Bool
    let action: () -> Void
    let buttonTitle: String = "実戦 打ち始めデータへ登録"
    let alertTitle: String = "打ち始めデータへの上書き登録"
    let alertMessage: String = "実戦データを全てリセットして、このページのデータを実戦の打ち始めデータとして登録します。現在の実戦データは全て消去されます。"
    
    var body: some View {
        HStack {
            Spacer()
            Button {
                self.isShowAlertRecord = true
            } label: {
                Text(self.buttonTitle)
                    .fontWeight(.bold)
            }
            .alert(self.alertTitle, isPresented: self.$isShowAlertRecord) {
                Button("キャンセル", role: .cancel) {
                    
                }
                Button("上書き登録", role: .destructive) {
                    self.action()
                    UINotificationFeedbackGenerator().notificationOccurred(.success)
                }
            } message: {
                Text(self.alertMessage)
            }
            Spacer()
        }
    }
}

//#Preview {
//    unitButtonRecordKenToStart()
//}
