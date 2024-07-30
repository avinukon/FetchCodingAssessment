//import Foundation
//import XCTest
//@testable import FetchCodingChallenge
//


//USER TESTING


//class MockDataFetcher: DataFetching {
//    var mockData: Data?
//    var shouldThrowError = false
//    
//    func download(url: URL) async throws -> Data {
//        if shouldThrowError {
//            throw URLError(.badServerResponse)
//        }
//        guard let data = mockData else {
//            throw URLError(.badServerResponse)
//        }
//        return data
//    }
//}
//
//
//final class APIManagerTests: XCTestCase {
//    var apiManager: APIManager!
//    var mockDataFetcher: MockDataFetcher!
//    
//    override func setUp() {
//        super.setUp()
//        mockDataFetcher = MockDataFetcher()
//        apiManager = APIManager(dataFetcher: mockDataFetcher)
//    }
//    
//    override func tearDown() {
//        apiManager = nil
//        mockDataFetcher = nil
//        super.tearDown()
//    }
//    
//    func testFetchDesserts() async throws {
//        let jsonData = """
//        {
//            "meals": [
//                {
//                    "idMeal": "53049",
//                    "strMeal": "Apam balik",
//                    "strMealThumb": "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg"
//                }
//            ]
//        }
//        """.data(using: .utf8)!
//        
//        mockDataFetcher.mockData = jsonData
//        
//        let meals = try await apiManager.fetchDesserts()
//        
//        XCTAssertEqual(meals.count, 1)
//        XCTAssertEqual(meals.first?.id, "53049")
//        XCTAssertEqual(meals.first?.name, "Apam balik")
//        XCTAssertEqual(meals.first?.thumbnail, "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")
//    }
//    
//    func testFetchMealDetail() async throws {
//        let jsonData = """
//        {
//            "meals": [
//                {
//                    "idMeal": "53049",
//                    "strMeal": "Apam balik",
//                    "strInstructions": "Mix all the ingredients",
//                    "strMealThumb": "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg",
//                    "strIngredient1": "Flour",
//                    "strIngredient2": "Sugar",
//                    "strMeasure1": "2 cups",
//                    "strMeasure2": "1 cup"
//                }
//            ]
//        }
//        """.data(using: .utf8)!
//        
//        mockDataFetcher.mockData = jsonData
//        
//        let mealDetail = try await apiManager.fetchMealDetail(by: "53049")
//        
//        XCTAssertEqual(mealDetail.id, "53049")
//        XCTAssertEqual(mealDetail.name, "Apam balik")
//        XCTAssertEqual(mealDetail.instructions, "Mix all the ingredients")
//        XCTAssertEqual(mealDetail.thumbnail, "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")
//        XCTAssertEqual(mealDetail.ingredients, ["Flour", "Sugar"])
//        XCTAssertEqual(mealDetail.measurements, ["2 cups", "1 cup"])
//    }
//    
//    func testFetchDessertsThrowsError() async {
//        mockDataFetcher.shouldThrowError = true
//        
//        do {
//            _ = try await apiManager.fetchDesserts()
//            XCTFail("Expected error not thrown")
//        } catch {
//            XCTAssertEqual(error as? URLError, URLError(.badServerResponse))
//        }
//    }
//    
//    func testFetchMealDetailThrowsError() async {
//        mockDataFetcher.shouldThrowError = true
//        
//        do {
//            _ = try await apiManager.fetchMealDetail(by: "53049")
//            XCTFail("Expected error not thrown")
//        } catch {
//            XCTAssertEqual(error as? URLError, URLError(.badServerResponse))
//        }
//    }
//}
