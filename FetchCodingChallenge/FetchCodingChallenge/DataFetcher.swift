import Foundation

protocol DataFetching {
    func download(url: URL) async throws -> Data
}

class NetworkFetcher: DataFetching {
    func download(url: URL) async throws -> Data {
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}
