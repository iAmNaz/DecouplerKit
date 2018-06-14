# DecouplerKit

[![CI Status](https://img.shields.io/travis/iamnaz/DecouplerKit.svg?style=flat)](https://travis-ci.org/iamnaz/DecouplerKit)
[![Version](https://img.shields.io/cocoapods/v/DecouplerKit.svg?style=flat)](https://cocoapods.org/pods/DecouplerKit)
[![License](https://img.shields.io/cocoapods/l/DecouplerKit.svg?style=flat)](https://cocoapods.org/pods/DecouplerKit)
[![Platform](https://img.shields.io/cocoapods/p/DecouplerKit.svg?style=flat)](https://cocoapods.org/pods/DecouplerKit)

## Features
- Single interface for your user interface and worker classes and controllers
- Asynch and sync task friendly
- Easier to test as it encourages decoupled code and methods are generally functional 
- Uses PromiseKit to properly wrap requests and responses
- Use cases scenarios are documented as enums
- Worker classes or controllers are registered in a registry object

## It is
- It makes code decoupling easier with the user of registries and interface
- It works with any iOS architecture such as MVVM, MVP, etc

## It is NOT
- A software architecture
- Enforcing a specific architecture while it is up to the developer to decide which one he will use with this kit

## Animated Data Flow
![DecouplerKit](https://raw.githubusercontent.com/iAmNaz/DecouplerKit/master/dk-animated-demo.gif)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Installation

To install
it, simply add the following line to your Podfile. For now since this is a new lib instead of loading it from git you may need to download the lib and reference it via the pod's path on your machine.

```ruby
pod 'DecouplerKit', :path => 'to Decoupler path/'
```

## TODO
- Registry object management
- Multiple registry management
- MVVM, MVP demo

## Author

iamnaz

## License

DecouplerKit is available under the MIT license. See the LICENSE file for more info.
