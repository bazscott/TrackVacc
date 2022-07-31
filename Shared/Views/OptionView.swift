import SwiftUI

struct OptionView: View {

    @EnvironmentObject var vaxDataStore: VaxDataStore

    @State private var firstPc: Double = 0
    @State private var secondPc: Double = 0
    @State private var thirdPc: Double = 0
    @State private var fourthPc: Double = 0
    @State private var thirdEligiblePc: Double = 0
    @State private var dosesToday: Int = 0

    @State var tweetFromDataIsPresented: Bool = false
    
    var body: some View {
        ZStack {
            Color.appGreen
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Text("Vax Tweet Generator")
                    .font(.system(size: 24, design: .monospaced))
                    .foregroundColor(Color.appYellow)
                    .multilineTextAlignment(.leading)
                    .padding([.top, .leading, .trailing])

                HStack {
                    PercentageField(value: $firstPc)
                        .frame(width: 150)
                    Text("% First")
                        .font(.system(size: 24, design: .monospaced))
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding([.top, .leading, .trailing])

                HStack {
                    PercentageField(value: $secondPc)
                        .frame(width: 150)
                    Text("% Second")
                        .font(.system(size: 24, design: .monospaced))
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding([.top, .leading, .trailing])

                HStack {
                    PercentageField(value: $thirdPc)
                        .frame(width: 150)
                    Text("% Third")
                        .font(.system(size: 24, design: .monospaced))
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding([.top, .leading, .trailing])

                HStack {
                    PercentageField(value: $fourthPc)
                        .frame(width: 150)
                    Text("% Fourth")
                        .font(.system(size: 24, design: .monospaced))
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding([.top, .leading, .trailing])

                HStack {
                    PercentageField(value: $thirdEligiblePc)
                        .frame(width: 150)
                    Text("% Third Eligible")
                        .font(.system(size: 24, design: .monospaced))
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding([.top, .leading, .trailing])

                Button("Generate") {
                    let data = VaxDataPacket(firstPc: firstPc,
                                             secondPc: secondPc,
                                             thirdPc: thirdPc,
                                             fourthPc: fourthPc,
                                             thirdEligiblePc: thirdEligiblePc)
                    vaxDataStore.generateFrom(data: data)
                    tweetFromDataIsPresented = true
                }
                .buttonStyle(ShrinkingButton(buttonDisposition: .neutral))
                .sheet(isPresented: $tweetFromDataIsPresented) {
                    TweetFromDataContainer(isPresented: $tweetFromDataIsPresented)
                }

                Spacer()
            }
        }
    }
}

struct OptionView_Previews: PreviewProvider {
    static var previews: some View {
        OptionView()
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .environmentObject(VaxDataStore())
    }
}
