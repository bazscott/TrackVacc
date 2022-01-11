import Foundation

struct VaxDataPacket {
    let firstPc: Double
    let secondPc: Double
    let thirdPc: Double
    let boosterEligiblePc: Double
    let dosesToday: Int

    var description: String {
        """

        ===================================================
        VaxDataPacket
        ---------------------------------------------------
        First %:            \(firstPc.asPercentage)
        Second %:           \(secondPc.asPercentage)
        Third %:            \(secondPc.asPercentage)
        Booster Eligible %: \(boosterEligiblePc.asPercentage)
        Doses Today:        \(dosesToday.asStyled)
        ===================================================

        """
    }

}
