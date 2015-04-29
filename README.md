#Persistent

Persistent is a small convenience wrapper around CoreData written in Swift.


## The Stack

The `Stack` class provides a simple interface to create a simple Core Data Stack with only a few lines of code. In the following example a fully functional stack is instanciated, popullated with a persistent store and made into a shared instance.

### Instantiation

A `Stack` will by default initialize with a merged Model from all Bundles but can be initialized with an optional Model.

```swift
let stack = Stack()

let model = NSManagedObjectModel()
let stack = Stack(model)
```
