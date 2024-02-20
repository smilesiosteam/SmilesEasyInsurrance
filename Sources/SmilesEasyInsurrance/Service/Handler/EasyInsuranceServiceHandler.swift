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
    func getInsuranceDetail(categoryId: Int) -> AnyPublisher<EasyInsuranceResponseModel, NetworkError>
}

final class EasyInsuranceServiceHandler: EasyInsuranceServiceHandlerProtocol {
    
    // MARK: - Properties
    private let repository: EasyInsuranceServiceable
    
    // MARK: - Init
    init(repository: EasyInsuranceServiceable) {
        self.repository = repository
    }
    
    // MARK: - Functions
    func getInsuranceDetail(categoryId: Int) -> AnyPublisher<EasyInsuranceResponseModel, NetworkingLayer.NetworkError> {
        let request = EasyInsuranceRequestModel(categoryId: categoryId)
        return repository.getInsuranceDetail(request: request)
    }
    
}


