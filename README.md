Start the container with
```
docker run --name truebit -ti -p 22449:80 -p 22448:22448 mrsmkl/webasm-test-docker:latest /webasm-solidity/dev.sh
```

Then with a web browser, go to `localhost:22449`. You can post a task and see if the binary search works.

If you are using Docker Toolbox and can't connect try: `http://192.168.99.100:22449/`

Kovan testnet:
```
docker run --name truebit -ti -v -v /srv/paritydata:/root/.local/share/io.parity.ethereum -p 4001:4001 -p 22449:80 -p 22448:22448 mrsmkl/webasm-test-docker:latest /webasm-solidity/kovan.sh
```

Rinkeby testnet:
```
docker run --name truebit -ti -v -v /srv/gethdata:/root/.ethereum -p 4001:4001 -p 22449:80 -p 22448:22448 mrsmkl/webasm-test-docker:latest /webasm-solidity/rinkeby.sh
```

On the testnets, you have to wait until the ethereum clients have synced. You also have to send them test ether to make them work.

