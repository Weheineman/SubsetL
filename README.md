# SubsetL
A simple DSL to manipulate finite sets. Inspired by the SetL language.

## Build
Stack is necessary to run this project. It can be found [here](https://docs.haskellstack.org/en/stable/README/).


```
stack setup
```

Every time MyLexer.x or MyParser.y are modified, the corresponding .hs files have to be generated. There is a bash script for that:

```
./generateParser
```

Once MyParser.hs and MyLexer.hs have been generated, the project can be built.

```
stack build
```

## Run
Save your programs in the programs folder. Execute them with:

```
stack run SubsetL-exe FileName
```
