//
//  UsersListViewModelTest.swift
//  TechnicalTestTests
//
//  Created by Fadhl Nader on 30/08/2024.
//

import XCTest
import Combine
@testable import TechnicalTest

final class UsersListViewModelTest: XCTestCase {

    var viewModel: UsersListViewModel!
        var mockUsersService: MockUsersService!
        var subscriptions = Set<AnyCancellable>()

    @MainActor override func setUp() {
            super.setUp()
            mockUsersService = MockUsersService()
            viewModel = UsersListViewModel(usersService: mockUsersService)
        }

        override func tearDown() {
            viewModel = nil
            mockUsersService = nil
            subscriptions.removeAll()
            super.tearDown()
        }

    @MainActor func testFetchUsersFromAPI() {
            // Arrange
            let expectation = XCTestExpectation(description: "Users fetched from API")
            
            viewModel.usersUpdated
                .sink { success in
                    XCTAssertTrue(success)
                    XCTAssertFalse(self.viewModel.usersViewModel.isEmpty)
                    expectation.fulfill()
                }
                .store(in: &subscriptions)
            
            // Act
            viewModel.fetchUsers()
            
            // Assert
            wait(for: [expectation], timeout: 1.0)
        }

        
    @MainActor func testRefreshUsers() {
            // Arrange
            let expectation = XCTestExpectation(description: "Users refreshed")
            
            viewModel.usersUpdated
                .sink { success in
                    XCTAssertTrue(success)
                    XCTAssertTrue(self.viewModel.usersViewModel.isEmpty)
                    expectation.fulfill()
                }
                .store(in: &subscriptions)
            
            // Act
            viewModel.refreshUsers()
            
            // Assert
            wait(for: [expectation], timeout: 1.0)
        }

}
