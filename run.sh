#!/bin/sh

# validate
if [ ! -n "$FLY1TKG_TESTFAIRY_APK_FILE" ]
then
    fail "missing apk_file, please check your wercker.yml"
fi

if [ ! -e "$FLY1TKG_TESTFAIRY_APK_FILE" ]
then
    fail "apk file is not found, please check the apk file path"
fi

if [! -n "$FLY1TKG_TESTFAIRY_API_KEY" ]
then
    fail "missing api_key, please check your wercker.yml"
fi

curl https://app.testfairy.com/api/upload/ -F api_key="$FLY1TKG_TESTFAIRY_API_KEY" -F apk_file=@"$FLY1TKG_TESTFAIRY_APK_FILE"
