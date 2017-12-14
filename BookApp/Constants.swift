//
//  Constants.swift
//  BookApp
//
//  Created by Petri Määttä on 2017-12-04.
//  Copyright © 2017 Petri Määttä. All rights reserved.
//

import Foundation

let BASE_URL = "https://www.googleapis.com/books/v1/volumes/"
let API_KEY = "443131834314-1m413gmc5q7r3c4c2qq5skkjt9scmhn9"
let BOOK_ID = "ZrsVZKWJg4UC"
let SEARCH_BASE_URL = "https://www.googleapis.com/books/v1/volumes?q="
let SEARCH_GET_COUNT = "&maxResults=40"
let SEARCH_ORDER_BY = "&orderBy=relevance"

typealias DownloadComplete = () -> ()

let BOOK_INFO = "\(BASE_URL)\(BOOK_ID)"
