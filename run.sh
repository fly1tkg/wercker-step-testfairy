#!/bin/sh

validate_params() {
    if [ ! -n "$WERCKER_TESTFAIRY_APK_FILE" ]
    then
        fail "missing apk_file, please check your wercker.yml"
    fi

    if [ ! -e "$WERCKER_TESTFAIRY_APK_FILE" ]
    then
        fail "apk file is not found, please check the apk file path"
    fi

    if [ ! -n "$WERCKER_TESTFAIRY_API_KEY" ]
    then
        fail "missing api_key, please check your wercker.yml"
    fi
}

deploy_to_testfairy() {
    curl -3 https://app.testfairy.com/api/upload/ \
        -F api_key="$WERCKER_TESTFAIRY_API_KEY" \
        -F apk_file=@"$WERCKER_TESTFAIRY_APK_FILE"
}

check_response() {
    if [ ! `echo $1 | grep '"status":"ok"'` ]
    then
        fail "deploying to TestFairy is failed, please check your wercker.yml"
    fi
}

validate_params
RES=`deploy_to_testfairy`
info "TestFairy response: $RES"
check_response $RES
