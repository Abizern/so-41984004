//
//  ViewController.swift
//  SO-41984004
//
//  Created by Abizer Nasir on 17/02/2017.
//  Copyright © 2017 Abizer Nasir. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController {

    fileprivate var container: NSPersistentContainer?
    fileprivate var dataProvider: FetchedResultsDataProvider<Item>?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupContainer()
    }

    private func setupContainer() {
        let container = NSPersistentContainer(name: "SO_41984004")
        container.loadPersistentStores { (storeDescription, error) in
            guard error == nil else { fatalError("Unresolved error \(error)") }

            let ctx = container.viewContext
            ctx.automaticallyMergesChangesFromParent = true

            DispatchQueue.main.async {
                let fetchRequest = Item.defaultFetchRequest()
                let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: ctx, sectionNameKeyPath: nil, cacheName: nil)
                self.dataProvider = FetchedResultsDataProvider(fetchedResultsController: frc, delegate: self)
                self.tableView.reloadData()
            }
        }
        self.container = container
    }

    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        guard let container = container else { return }
        let title = UUID().uuidString
        container.performBackgroundTask { (moc) in
            Item.insertInto(moc, title: title)
            try! moc.save()
        }
    }
}

extension ViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProvider?.numberOfItemsInSection(section) ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let provider = dataProvider else { return UITableViewCell() }

        let reuseIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let item = provider.object(at: indexPath)
        cell.textLabel?.text = item.title

        return cell
    }
}

extension ViewController: DataProviderDelegate {
    func dataProviderDidUpdate() {
        tableView.reloadData()
    }
}

