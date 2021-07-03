import SwiftUI

struct TweetFromDataView: View {

    @EnvironmentObject var vaxDataStore: VaxDataStore
 
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 9, style: .continuous)
                .fill(Color.appBlue)
                .padding(8)

            Text(vaxDataStore.tweetText)
                .font(.system(size: 14, design: .monospaced))
                .foregroundColor(Color.white)
                .multilineTextAlignment(.leading)
                .padding(16)
                .contextMenu(ContextMenu(menuItems: {
                    Button("Copy", action: {
#if os(macOS)
                        let pasteboard = NSPasteboard.general
                        pasteboard.clearContents()
                        pasteboard.setString(vaxDataStore.tweetText, forType: .string)
#else
                        UIPasteboard.general.string = vaxDataStore.tweetText
#endif
                    })
                }))
        }
        .frame(maxWidth: .infinity, maxHeight: 400, alignment: .topLeading)
    }
}

struct TweetFromDataView_Previews: PreviewProvider {
    static var previews: some View {
        TweetFromDataView()
            .previewLayout(.sizeThatFits)
            .environmentObject(VaxDataStore())
    }
}
