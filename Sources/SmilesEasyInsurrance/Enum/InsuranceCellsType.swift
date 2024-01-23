//
//  File.swift
//  
//
//  Created by Habib Rehman on 23/01/2024.
//

import Foundation


enum InsuranceCellsType: Equatable {

    case easyInsuranceTVC(model: EasyInsuranceViewModel)
    
    static func == (lhs: InsuranceCellsType, rhs: InsuranceCellsType) -> Bool {
        true
    }
}

