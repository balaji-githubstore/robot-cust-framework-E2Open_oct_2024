*** Settings ***
Documentation       This file handles all precondition
Library     RequestsLibrary
Library    SeleniumLibrary
Library    String

*** Variables ***
${CLIENT_ID}        xxxxx
${CLIENT_SECRET}    xxxx
${SCOPE}        repo
${REDIRECT_URI}         https://oauth.pstmn.io/v1/callback

${GIT_USERNAME}     xxxxx
${GIT_PASSWORD}     xxxx

${BASE_URL}     https://api.github.com

*** Keywords ***
Get Access Token
    Create Session    alias=git_oauth    url=https://github.com/login/oauth
#    SeleniumLibrary.Click Element    locator
    &{query_params}     Create Dictionary       client_id=${CLIENT_ID}      scope=${SCOPE}
    ${response}     GET On Session      alias=git_oauth     url=authorize   params=${query_params}
    #can make headlesschrome
    Open Browser    browser=chrome
    Maximize Browser Window
    Set Selenium Implicit Wait    20s
    Go To    url=${response.url}
    Input Text    id:login_field    ${GIT_USERNAME}
    Input Password    id:password    ${GIT_PASSWORD}
    Sleep    8s
    Click Element    xpath=//input[@value='Sign in']
    Wait Until Location Contains    code
    ${current_url}      Get Location
    ${output}    Fetch From Right    ${current_url}      code=
    &{payload}   Create Dictionary   client_id=${CLIENT_ID}      client_secret=${CLIENT_SECRET}      code=${output}
    &{headers}   Create Dictionary   Accept=application/json
    ${response}     POST On Session  alias=git_oauth     url=access_token    data=${payload}     headers=${headers}
    Return From Keyword      ${response.json()}[access_token]

Create Git Session
    Create Session    alias=github1    url=${BASE_URL}

Create Git Session With Basic Auth
    @{cred}     Create List     balaji-githubstore      xxxxxx
    Create Session    alias=github2    url=${BASE_URL}      auth=${cred}

Create Git Session With Bearer Token
    &{headers}   Create Dictionary   Accept=application/vnd.github+json      Authorization=Bearer xxxxxx
    Create Session    alias=github3    url=${BASE_URL}      headers=${headers}

Create PetShop Session
    Create Session    alias=petstore    url=https://petstore.swagger.io/v2/