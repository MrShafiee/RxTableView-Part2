//
//  ViewControllerViewModel.swift
//  SimpleUITableView
//
//  Created by Amin Shafiee on 10/28/1397 AP.
//  Copyright © 1397 amin. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

typealias TableViewSectionModel = SectionModel<TableViewSection, TableViewItem>
enum TableViewSection {
    case title( text:String )
}
enum TableViewItem {
    case article( article:articleModel )
    case cover( imageName:String )
    case description( text:String )
}

class ViewControllerViewModel: NSObject {
    
    var tableSections = PublishSubject<[TableViewSectionModel]>()
    
    func setDataSoruce() {
        
        var sections: [TableViewSectionModel] = []
        
        let item01 = TableViewItem.article(article: articleModel(title: "title 1", subtitle:"subtitle 1"))
        let item02 = TableViewItem.article(article: articleModel(title: "title 2", subtitle:"subtitle 2"))
        let item03 = TableViewItem.article(article: articleModel(title: "title 3", subtitle:"subtitle 3"))
        let item04 = TableViewItem.cover(imageName: "cover")
        let sectionOne = TableViewSectionModel(model: .title(text: "section 1"), items: [item01, item02, item03, item04])
        sections.append(sectionOne)
        
        let item11 = TableViewItem.cover(imageName: "cover")
        let item12 = TableViewItem.description(text: "put your description here to show on tableView")
        let item13 = TableViewItem.article(article: articleModel(title: "title rows 3", subtitle:"in section 1"))
        let item14 = TableViewItem.cover(imageName: "cover")
        let sectionTwo = TableViewSectionModel(model: .title(text: "section 2"), items: [item11, item12, item13, item14])
        sections.append(sectionTwo)
        
        tableSections.onNext(sections)
        
    }
}
