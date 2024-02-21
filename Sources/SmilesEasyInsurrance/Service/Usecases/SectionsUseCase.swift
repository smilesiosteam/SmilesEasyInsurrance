//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 20/02/2024.
//

import Foundation
import Combine
import NetworkingLayer
import SmilesUtilities
import SmilesSharedServices

protocol SectionsUseCaseProtocol {
    func getSections(categoryID: Int) -> Future<SectionsUseCase.State, Never>
}

final class SectionsUseCase: SectionsUseCaseProtocol {

    public var sectionsUseCaseInput: PassthroughSubject<SectionsViewModel.Input, Never> = .init()
    private let sectionsViewModel = SectionsViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    func getSections(categoryID: Int) -> Future<SectionsUseCase.State, Never> {
        return Future<State, Never> { [weak self] promise in
            guard let self else {
                return
            }
        sectionsUseCaseInput = PassthroughSubject<SectionsViewModel.Input, Never>()
        let output = sectionsViewModel.transform(input: sectionsUseCaseInput.eraseToAnyPublisher())
            self.sectionsUseCaseInput.send(.getSections(categoryID: categoryID, baseUrl: AppCommonMethods.serviceBaseUrl, isGuestUser: AppCommonMethods.isGuestUser))
            output.sink { event in
                    switch event {
                    case .fetchSectionsDidSucceed(let sectionsResponse):
                        debugPrint(sectionsResponse)
                        promise(.success(.sectionsDidSucceed(response: sectionsResponse)))
                    case .fetchSectionsDidFail(let error):
                        print(error.localizedDescription)
                        promise(.success(.sectionsDidFail(error: error.localizedDescription)))
                    }
                }.store(in: &cancellables)
        }
       
    }
    
}
extension SectionsUseCase {
    enum State {
        case sectionsDidSucceed(response: GetSectionsResponseModel)
        case sectionsDidFail(error: String)
    }
}
