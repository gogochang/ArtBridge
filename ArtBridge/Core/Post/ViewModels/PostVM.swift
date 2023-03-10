//
//  PostVM.swift
//  ArtBridge
//
//  Created by 김창규 on 2023/02/01.
//

import Foundation
import Firebase

class PostVM: ObservableObject {

    @Published var didUploadPost = false
    @Published var posts = [Post]()
    @Published var comments = [Comment]()
    let service = PostService()
    
    @Published var postData: PostData? = nil
    @Published var Boards : BoardResponse? = nil
    
    init() {
        print("PostVM - init called")
        fetchPosts()
    }
    
    //MARK: - Firebase 게시글 업로드
    func uploadPost(title: String, content: String, image: UIImage?) {
        print("PostVM - uploadPost called")
        service.uploadPost(title: title, content: content, image: image) { success in
            if success {
                self.didUploadPost = true
                print("PostVM - uploadPost success")
            } else {
                print("PostVM - uploadPost fail")
            }
        }
    }

    //MARK: - Firebase 게시글 수정
    func editPost(post: Post, title: String, content: String) {
        service.editPost(post, title: title, content: content) { success in
            if success {
                print("PostVM - editPost success")
            } else {
                print("PostVM - editPost fail")
            }
        }
    }
    
    //MARK: - Firebase 게시글 삭제
    func deletePost(post: Post) {
        service.deletePost(post) { success in
            if success {
                print("PostVM - deletePost success")
            } else {
                print("PostVM - deletePost fail")
            }
        }
    }
    
    //MARK: - Firebase 게시글 가져오기
    func fetchPosts() {
        print("PostVM - fetchPosts called")
        service.fetchPosts { posts in
            for index in 0 ..< posts.count {
                let uid = posts[index].uid
                self.posts = posts
            }
        }
    }
    
    //MARK: - Firebase 게시글 댓글 달기
    func addComment(post: Post, comment: String) {
        print("PostVM - addComment")
        service.addComment(post, comment: comment) { success in
            if success {
                print("PostVM - addComment success")
                self.getComment(post: post)
            } else {
                print("PostVM - addComment fail")
            }
        }
    }
   
    //MARK: - Firebase 게시글 댓글 가져오기
    func getComment(post: Post) {
        service.getComment(post) { comment in
            for index in 0 ..< comment.count {
                let uid = comment[index].uid
                self.comments = comment
            }
        }
    }
    
    //MARK: - Image 업로드
//    func uploadImage(image: UIImage?) {
//        print("PostVM - uploadImage called")
//        guard let image = image else{ return }
//        service.uploadImage(image: image) { success in
//        if success {
//            print("PostVM - uploadImage success")
//        } else {
//            print("PostVM - uploadImage fail")
//        }
//    }
//    }
}
