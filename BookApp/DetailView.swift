//
//  DetailView.swift
//  BookApp
//
//  Created by Petri Määttä on 2017-12-04.
//  Copyright © 2017 Petri Määttä. All rights reserved.
//

import Foundation
import UIKit

class DetailView: UIViewController {
    
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pageCountLabel: UILabel!
    
    var image = UIImage()
    var bookTitle = String()
    var author = String()
    var subtitle = String()
    var desc = String()
    var pages = Int()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        titleLabel.text = bookTitle
        subtitleLabel.text = subtitle
        authorLabel.text = "By \(author)"
        descriptionLabel.text = desc
        pageCountLabel.text = "\(String(pages)) Pages"
        coverImageView.image = image
        
        coverImageView.layer.cornerRadius = 10
        coverImageView.layer.masksToBounds = true
        
        self.navigationController?.navigationBar.topItem?.title = " "
        
        let label = UILabel()
        let stringValue = "\(desc)"
        let attrString = NSMutableAttributedString(string: stringValue)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 20 
        style.minimumLineHeight = 20
        attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value: style, range: NSRange(location: 0, length: stringValue.characters.count))
        descriptionLabel.attributedText = attrString
    }
    
}
        





