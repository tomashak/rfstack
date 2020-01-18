*** Settings ***
Library  SeleniumLibrary
Library  OperatingSystem

# TODO: zmenit naming convention promennych!
# robot -d results tests/Common.robot

*** Variables ***
${URL}=       https://www.mall.cz/
${BROWSER}=     chrome

# TODO rewrite - this is test data, it should not be in resources but in tests and passed via arguments!
${email}=   tester1901@email.cz
${password}=    TesenaSmartTesting

*** Keywords ***
Open Homepage
    open browser    ${URL}  ${BROWSER}
    maximize browser window

Login
    [Documentation]  Login using existing credentials
    click element   //a[@data-id='login']    # TODO dat nahoru do promennych
    Enter Email
    Enter Password
    click element   //p/button[@type='submit']/span   # TODO dat nahoru do promennych
    wait until element contains   //a[@data-id='login']    Tester1901 T.

Enter Email
    [Documentation]   Input email for login process
    wait until element is visible   //input[@id='customer-auth-email']  # TODO dat nahoru do promennych
    input text  //input[@id='customer-auth-email']     ${email}

Enter Password
    [Documentation]   Input password for login process
    wait until element is visible   //input[@id='customer-auth-password']  # TODO dat nahoru do promennych
    input password  //input[@id='customer-auth-password']   ${password}

Connect to Testing Database
    #Connect To Database	   dbConfigFile=${CURDIR}/../Configs/database.cfg
    Connect To Database	    dbapiModuleName=pymysql     dbHost=remotemysql.com      dbName=neA5AZzbNk       dbPort=3306
    ...                     dbUsername=neA5AZzbNk       dbPassword=pSsoVm9bme