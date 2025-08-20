import SwiftUI
import BounceKit

struct ContentView: View {
    var body: some View {
        UserPresenceAvatarContainer()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemBackground))
            .padding(2)
    }
}

#Preview {
    ContentView()
}