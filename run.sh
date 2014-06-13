#!/bin/sh

# validate
if [ ! -n "$WERCKER_TESTFAIRY_APK_FILE" ]
then
    fail "missing apk_file, please check your wercker.yml"
fi

if [ ! -e "$WERCKER_TESTFAIRY_APK_FILE" ]
then
    fail "apk file is not found, please check the apk file path"
fi

if [! -n "$WERCKER_TESTFAIRY_API_KEY" ]
then
    fail "missing api_key, please check your wercker.yml"
fi

curl https://app.testfairy.com/api/upload/ -F api_key="$WERCKER_TESTFAIRY_API_KEY" -F apk_file=@"$WERCKER_TESTFAIRY_APK_FILE"
