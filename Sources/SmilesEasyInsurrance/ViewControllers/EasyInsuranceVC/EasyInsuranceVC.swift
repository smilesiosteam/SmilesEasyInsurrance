//
//  EasyInsuranceVC.swift
//  
//
//  Created by Habib Rehman on 22/01/2024.
//

import UIKit
import Combine
import SmilesFontsManager
import SmilesUtilities

public final class EasyInsuranceVC: UIViewController {
    
    //MARK: OUtlets
    @IBOutlet weak var easyInsuranceTableView: UITableView!
    
    
    // MARK: - Properties
    private var cancellables: Set<AnyCancellable> = []
    
    var viewModel: EasyInsuranceViewModel!
    var insurancetype: [EasyInsuranceResponseModel]?
    lazy  var backButton: UIButton = UIButton(type: .custom)
    //MARK: ViewLifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    
    //MARK: customUI
    func setupTableView() {
        self.setUpNavigationBar(true)
        self.easyInsuranceTableView.sectionFooterHeight = .leastNormalMagnitude
        if #available(iOS 15.0, *) {
            self.easyInsuranceTableView.sectionHeaderTopPadding = CGFloat(0)
        }
        insurancetype = [EasyInsuranceResponseModel(title: "Habib"),EasyInsuranceResponseModel(title: "Habib")]
        
        easyInsuranceTableView.sectionHeaderHeight = UITableView.automaticDimension
        easyInsuranceTableView.estimatedSectionHeaderHeight = 1
        easyInsuranceTableView.delegate = self
        easyInsuranceTableView.dataSource = self
        easyInsuranceTableView.contentInsetAdjustmentBehavior = .never
        let customizable: CellRegisterable? = EasyInsuranceCellRegistration()
        customizable?.register(for: self.easyInsuranceTableView)
        self.easyInsuranceTableView.backgroundColor = .white
    }
    
    private func setUpNavigationBar(_ showBackButton: Bool = false) {
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(hexString: "#33424c99")
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
        
        let locationNavBarTitle = UILabel()
        locationNavBarTitle.text = "Easy_Insurance_navTitle".localizedString
        locationNavBarTitle.textColor = .black
        locationNavBarTitle.fontTextStyle = .smilesHeadline4
        self.navigationItem.titleView = locationNavBarTitle
        
        
        self.backButton = UIButton(type: .custom)
        self.backButton.setImage(UIImage(named: AppCommonMethods.languageIsArabic() ? "back_arrow_ar" : "back_arrow_eng", in: .module, compatibleWith: nil)?.withTintColor(.black), for: .normal)
        self.backButton.addTarget(self, action: #selector(self.onClickBack), for: .touchUpInside)
        self.backButton.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        self.backButton.backgroundColor = .white
        self.backButton.layer.cornerRadius = self.backButton.frame.height / 2
        self.backButton.clipsToBounds = true
        
        let barButton = UIBarButtonItem(customView: self.backButton)
        self.navigationItem.leftBarButtonItem = barButton
        if (!showBackButton) {
            self.backButton.isHidden = true
        }
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
    }
    
    
    //MARK: Actions
    @objc func onClickBack() {
        self.navigationController?.popViewController(animated: true)
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
