# tekkit2-reactor-filler
Handle logic for GalaciCraft's Compressors so they work with Logistics Pipes correctly

### Installation
0. Place down the blocks as seen on the image below: (TODO)

1. Get SquidDev's git cloner:
```shell
wget https://gist.githubusercontent.com/SquidDev/e0f82765bfdefd48b0b15a5c06c0603b/raw/clone.min.lua clone
```

2. Then clone the repo using it:
```shell
clone https://github.com/Pirulax/tekki2-lp-galacticraft.git lpgc
```

3. Make a new `startup.lua` that will run this program with the wanted recipe:
```lua
shell.run("main.lua galacticraftcore:basic_item/11 minecraft:coal galacticraftcore:basic_item/11")
```
