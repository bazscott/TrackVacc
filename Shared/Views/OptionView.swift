import SwiftUI

struct OptionView: View {

    @EnvironmentObject var vaxDataStore: VaxDataStore

    @State private var firstPc: Double = 0
    @State private var secondPc: Double = 0
    @State private var thirdPc: Double = 0
    @State private var adultPc: Double = 0
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
                    Text("% Partial")
                        .font(.system(size: 24, design: .monospaced))
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding([.top, .leading, .trailing])

                HStack {
                    PercentageField(value: $secondPc)
                        .frame(width: 150)
                    Text("% Full")
                        .font(.system(size: 24, design: .monospaced))
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding([.top, .leading, .trailing])

                HStack {
                    PercentageField(value: $thirdPc)
                        .frame(width: 150)
                    Text("% Boosted")
                        .font(.system(size: 24, design: .monospaced))
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding([.top, .leading, .trailing])

                HStack {
                    PercentageField(value: $adultPc)
                        .frame(width: 150)
                    Text("% 12+ Full")
                        .font(.system(size: 24, design: .monospaced))
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding([.top, .leading, .trailing])

                HStack {
                    IntField(int: $dosesToday)
                        .frame(width: 150)
                    Text("Doses today")
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
                                             adultPc: adultPc,
                                             dosesToday: dosesToday)
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
