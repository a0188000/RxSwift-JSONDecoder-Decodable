//
//  ViewController.swift
//  RxSwift-JSONDecoder&Decodable
//
//  Created by EVERTRUST on 2019/1/16.
//  Copyright © 2019 EVERTRUST. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class GroupViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    private var groupViewModel = GroupsViewModel()
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.configureCollectionView()
        self.bindCollectionView()
        self.configureTableView()
        self.bindTableView()
        
        let responseData = self.loadGroupsJson(fileName: "teams", type: ResponseData.self)
        var groupItems: [GroupViewPresentable] = []
        responseData?.groups.forEach { (groupData) in
            groupItems.append(GroupViewModel(groupData: groupData))
        }
        self.groupViewModel.currentTeams.accept(groupItems[0].teams)
        self.groupViewModel.groups.accept(groupItems)
        
    }
    
    private func configureTableView() {
        let teamCell = UINib(nibName: "TeamTableViewCell", bundle: nil)
        self.tableView.register(teamCell, forCellReuseIdentifier: "team")
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = 100
    }
    
    private func bindTableView() {
        self.groupViewModel.currentTeamsObservable
            .bind(to: self.tableView.rx.items(cellIdentifier: "team", cellType: TeamTableViewCell.self)) { (_, teamViewModel, cell) in
                cell.configure(withViewModel: teamViewModel)
        }.disposed(by: self.disposeBag)
    
        self.tableView.rx.modelSelected(TeamViewModel.self).subscribe(onNext: { (teamViewModel) in
            print("國家： \(teamViewModel.name)")
        }).disposed(by: self.disposeBag)
    }
    
    private func configureCollectionView() {
        let groupCell = UINib(nibName: "GroupCollectionViewCell", bundle: nil)
        self.collectionView.register(groupCell, forCellWithReuseIdentifier: "group")
        self.collectionView.sizeThatFits(CGSize(width: 124, height: 70))
    }
    
    private func bindCollectionView() {
        self.groupViewModel.groupsObservale
            .bind(to: self.collectionView.rx.items(cellIdentifier: "group", cellType: GroupCollectionViewCell.self)) { (_, groupViewModel, cell) in
                cell.configure(withViewModel: groupViewModel)
        }.disposed(by: self.disposeBag)

        self.collectionView.rx.modelSelected(GroupViewModel.self)
            .subscribe(onNext: { [weak self] (groupViewModel) in
                self?.groupViewModel.currentTeams.accept(groupViewModel.teams)
            }).disposed(by: self.disposeBag)
    }

    private func loadGroupsJson<T: Decodable>(fileName: String, type: T.Type) -> T? {
        if let url = Bundle.main.url(forResource: "teams", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(type, from: data)
                print("jsonData: \(jsonData)")
                return jsonData
            } catch {
                print("loading file error: \(error.localizedDescription)")
            }
      }
        return nil
    }
}

