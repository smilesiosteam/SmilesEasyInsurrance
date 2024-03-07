//
//  File.swift
//
//
//  Created by Ahmed Naguib on 13/12/2023.
//

import Foundation
import Combine
import SmilesTests
import NetworkingLayer
import SmilesSharedServices
@testable import SmilesEasyInsurrance

final class EasyInsuranceServiceHandlerMock: EasyInsuranceServiceHandlerProtocol {
    
    // MARK: - Properties
    var getInsuranceDetail: Result<EasyInsuranceResponseModel, NetworkError> = .failure(.badURL(""))
    var getFAQsDetails: Result<FAQsDetailsResponse, NetworkError> = .failure(.badURL(""))
    
    // MARK: - Mock Behaviours
    func getInsuranceDetail(categoryId: Int) -> AnyPublisher<EasyInsuranceResponseModel, NetworkError> {
        Future<EasyInsuranceResponseModel, NetworkError> { promise in
            promise(self.getInsuranceDetail)
        }.eraseToAnyPublisher()
    }
    
    func getFAQsDetails(categoryId: Int) -> AnyPublisher<FAQsDetailsResponse, NetworkError> {
        Future<FAQsDetailsResponse, NetworkError> { promise in
            promise(self.getFAQsDetails)
        }.eraseToAnyPublisher()
    }
    
    
}
