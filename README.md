# Piper
In Swift development it's all to familiar to see nested GCD code like the following:
```swift
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) { () -> Void in
    // Do some background work...
    dispatch_async(dispatch_get_main_queue()) { () -> Void in
        // Display results on main queue...
    }
}
```
`Piper` removes nesting and lets you chain arbitrary operations on any queue you like:
```swift
background {
  // Do some background work...
}.main {
  // Display results on main queue...
}.execute()

