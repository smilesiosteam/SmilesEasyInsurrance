//
//  File.swift
//
//
//  Created by Muhammad Shayan Zahid on 29/11/2023.
//

import Foundation
import NetworkingLayer

class EasyInsuranceResponseModel: BaseMainResponse {
    
    let insuranceTypes: [Insurance]? = nil

    enum CodingKeys: String, CodingKey {
        case insuranceTypes
    }
    
}

// MARK: - Insurance
class Insurance: Codable {
    
    let insuranceTypeTitle: String?
    let insuranceTypeImageURL, redirectionURL: String?

    enum CodingKeys: String, CodingKey {
        case insuranceTypeTitle
        case insuranceTypeImageURL = "insuranceTypeImageUrl"
        case redirectionURL = "redirectionUrl"
    }
    
}
