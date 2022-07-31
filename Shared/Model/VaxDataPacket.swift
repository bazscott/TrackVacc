import Foundation

struct VaxDataPacket {
    let firstPc: Double
    let secondPc: Double
    let thirdPc: Double
    let fourthPc: Double
    let childrenPc: Double = 5
    let thirdEligiblePc: Double

    var nonePc: Double { 100.00 - (firstPc + secondPc + thirdPc + fourthPc) }
}

// MARK: - CustomStringConvertible

extension VaxDataPacket: CustomStringConvertible {
    var description: String {
        """

        ===================================================
        VaxDataPacket
        ---------------------------------------------------
        None %:             \(nonePc.asPercentage)
        First %:            \(firstPc.asPercentage)
        Second %:           \(secondPc.asPercentage)
        Third %:            \(thirdPc.asPercentage)
        Fourth %:           \(fourthPc.asPercentage)
        Third Eligible %:   \(thirdEligiblePc.asPercentage)
        ===================================================

        """
    }
}
