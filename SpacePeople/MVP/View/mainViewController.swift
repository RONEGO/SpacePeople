//
//  ViewController.swift
//  SpacePeople
//
//  Created by Yegor Geronin on 04.03.2022.
//

import UIKit

//MARK: - View set
class mainViewController: mainViewDelegate {
    
    public var presenter: mainViewPresenter = mainViewPresenter()
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero,
                                style: .grouped)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set Presenter
        presenter.delegate      = self
        
        // Set Table
        tableView.delegate      = self
        tableView.dataSource    = self
        
        // Add UI
        view.addSubview(tableView)
        
        //Call Presenter
        presenter.getAstronauts()
    }

    override func viewWillLayoutSubviews() {
        tableView.frame = view.bounds
    }
    
    func showAstronauts() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else {
                return
            }
            let count = strongSelf.presenter.astronauts.flatMap { $0 }.count -
                        strongSelf.presenter.astronauts.count
            strongSelf.title = "Astronauts: \(count)"
            strongSelf.tableView.reloadData()
        }
    }
    
}

//MARK: - Table Delegate
extension mainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return .headerHeight / 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .headerHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = headerTableView(frame: CGRect(x: 0,
                                                 y: 0,
                                                 width: tableView.width,
                                                 height: .headerHeight),
                                   label:   presenter.astronauts[section][0],
                                   view:    self)
        return view
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.astronauts.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard presenter.astronauts.count > 0 else {
            return 0
        }
        return presenter.astronauts[section].count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = presenter.astronauts[indexPath.section][indexPath.row + 1]
        
        return cell
    }
    
    
}
