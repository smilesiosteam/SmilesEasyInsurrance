//
//  FooterTVC.swift
//  
//
//  Created by Habib Rehman on 23/01/2024.
//

import UIKit
import SmilesFontsManager
import SmilesUtilities

class FooterTVC: UITableViewCell {
    
    //MARK: - Outlets //
    @IBOutlet weak var descLbl: UILabel!{
        didSet{
            self.descLbl.semanticContentAttribute =  AppCommonMethods.languageIsArabic() ? .forceRightToLeft : .forceLeftToRight
            self.descLbl.fontTextStyle = .smilesBody3
            self.descLbl.textColor = UIColor(hexString: "#000000")
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
