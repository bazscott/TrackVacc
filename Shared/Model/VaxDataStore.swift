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
        formatter.roundingMode = .down
        formatter.maximumFractionDigits = 1
        return formatter
    }

    static var percentFormatterNoFractions: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.locale = Locale(identifier: "en_AU")
        formatter.roundingMode = .down
        formatter.maximumFractionDigits = 0
        return formatter
    }

    static var intFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "en_AU")
        formatter.roundingMode = .down
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

        3🟢 \(data.thirdPc.asPercentage) (\(data.boosterEligiblePc.asPercentageNoFractions) eligible)
        2🟩 \(data.secondPc.asPercentage)
        1🟪 \(data.firstPc.asPercentage)
        0⬜️ \(data.nonePc.asPercentage)

        📅 \(data.dosesToday.asStyled)
        """
        tweetText = tweetString
    }

    func squares(data: VaxDataPacket) -> String {
        // These are ordered so people moving right to left from one category to the next over time.
        // Said another way, an entry will only increase due to a proportional decrease in the next
        // entry. This means that a cumulative sum of these values should cancel out those changes,
        // and each entry should only ever increase in value over time. From this we can see that if
        // any of the values in the cumulative sum exceed the threshold to be rounded to the next
        // integer, it will never be rounded down again.
        // The difference between adjacent entries in the cumulative sum will only ever increase, and
        // so represents a count of that category which will only ever increase.
        //
        // The ideal maximum rounding 'error' in this count is `0.5`, ie. to the nearest integer.
        // As we are summing the unrounded values, we should only get rounding errors from
        // the sum error of those adjacent values. The worst case scenario then would be something
        // like `1.499` and `5.02` being rounded to `1` and `6`. From this we see that the
        // maximim error approaches `1`. We would prefer `0.5`, but we've gained the useful visual
        // communication property of monoticity. The sums will never decrease due to rounding.
        let symbols = ["🟢", "🟩", "🟪", "◻️"]
        let percentages = [data.thirdPc, data.secondPc, data.firstPc, data.childrenPc]

        var sumCount = 0
        var sumPercent = 0.0
        var displayCount: [(String, Int)] = []
        for (symbol, percent) in zip(symbols, percentages) {
            sumPercent += percent
            let count = Int(sumPercent.rounded()) - sumCount
            sumCount += count
            displayCount.append((symbol, count))
        }
        displayCount.append(("⬜️", 100 - sumCount))

        let displayOrder = ["🟢", "🟩", "🟪", "⬜️", "◻️"]
        displayCount.sort { lhs, rhs in
            displayOrder.firstIndex(of: lhs.0) ?? 0 < displayOrder.firstIndex(of: rhs.0) ?? 0
        }

        var outputString = ""
        var countSquares = 0
        for (symbol, count) in displayCount {
            for _ in 0..<count {
                if countSquares == 10 { outputString += "\n"; countSquares = 0 }
                outputString += symbol
                countSquares += 1
            }
        }

        return outputString
    }

}

extension Double {
    var asPercentage: String {
        VaxDataStore.percentFormatter.string(from: NSNumber(value: self / 100)) ?? "n/a"
    }

    var asPercentageNoFractions: String {
        VaxDataStore.percentFormatterNoFractions.string(from: NSNumber(value: self / 100)) ?? "n/a"
    }
}

extension Int {
    var asStyled: String {
        VaxDataStore.intFormatter.string(from: NSNumber(value: self)) ?? "n/a"
    }
}
