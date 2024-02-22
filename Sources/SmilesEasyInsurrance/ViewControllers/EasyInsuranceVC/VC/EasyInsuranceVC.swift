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

final class EasyInsuranceVC: UIViewController {
    
    //MARK: OUtlets
    @IBOutlet weak var easyInsuranceTableView: UITableView!
    
    // MARK: - Properties
    private var dependance: EasyInsuranceDependance
    private var viewModel: EasyInsuranceViewModel
    private var cancellables = Set<AnyCancellable>()
    var dataSource: SectionedTableViewDataSource?
    var sections = [TableSectionData<EasyInsuranceSectionIdentifier>]()
    var insuranceSections: GetSectionsResponseModel?
    var consentActionType: ConsentActionType?
    var redirectionURL: String?
    
    
    //MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - INITIALISER -
    init(dependance: EasyInsuranceDependance, viewModel: EasyInsuranceViewModel) {
        self.dependance = dependance
        self.viewModel = viewModel
        super.init(nibName: "EasyInsuranceVC", bundle: .module)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - METHODS -
    private func setupViews() {
        
        setupTableView()
        bindViewModel()
        viewModel.getSections(categoryId: dependance.categoryId)
        setUpNavigationBar()
        
    }
    
    private func setupTableView() {
        if #available(iOS 15.0, *) {
            self.easyInsuranceTableView.sectionHeaderTopPadding = CGFloat(0)
        }
        easyInsuranceTableView.contentInset = UIEdgeInsets.zero
        easyInsuranceTableView.sectionHeaderHeight = UITableView.automaticDimension
        easyInsuranceTableView.estimatedSectionHeaderHeight = 1
        easyInsuranceTableView.delegate = self
        easyInsuranceTableView.contentInsetAdjustmentBehavior = .never
        let customizable: CellRegisterable? = EasyInsuranceCellRegistration()
        customizable?.register(for: self.easyInsuranceTableView)
        self.easyInsuranceTableView.backgroundColor = .white
    }
    
    
    //MARK: - setUpNavigationBar
    private func setUpNavigationBar() {
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(hexString: "#33424c99")
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
        guard let headerData = insuranceSections?.sectionDetails?.first(where: { $0.sectionIdentifier == EasyInsuranceSectionIdentifier.topPlaceholder.rawValue }) else { return }
        let imageView = UIImageView()
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 24),
            imageView.widthAnchor.constraint(equalToConstant: 24)
        ])
        imageView.tintColor = .black
        imageView.sd_setImage(with: URL(string: headerData.iconUrl ?? "")) { image, _, _, _ in
            imageView.image = image?.withRenderingMode(.alwaysTemplate)
        }
        let locationNavBarTitle = UILabel()
        locationNavBarTitle.text = headerData.title
        locationNavBarTitle.textColor = .black
        locationNavBarTitle.fontTextStyle = .smilesHeadline4
        let hStack = UIStackView(arrangedSubviews: [imageView, locationNavBarTitle])
        hStack.spacing = 4
        hStack.alignment = .center
        self.navigationItem.titleView = hStack
        let backButton: UIButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: AppCommonMethods.languageIsArabic() ? "back_icon_ar" : "back_icon", in: .module, compatibleWith: nil)?.withTintColor(.black), for: .normal)
        backButton.addTarget(self, action: #selector(self.onClickBack), for: .touchUpInside)
        backButton.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        backButton.backgroundColor = .white
        backButton.layer.cornerRadius = backButton.frame.height / 2
        backButton.clipsToBounds = true
        
        let barButton = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = barButton
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
    }
    
    //MARK: Actions
    @objc func onClickBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Section Data
    private func configureSectionsData(with sectionsResponse: GetSectionsResponseModel) {
        
        insuranceSections = sectionsResponse
        setUpNavigationBar()
        if let sectionDetailsArray = sectionsResponse.sectionDetails, !sectionDetailsArray.isEmpty {
            self.dataSource = SectionedTableViewDataSource(dataSources: Array(repeating: [], count: sectionDetailsArray.count))
        }
        insuranceSectionsAPICalls()
        
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
    
}

// MARK: - DATA BINDING EXTENSION
extension EasyInsuranceVC {
    
    func bindViewModel() {
        viewModel.offersListingPublisher.sink { [weak self] state in
            switch state {
            case .fetchInsuranceTypeDidSucceed(let response):
                self?.configureInsuranceType(with: response)
            case .fetchInsuranceTypeDidfail(let error):
                debugPrint(error)
                self?.configureHideSection(for: .faqs, dataSource: EasyInsuranceResponseModel.self)
            case .fetchFAQsDidSucceed(let response):
                self?.configureFAQsDetails(with: response)
            case .fetchFAQsDidFail(let error):
                debugPrint(error.localizedDescription)
                self?.configureHideSection(for: .faqs, dataSource: FAQsDetailsResponse.self)
            case .fetchSectionsDidSucceed(response: let response):
                self?.configureSectionsData(with: response)
            case .fetchSectionsDidFail(error: let error):
                debugPrint(error)
            }
        }.store(in: &cancellables)
    }
    
}

// MARK: - SERVICE CALLING -
extension EasyInsuranceVC {
    
    private func insuranceSectionsAPICalls() {
        
        if let sectionDetails = self.insuranceSections?.sectionDetails, !sectionDetails.isEmpty {
            sections.removeAll()
            for (index, element) in sectionDetails.enumerated() {
                guard let sectionIdentifier = element.sectionIdentifier, !sectionIdentifier.isEmpty else {
                    return
                }
                if let section = EasyInsuranceSectionIdentifier(rawValue: sectionIdentifier), section != .topPlaceholder {
                    sections.append(TableSectionData(index: index, identifier: section))
                }
                switch EasyInsuranceSectionIdentifier(rawValue: sectionIdentifier) {
                case .insuranceCategories:
                    if let insuranceIndex = getSectionIndex(for: .insuranceCategories), let response = EasyInsuranceResponseModel.fromModuleFile() {
                        dataSource?.dataSources?[insuranceIndex] = TableViewDataSource.make(forInsurance: response, data: "#FFFFFF", isDummy: true)
                        configureDataSource()
                    }
                    viewModel.getInsuranceData(categoryId: dependance.categoryId)
                    
                case .faqs:
                    if let faqsIndex = getSectionIndex(for: .faqs), let response = FAQsDetailsResponse.fromModuleFile() {
                        dataSource?.dataSources?[faqsIndex] = TableViewDataSource.make(forFAQs: response.faqsDetails ?? [], data: "#FFFFFF", isDummy: true)
                        configureDataSource()
                    }
                    viewModel.getFAQsDetails(faqId: Constants.faqsID)
                    
                default: break
                }
            }
        }
    }
    
}

// MARK: - DataSource Configuration
extension EasyInsuranceVC {
    
    // MARK: - configure FAQsDetails
    private func configureFAQsDetails(with response: FAQsDetailsResponse) {
        if let faqIndex = getSectionIndex(for: .faqs) {
            dataSource?.dataSources?[faqIndex] = TableViewDataSource.make(forFAQs: response.faqsDetails ?? [], data: "#FFFFFF", isDummy: false)
            self.configureDataSource()
        }
    }
    
    // MARK: - configure InsuranceType
    private func configureInsuranceType(with response: EasyInsuranceResponseModel) {
        if let insuranceIndex = getSectionIndex(for: .insuranceCategories) {
            dataSource?.dataSources?[insuranceIndex] = TableViewDataSource.make(forInsurance: response, data: "#FFFFFF", isDummy: false)
            configureDataSource()
        }
    }
    
    // MARK: - configureHideSection
    fileprivate func configureHideSection<T>(for section: EasyInsuranceSectionIdentifier, dataSource: T.Type) {
        if let index = getSectionIndex(for: section) {
            (self.dataSource?.dataSources?[index] as? TableViewDataSource<T>)?.models = []
            (self.dataSource?.dataSources?[index] as? TableViewDataSource<T>)?.isDummy = false
            self.configureDataSource()
        }
    }
    
}
