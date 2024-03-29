# silentauth-sdk-ios

[![Swift Version][swift-image]][swift-url]
[![License][license-image]][license-url]

The only purpose of the SDK is to force the data cellular connectivity prior to call a public URL, and will return the following JSON response

* **Success**
When the data connectivity has been achieved and a response has been received from the url endpoint
```
{
"http_status": string, // HTTP status related to the url
"response_body" : { // optional depending on the HTTP status
           ... // the response body of the opened url 
           ... // see API doc for /device_ip and /redirect
          },
"debug" : {
    "device_info": string, 
    "url_trace" : string
    }
}
```

* **Error** 
When data connectivity is not available and/or an internal SDK error occurred

```
{
"error" : string,
"error_description": string,
"debug" : {
    "device_info": string, 
    "url_trace" : string
    }
}
```
Potential error codes: `sdk_no_data_connectivity`, `sdk_connection_error`, `sdk_redirect_error`, `sdk_error`.


## Installation

Using Package Dependencies 

```swift
import PackageDescription

let package = Package(
    dependencies: [
        .Package(url: "https://github.com/silentauth/silentauth-sdk-ios.git, majorVersion: 0, minor: 0)
    ]
)
```
Using cocoapods 

```
  pod 'silentauth-sdk-ios', '~> x.y.z'

```

## Compatibility

```
Minimum iOS: SilentAuthSDK is compatible with iOS 12+
```

## Size

```
silentauth-sdk-ios: ~115KiB
```

## Usage example

* Is the device eligible for silent authentication?

```swift
import SilentAuthSDK

let sdk: SilentAuthSDK = SilentAuthSDK()
// retrieve access token with coverage scope from back-end
let token = ...
// open the device_ip API endpoint
sdk.openWithDataCellularAndAccessToken(url: URL(string: "https://eu.api.silentauth.com/coverage/v0.1/device_ip")!, accessToken: token, debug: false) { (resp) in
    if (resp["error_code"]) != nil {
        NSLog("\(resp["error_description"])")
    } else {
        let status = resp["http_status"] as! Int
        if (status == 200) {
            let body = resp["response_body"] as! [String : Any]
            NSLog("\n==>device is reachable on \(body["network_name"] as! String)")
        } else if (status == 400) {
            NSLog("\n==>MNO not supported")
        } else if (status == 412) {
            NSLog("\n==>Not mobile IP")
        } else {
            NSLog("\n==>Other error")
        }
    }
}
```

* How to open a check URL 

```swift
import SilentAuthSDK

let sdk: SilentAuthSDK = SilentAuthSDK()

sdk.openWithDataCellular(url: URL(string: checkUrl) , debug: true) { (resp) in
    if (resp["error"]) != nil {
      // error
    } else {
      let status = resp["http_status"] as! Int
      if (status == 200) {
          let body = resp["response_body"] as! [String : Any]
          if let checkId = body["check_id"], let code =  body["code"] {
            var ref: String = ""
            if let _ref = body["reference_id"] { ref = _ref as! String}
            // send code, checkId and ref to back-end 
            // to trigger a PATCH /checks/{check_id}
          } else {
            if let error = body["error"], let desc =  body["error_description"] {
              // error
            } else {
              // invalid response format
            }              
          }
      } else if (status == 400) {
        // MNO not supported
      } else if (status == 412) {
        // MNO a mobile IP
      } else {
        // error
      }
    }

```
## Meta

Distributed under the MIT license. See ``LICENSE`` for more information.

[https://github.com/silentauth](https://github.com/silentauth)

[swift-image]:https://img.shields.io/badge/swift-5.0-green.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
