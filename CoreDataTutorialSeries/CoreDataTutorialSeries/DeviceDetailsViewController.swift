//
//  DeviceDetailsViewController.swift
//  CoreDataTutorialSeries
//
//  Created by Avalgate Team on 13/02/19.
//  Copyright © 2019 iOS Dev. All rights reserved.
//

import UIKit
import CoreData

class DeviceDetailsViewController: UIViewController {
    
    @IBOutlet var textDeviceName: UITextField!
    @IBOutlet var textDeviceVersion: UITextField!
    @IBOutlet var textDeviceCompany: UITextField!
    
    var selectedDevice: Device?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupView()
    }
    
    func setupView() {
        if isEditing {
            let rightBarButton = UIBarButtonItem(title: "Update", style: .plain, target: self, action: #selector(updateAction(_:)))
            self.navigationItem.rightBarButtonItem = rightBarButton
            
            if let device = self.selectedDevice {
                textDeviceName.text = device.name
                textDeviceVersion.text = device.version
                textDeviceCompany.text = device.company
            }
            
        } else {
            let rightBarButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveAction(_:)))
            self.navigationItem.rightBarButtonItem = rightBarButton
        }
    }
    
    @objc func saveAction(_ sender: UIBarButtonItem) {
        _ = self.createDeviceEntityFromInputData(deviceName: textDeviceName.text ?? "", deviceVersion: textDeviceVersion.text ?? "", deviceCompany: textDeviceCompany.text ?? "")
        do {
            try CoreDataStack.sharedInstance.persistentContainer.viewContext.save()
        } catch let error {
            print("Error = \(error.localizedDescription)")
        }
    }
    
    @objc func updateAction(_ sender: UIBarButtonItem) {
        
    }
    
    func createDeviceEntityFromInputData(deviceName: String, deviceVersion: String, deviceCompany: String) -> NSManagedObject? {
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        if let deviceEntity = NSEntityDescription.insertNewObject(forEntityName: "Device", into: context) as? Device {
            deviceEntity.name = deviceName
            deviceEntity.version = deviceVersion
            deviceEntity.company = deviceCompany
            
            return deviceEntity
        }
        
        return nil
    }
}
