//
//  NewsData.swift
//  appNoticias
//
//  Created by Igor Santana on 26/04/23.
//

import Foundation


struct NewsData{
    let title : String
    let byline : String
    let image : String
    let url : String
    
    init(title: String, byline : String, image: String, url : String) {
        self.title = title
        self.url = url
        self.image = image
        self.byline = byline
    }
}
