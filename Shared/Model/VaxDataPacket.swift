import Foundation

struct VaxDataPacket {
    let firstPc: Double
    let secondPc: Double
    let thirdPc: Double
    let boosterEligiblePc: Double
    let dosesToday: Int
    let childrenPc: Double = 5

    var nonePc: Double { 100.00 - (firstPc + secondPc + thirdPc) }
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
        Third %:            \(secondPc.asPercentage)
        Booster Eligible %: \(boosterEligiblePc.asPercentage)
        Doses Today:        \(dosesToday.asStyled)
        ===================================================

        """
    }
}
