*** Settings ***
Documentation    Suite description
Library   ../PythonLibrary/csvLibrary.py
Library     String
Library     Collections

*** Variables ***
${REFRESH_TOKEN}=  N/A

*** Keywords ***
Reading refresh token
    [Arguments]  ${cust}  ${app}
    ${selector1}=  convert to lowercase  ${cust}
    ${selector2}=  convert to lowercase  ${app}
    @{data}=        read csv file two select  ../Data/refreshTokens.csv  ${selector1}  ${selector2}
    ${REFRESH_TOKEN}=  get from list  @{data}[0]  2
    set global variable  ${REFRESH_TOKEN}
    should not be equal  ${REFRESH_TOKEN}  N/A    Refresh token was not found for App:${app} and Cust:${cust}
    [Return]  ${REFRESH_TOKEN}


*** Test Cases ***
Test CSV
    [Documentation]  test own library
    ${MyRefreshToken}=  Reading refresh token  cust1  app4