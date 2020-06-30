*** Settings ***
Library  SeleniumLibrary

Resource  ../Resources/common.robot
Resource  ../Resources/product_list_page.robot
Resource  ../Resources/product_detail_page.robot
Resource  ../Resources/change_profile_page.robot
Resource  ../Resources/purchase_order_page.robot
Resource  ../Resources/search_bar.robot

# robot -d results tests/mall_tests.robot


Test Setup      Open Homepage
Test Teardown  Close All Browsers

*** Variables ***
${URL}=         https://app.idoklad.cz/Account/Login
${MAIL}=        tomas.hak@tesena.com
${PSW}=         dxm.SjUnvEg94eb
${BROWSER}=     chrome

#page objects
${loginMailInput}=  //input[@id="UserName"]
${loginPswInput}=  //input[@id="Password"]
${loginButton}=  //input[@id="csw-login-button"]

${newInvoiceBtn}=  //div[contains(@class,"csw-overview-fast-steps")]//ul//a[@href="/IssuedInvoice/Create"]
${saveInvoiceBtn}=  //button[@id="csw-card-save"]

*** Keywords ***
Open Homepage
    open browser    ${URL}  ${BROWSER}
    #open browser  ${URL}  remote_url=https://tomashak4:6nd64NMLsr3A7aHH2RAf@hub-cloud.browserstack.com/wd/hub
    ...                   desired_capabilities=browser:edge,browser_version:18.0,os:Windows,os_version:10
    maximize browser window

Login to iDoklad
    [Documentation]  Login using existing credentials
    [Arguments]  ${user}  ${password}  ${lang}=CZ
    wait until page contains  Přihlášení
    wait until element is visible   ${loginMailInput}
    input text  ${loginMailInput}     ${user}
    wait until element is visible   ${loginPswInput}
    input text  ${loginPswInput}     ${password}
    #TODO use lang param
    click element   ${loginButton}
    wait until page contains element  ${newInvoiceBtn}  error="Nebylo nalezeno tlačítko pro Novou fakturu na hlavní stárnce, xpath:"${newInvoiceBtn}


Go to "Nova faktura"
    [Documentation]  Click on New invoice btn
    click element  ${newInvoiceBtn}
    wait until page contains element  ${saveInvoiceBtn}
    capture page screenshot



*** Test Cases ***
TC_01 - HappyPath
    [Tags]  solitea  profile
    [Documentation]  Example of RF test
    Login to iDoklad  ${MAIL}  ${PSW}
    Go to "Nova faktura"

