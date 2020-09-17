*** Settings ***
Library  SeleniumLibrary
Library  OperatingSystem

# TODO: zmenit naming convention promennych!
# robot -d results tests/Common.robot

*** Variables ***
${URL}=       https://www.mall.cz/
${BROWSER}=     Chrome
${HEADLESS}=   True

# TODO rewrite - this is test data, it should not be in resources but in tests and passed via arguments!
${email}=   tester1901@email.cz
${password}=    TesenaSmartTesting

*** Keywords ***
Open Homepage
    open browser    ${URL}  ${BROWSER}
    maximize browser window

Open chrome in virtualmachine
   [Arguments]  ${START_URL}
   variable should exist  ${HEADLESS}  GLobal variable HEADLESS is not defined
   ${enable_HEADLESS}  set variable  ${HEADLESS}
   ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
   Call Method    ${options}    add_argument    --start-maximized
   Call Method    ${options}    add_experimental_option  useAutomationExtension  ${False}
   run keyword if  '${enable_HEADLESS}' == 'True'  Call Method    ${options}    add_argument    headless
   run keyword if  '${enable_HEADLESS}' == 'True'  Call Method    ${options}    add_argument    disable-gpu
   Call Method    ${options}    add_argument  disable-dev-shm-usage
   #Open Browser      ${START_URL}    ${BROWSER}  chrome_options=${options}
   Create WebDriver    ${BROWSER}   chrome_options=${options}
   Go To  ${START_URL}
   #Open Browser      http://www.yoursite.com    headlesschrome

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