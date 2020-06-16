# Explain yml file

```
name: A workflow for lighthouse action
on: push
jobs:
    lighthouse_action:
      name: lighthouse action
      runs-on: ubuntu-latest
      steps:
        - name: Checkout
          uses: actions/checkout@v2

        - name: build ngnix
          run: docker image build -t mock-server /home/runner/work/github-action-playground/github-action-playground/packages/web-server/docker/static

        - name: run ngnix  //----> this step will run static nginx server on localhost:11111
          run: docker container run --rm -d -p 11111:80 -v /home/runner/work/github-action-playground/github-action-playground/packages/web-server/out:/usr/share/nginx/html mock-server

        - name: make list of html files //----> this step will produce a file containing html list
          run: |
            mkdir lighthouse-report
            cd /home/runner/work/github-action-playground/github-action-playground/packages/web-server/out
            find . -maxdepth 1 -type f -name '*.html' -not -path '*/\.*' | sed 's/^\.\///g' | sort > /home/runner/work/github-action-playground/github-action-playground/lighthouse-report/files.txt

        - name: run Lighthouse //----> this step will do lighthouse-test on localhost:11111 using the html file list
          env:
            INPUT_TARGET_ADDRESS: http:localhost:11111
            INPUT_LIST_OF_FILES: /usr/src/app/lighthouse-report/files.txt
            INPUT_EXPORT_TO: html
            INPUT_MIN_PERFORMANCE: 0.5
            INPUT_MIN_ACCESSIBILITY: 0.5
            INPUT_MIN_BEST_PRACTICES: 0.5
            INPUT_MIN_SEO: 0.5
            INPUT_MIN_PWA: 0.5
          run: docker container run --network="host" --rm 
              -v /home/runner/work/github-action-playground/github-action-playground/lighthouse-report:/usr/src/app/lighthouse-report 
              -e INPUT_TARGET_ADDRESS=$INPUT_TARGET_ADDRESS 
              -e INPUT_LIST_OF_FILES=$INPUT_LIST_OF_FILES 
              -e INPUT_EXPORT_TO=$INPUT_EXPORT_TO 
              -e INPUT_MIN_PERFORMANCE=$INPUT_MIN_PERFORMANCE 
              -e INPUT_MIN_ACCESSIBILITY=$INPUT_MIN_ACCESSIBILITY 
              -e INPUT_MIN_BEST_PRACTICES=$INPUT_MIN_BEST_PRACTICES 
              -e INPUT_MIN_SEO=$INPUT_MIN_SEO 
              -e INPUT_MIN_PWA=$INPUT_MIN_PWA 
              sijoonlee/lighthouse-v2:latest

        - name: zip report folder //----> zip all report files (a report will be generated for each html)
          run: |
            cd /home/runner/work/github-action-playground/github-action-playground/lighthouse-report
            zip -r /home/runner/work/github-action-playground/github-action-playground/lighthouse-report/lighthouse_report.zip .

        - name: save artifact //----> to enable user to download report files from github action page
          uses: actions/upload-artifact@v1
          with:
            name: report_files
            path: /home/runner/work/github-action-playground/github-action-playground/lighthouse-report/lighthouse_report.zip
```        

# Docker image repo
https://github.com/sijoonlee/lighthouse-docker-image
