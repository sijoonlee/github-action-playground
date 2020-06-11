#!/bin/bash
export INPUT_TARGET_ADDRESS=http:localhost:11111
export INPUT_EXPORT_TO=html
export INPUT_WILL_CHECK_PASS=yes
export INPUT_MIN_PERFORMANCE=0.5
export INPUT_MIN_ACCESSIBILITY=0.5
export INPUT_MIN_BEST_PRACTICES=0.5
export INPUT_MIN_SEO=0.5
export INPUT_MIN_PWA=0.5

### docker run with env to test localhost:11111
sudo docker container run --network="host" --rm \
-v /usr/src/app/lighthouse-report:/home/runner/work/github-action-playground/github-action-playground/lighthouse-report \
-e INPUT_TARGET_ADDRESS=$INPUT_TARGET_ADDRESS \
-e INPUT_EXPORT_TO=$INPUT_EXPORT_TO \
-e INPUT_WILL_CHECK_PASS=$INPUT_WILL_CHECK_PASS \
-e INPUT_MIN_PERFORMANCE=$INPUT_MIN_PERFORMANCE \
-e INPUT_MIN_ACCESSIBILITY=$INPUT_MIN_ACCESSIBILITY \
-e INPUT_MIN_BEST_PRACTICES=$INPUT_MIN_BEST_PRACTICES \
-e INPUT_MIN_SEO=$INPUT_MIN_SEO \
-e INPUT_MIN_PWA=$INPUT_MIN_PWA \
sijoonlee/lighthouse-v2

read passOrFail < ./lighthouse-report/passOrFail.txt
echo $passOrFail
if [ $passOrFail == "pass" ]; then 
    exit 0
else
    exit 1
fi