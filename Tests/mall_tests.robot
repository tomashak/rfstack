*** Settings ***
Library  SeleniumLibrary

Resource  ../Resources/common.robot
Resource  ../Resources/product_list_page.robot
Resource  ../Resources/product_detail_page.robot
Resource  ../Resources/change_profile_page.robot
Resource  ../Resources/purchase_order_page.robot
Resource  ../Resources/search_bar.robot

# robot -d results tests/mall_tests.robot

Suite Setup     Open chrome in virtualmachine  ${URL}
Test Setup      go to  ${URL}
Suite Teardown  Close All Browsers

*** Keywords ***
Open Homepage and Login
    Open Homepage

*** Test Cases ***
TC_01 - SEARCH FOR PRODUCT
    [Tags]  rfstack  mall  search
    Search for product by search bar    Beats
    Control list of items   Beats


TC_02 - PRODUCT'S DETAIL
    [Tags]  rfstack  detail
    Choose category  TV, audio a foto
    Choose subcategory  Televize
    Check every item on the list has mandatory fields
    Select random item


TC_03 - CHANGE PROFILE'S DETAIL
    [Tags]  profile
    Login
    Go to "Muj ucet"
    Change profile information
    Save changes
    Check confirming message


TC_04 - PURCHASE ORDER
    [Tags]  order
    Choose category  TV, audio a foto
    Choose subcategory  Televize
    Select random item
    Add product to cart
    Proceed with order
    Continue to checkout
    Continue to shipping and payment
    Choose shipping type  Doručení na mou adresu
    Choose payment method  Platba při převzetí
    Proceed to order summary




