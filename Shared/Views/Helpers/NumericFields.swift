import Combine
import SwiftUI

struct IntField: View {

    @Binding var int: Int
    @State private var intString: String  = ""

    var body: some View {
        return TextField("", text: $intString)
            .onReceive(Just(intString)) { value in
                let strippedValue = value.replacingOccurrences(of: ",", with: "")
                if let i = Int(strippedValue) {
                    int = i
                    intString = IntField.numberFormatter.string(for: int) ?? ""
                }
                else {
                    intString = IntField.numberFormatter.string(for: int) ?? ""
                }
            }
            .onAppear(perform: {
                intString = int == 0 ? "" : IntField.numberFormatter.string(for: int) ?? ""
            })
            .font(.system(size: 24, design: .monospaced))
#if os(macOS)
            .textFieldStyle(SquareBorderTextFieldStyle())
#else
            .textFieldStyle(.roundedBorder)
            .keyboardType(.numberPad)
#endif
    }

    private static var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = Locale.current.groupingSeparator
        return formatter
    }

}

struct PercentageField: View {

    @Binding var value: Double
    @State private var valueString: String  = ""

    var body: some View {
        return TextField("", text: $valueString)
            .onReceive(Just(valueString)) { v in
                if let d = Double(v) { value = d }
            }
            .onAppear(perform: {
                valueString = value.asPercentString
            })
            .font(.system(size: 24, design: .monospaced))
#if os(macOS)
            .textFieldStyle(SquareBorderTextFieldStyle())
#else
            .textFieldStyle(.roundedBorder)
            .keyboardType(.numberPad)
#endif
    }

}

struct NumericFields_Previews: PreviewProvider {
    static var previews: some View {
        PercentageField(value: .constant(123.45))
            .padding()
            .previewLayout(.sizeThatFits)
    }
}

extension Double {
    var asPercentString: String {
        guard self != 0 else { return "" }
        return NumberFormatter.percentFormatter.string(for: self) ?? ""
    }
}

extension NumberFormatter {
    static var percentFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = Locale.current.groupingSeparator
        return formatter
    }
}
