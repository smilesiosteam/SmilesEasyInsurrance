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
    
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 2 {
            return nil
        } else if section == 1 {
            let header = SectionHeader()
            return header
        } else {
            let header = SectionHeader()
            return header
        }
        
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
//        if let offersIndex = getSectionIndex(for: .upgradeBanner) {
//            if section == offersIndex {
//                return 0
//            }
//        }
//        if let offersIndex = getSectionIndex(for: .freetickets) {
//            if section == offersIndex {
//                return 0
//            }
//        }
        if section == 2 {
            return 0
        }
        return CGFloat.leastNormalMagnitude
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 2 {
            return 0
        }
        return UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section{
        case 0:
            if let insuranceTypeList = self.insurancetype, !insuranceTypeList.isEmpty {
                if insuranceTypeList.count <= 2 {
                    return 128
                }
                return 280
            }
              return 280
        case 1:
            return UITableView.automaticDimension
        default:
            return UITableView.automaticDimension
        }
    }
    
    
    
}
