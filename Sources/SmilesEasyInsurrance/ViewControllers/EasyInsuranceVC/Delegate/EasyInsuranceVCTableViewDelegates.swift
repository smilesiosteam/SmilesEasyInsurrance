//
//  File.swift
//
//
//  Created by Habib Rehman on 23/01/2024.
//

import Foundation
import UIKit
import SmilesReusableComponents
import SmilesSharedServices
import SmilesUtilities

extension EasyInsuranceVC: UITableViewDelegate, UITableViewDataSource{
    
    //MARK: - DidSelect Method
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch self.insuranceTypesSectionsData?.sectionDetails?[safe: indexPath.section]?.sectionIdentifier {
        case EasyInsuranceSectionIdentifier.insuranceType.rawValue:
           break
        case EasyInsuranceSectionIdentifier.faq.rawValue:
             if let faqIndex = getSectionIndex(for: .faq), faqIndex == indexPath.section {
                let faqDetail = ((self.dataSource?.dataSources?[safe: indexPath.section] as? TableViewDataSource<FaqsDetail>)?.models?[safe: indexPath.row] as? FaqsDetail)
                faqDetail?.isHidden = !(faqDetail?.isHidden ?? true)
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        default:
            break
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch self.insuranceTypesSectionsData?.sectionDetails?[safe: section]?.sectionIdentifier {
        case EasyInsuranceSectionIdentifier.insuranceType.rawValue:
            return 1
        case EasyInsuranceSectionIdentifier.faq.rawValue:
            return 4
        case EasyInsuranceSectionIdentifier.footer.rawValue:
            return 0
        default:
            return 0
        }
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    // MARK: - For Outer TableView CellConfiguration
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch self.insuranceTypesSectionsData?.sectionDetails?[safe: indexPath.section]?.sectionIdentifier {
        case EasyInsuranceSectionIdentifier.insuranceType.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EasyInsuranceTVC.self), for: indexPath) as! EasyInsuranceTVC
            return cell
        case EasyInsuranceSectionIdentifier.faq.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FAQTableViewCell.self), for: indexPath) as! FAQTableViewCell
            return cell
        case EasyInsuranceSectionIdentifier.footer.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FooterTVC.self), for: indexPath) as! FooterTVC
            return cell
        default:
            return UITableViewCell()
        }
        
        
        
    }
    
    // MARK: - For Outer TableView HeaderView Configuration
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch self.insuranceTypesSectionsData?.sectionDetails?[safe: section]?.sectionIdentifier {
        case EasyInsuranceSectionIdentifier.insuranceType.rawValue:
            let header = SectionHeader()
            return header
        case EasyInsuranceSectionIdentifier.faq.rawValue:
            let header = SectionHeader()
            header.titleLabel.text = "FAQs"
            header.subTitleLabel.text = ""
            return header
        case EasyInsuranceSectionIdentifier.footer.rawValue:
            return nil
        default:
            return nil
        }
        
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        switch self.insuranceTypesSectionsData?.sectionDetails?[safe: section]?.sectionIdentifier {
        case EasyInsuranceSectionIdentifier.insuranceType.rawValue:
            return CGFloat.leastNormalMagnitude
        case EasyInsuranceSectionIdentifier.faq.rawValue:
            return CGFloat.leastNormalMagnitude
        case EasyInsuranceSectionIdentifier.footer.rawValue:
            return 0
        default:
            return 0
        }
        
        
    }
    
    // MARK: - For Outer TableView HeaderView Heights
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch self.insuranceTypesSectionsData?.sectionDetails?[safe: section]?.sectionIdentifier {
        case EasyInsuranceSectionIdentifier.insuranceType.rawValue:
            return UITableView.automaticDimension
        case EasyInsuranceSectionIdentifier.faq.rawValue:
            return UITableView.automaticDimension
        case EasyInsuranceSectionIdentifier.footer.rawValue:
            return 0
        default:
            return 0
        }
        
    }
    
    // MARK: - For Outer TableView Row Height
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch self.insuranceTypesSectionsData?.sectionDetails?[safe: indexPath.section]?.sectionIdentifier {
        case EasyInsuranceSectionIdentifier.insuranceType.rawValue:
            if let insuranceTypeList = self.insurancetype, !insuranceTypeList.isEmpty {
                switch insuranceTypeList.count {
                case 1,2:
                    return 128.0
                default:
                    return 270.0
                }
            }
        case EasyInsuranceSectionIdentifier.faq.rawValue:
            return UITableView.automaticDimension
        case EasyInsuranceSectionIdentifier.footer.rawValue:
            return UITableView.automaticDimension
        default:
            return 0
        }
        return 0
    }
   
}
