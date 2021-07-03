import SwiftUI

struct ContentView: View {
    @EnvironmentObject var vaxDataStore: VaxDataStore

    var body: some View {
        ZStack {
            Color.appGreen
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)

            VStack {
                OptionView()
                Spacer()
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(VaxDataStore())
    }
}
