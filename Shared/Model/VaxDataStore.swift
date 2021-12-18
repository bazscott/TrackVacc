import Foundation
import Combine

class VaxDataStore: ObservableObject {

    @Published var tweetText: String = "PROCESSING..."

    func generateFrom(data: VaxDataPacket) {
        showProcessingState()
        generateTweet(data: data)
    }

    static var percentFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.locale = Locale(identifier: "en_AU")
        formatter.roundingMode = .halfUp
        formatter.maximumFractionDigits = 1
        return formatter
    }

    static var intFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "en_AU")
        formatter.roundingMode = .halfUp
        formatter.maximumFractionDigits = 0
        return formatter
    }

}

private extension VaxDataStore {

    func showProcessingState() {
        tweetText = "PROCESSING..."
    }

    func showErrorState() {
        tweetText = "ERROR!"
    }

    // MARK: - Tweet

    func generateTweet(data: VaxDataPacket) {
        let squares = squares(data: data)
        let tweetString = """
        \(squares)

        🟢 \(data.thirdPc.asPercentage) 💉💉💉
        🟩 \(data.secondPc.asPercentage) 💉💉
        🟪 \(data.firstPc.asPercentage) 💉

        \(data.adultPc.asPercentage) of 12+

        💉📅 \(data.dosesToday.asStyled)
        """
        tweetText = tweetString
    }

    func squares(data: VaxDataPacket) -> String {
        let boostedSquares = Int(data.thirdPc)
        let fullySquares = Int(data.secondPc)
        let partiallySquares = Int(data.firstPc)
        let blankSquares: Int = 85 - boostedSquares - fullySquares - partiallySquares
        let childSquares: Int = 15

        var outputString = ""
        var countSquares = 1

        for _ in 1...boostedSquares {
            if countSquares == 11 { outputString += "\n"; countSquares = 1 }
            outputString += "🟢"
            countSquares += 1
        }
        for _ in 1...fullySquares {
            if countSquares == 11 { outputString += "\n"; countSquares = 1 }
            outputString += "🟩"
            countSquares += 1
        }
        for _ in 1...partiallySquares {
            if countSquares == 11 { outputString += "\n"; countSquares = 1 }
            outputString += "🟪"
            countSquares += 1
        }
        for _ in 1...blankSquares {
            if countSquares == 11 { outputString += "\n"; countSquares = 1 }
            outputString += "⬜️"
            countSquares += 1
        }
        for _ in 1...childSquares {
            if countSquares == 11 { outputString += "\n"; countSquares = 1 }
            outputString += "◻️"
            countSquares += 1
        }

        return outputString
    }

}

extension Double {
    var asPercentage: String {
        VaxDataStore.percentFormatter.string(from: NSNumber(value: self / 100)) ?? "n/a"
    }
}

extension Int {
    var asStyled: String {
        VaxDataStore.intFormatter.string(from: NSNumber(value: self)) ?? "n/a"
    }
}
