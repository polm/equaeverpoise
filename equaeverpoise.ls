#prelude funcs: map, pairs-to-obj
prelude = require \prelude-ls
pairs-to-obj = prelude.pairs-to-obj

string2html = ->
    div = document.create-element \div
    div.innerHTML = it
    return div.child-nodes

class Rule
  # A rule for a single mapping
  (@selector, @accessor, opts=null) ~>
    @_push = opts?.push
    @_pull = opts?.extract

  push: (root, data) ~>
    if @_push
      @_push root.query-selector(@selector), data[@accessor]
    else
      root.query-selector(@selector).innerHTML = data[@accessor]

  pull: (root) ~>
    if @_pull
      [@accessor, @_pull root.query-selector(@selector)]
    else
      [@accessor, root.query-selector(@selector).innerHTML]

class Section
  # A page section
  -> @rules = []

  rule: (sel, acc, opts) ~>
    @rules.push new Rule sel, acc, opts

  push: (root, data) ~>
    console.log data
    @rules.map -> it.push root, data

  pull: (root) ~>
    pairs-to-obj @rules.map -> it.pull root

  subsection: (sel, sec) ~>
    @rules.push sel

  list-rule: (sel, acc, opts) ~>
    push = (root, data) ->
      base = root.query-selector(sel).innerHTML
      #data[acc].map 


s = new Section!
s.rule \.name, \name

inner = new Section!
inner.rule \i, \cool
inner.rule \span, \boring

s.rule \.description, \desc, inner

person = {name: "Tester", desc: {cool: \ohyeah, boring: \blahblah}}

s.push document, person

console.log s.pull document

  #TODO:
  #- kill the ifs
  #- add list rule
  #- add subection processing
  #- deal with child sections ?
  #- examples
