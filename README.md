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
```
## Installation

`Piper` is available through [CocoaPods](http://cocoapods.org). To install, simply include the following lines in your podfile:
```ruby
use_frameworks!
pod 'Piper'
```
Be sure to import the module at the top of your .swift files:
```swift
import Piper
```
Alternatively, clone this repo or download it as a zip and include the classes in your project.

## Usage
`Piper` allows you to chain sequential operations across different queues. You can manually specify the queues, operations and return types:
```swift
let queue1 = NSOperationQueue()
let queue2 = NSOperationQueue()
let mainQueue = NSOperationQueue.mainQueue()
queue(queue1) {
    // Execute a contrived long running operation...
    return counter
}.queue(queue2) { counter in
    // Run another contrived long running operation...
    return (counter, multiplier)
}.finally(mainQueue) { (counter, multiplier) in
    // Present the results on the main queue...
    print(counter * multiplier)
}
```
However, `Piper` also provides convenience methods and smart defaults that can manage the queues for you:
```swift
background /* creates a background queue */ {
    // Execute a contrived long running operation...
}.background /* creates another background queue */ { counter in
    // Run another contrived long running operation...
}.finally /* defaults to main queue */ { (counter, multiplier) in
    // Present the results on the main queue...
}
```
You can jump back between background and custom queues, as well as the main queue:
```swift
main {
    // Operation on the main queue
}.background {
    // Operation on an anonymous background queue
}.queue(myQueue) {
    // Operation on my own queue
}.finally {
    // Last operation on the main queue
}
```
You can also execute after an arbitrary delay (like `dispatch_after`):
```swift
background {
    // Background operation...
    return result
}.after(3.0).finally { result in
    // Receives result after minimum 3 second delay
    print(result)
}
```
_Finally_, you can use `execute()` instead of `finally()` if you'd prefer to trigger execution without a completion block:
```swift
background {
    // Do some work...
}.execute()
```
## Revision History

* 1.1.0 - Added `after` operation that mimics `dispatch_after`
* 1.0.0 - Initial Release

## Author

Brad Hilton, brad@skyvive.com

## License

Piper is available under the MIT license. See the LICENSE file for more info.


