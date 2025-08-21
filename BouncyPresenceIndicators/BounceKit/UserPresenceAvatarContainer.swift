import Combine
import SwiftUI

// MARK: - Codable Models for RandomUser API

struct RandomUserResponse: Codable {
    let results: [RandomUserResult]
}

struct RandomUserResult: Codable {
    let picture: Picture
}

struct Picture: Codable {
    let large: String
}

public struct UserPresenceAvatarContainer: View {
    @StateObject private var viewModel = ViewModel()

    public init() {}

    public var body: some View {
        VStack {
            HStack(spacing: 8) {
                ForEach(viewModel.users) { user in
                    UserAvatarView(avatarURL: user.avatarURL)
                        .transition(.asymmetric(
                            insertion: .move(edge: .top).combined(with: .opacity),
                            removal: .opacity
                        ))
                }
            }
            .animation(.spring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.25), value: viewModel.users.count)
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
                .disabled(viewModel.cachedUsers.isEmpty)
            }

            Spacer()
        }
        .task {
            await viewModel.preloadUsers()
        }
    }
}

public extension UserPresenceAvatarContainer {
    @MainActor
    class ViewModel: ObservableObject {
        @Published public var users: [User] = []
        @Published public var cachedUsers: [User] = []

        public func preloadUsers() async {
            // Fetch 10 users and cache them
            var newCachedUsers: [User] = []

            for _ in 0 ..< 10 {
                do {
                    let url = URL(string: "https://randomuser.me/api/")!
                    let (data, _) = try await URLSession.shared.data(from: url)

                    let response = try JSONDecoder().decode(RandomUserResponse.self, from: data)
                    if let firstResult = response.results.first {
                        let newUser = User(avatarURL: firstResult.picture.large)
                        newCachedUsers.append(newUser)
                    }
                } catch {
                    print("Error fetching user: \(error)")
                }
            }

            cachedUsers = newCachedUsers
        }

        public func addUser() {
            guard !cachedUsers.isEmpty else { return }
            let user = cachedUsers.removeFirst()
            users.append(user)
        }

        public func removeUser() {
            guard !users.isEmpty else { return }
            if let randomUser = users.randomElement() {
                users.removeAll { $0.id == randomUser.id }
            }
        }
    }
}
