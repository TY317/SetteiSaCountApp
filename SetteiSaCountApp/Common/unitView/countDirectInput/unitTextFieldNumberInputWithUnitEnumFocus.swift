import SwiftUI

public struct UnitTextFieldNumberInputWithUnitEnumFocus<Field: Hashable>: View {
    @State private var title: String
    @Binding private var inputValue: Int
    @State private var numberPadTypeSelect: Bool
    private var titleColor: Color
    private var inputNumberColor: Color
    private var unitText: String
    private var unitTextColor: Color
    private var unitTextFont: Font
    @FocusState<Field?>.Binding private var focusedField: Field?
    private var thisField: Field

    public init(
        title: String,
        inputValue: Binding<Int>,
        numberPadTypeSelect: Bool = true,
        titleColor: Color = .primary,
        inputNumberColor: Color = .primary,
        unitText: String = "回",
        unitTextColor: Color = .secondary,
        unitTextFont: Font = .footnote,
        focusedField: FocusState<Field?>.Binding,
        thisField: Field
    ) {
        self._title = State(initialValue: title)
        self._inputValue = inputValue
        self._numberPadTypeSelect = State(initialValue: numberPadTypeSelect)
        self.titleColor = titleColor
        self.inputNumberColor = inputNumberColor
        self.unitText = unitText
        self.unitTextColor = unitTextColor
        self.unitTextFont = unitTextFont
        self._focusedField = focusedField
        self.thisField = thisField
    }

    public var body: some View {
        HStack(spacing: 4) {
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(titleColor)
            HStack {
                let field = TextField(title, value: $inputValue, format: .number)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(inputNumberColor)
                    .focused($focusedField, equals: thisField)
                if numberPadTypeSelect {
                    field.keyboardType(.numberPad)
                } else {
                    field
                }
                Text(unitText)
                    .foregroundStyle(unitTextColor)
                    .font(unitTextFont)
            }
        }
    }
}

#Preview {
    enum TestField: Hashable { case first, second }
    struct Demo: View {
        @State private var firstValue: Int = 12
        @State private var secondValue: Int = 34
        @FocusState private var focus: TestField?
        var body: some View {
            VStack(spacing: 16) {
                UnitTextFieldNumberInputWithUnitEnumFocus<TestField>(
                    title: "First",
                    inputValue: $firstValue,
                    focusedField: $focus,
                    thisField: .first
                )
                UnitTextFieldNumberInputWithUnitEnumFocus<TestField>(
                    title: "Second",
                    inputValue: $secondValue,
                    unitText: "個",
                    focusedField: $focus,
                    thisField: .second
                )
            }
            .padding()
        }
    }
    return Demo()
}
