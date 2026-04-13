___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Zigpoll",
  "categories": [
    "SURVEY",
    "PERSONALIZATION"
  ],
  "brand": {
    "id": "brand_dummy",
    "displayName": "New North Digital",
    "thumbnail": ""
  },
  "description": "Zigpoll survey and poll widget. Load the Zigpoll script to display surveys, polls, and quizzes on your website.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "accountId",
    "displayName": "Account ID",
    "simpleValueType": true,
    "help": "Your Zigpoll account ID. Find it in the Zigpoll dashboard under Settings or in the embed code.",
    "alwaysInSummary": true,
    "valueValidators": [{"type": "NON_EMPTY"}]
  },
  {
    "type": "TEXT",
    "name": "pollId",
    "displayName": "Poll ID (optional)",
    "simpleValueType": true,
    "help": "Force a specific poll to display, overriding Zigpoll's targeting rules. Leave empty to use automatic display rules.",
    "canBeEmptyString": true
  },
  {
    "type": "GROUP",
    "name": "debugging",
    "displayName": "Debugging",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "CHECKBOX",
        "name": "debug",
        "checkboxText": "Log debug messages to console",
        "simpleValueType": true
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

var log = require('logToConsole');
var injectScript = require('injectScript');
var setInWindow = require('setInWindow');
var makeString = require('makeString');

var enableDebug = data.debug;
var debugLog = function(msg) {
  if (enableDebug) log('Zigpoll GTM - ' + msg);
};

var accountId = makeString(data.accountId);

// Set up the Zigpoll global config before script loads
var zigpollConfig = {
  accountId: accountId
};

// Add optional poll ID if provided
if (data.pollId) {
  zigpollConfig.pollId = makeString(data.pollId);
  debugLog('Forcing poll ID: ' + zigpollConfig.pollId);
}

setInWindow('Zigpoll', zigpollConfig, true);
debugLog('Configured with account ID: ' + accountId);

// Inject the Zigpoll script
var scriptUrl = 'https://cdn.zigpoll.com/static/js/main.js';

injectScript(scriptUrl, function() {
  debugLog('Zigpoll script loaded');
  data.gtmOnSuccess();
}, function() {
  debugLog('Zigpoll script failed to load');
  data.gtmOnFailure();
}, 'zigpoll-widget');


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "inject_script"
      },
      "param": [
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://cdn.zigpoll.com/*"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {},
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_globals"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "Zigpoll"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "logging"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: Script loads with account ID
  code: |-
    var mockData = {
      accountId: 'abc123'
    };

    mock('injectScript', function(url, success, failure, token) {
      success();
    });

    runCode(mockData);

    assertApi('setInWindow').wasCalledWith('Zigpoll', {accountId: 'abc123'}, true);
    assertApi('gtmOnSuccess').wasCalled();
- name: Optional poll ID is set when provided
  code: |-
    var mockData = {
      accountId: 'abc123',
      pollId: 'poll456'
    };

    mock('injectScript', function(url, success, failure, token) {
      success();
    });

    runCode(mockData);

    assertApi('setInWindow').wasCalledWith('Zigpoll', {accountId: 'abc123', pollId: 'poll456'}, true);
    assertApi('gtmOnSuccess').wasCalled();
- name: Script failure calls gtmOnFailure
  code: |-
    var mockData = {
      accountId: 'abc123'
    };

    mock('injectScript', function(url, success, failure, token) {
      failure();
    });

    runCode(mockData);

    assertApi('gtmOnFailure').wasCalled();


___NOTES___

Created on 4/3/2026, by New North Digital.


