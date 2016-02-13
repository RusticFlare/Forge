# Forge
Forge is a live coding language for generating heavy metal music.

## To use Forge
1. [Download Sonic-Pi](http://sonic-pi.net/ "Download Sonic-Pi")
2. Copy the contents of [`vendor/`](vendor/) into `PATH_TO/sonic-pi/app/server/vendor/`
3. Copy the contents of [`sonic-pi-buffers/workspace_zero.spi`](sonic-pi-buffers/workspace_zero.spi) into any Sonic-Pi buffer
4. Change `'PATH_TO/grammar/forge_grammar.tt'` on line 2 to the folders local path
5. Run the buffer (**_This must be run every time Sonic-Pi is opened_**)

## Forge Examples
* A simple repeating kick drum  - `:drums` *is the name of the* `live_loop` *created.*
```ruby
forge({ :drums => "k" })
```
* A repeating kick then snare
```ruby
forge({ :drums => "k s" }) # Listed items are played one after the other
```
* A repeating kick and snare
```ruby
forge({ :drums => "[k, s]" }) # Arrayed items are played simultaneously
```
* These can be combined in anyway
```ruby
forge({ :drums => "[k k k, hh] [s [s s]]" })
```
* `~` can be used for silence
```ruby
forge({ :drums => "~" }) # This is an empty loop 
```
* You can define multiple loops
```ruby
forge({ :guitar => "45 49 47 45", # Numbers refer to guitar notes
        :drums => "[k k,s]" })
```
### Additional features
Several shortcuts exist in Forge to make live-coding easier

* `*` can be used to repeat a sound. `k*3` is the same as `k k k`
* You can spread sounds over intervals using something of the form `k(3,5)` - here 3 kick drums are spread ove 5 beats, so it is equal to `k ~ k ~ k`
