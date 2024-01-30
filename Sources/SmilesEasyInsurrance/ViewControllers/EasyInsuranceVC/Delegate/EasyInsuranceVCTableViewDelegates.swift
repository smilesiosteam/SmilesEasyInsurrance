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

extension EasyInsuranceVC: UITableViewDelegate{
    
    //MARK: - DidSelect Method
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch getSectionIdentifier(for: indexPath.section) {
        case EasyInsuranceSectionIdentifier.insuranceType:
           break
        case EasyInsuranceSectionIdentifier.faq:
             if let faqIndex = getSectionIndex(for: .faq), faqIndex == indexPath.section {
                let faqDetail = ((self.dataSource?.dataSources?[safe: indexPath.section] as? TableViewDataSource<FaqsDetail>)?.models?[safe: indexPath.row] as? FaqsDetail)
                faqDetail?.isHidden = !(faqDetail?.isHidden ?? true)
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
    

    
    // MARK: - For Outer TableView HeaderView Configuration
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch getSectionIdentifier(for: section) {
        case EasyInsuranceSectionIdentifier.insuranceType:
            let header = SectionHeader()
            header.titleLabel.text = self.insuranceTypeResponse?.insurance?.subTitle ?? ""
            header.subTitleLabel.text = self.insuranceTypeResponse?.insurance?.description ?? ""
            return header
        case EasyInsuranceSectionIdentifier.faq:
            let header = SectionHeader()
            header.titleLabel.text = "FAQs"
            header.subTitleLabel.text = ""
            return header
        
        }
        
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        switch getSectionIdentifier(for: section) {
        case EasyInsuranceSectionIdentifier.insuranceType:
            return CGFloat.leastNormalMagnitude
        case EasyInsuranceSectionIdentifier.faq:
            return CGFloat.leastNormalMagnitude
        }
        
        
    }
    
    // MARK: - For Outer TableView HeaderView Heights
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch getSectionIdentifier(for: section) {
        case EasyInsuranceSectionIdentifier.insuranceType:
            return UITableView.automaticDimension
        case EasyInsuranceSectionIdentifier.faq:
            return UITableView.automaticDimension
        }
        
    }
    
    // MARK: - For Outer TableView Row Height
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch getSectionIdentifier(for: indexPath.section) {
        case EasyInsuranceSectionIdentifier.insuranceType:
            if let insuranceTypeList = self.insuranceTypeResponse {
                switch insuranceTypeList.insurance?.insuranceTypes?.count {
                case 0:
                    return 0
                case 1,2:
                    return 128.0
                default:
                    return 270.0
                }
            }
        case EasyInsuranceSectionIdentifier.faq:
            return UITableView.automaticDimension
        }
        return 0
    }
   
}
