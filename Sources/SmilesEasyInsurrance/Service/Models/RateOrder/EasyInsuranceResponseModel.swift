//
//  File.swift
//
//
//  Created by Muhammad Shayan Zahid on 29/11/2023.
//

import Foundation

struct EasyInsuranceResponseModel: Codable {
    
    let insurance: Insurance?
    
    init(insurance: Insurance) {
        self.insurance = insurance
    }
    
    enum CodingKeys: CodingKey {
        case insurance
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.insurance = try container.decode(Insurance.self, forKey: .insurance)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.insurance, forKey: .insurance)
    }
    
}

struct Insurance: Codable {
    let title: String?
    let insuranceIconUrl: String?
    let subTitle: String?
    let description: String?
    let insuranceTypes: [InsuranceType]?
    
    init(title: String, insuranceIconUrl: String, subTitle: String, description: String, insuranceTypes: [InsuranceType]) {
        self.title = title
        self.insuranceIconUrl = insuranceIconUrl
        self.subTitle = subTitle
        self.description = description
        self.insuranceTypes = insuranceTypes
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.insuranceIconUrl = try container.decode(String.self, forKey: .insuranceIconUrl)
        self.subTitle = try container.decode(String.self, forKey: .subTitle)
        self.description = try container.decode(String.self, forKey: .description)
        self.insuranceTypes = try container.decode([InsuranceType].self, forKey: .insuranceTypes)
    }
    
    enum CodingKeys: CodingKey {
        case title
        case insuranceIconUrl
        case subTitle
        case description
        case insuranceTypes
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.title, forKey: .title)
        try container.encode(self.insuranceIconUrl, forKey: .insuranceIconUrl)
        try container.encode(self.subTitle, forKey: .subTitle)
        try container.encode(self.description, forKey: .description)
        try container.encode(self.insuranceTypes, forKey: .insuranceTypes)
    }
}

struct InsuranceType: Codable {
    
    let insuranceTypeImageUrl: String?
    let redirectionUrl: String?
    let insuranceTypeTitle: String?
    
    init(insuranceTypeImageUrl: String, redirectionUrl: String, insuranceTypeTitle: String) {
        self.insuranceTypeImageUrl = insuranceTypeImageUrl
        self.redirectionUrl = redirectionUrl
        self.insuranceTypeTitle = insuranceTypeTitle
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.insuranceTypeImageUrl = try container.decode(String.self, forKey: .insuranceTypeImageUrl)
        self.redirectionUrl = try container.decode(String.self, forKey: .redirectionUrl)
        self.insuranceTypeTitle = try container.decode(String.self, forKey: .insuranceTypeTitle)
    }
    
    enum CodingKeys: CodingKey {
        case insuranceTypeImageUrl
        case redirectionUrl
        case insuranceTypeTitle
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.insuranceTypeImageUrl, forKey: .insuranceTypeImageUrl)
        try container.encode(self.redirectionUrl, forKey: .redirectionUrl)
        try container.encode(self.insuranceTypeTitle, forKey: .insuranceTypeTitle)
    }
}


