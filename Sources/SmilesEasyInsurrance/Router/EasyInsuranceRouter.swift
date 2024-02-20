//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 20/02/2024.
//

import Foundation
import UIKit

public final class EasyInsuranceRouter {
    
    public static let shared = EasyInsuranceRouter()
    private var navigationController: UINavigationController?
    
    public func pushEasyInsuranceVC(navigationController: UINavigationController?, dependance: EasyInsuranceDependance) {
        
        let vc = EasyInsuranceConfigurator.create(type: .easyInsuranceVC(dependance: dependance))
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func openURLInBrowser(urlString: String?) {
        
        if let urlString, let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
        
    }
    
}
