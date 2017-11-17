Start the container with
```
docker run -ti -p 22449:80 -p 22448:22448 -p 4001:4001 mrsmkl/webasm-test-docker:latest
```

Then with a web browser, go to `localhost:22449`. You can post a task and see if the binary search works.

If you are using Docker Toolbox and can't connect try: `http://192.168.99.100:22449/`
