//
//  File.swift
//  
//
//  Created by Habib Rehman on 25/01/2024.
//

import Foundation
import SmilesUtilities
import SmilesLanguageManager
import UIKit

class SectionHeader: UIView {
    
    // MARK: - OUTLETS -
    @IBOutlet weak var titleLabel: UILocalizableLabel!
    @IBOutlet weak var subTitleLabel: UILocalizableLabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var headerContentBottomSpace: NSLayoutConstraint!
    
    // MARK: - METHODS -
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        Bundle.module.loadNibNamed("SectionHeader", owner: self, options: nil)
        addSubview(mainView)
        mainView.frame = bounds
        mainView.bindFrameToSuperviewBounds()
        
        titleLabel.fontTextStyle = .smilesHeadline2
        subTitleLabel.fontTextStyle = .smilesBody3
        
        titleLabel.semanticContentAttribute = AppCommonMethods.languageIsArabic() ? .forceRightToLeft : .forceLeftToRight
        subTitleLabel.semanticContentAttribute = AppCommonMethods.languageIsArabic() ? .forceRightToLeft : .forceLeftToRight
        
        titleLabel.textColor = .black
        subTitleLabel.textColor = .black.withAlphaComponent(0.6)
        
    }
    
    
    // MARK: - METHODS DataSetup -
    func setupData(title: String?, subTitle: String?, removeBottomSpace: Bool = false) {
        titleLabel.localizedString = title ?? ""
        subTitleLabel.localizedString = subTitle ?? ""
        headerContentBottomSpace.constant = removeBottomSpace ? 0 : 24
    }
    
}
