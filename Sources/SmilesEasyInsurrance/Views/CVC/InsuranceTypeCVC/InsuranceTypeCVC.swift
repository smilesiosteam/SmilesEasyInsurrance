//
//  InsuranceTypeCVC.swift
//  
//
//  Created by Habib Rehman on 22/01/2024.
//

import UIKit
import SmilesFontsManager
import SDWebImage

class InsuranceTypeCVC: UICollectionViewCell {
    
    //MARK: - Outlets //
    @IBOutlet weak var titleLbl: UILabel!{
        didSet{
            self.titleLbl.fontTextStyle = .smilesTitle2
            self.titleLbl.textColor = UIColor(hexString: "#131728")
        }
    }
    
    @IBOutlet weak var image: UIImageView! {
        didSet{
            self.image.layer.cornerRadius = 8.0
            self.image.contentMode = .scaleAspectFill
        }
    }
    
    //MARK: - Cell Methods
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    func setupData(insurance: Insurance){
        titleLbl.text = insurance.insuranceTypeTitle
        image.setImageWithUrlString(insurance.insuranceTypeImageURL ?? "")
    }

}

