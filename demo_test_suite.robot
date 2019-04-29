*** Settings ***
Metadata    Version    1.0
Metadata    Info       Test to amaze everyone
Documentation          This test has three steps: 1. Google Test, which Googles "digital facilitation" and checks if our product comes 
...                    up. 2. Failing Google Test, which checks if the same search includes a site called "www.howsway.jep" and it 
...                    should fail. 3. Homepage Status, which goes to www.howspace.com and fails if the loading time is more than 5 seconds.
Library     SeleniumLibrary
Library     DateTime
Suite Setup    Go to homepage
Suite Teardown    Close All Browsers

*** Variables ***
${HOMEPAGE}    https://www.google.com
${BROWSER}     headlessfirefox
${TRESHOLD}    5
*** Test Cases ***
Google Test
    [Documentation]    Go to Google and search digital facilitation. Check if search results 
    ...                contain www.howspace.com
    [Tags]             Google Test
    Google and check results   digital facilitation    https://www.howspace.com

Failing Google Test
    [Documentation]    SHOULD FAIL! Check if results contain www.howsway.jep
    [Tags]             Failing Google Test
    Google and check results   digital facilitation    https://www.howsway.jep

Homepage Status
    [Documentation]    Go to www.howspace.com and check if it is responding and how fast.
    [Tags]             Homepage Status
    ${time1}=    Get Current Date
    Check homepage responding time    https://www.howspace.com
    ${time2}=    Get Current Date
    ${time}=     Subtract Date From Date    ${time2}    ${time1}
    Run Keyword If    ${time} > ${TRESHOLD}   Fail with msg
    Set Test Message    Load time: ${time}    

*** Keywords ***
Google and check results
    [Arguments]    ${searchkey}    ${searchresult}
    Input Text     name=q          ${searchkey}
    Press Keys     name=q     RETURN
    Wait Until Page Contains       ${searchresult}    timeout=3 s

Check homepage responding time
    [Arguments]    ${address}
    Go To    ${address}
    Wait Until Page Contains Element    id=hs-eu-confirmation-button
    
Go to homepage
    Open Browser    ${HOMEPAGE}    ${BROWSER}   

Fail with msg
    Fail    Page took too long to load (3s)

