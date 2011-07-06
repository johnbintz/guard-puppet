Reapply your Puppet configs automatically using Guard! Awesome!

``` ruby
guard 'puppet' do
  watch(%r{^(manifests|modules)})
end
```

It's assumed your configs are all in the current folder, which is the
equivalent of `--confdir=$PWD` at the command line. Otherwise,
there's not much use of using Guard with Puppet. :)

Four options so far:

* `:run_on_start`: Apply Puppet configs when starting Guard (default: `false`)
* `:verbose`: Show more output from Puppet (default: `true`)
* `:debug`: Show even more output from Puppet (default: `false`)
* `:manifest`: The main manifest file to run (default: `manifests/site.pp`)

Bugs and fixes? You know the drill.

