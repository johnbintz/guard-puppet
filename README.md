Reapply your Puppet configs automatically using Guard! Awesome!

``` ruby
guard 'puppet', :verbose => true, :manifest => 'manifests/site.pp' do
  watch(%r{^(manifests|modules)})
end
```

It's assumed your configs are all in the current folder, which is the
equivalent of `--confdir=$PWD` at the command line. Otherwise,
there's not much use of using Guard with Puppet. :)

Two options so far:

* `:verbose`: Show more output from Puppet (default: `true`)
* `:manifest`: The main manifest file to run (default: `manifests/site.pp`)

Bugs and fixes? You know the drill.

