import SwiftUI

public struct UserAvatarView: View {
    let avatarURL: String
    
    public init(avatarURL: String) {
        self.avatarURL = avatarURL
    }
    
    public var body: some View {
        AsyncImage(url: URL(string: avatarURL)) { phase in
            switch phase {
            case .empty:
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 75, height: 75)
                    .overlay(
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    )
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 75, height: 75)
                    .clipShape(Circle())
            case .failure(_):
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 75, height: 75)
                    .overlay(
                        Image(systemName: "person.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                    )
            @unknown default:
                EmptyView()
            }
        }
        .overlay(
            Circle()
                .stroke(Color.white, lineWidth: 3)
        )
        .shadow(radius: 5)
    }
}