import SwiftUI

struct ShareView: View {

    @EnvironmentObject var vaxDataStore: VaxDataStore

    @State private var isSharePresented: Bool = false
    
    var body: some View {
#if !os(macOS)
        Button {
            self.isSharePresented = true
        } label: {
            HStack {
                Image(systemName: "square.and.arrow.up")
                    .foregroundColor(Color.white)
                Text("Share")
                    .foregroundColor(Color.white)
            }
        }
        .buttonStyle(ShrinkingButton(buttonDisposition: .dark))
        .sheet(isPresented: $isSharePresented, onDismiss: {
            print("Share Sheet Dismissed")
        }, content: {
            ActivityViewController(activityItems: [vaxDataStore.tweetText])
        })
#endif
    }

}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ShareView()
            .environmentObject(VaxDataStore())
    }
}
