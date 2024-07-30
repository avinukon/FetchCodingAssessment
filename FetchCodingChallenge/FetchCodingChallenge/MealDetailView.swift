import SwiftUI

struct MealDetailView: View {
    let mealID: String
    @StateObject private var viewModel = MealViewModel()
    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(spacing: 0) {
                if let meal = viewModel.selectedMeal, let url = URL(string: meal.thumbnail) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 300)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                            .frame(height: 300)
                    }
                } else {
                    Color.gray
                        .frame(height: 300)
                }
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        if let meal = viewModel.selectedMeal {
                            MealInfoView(name: meal.name)
                            IngredientsView(ingredients: meal.ingredients, measurements: meal.measurements)
                            InstructionsView(instructions: meal.instructions)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .clipShape(
                        UnevenRoundedRectangle(topLeadingRadius: 20, topTrailingRadius: 20)
                    )
                }
                .scrollIndicators(.hidden)
            }
            
            UpperButtonsView(
                dismiss: dismiss,
                youtubeURLString: viewModel.selectedMeal?.strYoutube,
                openURL: openURL
            )
        }
        .ignoresSafeArea(edges: .top)
        .onAppear {
            Task {
                await viewModel.fetchMealDetail(by: mealID)
            }
        }
    }
}

struct MealInfoView: View {
    let name: String
    
    var body: some View {
        Text(name)
            .font(.system(.title2, design: .rounded))
            .fontWeight(.bold)
            .lineLimit(1)
            .minimumScaleFactor(0.5)
            .padding(.leading, 5)
    }
}

struct IngredientsView: View {
    let ingredients: [String]
    let measurements: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Ingredients: ")
                .font(.headline)
                .foregroundStyle(.black)
            
            ForEach(Array(zip(ingredients, measurements)), id: \.0) { ingredient, measurement in
                Text("• \(measurement) \(ingredient)")
                    .font(.subheadline)
                    .foregroundStyle(.black.opacity(0.8))
            }
            .padding(.leading, 3)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
        )
    }
}

struct InstructionsView: View {
    let instructions: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Instructions: ")
                .font(.headline)
                .foregroundStyle(.black)
            
            ForEach(instructions.split(separator: "."), id: \.self) { sentence in
                HStack(alignment: .top) {
                    Text("•")
                        .font(.subheadline)
                        .foregroundStyle(.black.opacity(0.8))
                    Text(sentence.trimmingCharacters(in: .whitespacesAndNewlines))
                        .font(.subheadline)
                        .foregroundStyle(.black.opacity(0.8))
                        .padding(.leading, 3)
                }
                .padding(.bottom, 2)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
        )
    }
}

struct UpperButtonsView: View {
    let dismiss: DismissAction
    let youtubeURLString: String?
    let openURL: OpenURLAction
    
    var body: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(.black)
                    .padding(10)
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(radius: 3)
            }
            
            Spacer()
            
            if let youtubeURLString = youtubeURLString, let youtubeURL = URL(string: youtubeURLString) {
                Button {
                    openURL(youtubeURL)
                } label: {
                    Image(systemName: "video")
                        .foregroundColor(.black)
                        .padding(10)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(radius: 3)
                }
            }
        }
        .padding(.top, 16)
        .padding(.horizontal, 16)
    }
}
