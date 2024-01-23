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
    
    func getOrderRating(ratingType: String, contentType: String, isLiveTracking: Bool, orderId: String) -> AnyPublisher<GetOrderRatingResponse, NetworkError>
    
}

final class EasyInsuranceServiceHandler: EasyInsuranceServiceHandlerProtocol {
    
    // MARK: - Properties
    private let repository: EasyInsuranceServiceable
    
    // MARK: - Init
    init(repository: EasyInsuranceServiceable) {
        self.repository = repository
    }
    
    // MARK: - Functions
    
    
    func getOrderRating(ratingType: String, contentType: String, isLiveTracking: Bool, orderId: String) -> AnyPublisher<GetOrderRatingResponse, NetworkError> {
        
        let request = GetOrderRatingRequest(ratingType: ratingType, contentType: contentType, isLiveTracking: isLiveTracking, orderId: orderId)
        return repository.getOrderRatingService(request: request)
    }
}


