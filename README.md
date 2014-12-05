To Run the Suite Headless

```Xvfb :10 -ac &```
```sleep 5```
```DISPLAY=:10 cucumber features -f pretty -f html -o report.html```