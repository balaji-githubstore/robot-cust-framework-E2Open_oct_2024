*** Settings ***

Resource    ../../resource/base/CommonFunctionality.resource

Test Setup  Create PetShop Session
Test Teardown   Delete All Sessions

Test Template      Find Valid Pet By Id Template

*** Test Cases ***
TC1
    2   noya
TC2
    3  john

#TC3
#    [Template]  None
#    [Setup]     None
#    Log To Console    hello
#    [Teardown]     None
#
#TC4
#    [Template]      Find Valid Pet By Id Template
#    3   kevin


*** Keywords ***
Find Valid Pet By Id Template
    [Arguments]     ${pet_id}       ${expected_name}
    ${response}     GET On Session      alias=petstore      url=pet/${pet_id}       expected_status=any
    Status Should Be    200
    Should Be Equal As Integers    ${response.json()}[id]    ${pet_id}
#    Should Be Equal As Strings    ${response.json()}[name]    ${expected_name}