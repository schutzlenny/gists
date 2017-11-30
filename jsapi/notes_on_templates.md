# Notes on the creation of JSAPI Templates

## Code style
* In both CSS and JS, comments should be encapsulated in /* ... */ to prevent problems with the minifier. This can potentially break the code.
* Same as above, missing a ";" in CSS or JS will break the code because of the minifier.
* Code is read more times than it is written so try to think if you'll understand what you did in two months.
* The minifier converts all single quotes (aka apostrophes) to double quotes; this means that if your single-quoted string contains a double quote character, the tempalte will break. You must escape the quotes like `"He said \"hi\" and then left"`.

## Best practices
* Avoid unused code - it makes debugging and maintaining the code much harder; furthermore, more useless code, means the template takes longer to download and render and degrades the user experience.
* If a template is only ever used in one language, translations might be unnecessary.
* Avoid copying lots of CSS from template to template when most of it is not relevant. It's important to know the difference between a "versatile" tempalte and a messy template.
* Best way to have reusable javascript is to encapsulate stuff in functions that can be copied around. Don't forget to comment those functions. (e.g.: the function 'updateProducts').
* It's best to use a "hidden" or "active" class in the tempalte wrapper than hiding and showing a dozen different elements and then hiding/showing them in CSS. A template usually only has a few states e.g. initial, selected, terms accepted and invalid, so 3 or 4 classes should be enough to style them have different styles cascade to each child element.
* Avoid "styles as a class" like `_s-p-l-30` or `_s-fs-20`; they litter the code, are not clear, and will potentially be left unused  while copy pasting around; many templates have dozens of classes like this and it's impossible to know which ones are in use.
* Don't ever copy the whole bootstrap CSS or some madness like that into a template.

## Usability
* Clicking anywhere outside a popup should always close it;
* Keep it simple; fancy animations will probably not be very smooth in the big heavy shops in production;
* If something is clickable, set the approriate cursor `cursor: pointer`;
* Tables not very flexible. Avoid them.

## Technical
* HTML: it's practical to place all texts as variables in the top of the template for easier maintenance and translation.
* HTML: this template use the `underscore` [template engine](http://underscorejs.org/#template). All you need to know:
```  
<%  %> - to execute some js code
<%= %> - to print some value in template
<%- %> - to print some values HTML escaped
```
* JS: `go` = there are no errors or no insurance selected
* JS: `goIns` = an insurance has been selected
* JS: templates should not use jQuery/$ - it might not be available in the shop or the shop might override `$`
* JS: the DOM can be queried with `ender`, which contains `bonzo`. However, `bonzo` is not `jQuery` even though their APIs are similar. Its "jQuery-like" functions are documented here: https://github.com/ded/bonzo
