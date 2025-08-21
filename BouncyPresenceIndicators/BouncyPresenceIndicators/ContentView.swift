import SwiftUI
import BounceKit

struct ContentView: View {
    var body: some View {
        UserPresenceAvatarContainer()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(
                    colors: [Color(red: 0.1, green: 0.3, blue: 0.7), Color(red: 0.05, green: 0.15, blue: 0.4)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .padding(2)
    }
}

#Preview {
    ContentView()
}