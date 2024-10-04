//
//  CreatePostViewModel.swift
//  ArtBridge
//
//  Created by 김창규 on 7/30/24.
//

import Foundation
import RxSwift

struct CreatePostForm {
    var title: String?
    var content: String?
    var category: String?
    var tag: String?
    var image: Data?
}

final class CreatePostViewModel {
    //MARK: - Properties
    private var disposeBag = DisposeBag()
    var routeInputs = RouteInput()
    var routes = Route()
    var inputs = Input()
    var outputs = Output()
    
    var createPostForm: CreatePostForm
    
    //MARK: - Init
    init(form createPostForm: CreatePostForm = CreatePostForm(
        title: "", 
        content: "",
        category: nil,
        tag: nil,
        image: nil
    )) {
        self.createPostForm = createPostForm
        
        inputs.backward
            .bind(to: routes.backward)
            .disposed(by: disposeBag)
        
        inputs.tappedCreateButton
            .bind {
                print("게시글 등록 API와 연동 후 기능이 동작됩니다.")
            }.disposed(by: disposeBag)
        
        inputs.titleText
            .bind { [weak self] titleText in
                guard let self = self else { return }
                self.createPostForm.title = titleText
                self.outputs.isValid.onNext(isValid())
            }.disposed(by: disposeBag)
        
        inputs.contentText
            .bind { [weak self] contentText in
                guard let self = self else { return }
                self.createPostForm.content = contentText
                self.outputs.isValid.onNext(isValid())
            }.disposed(by: disposeBag)
    }
    
    private func isValid() -> Bool {
        guard let title = createPostForm.title,
              createPostForm.title != "",
              let content = createPostForm.content,
              createPostForm.content != "" else {
            return false
        }
        return true
    }
    
    struct RouteInput{
        
    }
    
    struct Input {
        var titleText = PublishSubject<String?>()
        var contentText = PublishSubject<String?>()
        var tappedCreateButton = PublishSubject<Void>()
        var backward = PublishSubject<Void>()
    }
    
    struct Output {
        var isValid = PublishSubject<Bool>()
    }
    
    struct Route {
        var backward = PublishSubject<Void>()
    }
}
