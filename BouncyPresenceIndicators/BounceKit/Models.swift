import Foundation

public struct User: Identifiable, Equatable {
    public let id = UUID()
    public let imageName: String
    public let name: String
    public let timestamp = Date()
    public let index: Int = 2
    
    public init(imageName: String, name: String) {
        self.imageName = imageName
        self.name = name
    }
}
