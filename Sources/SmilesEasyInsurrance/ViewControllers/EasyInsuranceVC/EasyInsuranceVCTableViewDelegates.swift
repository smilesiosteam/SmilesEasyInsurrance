//
//  File.swift
//  
//
//  Created by Habib Rehman on 23/01/2024.
//

import Foundation
import UIKit
import SmilesReusableComponents

extension EasyInsuranceVC: UITableViewDelegate, UITableViewDataSource{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return 1
        case 1:
            return 4
        default:
            return 1
        }
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EasyInsuranceTVC.self), for: indexPath) as! EasyInsuranceTVC
            return cell
            
            case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FAQTableViewCell.self), for: indexPath) as! FAQTableViewCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FooterTVC.self), for: indexPath) as! FooterTVC
            return cell
        }
        
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section{
        case 0:
            return 232
        case 1:
            return 80
        default:
            return 104
        }
    }
    
    
    
}
