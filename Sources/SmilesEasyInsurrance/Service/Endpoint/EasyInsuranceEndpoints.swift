//
//  File.swift
//  
//
//  Created by Habib Rehman on 22/01/2024.
//

import Foundation

enum EasyInsuranceEndpoints {
   
    case getInsuranceDetail
    
    var url: String {
        switch self {
        case .getInsuranceDetail:
            return "insurance/"
        }
    }
}
