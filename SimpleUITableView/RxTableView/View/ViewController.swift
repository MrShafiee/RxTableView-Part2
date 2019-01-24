//
//  ViewController.swift
//  SimpleUITableView
//
//  Created by Amin Shafiee on 10/28/1397 AP.
//  Copyright © 1397 amin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private let viewModel = ViewControllerViewModel()
    private let disposeBag = DisposeBag()
    var rows = PublishSubject<[TableViewSectionModel]>()
    
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<TableViewSectionModel>(configureCell: configureCell, titleForHeaderInSection: titleForHeaderInSection)
    
    private lazy var configureCell: RxTableViewSectionedReloadDataSource<TableViewSectionModel>.ConfigureCell = { [weak self] (dataSource, tableView, indexPath, item) in
        guard let strongSelf = self else { return UITableViewCell() }
        switch item {
        case .article(let article):
            return strongSelf.configArticleCell(atIndex:indexPath, article:article)
        case .cover(let image):
            return strongSelf.configCoverCell(atIndex:indexPath, cover:image)
        case .description(let text):
            return strongSelf.configDescriptionCell(atIndex:indexPath, description:text)
        }
    }

    private lazy var titleForHeaderInSection: RxTableViewSectionedReloadDataSource<TableViewSectionModel>.TitleForHeaderInSection = { [weak self] (dataSource, section) in
        
        switch dataSource.sectionModels[section].model {
        case .title(let title):
            return title
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupBinding()
        viewModel.setDataSoruce()
    }
    
    func setupTableView(){
        tableView.allowsSelection = true
        tableView.backgroundColor = .clear
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "ArticleCellId")
        tableView.register(UINib(nibName: "TableViewImageCell", bundle: nil), forCellReuseIdentifier: "CoverCellId")
        tableView.register(UINib(nibName: "TableViewTextCell", bundle: nil), forCellReuseIdentifier: "DescriptionCellId")
        tableView.tableFooterView = UIView()
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }

    func setupBinding(){
        
        viewModel.tableSections.bind(to: rows).disposed(by: disposeBag)
        rows.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
    }
}

extension ViewController {
    func configArticleCell( atIndex:IndexPath, article: articleModel ) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "ArticleCellId", for: atIndex) as? TableViewCell else {
            return UITableViewCell()
        }
        cell.titleLbl.text = article.title
        cell.subtitleLbl.text = article.subtitle
        return cell
        
    }
    func configCoverCell( atIndex:IndexPath, cover:String ) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "CoverCellId", for: atIndex) as? TableViewImageCell else {
            return UITableViewCell()
        }
        cell.cellImage.image = UIImage(named: cover)
        return cell
        
    }
    func configDescriptionCell( atIndex:IndexPath, description:String ) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "DescriptionCellId", for: atIndex) as? TableViewTextCell else {
            return UITableViewCell()
        }
        cell.celltextView.text = description
        return cell
        
    }
}

extension ViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
