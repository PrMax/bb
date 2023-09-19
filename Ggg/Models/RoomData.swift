


import Foundation

struct RoomData: Codable {
    let rooms: [BRoom]
}

struct BRoom: Codable, Identifiable {
    let id: Int
    let name: String
    let price: Int
    let price_per: String
    let peculiarities: [String]
    let image_urls: [String]
}

