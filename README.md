# a11y-combos

The back end for voting on accessible color combinations.

## Installation

```sh
git clone https://github.com/johnotander/a11y-combos-api.git
cd a11y-combos-api
bundle
```

## Usage

```
rails s
rake test
```

```sh
curl -H "Content-Type: application/json" -X POST -d '{"vote": { "value": true }, "combo": ["#111", "#fafafa"]}' http://a11ycombos.herokuapp.com/votes
```
