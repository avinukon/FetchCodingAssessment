import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MealViewModel()
    @State private var selectedMeal: Meal?
    
    var body: some View {
        NavigationView {
            MealListView(meals: $viewModel.meals, selectedMeal: $selectedMeal)
                .navigationTitle("Desserts")
                .onAppear {
                    Task {
                        await viewModel.fetchDesserts()
                    }
                }
                .sheet(item: $selectedMeal) { meal in
                    MealDetailView(mealID: meal.id)
                        .presentationDetents([.large])
                        .presentationDragIndicator(.visible)
                        
                }
        }
    }
}

struct MealListView: View {
    @Binding var meals: [Meal]
    @Binding var selectedMeal: Meal?
    
    var body: some View {
        List(meals) { meal in
            Text(meal.name)
                .onTapGesture {
                    selectedMeal = meal
                }
        }
    }
}

#Preview {
    ContentView()
}
