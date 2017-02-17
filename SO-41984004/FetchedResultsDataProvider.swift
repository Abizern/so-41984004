//
//  FetchedResultsDataProvider.swift
//  SO-41984004
//
//  Created by Abizer Nasir on 17/02/2017.
//  Copyright © 2017 Abizer Nasir. All rights reserved.
//

import CoreData

class FetchedResultsDataProvider<T>: NSObject, NSFetchedResultsControllerDelegate, DataProvider where T: NSFetchRequestResult {
    private let fetchedResultsController: NSFetchedResultsController<T>
    private weak var delegate: DataProviderDelegate?

    init(fetchedResultsController: NSFetchedResultsController<T>, delegate: DataProviderDelegate) {
        self.fetchedResultsController = fetchedResultsController
        self.delegate = delegate
        super.init()
        fetchedResultsController.delegate = self
        try! fetchedResultsController.performFetch()
        delegate.dataProviderDidUpdate()
        
    }

    func object(at indexPath: IndexPath) -> T {
        return fetchedResultsController.object(at: indexPath)
    }

    func numberOfItemsInSection(_ section: Int) -> Int {
        return fetchedResultsController.sections?.first?.numberOfObjects ?? 0
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.dataProviderDidUpdate()
    }
}

