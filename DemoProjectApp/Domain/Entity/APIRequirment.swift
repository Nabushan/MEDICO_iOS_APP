//
//  APIRequirment.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 25/09/22.
//

import Foundation

struct APIResult: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}


struct Article: Codable {
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}
