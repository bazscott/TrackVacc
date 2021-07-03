import Foundation

struct VaxDataPacket {
    let firstPc: Double
    let secondPc: Double
    let thirdPc: Double
    let adultPc: Double
    let dosesToday: Int

    var description: String {
        """

        ===================================================
        VaxDataPacket
        ---------------------------------------------------
        First %:      \(firstPc.asPercentage)
        Second %:     \(secondPc.asPercentage)
        Third %:      \(secondPc.asPercentage)
        Adult %:      \(adultPc.asPercentage)
        Doses Today:  \(dosesToday.asStyled)
        ===================================================

        """
    }

}
