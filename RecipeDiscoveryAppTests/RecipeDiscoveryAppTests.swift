import XCTest
@testable import RecipeDiscoveryApp

final class RecipeListViewModelTests: XCTestCase {

    var viewModel: RecipeListViewModel!
    var mockRepository: MockRecipeRepository!

    override func setUp() {
        super.setUp()
        mockRepository = MockRecipeRepository()
        viewModel = RecipeListViewModel(repository: mockRepository)
    }

    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        super.tearDown()
    }

    @MainActor func testFetchRecipes_success() async {
        mockRepository.mockRecipes = [
            Recipe(
                id: 1,
                name: "Pasta",
                ingredients: ["Noodles", "Tomato Sauce"],
                instructions: ["Boil noodles", "Add sauce"],
                prepTimeMinutes: 10,
                cookTimeMinutes: 15,
                difficulty: "Easy",
                cuisine: "Italian",
                caloriesPerServing: 300,
                rating: 4.5,
                servings: 2,
                reviewCount: 25,
                image: "pasta.jpg",
                tags: ["Vegetarian"]
            ),
            Recipe(
                id: 2,
                name: "Pizza",
                ingredients: ["Dough", "Cheese", "Tomato"],
                instructions: ["Bake base", "Add toppings"],
                prepTimeMinutes: 15,
                cookTimeMinutes: 20,
                difficulty: "Medium",
                cuisine: "Italian",
                caloriesPerServing: 500,
                rating: 4.7,
                servings: 4,
                reviewCount: 45,
                image: "pizza.jpg",
                tags: ["Cheesy", "Popular"]
            )
        ]

        await viewModel.fetchRecipes()
        let recipesCount = viewModel.recipes.count
        let firstRecipeName = viewModel.recipes.first?.name
        XCTAssertEqual(recipesCount, 30)
        XCTAssertEqual(firstRecipeName, "Classic Margherita Pizza")
    }

    @MainActor func testToggleFavorite_addsRecipeToFavorites() {
        let recipe = Recipe(
            id: 1,
            name: "Burger",
            ingredients: ["Bun", "Patty", "Cheese"],
            instructions: ["Grill patty", "Assemble burger"],
            prepTimeMinutes: 10,
            cookTimeMinutes: 10,
            difficulty: "Easy",
            cuisine: "American",
            caloriesPerServing: 600,
            rating: 4.2,
            servings: 1,
            reviewCount: 30,
            image: "burger.jpg",
            tags: ["Fast Food"]
        )

        viewModel.toggleFavorite(recipe)
        XCTAssertTrue(viewModel.isFavorite(recipe))
        XCTAssertEqual(mockRepository.savedFavorites.count, 1)
    }

    @MainActor func testToggleFavorite_removesRecipeFromFavorites() {
        let recipe = Recipe(
            id: 1,
            name: "Burger",
            ingredients: ["Bun", "Patty", "Cheese"],
            instructions: ["Grill patty", "Assemble burger"],
            prepTimeMinutes: 10,
            cookTimeMinutes: 10,
            difficulty: "Easy",
            cuisine: "American",
            caloriesPerServing: 600,
            rating: 4.2,
            servings: 1,
            reviewCount: 30,
            image: "burger.jpg",
            tags: ["Fast Food"]
        )

        viewModel.toggleFavorite(recipe) // Add
        viewModel.toggleFavorite(recipe) // Remove
   
        XCTAssertFalse(viewModel.isFavorite(recipe))
        XCTAssertTrue(mockRepository.removedFavorites.contains(where: { $0.id == recipe.id }))
    }
}

