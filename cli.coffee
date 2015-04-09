fspp = require('./fspp.coffee')
path = require('path')
fs = require('fs')

argv = process.argv
if argv.length != 4
  console.log 'Usage: coffee cli.coffee <input> <output>'
  process.exit()

input_path = path.resolve(argv[2])
output_path = path.resolve(argv[3])

console.log 'Fluxbox Style Preprocessor CLI'
console.log "#{input_path} -> #{output_path}"
console.log 'Opening source'
fs.readFile input_path, 'utf8', (err_input, text) ->
  if err_input
    console.error 'Error opening source'
    console.error err_input
    process.exit()

  console.log 'Compiling source'
  try
    output = fspp.compile(text)
  catch err_compile
    console.error 'Error compiling source'
    console.error err_compile
    process.exit()

  console.log 'Writing output file'
  fs.writeFile output_path, output, (err_output) ->
    if err_output
      console.error 'Error writing output file'
      console.error err_output
      process.exit()

  console.log 'Done'
