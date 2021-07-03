import SwiftUI

struct ShrinkingButton: ButtonStyle {

    var buttonDisposition: AppButtonDisposition

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 24, design: .monospaced))
            .frame(maxWidth: .infinity)
            .padding()
            .background(buttonDisposition.backgroundColor)
            .foregroundColor(buttonDisposition.foregroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .padding()
    }
}
