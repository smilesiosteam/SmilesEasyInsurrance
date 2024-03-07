//
//  File.swift
//  
//
//  Created by Habib Rehman on 06/03/2024.
//


import XCTest
import SmilesTests
import Combine
import NetworkingLayer
@testable import SmilesEasyInsurrance

final class EasyInsuranceUseCaseTests: XCTestCase {
        
        var sut: EasyInsuranceUseCase!
        var services: EasyInsuranceServiceHandlerMock!
        var cancellables = Set<AnyCancellable>()
        
        
    // MARK: - Life Cycle
    override func setUpWithError() throws {
        services = EasyInsuranceServiceHandlerMock()
        sut = EasyInsuranceUseCase(services: services)
    }

    override func tearDownWithError() throws {
        services = nil
        sut = nil
    }

    // MARK: - Tests
    func test_FetchInsuranceType_DidSucceed()  throws {
        // Given
        let response = Stubs.getEasyInsuranceResponse
        services.getInsuranceDetail = .success(response)
        let categoryId = 14
       
        // When
        let publisher = sut.getInsuranceData(categoryId: categoryId)
        
        // Then
        let result = try awaitPublisher(publisher)
        let expectedResult = EasyInsuranceUseCase.State.fetchInsuranceTypeDidSucceed(response: response)
        XCTAssertEqual(result, expectedResult)
    }
    
    func test_FetchInsuranceType_DidFail() throws {
        // Given
        let errorMessage = Constants.errorMessage.rawValue
        services.getInsuranceDetail = .failure(.badURL(errorMessage))
        let categoryId = 14
       
        // When
        let publisher = sut.getInsuranceData(categoryId: categoryId)
        // Then
        let result = try awaitPublisher(publisher)
        let expectedResult = EasyInsuranceUseCase.State.fetchInsuranceTypeDidfail(error: errorMessage)
        XCTAssertEqual(result, expectedResult)
    }
    
    }

