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
import SmilesSharedServices

public final class EasyInsuranceVC: UIViewController {
    
    //MARK: OUtlets
    @IBOutlet weak var easyInsuranceTableView: UITableView!
    
    
    // MARK: - Properties
    var input: PassthroughSubject<EasyInsuranceViewModel.Input, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    var viewModel: EasyInsuranceViewModel!
    var insurancetype: [EasyInsuranceResponseModel]?
    lazy  var backButton: UIButton = UIButton(type: .custom)
    var dataSource: SectionedTableViewDataSource?
    var sections = [TableSectionData<EasyInsuranceSectionIdentifier>]()
    var insuranceTypesSectionsData: GetSectionsResponseModel?
    
    //MARK: ViewLifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bind(to: viewModel)
    }
    
    
    //MARK: - customUI
    fileprivate func setupTableView() {
        self.setUpNavigationBar(true)
        self.easyInsuranceTableView.sectionFooterHeight = .leastNormalMagnitude
        if #available(iOS 15.0, *) {
            self.easyInsuranceTableView.sectionHeaderTopPadding = CGFloat(0)
        }
        
        if let response = GetSectionsResponseModel.fromModuleFile() {
            self.configureSectionsData(with: response)
        }
        insurancetype = [EasyInsuranceResponseModel(title: "Habib"),EasyInsuranceResponseModel(title: "Habib")]
        easyInsuranceTableView.sectionHeaderHeight = UITableView.automaticDimension
        easyInsuranceTableView.estimatedSectionHeaderHeight = 1
        easyInsuranceTableView.delegate = self
        easyInsuranceTableView.contentInsetAdjustmentBehavior = .never
        let customizable: CellRegisterable? = EasyInsuranceCellRegistration()
        customizable?.register(for: self.easyInsuranceTableView)
        self.easyInsuranceTableView.backgroundColor = .white
    }
    
    //MARK: - setUpNavigationBar
    private func setUpNavigationBar(_ showBackButton: Bool = false) {
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(hexString: "#33424c99")
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
        
        let imageView = UIImageView()
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 24),
            imageView.widthAnchor.constraint(equalToConstant: 24)
        ])
        imageView.tintColor = .black
//        imageView.sd_setImage(with: URL(string: "headerData.iconUrl" ?? "")) { image, _, _, _ in
//            imageView.image = image?.withRenderingMode(.alwaysTemplate)
//        }
        imageView.image = UIImage(named: "iconsCategory")
        let locationNavBarTitle = UILabel()
        locationNavBarTitle.text = "INSURANCE".localizedString.capitalized
        locationNavBarTitle.textColor = .black
        locationNavBarTitle.fontTextStyle = .smilesHeadline4
        let hStack = UIStackView(arrangedSubviews: [imageView, locationNavBarTitle])
        hStack.spacing = 4
        hStack.alignment = .center
        self.navigationItem.titleView = hStack
        
        self.backButton = UIButton(type: .custom)
        self.backButton.setImage(UIImage(named: AppCommonMethods.languageIsArabic() ? "back_icon_ar" : "back_icon", in: .module, compatibleWith: nil)?.withTintColor(.black), for: .normal)
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
    
    // MARK: - Section Data
    private func configureSectionsData(with sectionsResponse: GetSectionsResponseModel) {
        
        self.insuranceTypesSectionsData = sectionsResponse
        if let sectionDetailsArray = sectionsResponse.sectionDetails, !sectionDetailsArray.isEmpty {
            self.dataSource = SectionedTableViewDataSource(dataSources: Array(repeating: [], count: sectionDetailsArray.count))
            configureDataSource()
            homeAPICalls()
        }
    }
    fileprivate func configureDataSource() {
        self.easyInsuranceTableView.dataSource = self.dataSource
        DispatchQueue.main.async {
            self.easyInsuranceTableView.reloadData()
        }
    }
    
    
    func getSectionIndex(for identifier: EasyInsuranceSectionIdentifier) -> Int? {
        return sections.first(where: { obj in
            return obj.identifier == identifier
        })?.index
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

// MARK: - Api Calls
extension EasyInsuranceVC {
    func homeAPICalls() {
        if let sectionDetails = self.insuranceTypesSectionsData?.sectionDetails, !sectionDetails.isEmpty {
            sections.removeAll()
            for (index, element) in sectionDetails.enumerated() {
                
                guard let sectionIdentifier = element.sectionIdentifier, !sectionIdentifier.isEmpty else {
                    return
                }
                
                switch EasyInsuranceSectionIdentifier(rawValue: sectionIdentifier) {
                case .insuranceType:
                    break
                case .faq:
                    if let faqsIndex = getSectionIndex(for: .faq), let response = FAQsDetailsResponse.fromModuleFile() {
                        dataSource?.dataSources?[faqsIndex] = TableViewDataSource.make(forFAQs: response.faqsDetails ?? [], data: "#FFFFFF", isDummy: true, completion: nil)
                    }
                    self.input.send(.getFAQsDetails(faqId: 9))
                    break
                
                default:
                    break
                }
            }
            OperationQueue.main.addOperation{
                self.easyInsuranceTableView.reloadData()
            }
        }
    }
}


// MARK: - DATA BINDING EXTENSION
extension EasyInsuranceVC {
    
    func bind(to viewModel: EasyInsuranceViewModel) {
        self.input = PassthroughSubject<EasyInsuranceViewModel.Input, Never>()
        let output = viewModel.transform(input: input.eraseToAnyPublisher())
        output
            .sink { [weak self] event in
                switch event {
                case .fetchInsuranceTypeDidSucceed(response: let response):
                    break
                    
                case .fetchInsuranceTypeDidfail(error: let error):
                    debugPrint(error.localizedDescription)
                    
                case .fetchFAQsDidSucceed(response: let response):
                    self?.configureFAQsDetails(with: response)
                    
                case .fetchFAQsDidFail(error: let error):
                    debugPrint(error.localizedDescription)
                    
                }
            }.store(in: &cancellables)
    }
    
}

// MARK: - DataSource Configuration
extension EasyInsuranceVC {
    
    private func configureFAQsDetails(with response: FAQsDetailsResponse) {
        if let faqIndex = getSectionIndex(for: .faq) {
            dataSource?.dataSources?[faqIndex] = TableViewDataSource.make(forFAQs: response.faqsDetails ?? [], data: "#FFFFFF", completion: nil)
            configureDataSource()
        }
    }
}
