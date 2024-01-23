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
    var title: String?
    
    
    // MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        case title
        
    }
    
    // MARK: - Lifecycle
    init(title: String? = nil) {
        super.init()
        self.title = title
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.title, forKey: .title)
        
    }
}
