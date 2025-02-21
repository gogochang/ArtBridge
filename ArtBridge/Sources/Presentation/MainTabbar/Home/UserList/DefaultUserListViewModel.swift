//
//  DefaultUserListViewModel.swift
//  ArtBridge
//
//  Created by 김창규 on 2/12/25.
//

import Foundation
import RxSwift
import RxCocoa

struct UserListViewModelInput {
    let userSelected: Observable<IndexPath>
}

struct UserListViewModelOutput {
    
}

struct UserListViewModelRoute {
    var backward = PublishSubject<Void>()
    var detailUser = PublishSubject<User>()
}

struct UserListViewModelRouteInputs {
    
}

protocol UserListViewModel {
    // MARK: - Binding
    func transform(input: UserListViewModelInput) -> UserListViewModelOutput
    
    // MARK: - Route
    var routeInputs: UserListViewModelRouteInputs { get }
    var routes: UserListViewModelRoute { get }
}

final class DefaultUserListViewModel: BaseViewModel, UserListViewModel {
    // MARK: - Properties
    private var disposeBag = DisposeBag()
    private var users: [User] = [
        User(id: 0, nickname: "A", profileImgUrl: ""),
        User(id: 1, nickname: "A", profileImgUrl: ""),
        User(id: 2, nickname: "A", profileImgUrl: ""),
        User(id: 3, nickname: "A", profileImgUrl: ""),
        User(id: 4, nickname: "A", profileImgUrl: ""),
        User(id: 5, nickname: "A", profileImgUrl: ""),
        User(id: 6, nickname: "A", profileImgUrl: ""),
        User(id: 7, nickname: "A", profileImgUrl: ""),
        User(id: 8, nickname: "A", profileImgUrl: ""),
        User(id: 9, nickname: "A", profileImgUrl: "")
    ]
    
    var routeInputs = UserListViewModelRouteInputs()
    var routes = UserListViewModelRoute()
    
    // MARK: - Init
    override init() {
        super.init()
    }
    
    // MARK: - Output
    
    // MARK: - Binding
    func transform(input: UserListViewModelInput) -> UserListViewModelOutput {
        input.userSelected
            .compactMap { [weak self] indexPath in
                guard let self = self else { return nil }
                return self.users[indexPath.row]
            }
            .bind(to: routes.detailUser)
            .disposed(by: disposeBag)
        
        return UserListViewModelOutput()
    }
    
    // MARK: - Methods
}
