//
//  File.swift
//  
//
//  Created by Habib Rehman on 26/01/2024.
//

import Foundation
import SmilesUtilities
import SmilesSharedServices
import SmilesReusableComponents

//MARK: - Make For FAQs
extension TableViewDataSource where Model == FaqsDetail {
    static func make(forFAQs faqsDetails: [FaqsDetail],
                     reuseIdentifier: String = "FAQTableViewCell", data: String, isDummy: Bool = false) -> TableViewDataSource {
        return TableViewDataSource(
            models: faqsDetails,
            reuseIdentifier: reuseIdentifier,
            data: data,
            isDummy:isDummy
        ) { (faqDetail, cell, data, indexPath) in
            guard let cell = cell as? FAQTableViewCell else {return}
            cell.bottomViewIsHidden = faqDetail.isHidden ?? true
            cell.setupCell(model: faqDetail)
        }
    }
}
//MARK: - Make For Insurance Types

extension TableViewDataSource where Model == EasyInsuranceResponseModel {
    static func make(forInsurance insurance: EasyInsuranceResponseModel,
                     reuseIdentifier: String = "EasyInsuranceTVC", data: String, isDummy: Bool = false, completion:((Insurance?) -> ())?) -> TableViewDataSource {
        return TableViewDataSource(
            models: [insurance],
            reuseIdentifier: reuseIdentifier,
            data: data,
            isDummy:isDummy
        ) { (insurance, cell, data, indexPath) in
            guard let cell = cell as? EasyInsuranceTVC else {return}
            cell.setupInsuranceData(insuranceTypes: insurance.insuranceTypes)
            cell.callBack = { data in
                completion?(data)
            }
        }
    }
}

