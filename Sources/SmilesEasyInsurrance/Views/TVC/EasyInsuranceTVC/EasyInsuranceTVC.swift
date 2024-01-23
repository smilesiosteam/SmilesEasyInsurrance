//
//  EasyInsuranceTVC.swift
//  
//
//  Created by Habib Rehman on 22/01/2024.
//

import UIKit

class EasyInsuranceTVC: UITableViewCell {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //cell registered for Insurance type
        self.collectionView.register(UINib(nibName: String(describing: InsuranceTypeCVC.self), bundle: .module), forCellWithReuseIdentifier: String(describing: InsuranceTypeCVC.self))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
