*** Settings ***
Library  SeleniumLibrary

# TODO: zmenit naming convention promennych!

*** Variables ***



*** Keywords ***
Search for product by search bar
    [Documentation]  Searching by general name of product (brand)
    [Arguments]  ${searchProductName}
    wait until element is visible  //input[@id='form-sitesearch-input']
    input text  //input[@id='form-sitesearch-input']    ${searchProductName}
    click element  css=.sitesearch-btn

    set test variable  ${searchProductName}

Control list of items
    [Documentation]  Check that searched name appeared in the list of items
    [Arguments]  ${searchProductName}
    wait until element is visible  //main[@id='content']/section
    ${noOFProductItems}     get element count  //main[@id="content"]//article[starts-with(@id,"list")]//a[contains(text(), "${searchProductName}")]
    ${noOfFoundItems}   get element count   //main[@id="content"]//article[starts-with(@id,"list")]
    should be equal as integers   ${noOFProductItems}  ${noOfFoundItems}
