//
//  CategoryListViewModelTests.swift
//  brain-marksTests
//
//  Created by Andrew Erickson on 2022-05-14.
//

import XCTest
@testable import brain_marks

class CategoryListViewModelTests: XCTestCase {

    var viewModel: CategoryListViewModel!
    var mockDataStoreManager: MockDataStoreManager!

    override func setUp() async throws {
        viewModel = CategoryListViewModel()
        self.mockDataStoreManager = MockDataStoreManager()
        viewModel.dataStoreManager = mockDataStoreManager
    }

    func test_getCategories_twoSaved() {
        // Given
        mockDataStoreManager.categoriesResult = .success(multipleCategories)
        let expectation = expectation(description: "Wait for categories to update")
        
        // When
        viewModel.getCategories(completion: {
            expectation.fulfill()
        })
        waitForExpectations(timeout: 0.5)

        // Then
        XCTAssertEqual(viewModel.categories.count, 2)
        XCTAssertEqual(viewModel.categories.first?.name, "Games")
    }

    func test_getCategories_noneSaved() {
        // Given
        mockDataStoreManager.categoriesResult = .success([])

        // When
        viewModel.getCategories()

        // Then
        XCTAssertEqual(viewModel.categories.count, 0)
    }

    func test_getCategories_failure() {
        // Given
        mockDataStoreManager.categoriesResult = .failure(ExampleError.serverError)

        // When
        viewModel.getCategories()

        // Then
        XCTAssertEqual(viewModel.categories.count, 0)
    }

    func test_confirmDelete() {
        // Given
        let toDelete = IndexSet(integer: 0)

        // When
        viewModel.confirmDelete(at: toDelete)

        // Then
        XCTAssertTrue(viewModel.showingDeleteActionSheet)
        XCTAssertEqual(viewModel.indexSetToDelete, toDelete)
    }

    func test_deleteCategory_notConfirmed() {
        // Given
        viewModel.categories = multipleCategories
        let categoryCountBeforeDelete = viewModel.categories.count
        viewModel.indexSetToDelete = nil

        // When
        viewModel.deleteCategory()

        // Then
        // nothing should be deleted
        XCTAssertEqual(viewModel.categories.count, categoryCountBeforeDelete)
    }

    func test_deleteCategory_deleteFirst() {
        // Given
        viewModel.categories = multipleCategories
        let categoryCountBeforeDelete = viewModel.categories.count
        let categoryIndexToDelete = 0
        let categoryIdToDelete = viewModel.categories[categoryIndexToDelete].id
        viewModel.indexSetToDelete = IndexSet(integer: categoryIndexToDelete)

        // When
        viewModel.deleteCategory()

        // Then
        // there should be one less category
        XCTAssertEqual(viewModel.categories.count, categoryCountBeforeDelete - 1)
        // the deleted category should no longer exist
        XCTAssertEqual(viewModel.categories.filter { $0.id == categoryIdToDelete }.count, 0)
    }

    func test_refreshLastEditedCategory_noLastEditedCategory() {
        // Given
        viewModel.lastEditedCategoryID = ""

        // When
        viewModel.refreshLastEditedCategory()

        // Then
        XCTAssertEqual(mockDataStoreManager.fetchSingleCategoryCallCount, 0)
        XCTAssertEqual(viewModel.editCategory, nil)
    }

    func test_refreshLastEditedCategory_hasLastEditedCategory() {
        // Given
        viewModel.lastEditedCategoryID = "1"
        mockDataStoreManager.singleCategoryResult = .success(gamesCategory)

        // When
        viewModel.refreshLastEditedCategory()

        // Then
        XCTAssertEqual(mockDataStoreManager.fetchSingleCategoryCallCount, 1)
        XCTAssertEqual(viewModel.editCategory, gamesCategory)
    }

    func test_refreshLastEditedCategory_failure() {
        // Given
        viewModel.lastEditedCategoryID = "1"
        mockDataStoreManager.singleCategoryResult = .failure(ExampleError.serverError)

        // When
        viewModel.refreshLastEditedCategory()

        // Then
        XCTAssertEqual(mockDataStoreManager.fetchSingleCategoryCallCount, 1)
        XCTAssertEqual(viewModel.editCategory, nil)

    }

    func test_didTapAddCategory() {
        // Given

        // When
        viewModel.didTapAddCategory()

        // Then
        XCTAssertEqual(viewModel.categorySheetState, .new)
        XCTAssertEqual(viewModel.showingCategorySheet, true)
    }

    func test_didTapEdit() {
        // Given
        let categoryToEdit = iOSCategory

        // When
        viewModel.didTapEdit(categoryToEdit)

        // Then
        XCTAssertEqual(viewModel.editCategory, categoryToEdit)
        XCTAssertEqual(viewModel.categorySheetState, .edit)
        XCTAssertEqual(viewModel.showingCategorySheet, true)
    }
}

// Reusable test data

extension CategoryListViewModelTests {
    var gamesCategory: AWSCategory {
        AWSCategory(
            id: "1",
            name: "Games",
            imageName: "controller"
        )
    }

    var iOSCategory: AWSCategory {
        AWSCategory(
            id: "2",
            name: "iOS",
            imageName: "computer"
        )
    }

    var multipleCategories: [AWSCategory] {
        [gamesCategory, iOSCategory]
    }

    enum ExampleError: Error {
        case serverError
    }
}
