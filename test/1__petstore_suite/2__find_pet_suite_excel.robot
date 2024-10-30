*** Settings ***

Resource    ../../resource/base/CommonFunctionality.resource

Library     DataDriver      file=../../test-data/test-data.xlsx     sheet_name=Find Valid Pet By Id Template

Test Setup  Create PetShop Session
Test Teardown   Delete All Sessions


Test Template      Find Valid Pet By Id Template

*** Test Cases ***
TC1


*** Keywords ***
Find Valid Pet By Id Template
    [Arguments]     ${pet_id}       ${expected_name}
    ${response}     GET On Session      alias=petstore      url=pet/${pet_id}       expected_status=any
    Status Should Be    200
    Should Be Equal As Integers    ${response.json()}[id]    ${pet_id}
#    Should Be Equal As Strings    ${response.json()}[name]    ${expected_name}