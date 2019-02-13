//
//  ViewController.swift
//  CoreDataTutorialSeries
//
//  Created by Avalgate Team on 13/02/19.
//  Copyright © 2019 iOS Dev. All rights reserved.
//

import UIKit
import CoreData

class DevicesViewController: UIViewController {
    
    let addNewDeviceSegueIdentifier = "addNewDevice"
    let deviceDetailsSegueIdentifier = "deviceDetails"
    
    let cellIdentifier = "cellIdentifier"
    @IBOutlet var tableView: UITableView!
    
    var devices: [Device] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setupView()
    }

    func setupView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 60.0
        tableView.rowHeight = 60.0
        tableView.tableFooterView = UIView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.getDevicesListFromDB()
    }
    //
    func getDevicesListFromDB() {
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Device")
        do {
            self.devices = try context.fetch(fetchRequest) as? [Device] ?? []
        } catch let error {
            print("ERROR fetching : \(error)")
        }
        tableView.reloadData()
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let identifier = segue.identifier {
            if identifier == addNewDeviceSegueIdentifier {
                let vc = segue.destination as? DeviceDetailsViewController
                vc?.title = "Add Device"
                vc?.isEditing = false
                
            } else if identifier == deviceDetailsSegueIdentifier {
                let vc = segue.destination as? DeviceDetailsViewController
                vc?.title = "Device Details"
                vc?.isEditing = true
                
                if let indexPath = tableView.indexPathForSelectedRow {
                    let device = self.devices[indexPath.row]
                    vc?.selectedDevice = device
                }
                
            }
        }
    }
}

extension DevicesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.devices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DeviceCell else {
            return UITableViewCell()
        }
        let device = self.devices[indexPath.row]
        cell.labelDeviceName.text = device.name
        cell.labelDeviceCompany.text = device.company
        return cell
    }
}


extension DevicesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
