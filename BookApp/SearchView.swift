//
//  SearchView.swift
//  BookApp
//
//  Created by Petri Määttä on 2017-12-09.
//  Copyright © 2017 Petri Määttä. All rights reserved.
//

import UIKit

class SearchVC: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
        
    private var books: [BookDataSearch]?
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let keyword = searchBar.text
        let finalKeyword = keyword?.replacingOccurrences(of: " ", with: "+", options: .regularExpression, range: nil)
        
        BookDataSearch.searchBooks(finalKeyword: finalKeyword!) { (books) in
            self.books = books
            self.updateMainUI()
        }
        
        self.view.endEditing(true)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
    //Styling
        self.tableView.rowHeight = 140.0
        
        //SearchBar
        searchBar.backgroundColor = UIColor(red: 31/255, green: 33/255, blue: 68/255, alpha: 1)
        
        
    }
    
    func updateMainUI() {
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let books = books {
            self.tableView.isHidden = false
            return books.count
        } else {
            self.tableView.isHidden = true
            return 0
        }
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell") as! TableViewCell
        let currentBook = books![indexPath.row]
        cell.titleLabel.text = currentBook.title
        cell.authorLabel.text = "By \(currentBook.author)"
        
        let task = URLSession.shared.dataTask(with: URL(string: currentBook.thumbnail)!) { (imageData, _, _) in
            guard let imageData = imageData, let coverImage = UIImage(data: imageData) else {
                return
            }
            
            DispatchQueue.main.async {
                cell.coverImage.image = coverImage
                currentBook.image = coverImage
            }
        }
        task.resume()
        
        cell.coverImage.layer.cornerRadius = 4
        cell.coverImage.layer.masksToBounds = true
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indexPath = self.tableView.indexPathForSelectedRow?.row
        let vc = segue.destination as! DetailView
        
        vc.bookTitle = books![indexPath!].title
        vc.subtitle = books![indexPath!].subtitle
        vc.author = books![indexPath!].author
        vc.desc = books![indexPath!].description
        vc.pages = books![indexPath!].pageCount
        vc.image = books![indexPath!].image
    }
    
}






