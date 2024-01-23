//
//  EasyInsuranceVC.swift
//  
//
//  Created by Habib Rehman on 22/01/2024.
//

import UIKit

class EasyInsuranceVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


   
    // MARK: - Navigation


}
// MARK: - Create
extension EasyInsuranceVC {
    static public func create() -> EasyInsuranceVC {
        let viewController = EasyInsuranceVC(nibName: String(describing: EasyInsuranceVC.self), bundle: .module)
        return viewController
    }
}
