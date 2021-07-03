import SwiftUI

@main
struct TrackVaccApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(VaxDataStore())
        }
    }
}
