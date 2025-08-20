import Foundation

public struct User: Identifiable {
    public let id = UUID()
    public let avatarURL: String
    public let timestamp = Date()
    public let index: Int = 2
    
    public init(avatarURL: String) {
        self.avatarURL = avatarURL
    }
}
