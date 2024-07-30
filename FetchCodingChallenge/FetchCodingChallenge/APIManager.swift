import Foundation

protocol APIService {
    func fetchDesserts() async throws -> [Meal]
    func fetchMealDetail(by id: String) async throws -> MealDetail
}

class APIManager: APIService {
    private var dataFetcher: DataFetching

    init(dataFetcher: DataFetching = NetworkFetcher()) {
        self.dataFetcher = dataFetcher
    }

    func fetchDesserts() async throws -> [Meal] {
        let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")!
        let data = try await dataFetcher.download(url: url)
        let response = try JSONDecoder().decode(MealListResponse.self, from: data)
        return response.meals.filter { !$0.name.isEmpty }.sorted { $0.name < $1.name }
    }

    func fetchMealDetail(by id: String) async throws -> MealDetail {
        let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)")!
        let data = try await dataFetcher.download(url: url)
        let response = try JSONDecoder().decode(MealDetailResponse.self, from: data)
        guard let mealDetail = response.meals.first else {
            throw URLError(.badServerResponse)
        }
        return mealDetail
    }
}
