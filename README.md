# Annex
Annex is just a little collections of categories I use when developing iOS applications.  Just wanted to get them all in a single repository as a static lib so i can use it as a submodule.

# Contains additions to:
- NSObject
- NSDate 
- NSString
- NSDictionary
- UIColor
- UIView

# Requires:
- Security.framework
- QuartzCore.framework
- UIKit.framework
- Foundation.framework

# Usage:
Include the Annex project in your project, then link to the Annex static lib. Follow up with
```#include<Annex/Annex.h>```