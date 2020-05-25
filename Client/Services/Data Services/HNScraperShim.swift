//
//  HNScraperShim.swift
//  Hackers
//
//  Created by Weiran Zhang on 25/05/2020.
//  Copyright © 2020 Weiran Zhang. All rights reserved.
//

import Foundation
import HNScraper
import PromiseKit

class HNScraperShim {
    private let hackerNewsService = HackerNewsService()
}

extension HNScraperShim { // posts
    func upvote(post: HNPost) -> Promise<Void> {
        return hackerNewsService.upvote(post: post)
    }

    func unvote(post: HNPost) -> Promise<Void> {
        return hackerNewsService.unvote(post: post)
    }

    func getPost(id: Int) -> Promise<HNPost> {
        let (promise, seal) = Promise<HNPost>.pending()
        HNScraper.shared.getPost(ById: String(id)) { (post, _, error) in
            if let post = post {
                seal.fulfill(post)
            } else if let error = error {
                seal.reject(error)
            } else {
                seal.reject(HackerNewsError.hnScraperError)
            }
        }
        return promise
    }
}

extension HNScraperShim { // comments
    func upvote(comment: HNComment) -> Promise<Void> {
        return hackerNewsService.upvote(comment: comment)
    }

    func unvote(comment: HNComment) -> Promise<Void> {
        return hackerNewsService.unvote(comment: comment)
    }

    func getComment(id: Int, for post: HackerNewsPost) -> Promise<HNComment> {
        let (promise, seal) = Promise<HNComment>.pending()

        HNScraper.shared.getComments(ByPostId: String(post.id)) { (_, comments, error) in
            if let error = error {
                seal.reject(error)
            } else {
                let comment = self.firstComment(in: comments, for: id)
                if let comment = comment {
                    seal.fulfill(comment)
                } else {
                    seal.reject(HackerNewsError.hnScraperError)
                }
            }
        }

        return promise
    }

    private func firstComment(in comments: [HNComment], for commentId: Int) -> HNComment? {
        let commentIdString = String(commentId)

        for comment in comments {
            if comment.id == commentIdString {
                return comment
            } else if !comment.replies.isEmpty {
                let replies = comment.replies.compactMap { $0 as? HNComment }
                return firstComment(in: replies, for: commentId)
            }
        }

        return nil
    }
}
