//
//  UsersServiceTest.swift
//  TechnicalTestTests
//
//  Created by Fadhl Nader on 30/08/2024.
//

import XCTest
@testable import TechnicalTest

final class UsersServiceTest: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testfetchUsers() async {
        
        //Given
        let mockUsersService = MockUsersService()
        
        //When
        Task {
            let users = try await mockUsersService.fetchUsers()
            
            //Then
            XCTAssertEqual(users.count, 1)
            XCTAssertEqual(users.first?.gender, "female")
            XCTAssertEqual(users.first?.name.title, "Miss")
            XCTAssertEqual(users.first?.name.first, "Jennie")
            XCTAssertEqual(users.first?.name.last, "Nichols")
            XCTAssertEqual(users.first?.location.street.number, 8929)
            XCTAssertEqual(users.first?.location.street.name, "Valwood Pkwy")
            XCTAssertEqual(users.first?.location.city, "Billings")
            XCTAssertEqual(users.first?.location.state, "Michigan")
            XCTAssertEqual(users.first?.location.country, "United States")
            XCTAssertEqual(users.first?.location.coordinates.latitude, "-69.8246")
            XCTAssertEqual(users.first?.location.coordinates.longitude, "134.8719")
            XCTAssertEqual(users.first?.location.timezone.description, "Adelaide, Darwin")
            XCTAssertEqual(users.first?.location.timezone.offset, "+9:30")
            XCTAssertEqual(users.first?.email, "jennie.nichols@example.com")
            XCTAssertEqual(users.first?.phone, "(272) 790-0888")
            XCTAssertEqual(users.first?.dob.date, "1992-03-08T15:13:16.688Z")
            XCTAssertEqual(users.first?.dob.age, 30)
            XCTAssertEqual(users.first?.registered.date, "2007-07-09T05:51:59.390Z")
            XCTAssertEqual(users.first?.registered.age, 14)
            XCTAssertEqual(users.first?.cell, "(489) 330-2385")
            XCTAssertEqual(users.first?.id?.name, "SSN")
            XCTAssertEqual(users.first?.id?.value, "405-88-3636")
            XCTAssertEqual(users.first?.nat, "US")
            XCTAssertEqual(users.first?.picture.large, "https://randomuser.me/api/portraits/men/75.jpg")
            XCTAssertEqual(users.first?.picture.medium, "https://randomuser.me/api/portraits/med/men/75.jpg")
            XCTAssertEqual(users.first?.picture.thumbnail, "https://randomuser.me/api/portraits/thumb/men/75.jpg")
            
            XCTAssertEqual(users.first?.login.uuid, "7a0eed16-9430-4d68-901f-c0d4c1c3bf00")
            XCTAssertEqual(users.first?.login.username, "yellowpeacock117")
            XCTAssertEqual(users.first?.login.password, "addison")
            XCTAssertEqual(users.first?.login.salt, "sld1yGtd")
            XCTAssertEqual(users.first?.login.md5, "ab54ac4c0be9480ae8fa5e9e2a5196a3")
            XCTAssertEqual(users.first?.login.sha1, "edcf2ce613cbdea349133c52dc2f3b83168dc51b")
            XCTAssertEqual(users.first?.login.sha256, "48df5229235ada28389b91e60a935e4f9b73eb4bdb855ef9258a1751f10bdc5d")
        }
        
    }
    
    func testIsConnectedToNetwork() async {
        //Given
        let mockUsersService = MockUsersService()
        
        //When
        let isConnected = await mockUsersService.isConnectedToNetwork()
        
        //Then
        XCTAssertTrue(isConnected)
    }
}
