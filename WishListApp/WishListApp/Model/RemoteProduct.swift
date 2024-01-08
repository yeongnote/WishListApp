import Foundation


struct RemoteProduct: Decodable {
    let id: Int64
    let title: String
    let price: Double
    let description: String
    let thumbnail: URL
}
