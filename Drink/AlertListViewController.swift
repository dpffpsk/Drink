//
//  AlertListViewController.swift
//  Drink
//
//  Created by 이니텍 on 2021/12/20.
//

import UIKit

class AlertListViewController: UITableViewController {
    var alerts: [Alert] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //cell 등록
        let nibName = UINib(nibName: "AlertListCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "AlertListCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        alerts = alertList()
    }
    
    //추가 버튼
    @IBAction func addAlertButtonAction(_ sender: UIBarButtonItem) {
        guard let addAlertVC = storyboard?.instantiateViewController(withIdentifier: "AddAlertViewController") as? AddAlertViewController else { return }
        
        addAlertVC.pickedDate = {[weak self] date in
            guard let self = self else { return }
            
            var alertList = self.alertList()
            let newAlert = Alert(date: date, isOn: true)
            
            alertList.append(newAlert)
            alertList.sort{ $0.date < $1.date } //오름차순
            
            //tableView에 저장(출력)
            self.alerts = alertList
            
            //userdefault에 저장
            UserDefaults.standard.set(try? PropertyListEncoder().encode(self.alerts), forKey: "alerts")
            
            self.tableView.reloadData()
        }
        self.present(addAlertVC, animated: true, completion: nil)
    }
    
    //UserDefaults는 커스텀한 구조체(Alert)를 이해하지 못하기 때문에 해당 구조체의 데이터를 UserDefaults에 넣고 뺄때 decoding해줘야함
    func alertList() -> [Alert] {
        guard let data = UserDefaults.standard.value(forKey: "alerts") as? Data,
              let alerts = try? PropertyListDecoder().decode([Alert].self, from: data) else { return [] }
        return alerts
    }
    
}

//UITableView Datasource, Delegate
extension AlertListViewController {
    //cell count
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alerts.count
    }
    
    //header
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "🚰 물 마실 시간"
        default:
            return nil
        }
    }
    
    //cell 내용
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlertListCell", for: indexPath) as? AlertListCell else { return UITableViewCell() }
        cell.alertSwitch.isOn = alerts[indexPath.row].isOn
        cell.timeLabel.text = alerts[indexPath.row].time
        cell.meridiemLabel.text = alerts[indexPath.row].merdiem
        
        return cell
    }
    
    //cell 높이
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    //cell 수정 or 삭제 가능여부
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //cell 수정 or 삭제 기능
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case . delete:
            self.alerts.remove(at: indexPath.row)
            UserDefaults.standard.set(try? PropertyListEncoder().encode(self.alerts), forKey: "alerts")
            self.tableView.reloadData()
            return
        default:
            break
        }
    }
}
