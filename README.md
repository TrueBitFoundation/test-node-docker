Start the container with
```
docker run -ti -p 22449:80 -p 22448:22448 mrsmkl/webasm-test-docker:latest
```

Then with a web browser, go to `localhost:22449`. You can post a task and see if the binary search works.
