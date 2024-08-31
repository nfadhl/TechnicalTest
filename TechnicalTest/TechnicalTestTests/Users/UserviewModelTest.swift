//
//  UserviewModelTest.swift
//  TechnicalTestTests
//
//  Created by Fadhl Nader on 30/08/2024.
//

import XCTest
@testable import TechnicalTest

final class UserviewModelTest: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInit() async  {
        //Given
        let mockUsersService = MockUsersService()
        
        //When
        do {
            let user = (try await mockUsersService.fetchUsers().first)!
            let userViewModel = UserViewModel(user: user)
            
            //Then
            XCTAssertEqual(userViewModel.name, "Miss Jennie Nichols")
            XCTAssertEqual(userViewModel.email,"jennie.nichols@example.com")
            XCTAssertEqual(userViewModel.image,"https://randomuser.me/api/portraits/thumb/men/75.jpg")
        } catch {
            XCTFail("Fetching users failed with error: \(error)")
        }
    }
}
