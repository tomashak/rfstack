*** Settings ***
Library  SeleniumLibrary

# TODO: zmenit naming convention promennych!

*** Variables ***

*** Keywords ***
Choose category   # todo: opravdu se to tyka jen product list page? nema to byt nahodou v common?
    [Arguments]  ${categoryName}
    click element   css=.head-category-menu
    wait until element is visible   //*[@id='main-menu']//*[@class='desktop-menu__item' and contains(text(), '${categoryName}')]
    mouse over  //*[@id='main-menu']//*[@class='menu-item--title' and contains(text(), '${categoryName}')]

Choose subcategory
    [Arguments]  ${subcategoryName}
    wait until element is visible   //div[@class='new-menu-container']//a[contains(text(), '${subcategoryName}')]
    click element  //div[@class='new-menu-container']//a[contains(text(), '${subcategoryName}')]

Check every item on the list has mandatory fields
    wait until element is visible  //main[@id='content']//article[starts-with(@id,"list")]
    ${noOfElements}   get element count  //main[@id='content']//article[starts-with(@id,"list")]
    ${name}   page should contain element     //main[@id='content']//article[starts-with(@id,"list")]//h3[contains(@class,"lst-product-item-title") and not(text()="")]   limit=${noOfElements}
    ${price}  page should contain element  //main[@id='content']//article[starts-with(@id,"list")]//span[@class="lst-product-item-price-value" and contains(text(),"Kč")]  limit=${noOfElements}
    ${availability}  page should contain element  //main[@id='content']//article[starts-with(@id,"list")]//p[contains(@class,"lst-product-item-availability") and not(text()="")]  limit=${noOfElements}




#Choose item
#    [Arguments]  ${itemNumber}
#    wait until element is visible   //article[@data-position= '${itemNumber}']
#    click element   //article[@data-position= '${itemNumber}']
#    wait until element is visible  //article[@ng-controller='MallWebProduct as detail']/div[@class='pro-wrapper']
#
