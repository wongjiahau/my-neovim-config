This config file have a few dependencies:

1. Coc
Fisrt install Node.
```
curl -sL install-node.now.sh/lts | bash
```
Then make sure `npm` install at local instead of root folder to prevent permission issues.
```
npm config set prefix ~/npm
```
Then install COC extensions:
Run in Nvim:
```
:CocInstall coc-tsserver
:CocInstall coc-explorer
```

2. Silver Searcher
Refer https://github.com/ggreer/the_silver_searcher#installing
