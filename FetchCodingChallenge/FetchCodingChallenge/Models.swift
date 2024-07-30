
import Foundation


struct MealListResponse: Decodable {
    let meals: [Meal]
}

struct Meal: Decodable, Identifiable {
    let id: String
    let name: String
    let thumbnail: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case thumbnail = "strMealThumb"
    }
}

struct MealDetailResponse: Decodable {
    let meals: [MealDetail]
}


struct MealDetail: Decodable {
    let id: String
    let name: String
    let instructions: String
    let ingredients: [String]
    let measurements: [String]
    let thumbnail: String
    let strYoutube: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case instructions = "strInstructions"
        case thumbnail = "strMealThumb"
        case strYoutube = "strYoutube"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        instructions = try container.decode(String.self, forKey: .instructions)
        thumbnail = try container.decode(String.self, forKey: .thumbnail)
        strYoutube = try container.decode(String.self, forKey: .strYoutube)
        
        let dynamicContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)
        
        var tempIngredients = [String]()
        var tempMeasurements = [String]()
        
        for i in 1...20 {
            if let ingredientKey = DynamicCodingKeys(stringValue: "strIngredient\(i)"),
               let measurementKey = DynamicCodingKeys(stringValue: "strMeasure\(i)") {
                
                if let ingredient = try dynamicContainer.decodeIfPresent(String.self, forKey: ingredientKey),
                   !ingredient.isEmpty {
                    tempIngredients.append(ingredient)
                    if let measurement = try dynamicContainer.decodeIfPresent(String.self, forKey: measurementKey),
                       !measurement.isEmpty {
                        tempMeasurements.append(measurement)
                    } else {
                        tempMeasurements.append("")
                    }
                }
            }
        }
        
        ingredients = tempIngredients
        measurements = tempMeasurements
    }
}

struct DynamicCodingKeys: CodingKey {
    var stringValue: String
    var intValue: Int?
    
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    init?(intValue: Int) {
        self.stringValue = "\(intValue)"
        self.intValue = intValue
    }
}

