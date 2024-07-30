import Foundation

@MainActor
class MealViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var selectedMeal: MealDetail?
    @Published var errorMessage: String?
    
    private let apiService: APIService

    init(apiService: APIService = APIManager()) {
        self.apiService = apiService
    }
    
    func fetchDesserts() async {
        do {
            let meals = try await apiService.fetchDesserts()
            self.meals = meals
        } catch {
            errorMessage = "Failed to fetch desserts: \(error.localizedDescription)"
            print("Error fetching desserts: \(error)")
        }
    }
    
    func fetchMealDetail(by id: String) async {
        do {
            let mealDetail = try await apiService.fetchMealDetail(by: id)
            self.selectedMeal = mealDetail
        } catch {
            errorMessage = "Failed to fetch meal detail: \(error.localizedDescription)"
            print("Error fetching meal detail: \(error)")
        }
    }
}
