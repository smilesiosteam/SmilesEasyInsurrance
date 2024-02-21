//
//  File.swift
//  
//
//  Created by Habib Rehman on 26/01/2024.
//

import Foundation
import SmilesUtilities

enum EasyInsuranceSectionIdentifier: String, SectionIdentifierProtocol {
    
    var identifier: String { return self.rawValue}
    case topPlaceholder = "TOP_PLACEHOLDER"
    case insuranceCategories = "INUSRANCE_CATEGORIES"
    case faqs = "FAQS"
    
}
