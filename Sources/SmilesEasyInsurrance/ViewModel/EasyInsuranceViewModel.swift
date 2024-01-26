//
//  File.swift
//  
//
//  Created by Habib Rehman on 23/01/2024.
//

import Foundation
import Combine
import SmilesUtilities
import SmilesSharedServices

final class EasyInsuranceViewModel {
    
    // MARK: - Input
    public enum Input {
        case fetchInsuranceType(res: EasyInsuranceResponseModel)
        case getFAQsDetails(faqId: Int)
    }
    
    // MARK: - Output
    public enum Output {
        ///Insurance type Output
        case fetchInsuranceTypeDidSucceed(response: EasyInsuranceResponseModel)
        case fetchInsuranceTypeDidfail(error: Error)
        ///FAQs type Output
        case fetchFAQsDidSucceed(response: FAQsDetailsResponse)
        case fetchFAQsDidFail(error: Error)
        
    }
    
    // MARK: - Properties
    var output: PassthroughSubject<Output, Never> = .init()
    var cancellables = Set<AnyCancellable>()
    private let faqsViewModel = FAQsViewModel()
    private var faqsUseCaseInput: PassthroughSubject<FAQsViewModel.Input, Never> = .init()
    
    // MARK: - Init
    init() {
    }
}

//MARK: - EasyInsuranceViewModel Transformation
extension EasyInsuranceViewModel {
    
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        output = PassthroughSubject<Output, Never>()
        input.sink { [weak self] event in
            switch event {
            case .fetchInsuranceType(let response):
                self?.output.send(.fetchInsuranceTypeDidSucceed(response: response))
               
            case .getFAQsDetails(faqId: let faqId):
                self?.bind(to: self?.faqsViewModel ?? FAQsViewModel())
                self?.faqsUseCaseInput.send(.getFAQsDetails(faqId: faqId, baseUrl: AppCommonMethods.serviceBaseUrl))
                break
            }
            
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
    
}

//MARK: - DATA BINDING FOR FAQS
extension EasyInsuranceViewModel {
    func bind(to faqsViewModel: FAQsViewModel) {
        faqsUseCaseInput = PassthroughSubject<FAQsViewModel.Input, Never>()
        let output = faqsViewModel.transform(input: faqsUseCaseInput.eraseToAnyPublisher())
        output
            .sink { [weak self] event in
                switch event {
                case .fetchFAQsDidSucceed(let response):
                    self?.output.send(.fetchFAQsDidSucceed(response: response))
                case .fetchFAQsDidFail(let error):
                    self?.output.send(.fetchFAQsDidFail(error: error))
                }
            }.store(in: &cancellables)
    }
}
