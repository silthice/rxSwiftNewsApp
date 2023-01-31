//
//  URLRequest+Extensions.swift
//  NewsApp
//
//  Created by Giap on 31/01/2023.
//

import Foundation
import RxCocoa
import RxSwift

struct Resource<T: Decodable> {
    let url: URL
}

extension ArticleList {
    static var all: Resource<ArticleList> = {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=8df1353389ed43a6b6ba142136c17d22")!
        return Resource(url: url)
    }()
}

extension URLRequest {
    static func load<T>(resource: Resource<T>) -> Observable<T?> {
        return Observable.from([resource.url])
            .flatMap { url -> Observable<Data> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.data(request: request)
            }.map { data -> T? in
                return try? JSONDecoder().decode(T.self, from: data)
            }.asObservable()
    }
}
