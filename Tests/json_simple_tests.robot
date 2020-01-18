*** Settings ***
Library  OperatingSystem
Library  Collections

*** Test Cases ***
Simple json example
    [Documentation]     To show how to extract data from a simple json file
    ${json_file}=   Get file    Data/simple.json
    &{data}=        Evaluate    json.loads('''${json_file}''')      json
    log  Hello, my name is ${data['firstName']} ${data['lastName']} and my password is ${data['password']}    WARN