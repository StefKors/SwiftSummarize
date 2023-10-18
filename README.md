# SwiftSummarize

SwiftSummarize is the easiest way to create a summary from a String. Internally it's a simple wrapper around CoreServices [SKSummary](https://developer.apple.com/documentation/coreservices/1446229-sksummarycreatewithstring)

**Before**
> Here's to the crazy ones. The misfits. The rebels. The troublemakers. The round pegs in the square holes. The ones who see things differently. They're not fond of rules. And they have no respect for the status quo. You can quote them, disagree with them, glorify or vilify them. About the only thing you can't do is ignore them. Because they change things. They push the human race forward. And while some may see them as the crazy ones, we see genius. Because the people who are crazy enough to think they can change the world, are the ones who do.

**After**
> Because the people who are crazy enough to think they can change the world, are the ones who do
## Install

Add this url to your dependencies:

```
https://github.com/StefKors/SwiftSummarize
```

## Example

```Swift
let input = """
Here's to the crazy ones. The misfits. The rebels. The troublemakers. The round pegs in the square
holes. The ones who see things differently. They're not fond of rules. And they have no respect for the
status quo. You can quote them, disagree with them, glorify or vilify them. About the only thing you
can't do is ignore them. Because they change things. They push the human race forward. And while some
may see them as the crazy ones, we see genius. Because the people who are crazy enough to think they
can change the world, are the ones who do.   
"""

let summary = Summary(text, numberOfSentences: 1)

print(summary.output)
// Because the people who are crazy enough to think they can change the world, are the ones who do
```
Or use it directly on Strings with the extension
```Swift
let input = """
Here's to the crazy ones. The misfits. The rebels. The troublemakers. The round pegs in the square
holes. The ones who see things differently. They're not fond of rules. And they have no respect for the
status quo. You can quote them, disagree with them, glorify or vilify them. About the only thing you
can't do is ignore them. Because they change things. They push the human race forward. And while some
may see them as the crazy ones, we see genius. Because the people who are crazy enough to think they
can change the world, are the ones who do.   
"""

let output = input.summarize(numberOfSentences: 1)

print(output)
// Because the people who are crazy enough to think they can change the world, are the ones who do
```
