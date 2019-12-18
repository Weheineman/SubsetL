# SubsetL
A simple DSL to manipulate finite sets. Inspired by the SetL language.

##Build
Stack is necessary to run this project. It can be found here:
https://docs.haskellstack.org/en/stable/README/


```
stack setup
```

If you don't want to modify MyLexer.x or MyParser.y, skip this command.

```
./generateParser
```

Once MyParser.hs and MyLexer.hs have been generated, the project can be built.

```
stack build
```

##Run
Save your programs in the programs folder. Execute them with:

```
stack run SubsetL-exe FileName
```
