//
//  BookData.swift
//  BookApp
//
//  Created by Petri Määttä on 2017-12-04.
//  Copyright © 2017 Petri Määttä. All rights reserved.
//

import UIKit
import Alamofire

class BookDataDetail {
    
    var _title: String!
    var title: String {
        if _title == nil {
            _title = ""
        }
        return _title
    }
    
    var _subtitle: String!
    var subtitle: String {
        if _subtitle == nil {
            _subtitle = ""
        }
        return _subtitle
    }
    
    var _author: String!
    var author: String {
        if _author == nil {
            _author = ""
        }
        return _author
    }
    
    var _largeCover: String!
    var largeCover: String {
        if _largeCover == nil {
            _largeCover = ""
        }
        return _largeCover
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
    
    
    // API call
    
    func downloadBookInfo(completed: @escaping DownloadComplete) {
        _ = URL(string: BOOK_INFO)!
 
        Alamofire.request(BOOK_INFO).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? [String: AnyObject] {
                
                if
                    let volumeInfo = dict["volumeInfo"] as? [String: AnyObject],
                    let tempconst = volumeInfo["imageLinks"] as? [String: AnyObject],
                    let largeCover = tempconst["medium"] as? String {
                            self._largeCover = largeCover
                            print(self._largeCover)
                    }
                
                if let volumeInfo = dict["volumeInfo"] as? [String: AnyObject] {
                    if let title = volumeInfo["title"] as? String {
                        self._title = title
                        print(self._title)
                    }
                }
                
                if let volumeInfo = dict["volumeInfo"] as? [String: AnyObject] {
                    if let subtitle = volumeInfo["subtitle"] as? String {
                        self._subtitle = subtitle
                        print(self._subtitle)
                    }
                }
                
                if let volumeInfo = dict["volumeInfo"] as? [String: AnyObject] {
                    if let author = volumeInfo["authors"] as? [String] {
                        self._author = author[0]
                        print(self._author)
                    }
                }
                
                if let volumeInfo = dict["volumeInfo"] as? [String: AnyObject] {
                    if let description = volumeInfo["description"] as? String {
                        let description = description.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
                        self._description = description
                        print(self._description)
                    }
                }
                
                if let volumeInfo = dict["volumeInfo"] as? [String: AnyObject] {
                    if let pageCount = volumeInfo["pageCount"] as? Int {
                        self._pageCount = pageCount
                        print(self._pageCount)
                    }
                }
                
            }
            completed()
        }
    }
}



