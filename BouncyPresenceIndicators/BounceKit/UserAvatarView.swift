import SwiftUI

public struct UserAvatarView: View {
    let imageName: String
    
    public init(imageName: String) {
        self.imageName = imageName
    }
    
    public var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 75, height: 75)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color.white, lineWidth: 3)
            )
            .shadow(radius: 5)
    }
}
