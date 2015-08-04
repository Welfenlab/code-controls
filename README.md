# more-markdown / code-controls

A plugin that can add HTML code for code envirnoments (e.g. Debug buttons).

# Installation

```
npm install @more-markdown/code-controls
```

# Usage

Currently this plugin supports two controls. A `play` button and a `debug` button.
The class of the button specifies which method is run. This package returns a
function that takes the fenced code language tag. Two functions run and debug
and a function that generates the HTML. The element is found via the `data-element-id`
attribute. This plugin searches for the play and debug button in this
element only.

```
var moreMarkdown = require('more-markdown');
var codeControls = require('@more-markdown/code-controls');
var _ = require('lodash');

// create a processor that writes the final html
// to the element with the id 'output'
var proc = moreMarkdown.create('output', processors: [
  codeControls("js", {
      run: eval,
      debug: eval
    }, _.template("<div data-element-id=\"<%= id %>\">"+
        "<button class='play'>Run</button>" +
        "<button class='debug'>Debug</button>" +
      "</div>"
      "<%= html %>"))
  ]);

proc.render("```js"+
'console.log("print this")'
"```");
```
