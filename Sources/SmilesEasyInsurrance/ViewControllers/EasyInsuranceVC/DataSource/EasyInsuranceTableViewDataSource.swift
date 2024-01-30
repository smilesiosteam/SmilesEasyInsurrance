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
    static func make(forFAQs  faqsDetails: [FaqsDetail],
                     reuseIdentifier: String = "FAQTableViewCell", data : String, isDummy:Bool = false, completion:(() -> ())?) -> TableViewDataSource {
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
    static func make(forInsurance  insuranceType: EasyInsuranceResponseModel,
                     reuseIdentifier: String = "EasyInsuranceTVC", data : String, isDummy:Bool = false, completion:((InsuranceType) -> ())?) -> TableViewDataSource {
        return TableViewDataSource(
            models: [insuranceType].filter({$0.insurance?.insuranceTypes?.count ?? 0 > 0}),
            reuseIdentifier: reuseIdentifier,
            data: data,
            isDummy:isDummy
        ) { (insuranceTypes, cell, data, indexPath) in
            guard let cell = cell as? EasyInsuranceTVC else {return}
            cell.updateCellData = insuranceTypes.insurance?.insuranceTypes
            print(insuranceTypes)
            cell.callBack = { insuranceType in
                completion?(insuranceType)
            }
        }
    }
}

