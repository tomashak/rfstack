*** Settings ***
Library  SeleniumLibrary
Library  RequestsLibrary
Library  robot.libraries.DateTime

#Info about API testing
#testing on: https://jsonplaceholder.typicode.com/  (fake API)

# robot -d results tests/restAPI_tests.robot

Test Setup  create session  TestAPI  ${host_url}  disable_warnings=1
#Test Teardown  Close All Browsers

*** Variables ***
${host_url}=  https://jsonplaceholder.typicode.com
${endpoint_POSTS}=  /posts

*** Test Cases ***
Example API 1
    [Documentation]  Get all posts from API
    [Tags]  api  posts
    ${endpoint_url}=    Replace Variables    ${endpoint_POSTS}     #?bank=${bankCode}&sort=${sort}&order=${order}&page=${page}&size=${size}
    ${resp}=  get request  TestAPI  ${endpoint_url}  #headers=${headers_dict}
    log  ${resp.json()}
    Should Be Equal As Strings  ${resp.status_code}  200  Response: status:${resp.status_code} (expected: 200) : ${resp.json()}


Example API 2
    [Documentation]  Create new post
    [Tags]  api  posts
    ${endpoint_url}=    Replace Variables    ${endpoint_POSTS}
    ${headers_dict}=  create dictionary  Content-Type=application/json; charset=UTF-8
    ${string_json}=  catenate
    ...  {
    ...    "userId": 1989,
    ...    "title": "Test post for course - Tomas Hakx",
    ...    "body": "Post from Advance course Robot Framework - Tesena"
    ...  }
    ${timeBefore} =    Get Current Date
    ${resp}=  post request  TestAPI  ${endpoint_url}  data=${string_json}   headers=${headers_dict}
    ${timeAfter} =    Get Current Date
    ${timeTotalMs} =    Subtract Date From Date    ${timeAfter}    ${timeBefore}    result_format=number
    should be true   ${timeTotalMs} < 0.90  Check time response for API call - ${timeTotalMs}
    log  ${resp.json()}
    ${resp_json}=  set variable  ${resp.json()}
    Should Be Equal As Strings  ${resp.status_code}  201  Response: status:${resp.status_code} (expected: 201) : ${resp.json()}
    should be equal as strings  ${resp_json['userId']}  1989


#TODO - zadat na kurzu
#negativní scénáře, stejnou práci s endpointem comments, připravit vlastní funkce na jednotliva volani


