*** Settings ***

Library     ../../resource/base/CommonFunction.py

*** Test Cases ***
TC1
    ${res}      Add     4   55
    Log To Console    ${res}

    ${res}      Cust Sqrt    8
    Log To Console    ${res}