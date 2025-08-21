import Combine
import SwiftUI

public struct UserPresenceAvatarContainer: View {
    @StateObject private var viewModel = ViewModel()

    public init() {}

    @ViewBuilder private func userView(for user: User) -> some View {
        VStack(spacing: 8) {
            UserAvatarView(imageName: user.imageName)
            Text(user.name)
                .font(.system(size: 14))
                .foregroundColor(.white)
        }
        .id(user.id)
    }

    public var body: some View {
        VStack {
            HStack(spacing: 8) {
                ForEach(viewModel.users) { user in
                    userView(for: user)
                        .transition(.asymmetric(
                            insertion: .move(edge: .top).combined(with: .opacity),
                            removal: .opacity
                        ))
                }
            }
            .animation(.spring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.25), value: viewModel.users)
            .padding(.horizontal)
            .frame(height: 100)
            .padding(.top, 50)

            Spacer()

            HStack(spacing: 40) {
                Button {
                    viewModel.removeUser()
                } label: {
                    Image(systemName: "minus.circle.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.red)
                }
                .disabled(viewModel.users.isEmpty)

                Button {
                    viewModel.addUser()
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.green)
                }
                .disabled(viewModel.cachedUsers.isEmpty || viewModel.users.count >= 4)
            }

            Spacer()
        }
    }
}

public extension UserPresenceAvatarContainer {
    @MainActor
    class ViewModel: ObservableObject {
        @Published public var users: [User] = []
        @Published public var cachedUsers: [User] = []

        public init() {
            // Preload all 10 user images with names
            let names = ["Alex", "Sam", "Jordan", "Taylor", "Morgan", "Casey", "Riley", "Avery", "Quinn", "Drew"]
            cachedUsers = (1 ... 10).map { index in
                User(imageName: "user_\(index)", name: names[index - 1])
            }
        }

        public func addUser() {
            guard !cachedUsers.isEmpty && users.count < 4 else { return }
            let user = cachedUsers.removeFirst()
            users.insert(user, at: 0)
        }

        public func removeUser() {
            guard !users.isEmpty else { return }
            if let randomUser = users.randomElement() {
                users.removeAll { $0.id == randomUser.id }
            }
        }
    }
}
