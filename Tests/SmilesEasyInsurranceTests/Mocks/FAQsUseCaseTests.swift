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
import SmilesUtilities
@testable import SmilesEasyInsurrance

final class FAQsUseCaseTests: XCTestCase {
        
        var sut: FAQsUseCase!
        var services: EasyInsuranceServiceHandlerMock!
        var cancellables = Set<AnyCancellable>()
        
        
    // MARK: - Life Cycle
    override func setUpWithError() throws {
        services = EasyInsuranceServiceHandlerMock()
        sut = FAQsUseCase()
    }

    override func tearDownWithError() throws {
        services = nil
        sut = nil
    }

    // MARK: - Tests
    func test_FetchFAQs_DidSucceed()  throws {
        // Given
        let response = Stubs.getFAQsResponse
        services.getFAQsDetails = .success(response)
        let faqId = 9
       
        // When
        let publisher = sut.getFAQsDetails(faqId: faqId, baseUrl: AppCommonMethods.serviceBaseUrl)
        
        // Then
        let result = try awaitPublisher(publisher)
        let expectedResult = FAQsUseCase.State.fetchFAQsDidSucceed(response: response)
        XCTAssertEqual(result, expectedResult)
    }
    
    func test_FetchFAQs_DidFail() throws {
        // Given
        let errorMessage = Constants.errorMessage.rawValue
        services.getFAQsDetails = .failure(.badURL(errorMessage))
        let faqId = 9
       
        // When
        let publisher = sut.getFAQsDetails(faqId: faqId, baseUrl: AppCommonMethods.serviceBaseUrl)
        // Then
        let result = try awaitPublisher(publisher)
        let expectedResult = FAQsUseCase.State.fetchFAQsDidFail(error: errorMessage)
        XCTAssertEqual(result, expectedResult)
    }
    
    }


