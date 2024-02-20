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
        switch sections[indexPath.section].identifier {
        case EasyInsuranceSectionIdentifier.insuranceType:
           break
        case EasyInsuranceSectionIdentifier.faqs:
            let faqDetail = ((self.dataSource?.dataSources?[safe: indexPath.section] as? TableViewDataSource<FaqsDetail>)?.models?[safe: indexPath.row] as? FaqsDetail)
            faqDetail?.isHidden = !(faqDetail?.isHidden ?? true)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    

    
    // MARK: - For Outer TableView HeaderView Configuration
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if self.dataSource?.tableView(tableView, numberOfRowsInSection: section) == 0 {
            return nil
        }
        switch sections[section].identifier {
        case EasyInsuranceSectionIdentifier.insuranceType:
            let header = SectionHeader()
            if let dataSource = dataSource?.dataSources?[safe: section] as? TableViewDataSource<EasyInsuranceResponseModel>,
               let insuranceTypeResponse = dataSource.models?.first {
//                header.titleLabel.text = insuranceTypeResponse.insurance?.subTitle ?? ""
//                header.subTitleLabel.text = self.insuranceTypeResponse.insurance?.description ?? ""
            }
            configureHeaderForShimmer(section: section, headerView: header)
            return header
        case EasyInsuranceSectionIdentifier.faqs:
            let header = SectionHeader()
            header.titleLabel.text = "FAQs"
            header.subTitleLabel.text = ""
            configureHeaderForShimmer(section: section, headerView: header)
            return header
        
        }
        
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        
        if self.dataSource?.tableView(tableView, numberOfRowsInSection: section) == 0 {
            return 0
        }
        return CGFloat.leastNormalMagnitude
        
    }
    
    // MARK: - For Outer TableView HeaderView Heights
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if self.dataSource?.tableView(tableView, numberOfRowsInSection: section) == 0 {
            return 0
        }
        return UITableView.automaticDimension
        
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    // MARK: - For Outer TableView Row Height
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.dataSource?.tableView(tableView, numberOfRowsInSection: indexPath.section) == 0 {
            return 0
        }
        switch sections[indexPath.section].identifier {
        case EasyInsuranceSectionIdentifier.insuranceType:
            
            if let dataSource = ((self.dataSource?.dataSources?[safe: indexPath.section] as? TableViewDataSource<EasyInsuranceResponseModel>)) {
                let insuranceTypeList = dataSource.models?[safe: indexPath.row] as? EasyInsuranceResponseModel
                switch insuranceTypeList?.insuranceTypes?.count {
                case 0:
                    return 0
                case 1,2:
                    return 128.0
                default:
                    return 280.0
                }
            }
        case EasyInsuranceSectionIdentifier.faqs:
            return UITableView.automaticDimension
        }
        return 0
    }
   
}
// MARK: - configure Header For Shimmer
extension EasyInsuranceVC {
    func configureHeaderForShimmer(section: Int, headerView: UIView) {
       
        func showHide(isDummy: Bool) {
            if isDummy {
                headerView.enableSkeleton()
                headerView.showAnimatedGradientSkeleton()
            } else {
                headerView.hideSkeleton()
            }
        }
        
        if let index = getSectionIndex(for: .insuranceType) {
            if let dataSource = self.dataSource?.dataSources?[safe: index] as? TableViewDataSource<EasyInsuranceResponseModel> {
                showHide(isDummy: dataSource.isDummy)
            }
        }
        
        if let index = getSectionIndex(for: .faqs) {
            if let dataSource = self.dataSource?.dataSources?[safe: index] as? TableViewDataSource<FaqsDetail> {
                showHide(isDummy: dataSource.isDummy)
            }
        }
        
    }
}
