//
//  File.swift
//
//
//  Created by Muhammad Shayan Zahid on 29/11/2023.
//

import Foundation
import NetworkingLayer

class EasyInsuranceResponseModel: BaseMainResponse {
    
    var insuranceTypes: [Insurance]?

    enum CodingKeys: String, CodingKey {
        case insuranceTypes
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        insuranceTypes = try values.decodeIfPresent([Insurance].self, forKey: .insuranceTypes)
        try super.init(from: decoder)
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
