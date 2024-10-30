*** Settings ***

Resource    ../../resource/base/CommonFunctionality.resource

Library     DataDriver      file=../../test-data/valid_pet.csv

Test Setup  Create PetShop Session
Test Teardown   Delete All Sessions

Test Template      Find Valid Pet By Id Template

*** Test Cases ***
TC1-${pet_id}

*** Keywords ***
Find Valid Pet By Id Template
    [Arguments]     ${pet_id}       ${expected_name}
    ${response}     GET On Session      alias=petstore      url=pet/${pet_id}       expected_status=any
    Status Should Be    200
    Should Be Equal As Integers    ${response.json()}[id]    ${pet_id}
#    Should Be Equal As Strings    ${response.json()}[name]    ${expected_name}