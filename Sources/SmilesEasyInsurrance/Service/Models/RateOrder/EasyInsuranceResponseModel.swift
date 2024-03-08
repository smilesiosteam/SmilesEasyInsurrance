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
    
    override init () {
        super.init()
    }
    
}


extension EasyInsuranceResponseModel: Equatable {
    static func == (lhs: EasyInsuranceResponseModel, rhs: EasyInsuranceResponseModel) -> Bool {
        // Check if both insuranceTypes arrays are nil or have equal count
       return lhs.insuranceTypes == rhs.insuranceTypes
        
    }
}


// MARK: - Insurance
class Insurance: Codable, Equatable {
    static func == (lhs: Insurance, rhs: Insurance) -> Bool {
        return lhs.insuranceTypeTitle == rhs.insuranceTypeTitle
    }
    
    
    let insuranceTypeTitle: String?
    let insuranceTypeImageURL, redirectionURL: String?

    enum CodingKeys: String, CodingKey {
        case insuranceTypeTitle
        case insuranceTypeImageURL = "insuranceTypeImageUrl"
        case redirectionURL = "redirectionUrl"
    }
    
}
