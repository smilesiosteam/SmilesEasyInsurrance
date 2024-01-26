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
