//
//  File.swift
//  
//
//  Created by Habib Rehman on 06/03/2024.
//

import Foundation
import SmilesTests
import SmilesSharedServices
@testable import SmilesEasyInsurrance

enum Stubs {
    static var getEasyInsuranceResponse: EasyInsuranceResponseModel {
        let model: EasyInsuranceResponseModel? = readJsonFile("EasyInsuranceResponseModel", bundle: .module)
        return model ?? .init()
    }
    
    static var getFAQsResponse: FAQsDetailsResponse {
        let model: FAQsDetailsResponse? = readJsonFile("FAQsDetailsResponse", bundle: .module)
        return model!
    }
    
}
