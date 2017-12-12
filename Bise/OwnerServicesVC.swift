//
//  OwnerServicesVC.swift
//  Bise
//
//  Created by Grandon Lin on 2017-12-08.
//  Copyright © 2017 Grandon Lin. All rights reserved.
//

import UIKit

class OwnerServicesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var mainServiceTableView: UITableView!
    
    var selectedRow: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainServiceTableView.delegate = self
        mainServiceTableView.dataSource = self
        print("Bise(OwnerServiceVC): the services now have \(services.count) records")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if services.count == 0 {
            initializedService()
        }
        print("Bise(OwnerServiceVC): the services have \(services.count) records")
    }

    func initializedService() {
        let initialService = Service(serviceName: "", servicePrice: 0, priceUnit: "15 mins", serviceDuration: 0, durationUnit: "hour(s)", serviceImageUrl: "", serviceImage: #imageLiteral(resourceName: "emptyImage"))
        services.append(initialService)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MainServiceCell", for: indexPath) as? MainServiceCell {
            let service = services[indexPath.row]
            if service.serviceName != "" {
                cell.configureCell(service: service)
            }
            else {
                cell.serviceNameLbl.text = "Service \(services.count)"
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        performSegue(withIdentifier: "ServiceDetailVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ServiceDetailVC {
            destination.serviceNumber = selectedRow
            print("Bise(OwnerServiceVC): the serviceNumber is \(selectedRow)")
            
        }
    }
    
    @IBAction func plusBtnPressed(_ sender: UIButton) {
        let addedService = Service(serviceName: "", servicePrice: 0, priceUnit: "15 mins", serviceDuration: 0, durationUnit: "hour(s)", serviceImageUrl: "", serviceImage: #imageLiteral(resourceName: "emptyImage"))
        services.append(addedService)
        let indexPath = IndexPath(row: services.count - 1, section: 0)
        mainServiceTableView.beginUpdates()
        mainServiceTableView.insertRows(at: [indexPath], with: .automatic)
        mainServiceTableView.endUpdates()
    }
    
    @IBAction func minusBtnPressed(_ sender: UIButton) {
        if services.count > 1 {
            
            //remove the record in Firebase
            let service = services[services.count - 1]
            let serviceName = service.serviceName
            DataService().OWNERS_CURRENT_REF.child("Store Information").child("services").child(serviceName).removeValue()
        
            //remove the record from the table view and the array
            let indexPath = IndexPath(row: services.count - 1, section: 0)
            
            mainServiceTableView.beginUpdates()
            mainServiceTableView.deleteRows(at: [indexPath], with: .fade)
            services.remove(at: services.count - 1)
            mainServiceTableView.endUpdates()
        } else {
            let alertController = UIAlertController(title: "Confirmation", message: "This is the only record you have, are you sure to delete it?", preferredStyle: .alert)
 
            let oKHandler = {(action: UIAlertAction) -> Void in
                //remove the record in the array locally
                services.removeFirst()
                let service = Service(serviceName: "", servicePrice: 0, priceUnit: "15 mins", serviceDuration: 0, durationUnit: "hour(s)", serviceImageUrl: "", serviceImage: #imageLiteral(resourceName: "emptyImage"))
                services.append(service)
                
                //remove the record in Firebase
                DataService().OWNERS_CURRENT_REF.child("Store Information").child("services").removeValue()
                
                self.sendAlertWithoutHandler(alertTitle: "Delete Completed", alertMessage: "The last record has been removed", actionTitle: ["OK"])
            }
            
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: oKHandler))
            alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    

}
