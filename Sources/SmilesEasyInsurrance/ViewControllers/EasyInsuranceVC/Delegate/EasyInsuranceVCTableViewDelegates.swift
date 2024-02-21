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
        
        if let sectionData = insuranceSections?.sectionDetails?[indexPath.section] {
            let identifier = EasyInsuranceSectionIdentifier(rawValue: sectionData.sectionIdentifier ?? "") ?? .none
            switch identifier {
            case .faqs:
                let faqDetail = ((self.dataSource?.dataSources?[safe: indexPath.section] as? TableViewDataSource<FaqsDetail>)?.models?[safe: indexPath.row] as? FaqsDetail)
                faqDetail?.isHidden = !(faqDetail?.isHidden ?? true)
                tableView.reloadRows(at: [indexPath], with: .automatic)
            default: break
            }
        }
        
    }
    
    // MARK: - For Outer TableView HeaderView Configuration
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if self.dataSource?.tableView(tableView, numberOfRowsInSection: section) == 0 {
            return .init(frame: .init(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))
        }
        
        if let sectionData = insuranceSections?.sectionDetails?[section] {
            let identifier = EasyInsuranceSectionIdentifier(rawValue: sectionData.sectionIdentifier ?? "") ?? .none
            let header = SectionHeader()
            switch identifier {
            case .insuranceCategories:
                header.setupData(title: sectionData.title, subTitle: sectionData.subTitle)
            case .faqs:
                header.setupData(title: sectionData.title, subTitle: sectionData.subTitle, removeBottomSpace: true)
            default: break
            }
            configureHeaderForShimmer(section: section, headerView: header)
            return header
        }
        return .init(frame: .init(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))
        
    }
    
    // MARK: - For Outer TableView HeaderView Heights
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if self.dataSource?.tableView(tableView, numberOfRowsInSection: section) == 0 {
            return 0
        }
        return UITableView.automaticDimension
        
    }
    
    // MARK: - For Outer TableView Row Height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.dataSource?.tableView(tableView, numberOfRowsInSection: indexPath.section) == 0 {
            return 0
        }
        if let sectionData = self.insuranceSections?.sectionDetails?[safe: indexPath.section] {
            switch sectionData.sectionIdentifier {
            case EasyInsuranceSectionIdentifier.insuranceCategories.rawValue:
                if let dataSource = ((self.dataSource?.dataSources?[safe: indexPath.section] as? TableViewDataSource<EasyInsuranceResponseModel>)) {
                    let insuranceTypeList = dataSource.models?[safe: indexPath.row] as? EasyInsuranceResponseModel
                    switch insuranceTypeList?.insuranceTypes?.count {
                    case 0:
                        return 0
                    case 1,2:
                        return getInsuranceItemWidth() * 0.78
                    default:
                        let singleLineHeight = getInsuranceItemWidth() * 0.78
                        return (singleLineHeight * 2) + 16
                    }
                }
            default:
                return UITableView.automaticDimension
            }
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
        
        if let index = getSectionIndex(for: .insuranceCategories) {
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
    
    private func getInsuranceItemWidth() -> CGFloat {
        
        let totalWidth = easyInsuranceTableView.frame.width
        let spacing: CGFloat = 16
        let itemWidth = (totalWidth - (spacing * 3)) / 2
        return itemWidth
        
    }
    
}
