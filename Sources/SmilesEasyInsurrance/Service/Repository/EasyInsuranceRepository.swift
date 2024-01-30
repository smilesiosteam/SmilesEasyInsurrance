//
//  File.swift
//  
//
//  Created by Habib Rehman on 22/01/2024.
//

import Foundation
import Combine
import NetworkingLayer
import SmilesUtilities


protocol EasyInsuranceServiceable {
    
    func getInsuranceDetail(request: EasyInsuranceRequestModel) -> AnyPublisher<EasyInsuranceResponseModel, NetworkError>
}

final class EasyInsuranceRepository: EasyInsuranceServiceable {
    
    // MARK: - Properties
    private let networkRequest: Requestable
    
    // MARK: - Init
    init(networkRequest: Requestable) {
        self.networkRequest = networkRequest
    }
  
    // MARK: - Functions
    func getInsuranceDetail(request: EasyInsuranceRequestModel) -> AnyPublisher<EasyInsuranceResponseModel, NetworkingLayer.NetworkError> {
        let endPoint = EasyInsuranceRequestBuilder.getInsuranceDetail(request: request)
        let request = endPoint.createRequest(
            endPoint: .getInsuranceDetail
        )
        return networkRequest.request(request)
    }
    
}

