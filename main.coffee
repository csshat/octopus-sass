_ = require 'lodash'
{css, utils} = require 'octopus-helpers'


declaration = ($$, scssSyntax, property, value, modifier) ->
  return unless value?

  if scssSyntax
    semicolon = ';'
  else
    semicolon = ''

  if modifier
    value = modifier(value)

  $$ "#{property}: #{value}#{semicolon}"


mixin = ($$, scssSyntax, name, value, modifier) ->
  return unless value?

  if scssSyntax
    include = '@include '
  else
    include = '+'

  if modifier
    value = modifier(value)

  $$ "#{include}#{name}(#{value});"


renderColor = (color, colorVariable) ->
  colorVariable = renderVariable(colorVariable)
  if color.a < 1
    "rgba(#{colorVariable}, #{color.a})"
  else
    colorVariable


comment = ($, showTextSnippet, text) ->
  return unless showTextSnippet
  $ "// #{text}"


convertColor = _.partial(css.convertColor, renderColor)


defineVariable = (name, value, options) ->
  semicolon = if options.scssSyntax then ';' else ''
  "$#{name}: #{value}#{semicolon}"


renderVariable = (name) -> "$#{name}"


startSelector = ($, selector, scssSyntax, selectorOptions, text) ->
  return unless selector
  curlyBracket = if scssSyntax then ' {' else ''
  $ '%s%s', utils.prettySelectors(text, selectorOptions), curlyBracket


endSelector = ($, selector, scssSyntax) ->
  $ '}' if selector and scssSyntax


module.exports = {declaration, mixin, renderColor, comment, convertColor, defineVariable, renderVariable, startSelector, endSelector}
