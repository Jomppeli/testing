*** Settings ***
Metadata    Version    1.0
Metadata    Info       This is a demo test
Documentation          This is the documentation of this test suite
Library     SeleniumLibrary
Library     DateTime
Suite Setup    Go to homepage
Suite Teardown    Close All Browsers

*** Variables ***
${HOMEPAGE}    https://www.google.com
${BROWSER}     firefox
${TRESHOLD}    3
*** Test Cases ***
Demo Test
    [Documentation]    Go to Google and search digital facilitation. Check if search results 
    ...                contain www.howspace.com
    Google and check results   digital facilitation    https://www.howspace.com

Failing Demo Test
    [Documentation]    SHOULD FAIL! Check if results contain www.howsway.jep
    Google and check results   digital facilitation    https://www.howsway.jep

Homepage Status
    [Documentation]    Go to www.howspace.com and check if it is responding and how fast.
    ${time1}=    Get Current Date
    Check homepage responding time    https://www.howspace.com
    ${time2}=    Get Current Date
    ${time}=     Subtract Date From Date    ${time2}    ${time1}
    Run Keyword If    ${time} < ${TRESHOLD}   Fail with msg

*** Keywords ***
Google and check results
    [Arguments]    ${searchkey}    ${searchresult}
    Input Text     name=q          ${searchkey}
    Press Keys     name=q     RETURN
    Wait Until Page Contains       ${searchresult}    timeout=5 s

Check homepage responding time
    [Arguments]    ${address}
    Go To    ${address}
    Wait Until Page Contains Element    id=hs-eu-confirmation-button

Go to homepage
    Open Browser    ${HOMEPAGE}    ${BROWSER}   

Fail with msg
    Fail    Page took too long to load (3s)
