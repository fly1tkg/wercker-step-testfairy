#!/bin/sh

validate_params() {
    # Required parameters
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

set_default_params_if_needed() {
    #Optional parameters
    if [ ! -n "$WERCKER_TESTFAIRY_METRICS" ]
    then
        WERCKER_TESTFAIRY_METRICS="cpu,memory,network,logcat,phone-signal,gps,battery"
    fi

    if [ ! -n "$WERCKER_TESTFAIRY_MAX_DURATION" ]
    then
        WERCKER_TESTFAIRY_MAX_DURATION="10m"
    fi

    if [ ! -n "$WERCKER_TESTFAIRY_VIDEO" ]
    then
        WERCKER_TESTFAIRY_VIDEO="on"
    fi

    if [ ! -n "$WERCKER_TESTFAIRY_VIDEO_QUALITY" ]
    then
        WERCKER_TESTFAIRY_VIDEO_QUALITY="high"
    fi

    if [ ! -n "$WERCKER_TESTFAIRY_VIDEO_RATE" ]
    then
        WERCKER_TESTFAIRY_VIDEO_RATE="1.0"
    fi

    if [ ! -n "$WERCKER_TESTFAIRY_ICON_WAETERMARK" ]
    then
        WERCKER_TESTFAIRY_ICON_WAETERMARK="off"
    fi

    if [ ! -n "$WERCKER_TESTFAIRY_COMMENT" ]
    then
        WERCKER_TESTFAIRY_COMMENT="Deploy of commit: $WERCKER_GIT_COMMIT from branch: $WERCKER_GIT_BRANCH"
    fi
}

deploy_to_testfairy() {
    if [ -n "$WERCKER_TESTFAIRY_PROGUARD_FILE" ]
    then
        PROGUARD_FILE_OPTION="-F proguard_file=@$WERCKER_TESTFAIRY_PROGUARD_FILE"
    fi

    curl -3 https://app.testfairy.com/api/upload/ \
        -F api_key="$WERCKER_TESTFAIRY_API_KEY" \
        -F apk_file=@"$WERCKER_TESTFAIRY_APK_FILE" \
        -F testers_groups="$WERCKER_TESTFAIRY_TESTERS_GROUPS" \
        -F metrics="$WERCKER_TESTFAIRY_METRICS" \
        -F max-duration="$WERCKER_TESTFAIRY_MAX_DURATION" \
        -F video="$WERCKER_TESTFAIRY_VIDEO" \
        -F video-quality="$WERCKER_TESTFAIRY_VIDEO_QUALITY" \
        -F video-rate="$WERCKER_TESTFAIRY_VIDEO_RATE" \
        -F icon-watermark="$WERCKER_TESTFAIRY_ICON_WAETERMARK" \
        -F comment="$WERCKER_TESTFAIRY_COMMENT" \
        $PROGUARD_FILE_OPTION
}

check_response() {
    if [ ! `echo $1 | grep '"status":"ok"'` ]
    then
        fail "deploying to TestFairy is failed, please check your wercker.yml"
    fi
}

validate_params
set_default_params_if_needed
RES=`deploy_to_testfairy`
info "TestFairy response: $RES"
check_response $RES
