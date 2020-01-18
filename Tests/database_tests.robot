*** Settings ***
Library  DatabaseLibrary

Resource  ../Resources/common.robot

# TODO: zmenit naming convention promennych!
    #  robot -d results tests/database_tests.robot

Suite Setup  Connect to Testing Database

*** Test Cases ***
Check number of rows in table
    ${rowCount}  row count  select * from user;
    Log  ${rowCount}

Check number of Females
    ${noFemale}  row count  select * from user where gender = 'Female'
    Log  ${noFemale}

Check if data exists
    check if exists in database  select id from user where first_name = 'Frank'

Find data from table
    @{queryResults}  query  select * from user  #where id = 10
    Log many  @{queryResults}