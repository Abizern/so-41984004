# Core Data Background Context Example

An example provided for http://stackoverflow.com/questions/41984004 to show that importing on a background context
provided by a container does propagate to the main view context.

The application is a simple tableview listing UUIDs. Tapping on the plus button will add a new UUID via the container's
`performBackgroundTask` method. The table view is backed by an NSFetchedResultsController on the viewContext. 

As tapping the plus button updates the tableview, it can be seen that background saves do propagate to the main view context.
