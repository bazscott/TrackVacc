import SwiftUI

struct TweetFromDataContainer: View {

    @EnvironmentObject var vaxDataStore: VaxDataStore
    @Binding var isPresented: Bool

    var body: some View {
        ZStack {
            Color.appGreen
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)

            VStack {
                TweetFromDataView()

                ShareView()

                Spacer()

                Button("Close") {
                    isPresented = false
                }
                .buttonStyle(ShrinkingButton(buttonDisposition: .negative))
            }
        }
        .frame(minWidth: 300, idealWidth: 400, maxWidth: .infinity, minHeight: 400, idealHeight: 500, maxHeight: .infinity, alignment: .center)
    }
}

struct TweetFromDataContainer_Previews: PreviewProvider {
    static var previews: some View {
        TweetFromDataContainer(isPresented: .constant(true))
            .environmentObject(VaxDataStore())
    }
}
