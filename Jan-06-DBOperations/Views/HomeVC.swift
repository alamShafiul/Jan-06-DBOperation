//
//  HomeVC.swift
//  Jan-06-DBOperations
//
//  Created by Admin on 9/1/23.
//

import UIKit

protocol SaveProtocol {
    var isAdd: Bool { get set }
    var storeData: String { get set }
    func updateInDB(val: String)
    func writeToDB(val: String)
}

class HomeVC: UIViewController, SaveProtocol {

//MARK: - Variables
    var darkTheme : Bool!
    let isDark = "isDark"
    var isAdd: Bool = true
    var storeData = String()
    var idxPath: IndexPath!
    
//MARK: - Outlets
    @IBOutlet weak var switchBtnOutlet: UISwitch!
    @IBOutlet weak var topbarLabel: UILabel!
    @IBOutlet weak var BGView: UIView!
    @IBOutlet weak var addBtnOutlet: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: UIView!
    
//MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        darkTheme = UserDefaults.standard.bool(forKey: isDark)
        setTheme(val: darkTheme)
        
        addBtnOutlet.layer.cornerRadius = 35
        
        tableView.dataSource = self
        tableView.delegate = self
        
        CoreDataManager.shared.getAllData()
        tableView.reloadData()
    }
    
//MARK: - Prepare Function
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == Constants.gotoAddDataSegue) {
            if let addDataPage = segue.destination as? AddDataVC {
                //addDataPage.loadViewIfNeeded()
                addDataPage.delegate = self
            }
        }
    }
    
//MARK: - Button Actions
    @IBAction func switchBtn(_ sender: Any) {
        darkTheme = UserDefaults.standard.bool(forKey: isDark)
        setTheme(val: !darkTheme)
        UserDefaults.standard.set(!darkTheme, forKey: isDark)
    }
    
    @IBAction func addBtnClicked(_ sender: Any) {
        performSegue(withIdentifier: Constants.gotoAddDataSegue, sender: nil)
    }
    
//MARK: - Functions
    func setTheme(val: Bool) {
        if val {
            switchBtnOutlet.isOn = true
            tableView.backgroundColor = .darkGray
            topView.backgroundColor = .darkGray
        }
        else {
            switchBtnOutlet.isOn = false
            tableView.backgroundColor = .white
            topView.backgroundColor = .systemIndigo
        }
    }
    
    func writeToDB(val: String) {
        CoreDataManager.shared.addData(val: val)
        tableView.reloadData()
    }
    
    func updateInDB(val: String) {
        CoreDataManager.shared.updateData(val: val, indexPath: idxPath)
        tableView.reloadData()
        isAdd = true
    }
    
}


extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: nil) {[weak self] _,_,_ in
            guard let self = self else { return }
            self.doDelete(indexPath: indexPath)
        }
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .systemRed
        
        let updateAction = UIContextualAction(style: .normal, title: nil) { [weak self] _,_,_ in
            guard let self = self else { return }
            self.doUpdate(indexPath: indexPath)
        }
        
        updateAction.image = UIImage(systemName: "pencil")
        updateAction.backgroundColor = .systemGreen
        
        let actions = UISwipeActionsConfiguration(actions: [deleteAction, updateAction])
        return actions
    }
    
    func doUpdate(indexPath: IndexPath) {
        isAdd = false
        storeData = CoreDataManager.shared.notesModels[indexPath.row].content ?? ""
        performSegue(withIdentifier: Constants.gotoAddDataSegue, sender: nil)
        idxPath = indexPath
    }
    
    func doDelete(indexPath: IndexPath) {
        CoreDataManager.shared.deleteData(indexPath: indexPath)
        tableView.reloadData()
    }
}

extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.shared.notesModels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tempCell) as! customTVC
        
        cell.dateField.text = CoreDataManager.shared.notesModels[indexPath.row].date
        cell.contentField.text = CoreDataManager.shared.notesModels[indexPath.row].content
        
        return cell
    }
}

