import SwiftUI

extension Color {
    static let appRed = Color("App Red")
    static let appGreen = Color("App Green")
    static let appBlue = Color("App Blue")
    static let appYellow = Color("App Yellow")
}

enum AppButtonDisposition {
    case positive, negative, neutral, dark

    var backgroundColor: Color {
        switch self {
            case .positive:
                return Color.appGreen
            case .negative:
                return Color.appRed
            case .neutral:
                return Color.appYellow
            case .dark:
                return Color.appBlue
        }
    }

    var foregroundColor: Color {
        switch self {
            case .positive:
                return Color.white
            case .negative:
                return Color.white
            case .neutral:
                return Color.black
            case .dark:
                return Color.white
        }
    }
}
