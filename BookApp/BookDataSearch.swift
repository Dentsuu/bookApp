//
//  BookDataSearch.swift
//  BookApp
//
//  Created by Petri Määttä on 2017-12-10.
//  Copyright © 2017 Petri Määttä. All rights reserved.
//

import UIKit
import Alamofire

class BookDataSearch {
    
    private var _title: String!
    var title: String {
        if _title == nil {
            _title = ""
        }
        return _title
    }
    
    private var _subtitle: String!
    var subtitle: String {
        if _subtitle == nil {
            _subtitle = ""
        }
        return _subtitle
    }
    
    private var _author: String!
    var author: String {
        if _author == nil {
            _author = ""
        }
        return _author
    }
    
    var _description: String!
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var _pageCount: Int!
    var pageCount: Int {
        if _pageCount == nil {
            _pageCount = 0
        }
        return _pageCount
    }
    
    private var _thumbnail: String!
    var thumbnail: String {
        if _thumbnail == nil {
            _thumbnail = ""
        }
        return _thumbnail
    }
    
    private var _cleanThumbnail: String!
    var cleanThumbnail: String {
        if _cleanThumbnail == nil {
            _cleanThumbnail = ""
        }
        return _cleanThumbnail
    }
    
    var image: UIImage!

    
    static func searchBooks(finalKeyword: String, completed: @escaping ([BookDataSearch]) -> Void) {
        let getBooks = URL(string: "\(SEARCH_BASE_URL)\(finalKeyword)\(SEARCH_GET_COUNT)\(SEARCH_ORDER_BY)")!
        print(getBooks)
        
        Alamofire.request(getBooks).responseJSON { response in
            let result = response.result
            var books: [BookDataSearch] = []
            
            if let dict = result.value as? [String: AnyObject] {
                
                if let searchItems = dict["items"] as? [Dictionary<String, AnyObject>] {
                    for item in searchItems {
                        if let volumeInfo = item["volumeInfo"] as? Dictionary<String, AnyObject> {
                            if let title = volumeInfo["title"] as? String, let subtitle = volumeInfo["subtitle"] as? String, let author = volumeInfo["authors"] as? [String], let description = volumeInfo["description"] as? String, let pageCount = volumeInfo["pageCount"] as? Int, let thumb = volumeInfo["imageLinks"] as? [String: AnyObject] {
                                if let thumbnail = thumb["smallThumbnail"] as? String {
                                    let book = BookDataSearch()
                                    book._title = title
                                    book._subtitle = subtitle
                                    book._author = author[0]
                                    book._description = description.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
                                    book._pageCount = pageCount
                                    book._thumbnail = thumbnail.replacingOccurrences(of: "&edge=curl", with: "", options: .regularExpression, range: nil)
                                    books.append(book)
                                }
                            }
                        }
                    }
                }
                completed(books)
            }
        }
    }
}
