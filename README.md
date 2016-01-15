# Forge
Forge is a live coding language for generating heavy metal music.

## To use Forge
1. [Download Sonic-Pi](http://sonic-pi.net/ "Sonic-Pi")
2. Copy the contents of [`sonic-pi-buffers/workspace_zero.spi`](sonic-pi-buffers/workspace_zero.spi) into any Sonic-Pi buffer and run. (**_This must be run every time Sonic-Pi is opened_**)

## Forge Examples
* A simple repeating kick drum  - `:drums` *is the name of the* `live_loop` *created.*
```ruby
forge({ :drums => "k" })
```
* A repeating kick and snare - *Spaced items are played simultaneously.*
```ruby
forge({ :drums => "k s" })
```
* A repeating kick then snare - *Listed items are played one after the other. Note that the loop stays the same length.*
```ruby
forge({ :drums => "[k, s]" })
```
* These can be combined in anyway
```ruby
forge({ :drums => "[k, k, k, k] [s, [s, s]]" })
```
* `x` can be used for silence
```ruby
forge({ :drums => "[k, x, s]" })
```
* You can define multiple loops - *Numbers refer to guitar notes.*
```ruby
forge({ :guitar => "[45, 49, 47, 45]",
        :drums => "[k s, k]" })
```
### Additional features
Several shortcuts exist in Forge to make live-coding easier

* `*` can be used to repeat a sound. `k*3` is the same as `[k, k, k]`
* You can spread sounds over intervals using something of the form `k(3,5)` - here 3 kick drums are spread ove 5 beats, so it is equal to `[k, x, k, x, k]`
