//
//  EasyInsuranceVC.swift
//  
//
//  Created by Habib Rehman on 22/01/2024.
//

import UIKit
import Combine

public final class EasyInsuranceVC: UIViewController {
    
    //MARK: OUtlets
    @IBOutlet weak var easyInsuranceTableView: UITableView!
    
    
    // MARK: - Properties
    private var cancellables: Set<AnyCancellable> = []
    
    var viewModel: EasyInsuranceViewModel!
    
    //MARK: ViewLifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    
    //MARK: customUI
    func setupTableView() {
        self.easyInsuranceTableView.sectionFooterHeight = .leastNormalMagnitude
        if #available(iOS 15.0, *) {
            self.easyInsuranceTableView.sectionHeaderTopPadding = CGFloat(0)
        }
        easyInsuranceTableView.sectionHeaderHeight = UITableView.automaticDimension
        easyInsuranceTableView.estimatedSectionHeaderHeight = 1
        easyInsuranceTableView.delegate = self
        easyInsuranceTableView.contentInsetAdjustmentBehavior = .never
        
        self.easyInsuranceTableView.register(UINib(nibName: String(describing: EasyInsuranceTVC.self), bundle: .module), forCellReuseIdentifier: String(describing: EasyInsuranceTVC.self))
        self.easyInsuranceTableView.register(UINib(nibName: String(describing: FooterTVC.self), bundle: .module), forCellReuseIdentifier: String(describing: FooterTVC.self))
        self.easyInsuranceTableView.backgroundColor = .white
    }
    
    
    //MARK: Actions


   
    // MARK: - Navigation


}
// MARK: - Create
extension EasyInsuranceVC {
    static public func create() -> EasyInsuranceVC {
        let viewController = EasyInsuranceVC(nibName: String(describing: EasyInsuranceVC.self), bundle: .module)
        return viewController
    }
}
