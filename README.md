# Forge
Forge is a live coding language for generating heavy metal music.

## To use Forge
1. [Download Sonic-Pi](http://sonic-pi.net/ "Download Sonic-Pi")
2. Copy the contents of [`vendor/`](vendor/) into `PATH_TO/Sonic Pi/app/server/vendor/`
3. Copy the contents of [`samples/`](samples/) into `PATH_TO/Sonic Pi/etc/samples/`
4. Copy the contents of [`forge.rb`](forge.rb) into any Sonic-Pi buffer
5. Change `'PATH_TO/grammar/forge_grammar.tt'` on line 2 to the folders local path
6. Run the buffer (**_This must be run every time Sonic-Pi is opened_**)

## Forge Examples
* A simple repeating kick drum  - `:drums` *is the name of the* `live_loop` *created.*
```ruby
forge :drums, "k"
```
* A repeating kick then snare
```ruby
forge :drums, "k s" # Listed items are played one after the other
```
* A repeating kick and snare
```ruby
forge :drums, "[k, s]" # Arrayed items are played simultaneously
```
* These can be combined in anyway
```ruby
forge :drums, "[k k k, cc] [s [s s]]"
```
* `~` can be used for silence
```ruby
forge :drums, "~" # This is an empty loop 
```
* You can define multiple loops
```ruby
forge :guitar, "45 49 47 45" # Numbers refer to guitar notes
forge :drums, "[k k,s]"
```
### Additional features
Several shortcuts exist in Forge to make live-coding easier

* `*` can be used to repeat a sound. `"k*3"` is the same as `"k k k"`
* You can spread sounds over intervals using something of the form `"k(3,5)"` - here 3 kick drums are spread evenly over 5 beats, so it is equal to `"k ~ k ~ k"`
* `/` will cause a sound to last longer. For example in `"45/3"` the note will last 3 times longer than the note in `"45"`
* It is also possibe to define your own sounds in Sonic Pi and call them in Forge. This is done as a function that is evaluated in Forge:
```ruby
# Define your sound as an argumentless function
define :a_chord do
  play 45
  play 47
  play 50
end

forge :guitar, "a_chord" # Call the function in Forge
```
