//
//  File.swift
//  
//
//  Created by Muhammad Shayan Zahid on 29/11/2023.
//

import Foundation
import SmilesUtilities
import SmilesBaseMainRequestManager

final class EasyInsuranceRequestModel: SmilesBaseMainRequest {
    // MARK: - Properties
    var categoryId: Int?
    
    // MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        case categoryId
        
    }
    
    // MARK: - Lifecycle
    init(categoryId: Int? = nil) {
        super.init()
        self.categoryId = categoryId
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.categoryId, forKey: .categoryId)
        
    }
}
