*** Settings ***
Library  SeleniumLibrary

Resource  ../Resources/common.robot

*** Variables ***
# element selectors
${MENU_ITEMS_SELECTOR}              css=#block_top_menu > ul > li

*** Keywords ***
Open Automation Practice Homepage
    open browser    http://automationpractice.com/index.php  ${BROWSER}
    maximize browser window

*** Test Cases ***
Verify Menu Item Names
    [Setup]  Open Automation Practice Homepage
    [Teardown]  close browser
    @{expected_menu_item_names}     create list         WOMEN    DRESSES    T-SHIRTS
    @{menu_items}                   get webelements     ${MENU_ITEMS_SELECTOR}

    # verify if the count of menu items match with expected number of items
    ${expected_menu_items_count}    get length      ${expected_menu_item_names}
    ${menu_items_count}             get length      ${menu_items}
    should be equal as numbers      ${menu_items_count}         ${expected_menu_items_count}

    # verify menu item names
    ${i}=   set variable    ${0}
    :FOR    ${expected_menu_item_name}    IN      @{expected_menu_item_names}
    \   element text should be      ${menu_items}[${i}]    ${expected_menu_item_name}
    \   ${i}=   evaluate    ${i}+1  # increment the variable for next loop