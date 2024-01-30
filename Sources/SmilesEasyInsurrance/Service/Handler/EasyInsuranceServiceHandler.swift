//
//  File.swift
//
//
//  Created by Habib Rehman on 22/01/2024.
//

import Foundation
import Combine
import NetworkingLayer
import SmilesBaseMainRequestManager

protocol EasyInsuranceServiceHandlerProtocol {
    func getInsuranceDetail() -> AnyPublisher<EasyInsuranceResponseModel, NetworkError>
}

final class EasyInsuranceServiceHandler: EasyInsuranceServiceHandlerProtocol {
    
    // MARK: - Properties
    private let repository: EasyInsuranceServiceable
    
    // MARK: - Init
    init(repository: EasyInsuranceServiceable) {
        self.repository = repository
    }
    
    // MARK: - Functions
    func getInsuranceDetail() -> AnyPublisher<EasyInsuranceResponseModel, NetworkingLayer.NetworkError> {
        let request = EasyInsuranceRequestModel()
        return repository.getInsuranceDetail(request: request)
        
    }
    
}


