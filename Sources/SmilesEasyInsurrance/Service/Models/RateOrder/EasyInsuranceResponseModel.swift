//
//  File.swift
//
//
//  Created by Muhammad Shayan Zahid on 29/11/2023.
//

import Foundation

struct EasyInsuranceResponseModel: Codable {
    // MARK: - Properties
   var title: String?
   
    
    enum CodingKeys: String, CodingKey {
        case title
    }
    
    // MARK: - Lifecycle
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
    }
    init(){}
}
