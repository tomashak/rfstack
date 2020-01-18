*** Settings ***
Library  OperatingSystem
Library  Collections
Library  SeleniumLibrary
Library  String

Resource  ../Resources/common.robot

*** Variables ***
# element selectors
${MENU_ITEMS_SELECTOR}          //*[@id="block_top_menu"]/ul/li
${SUBMENU_ITEMS_SELECTOR}       //*[@id="block_top_menu"]//*[contains(@class,"submenu-container")]/li/a
${CATEGORY_SELECTOR}            //*[@id="block_top_menu"]//*[contains(@class,"submenu-container")]/li[replace]/ul/li/a

*** Keywords ***
Open Automation Practice Homepage
    open browser    http://automationpractice.com/index.php  ${BROWSER}
    maximize browser window

Get json Data From File
    [Arguments]         ${filepath}
    ${json_file}=       Get file        ${filepath}   # read data from file
    &{dictionary}=      Evaluate        json.loads('''${json_file}''')      json  # parse json data into python dictionary
    [Return]            ${dictionary}

Verify all menu items names
    [Arguments]   @{menu_items}
    ${i}=   Set Variable    ${1}
    :FOR  ${menu_item}    IN    @{menu_items}
    \   &{menu_item_dict}=      convert to dictionary   ${menu_item}
    \   ${expected_name}=       get from dictionary     ${menu_item_dict}           name
    \   run keyword and continue on failure             element text should be      xpath=(${MENU_ITEMS_SELECTOR})[${i}]        ${expected_name}
    \   mouse over              xpath=(${MENU_ITEMS_SELECTOR})[${i}]
    \   ${has_submenu_items}=   run keyword and return status       get from dictionary     ${menu_item_dict}           submenu_items
    \   @{submenu_items}=       run keyword if          ${has_submenu_items}
    ...     get from dictionary     ${menu_item_dict}   submenu_items
    \   run keyword if      ${has_submenu_items}        verify all submenu items names      @{submenu_items}
    \   ${i}=   evaluate    ${i}+1  # increment the variable for next loop

Verify all submenu items names
    [Arguments]   @{submenu_items}
    Set test Variable  ${j}  ${1}
    :FOR  ${submenu_item}    IN      @{submenu_items}
    \   &{submenu_dict}=    convert to dictionary   ${submenu_item}
    \   ${expected_name}=   get from dictionary     ${submenu_dict}             name
    \   run keyword and continue on failure         element text should be      xpath=(${SUBMENU_ITEMS_SELECTOR})[${j}]     ${expected_name}
    \   @{categories}=      get from dictionary     ${submenu_dict}             categories
    \   verify all categories names  @{categories}
    \   set test variable   ${j}    ${j+1}  # increment the variable for next loop

Verify all categories names
    [Arguments]   @{categories}
    Set test Variable  ${k}  ${1}
    ${j_string}=    convert to string  ${j}
    :FOR  ${expected_category_name}    IN      @{categories}
    \   ${element_selector}=    replace string  ${CATEGORY_SELECTOR}        replace     ${j_string}   # replace placeholder by index
    \   run keyword and continue on failure     element text should be      xpath=(${element_selector})[${k}]        ${expected_category_name}
    \   ${k}=   evaluate  ${k}+1  # increment the variable for next loop

*** Test Cases ***
Verify categories
    [Documentation]     Verify upper menu items with product categories.
    ...                 Uses structured json config file: categories.json
    [Setup]  Open Automation Practice Homepage
    [Teardown]  close browser

    # prepare test data - this could be placed in test setup
    &{data}=            get json data from file     Data/categories.json
    @{values}=          get from dictionary         ${data}         menu_items
    verify all menu items names                     @{values}