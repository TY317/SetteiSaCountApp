//
//  unitToggleWithQuestion.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/11.
//

import SwiftUI

struct unitToggleWithQuestion<QuestionView: View>: View {
    @Binding var enable: Bool
    var title: String
    var titleFont: Font = .body
    
    private let questionView: QuestionView
    
    init(
        enable: Binding<Bool>,
        title: String,
        titleFont: Font = .body,
        @ViewBuilder questionView: () -> QuestionView = { EmptyView() }
    ) {
        self._enable = enable
        self.title = title
        self.titleFont = titleFont
        self.questionView = questionView()
    }
    
    var body: some View {
        Toggle(isOn: self.$enable) {
            HStack {
                Text(self.title)
                    .foregroundStyle(self.enable ? Color.primary : Color.secondary)
                    .font(self.titleFont)
                if QuestionView.self != EmptyView.self {
                    unitToolbarButtonQuestion {
                        self.questionView
                    }
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var enable = false
    List {
        unitToggleWithQuestion(
            enable: $enable,
            title: "Test",
        ) {
            unitExView5body2image(
                title: "test",
                textBody1: "test",
            )
        }
    }
}
