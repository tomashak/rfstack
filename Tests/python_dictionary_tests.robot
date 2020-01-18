*** Settings ***
Library  SeleniumLibrary
Library  Collections

Resource  ../Resources/common.robot

*** Variables ***
# element selectors
${PRODUCT_NAME_SELECTOR}        css=#center_column h1
${PRODUCT_CONDITION_SELECTOR}   css=#product_condition span
${PRICE_SELECTOR}               css=#our_price_display

*** Keywords ***
Open Automation Practice Product Detail
    [Arguments]  ${product_id}
    open browser    http://automationpractice.com/index.php?id_product=${product_id}&controller=product     ${BROWSER}
    maximize browser window

*** Test Cases ***
Verify Detail of Product nr1
    [Documentation]     Example of test with "hardcoded" verification of each key from dictionary
    [Setup]         Open Automation Practice Product Detail     1
    [Teardown]      Close Browser
    # prepare expected test data
    &{product}      create dictionary    name=Faded Short Sleeve T-shirts    price=$16.51    condition=New

    # verify elements text in product detail one by one
    element text should be  ${PRODUCT_NAME_SELECTOR}        &{product}[name]
    element text should be  ${PRODUCT_CONDITION_SELECTOR}   &{product}[condition]
    element text should be  ${PRICE_SELECTOR}               &{product}[price]

Verify Detail of Product nr5
    [Documentation]     Example of test with dynamic verification of each key from dictionary.
    ...     Important: keep in sync the selector variable names with the keys in dictionary.
    [Setup]         Open Automation Practice Product Detail     5
    [Teardown]      Close Browser
    # prepare expected test data
    &{product}      create dictionary    product_name=Printed Summer Dress    price=$28.98    product_condition=New

    # verify elements text in product detail, using dynamic loop
    @{keys}     get dictionary keys     ${product}
    :FOR   ${key}   IN      @{keys}
    \    element text should be  ${${key}_SELECTOR}        &{product}[${key}]