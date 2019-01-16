//
//  GroupsViewModel.swift
//  RxSwift-JSONDecoder&Decodable
//
//  Created by EVERTRUST on 2019/1/16.
//  Copyright © 2019 EVERTRUST. All rights reserved.
//

import RxSwift
import RxCocoa

protocol GroupsViewPresentable {
    var groups: BehaviorRelay<[GroupViewPresentable]> { get }
    var currentTeams: BehaviorRelay<[TeamViewPresentable]> { get }
    var groupsObservale: Observable<[GroupViewPresentable]> { get }
    var currentTeamsObservable: Observable<[TeamViewPresentable]> { get }
}

protocol GroupViewPresentable {
    var title: String { get }
    var backgroundColor: UIColor { get }
    var teams: [TeamViewPresentable] { get }
}

protocol TeamViewPresentable {
    var name: String { get }
    var flag: String { get }
}

class GroupsViewModel: GroupsViewPresentable {
    var groups: BehaviorRelay<[GroupViewPresentable]> = BehaviorRelay(value: [])
    var currentTeams: BehaviorRelay<[TeamViewPresentable]> = BehaviorRelay(value: [])
    lazy var groupsObservale: Observable<[GroupViewPresentable]> = self.groups.asObservable()
    lazy var currentTeamsObservable: Observable<[TeamViewPresentable]> = self.currentTeams.asObservable()
}

class GroupViewModel: GroupViewPresentable {
    var title: String
    var backgroundColor: UIColor
    var teams: [TeamViewPresentable] = []
    
    init(groupData: GroupData) {
        self.title = groupData.group.name
        self.backgroundColor = UIColor.darkGray
        groupData.group.teams.forEach { (teamData) in
            self.teams.append(TeamViewModel(teamData: teamData))
        }
    }
}

class TeamViewModel: TeamViewPresentable {
    var name: String
    var flag: String
    
    init(teamData: TeamData) {
        self.name = teamData.team.name
        self.flag = teamData.team.logo
    }
}
