//
//  File.swift
//  
//
//  Created by Habib Rehman on 24/01/2024.
//

import UIKit
import Foundation
import SmilesUtilities
import SmilesReusableComponents

struct EasyInsuranceCellRegistration: CellRegisterable {
    
    func register(for tableView: UITableView) {
        tableView.registerCellFromNib(EasyInsuranceTVC.self, bundle: .module)
        tableView.registerCellFromNib(FAQTableViewCell.self,bundle: FAQTableViewCell.module)
    }
    
}
