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
    var image: String?
   
    
    enum CodingKeys: String, CodingKey {
        case title
        case image
    }
    
    // MARK: - Lifecycle
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
    }
    
    init(title:String? = nil){
        self.title = title
    }
}
