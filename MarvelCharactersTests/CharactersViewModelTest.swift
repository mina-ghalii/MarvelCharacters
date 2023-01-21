//
//  CharactersViewModelTest.swift
//  EtisalatTaskTests
//
//  Created by Mina Atef on 21/01/2023.
//

import XCTest
@testable import MarvelCharacters
@MainActor
class CharactersViewModelTest: XCTestCase {

    var mockUserlistDataSource: MockCharactersDataSource!
    var viewModel: CharactersListViewModel!
    @MainActor override func setUp() {
        mockUserlistDataSource = MockCharactersDataSource()
        viewModel = CharactersListViewModel(dataSource: mockUserlistDataSource, getCharactersImmidiatly: false)
    }
    @MainActor override func tearDown() {
        mockUserlistDataSource = nil
        viewModel = nil
    }
    
    func test_validData() async {
        await viewModel.getCharacters()
        XCTAssertNotEqual(viewModel.characters.count, 0)
    }
    func test_notValidData() async {
        mockUserlistDataSource.succeeded = false
        await viewModel.getCharacters()
        XCTAssertTrue(!viewModel.errorMessage.isEmpty)
    }
    func test_loadingBeforeRequest() async {
        await viewModel.getCharacters()
        XCTAssertTrue(!viewModel.isLoading)
    }
    func test_incrementPage() async {
        viewModel.limit = 25
        viewModel.offset = -25
        viewModel.incrementPage()
        XCTAssertEqual(viewModel.offset, 0)
    }
    func test_searchEmpty() async {
        await viewModel.getCharacters()
        XCTAssertEqual(viewModel.searchResults.count, viewModel.characters.count)
    }
    func test_searchNotEmpty() async {
        await viewModel.getCharacters()
        viewModel.searchText = "m"
        XCTAssertNotEqual(viewModel.searchResults.count, viewModel.characters.count)
    }
    
}
