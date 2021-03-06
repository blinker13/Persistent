#Persistent

Persistent is a small convenience wrapper around CoreData written in Swift.


## Model

The `Model` is an alias for the `NSManagedObjectModel`. It also extends the current functionality with some short and convenient methods.

```swift
// merged model from all bundles
let a = Model.all()

// merged model from main bundle
let b = Model.main()

// merged model from multiple models
let c = Model(m1, m2, m3)
```


## Stack

The `Stack` class provides a simple interface to create a simple Core Data Stack with only a few lines of code. A newly created `Stack` automatically creates a `Coordinator` -> `NSPersistentStoreCoordinator` and a `Context` -> `NSManagedObjectContext` for access on the main thread.

### Instantiation

A `Stack` will by default initialize with a merged Model from all Bundles but can be initialized with an optional Model.

```swift
let stack = Stack()

let model = Model.main()
let stack = Stack(model:model)
```

Only a `Store` is missing to make it fully functional.


## Store

The `Store` is kind of an abstract representation for a `NSPersistentStore`. 


## DAO


## Query, Comparison, Compound

A `Query` is just an alias for `NSPredicate`. Same goes for `Comparison` -> `NSComparisonPredicate` and `Compound` -> `NSCompoundPredicate`.

### Operator extensions

`NSPredicate` already provided a stright forward implementation to create queries and by leveraging operator overloading in swift it is eaven more simple.

```swift
let old = NSPredicate(format:"name == %@", "Jenny")
let new:Query = "name" == "Jenny"
```

```swift
let old = NSPredicate(format:"name == %@ && ALL age >= %@", "John", 21)
let new:Query = "name" == "John" && ALL("age" >= 21)
```
