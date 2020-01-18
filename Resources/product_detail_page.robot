*** Settings ***
Library  SeleniumLibrary
Library  String
Library  OperatingSystem

# TODO: zmenit naming convention promennych!

*** Variables ***



*** Keywords ***
Select random item
    wait until element is visible   //main[@id='content']//article[starts-with(@id,"list")]
    ${itemsFound}  get element count  //main[@id='content']//article[starts-with(@id,"list")]//h3[contains(@class,"lst-product-item-title") and not(text()="")]
    ${random int}=  Evaluate  random.randint(1, ${itemsFound})   modules=random
    ${product}=  set variable  (//main[@id='content']//article[starts-with(@id,"list")]//h3[contains(@class,"lst-product-item-title") and not(text()="")])[${random int}]
    ${productNameInList}  get text  ${product}
    ${productPriceInList}  get text  (//main[@id='content']//article[starts-with(@id,"list")]//span[contains(@class,"lst-product-item-price-value")])[${random int}]
    ${productAvailabilityInList}  get text  (//main[@id='content']//article[starts-with(@id,"list")]//p[contains(@class,"lst-product-item-availability")])[${random int}]
    @{productAvailabilityInList}  split string  ${productAvailabilityInList}  ${SPACE}
    ${productAvailabilityInList}=  set variable  @{productAvailabilityInList}[0]
    wait until element is visible  ${product}
    wait until keyword succeeds  5s  1s  click element  ${product}

    wait until element is visible  //h1[@itemprop="name" and contains(text(),"${productNameInList}")]
    wait until element is visible  //b[contains(@class,"pro-price") and contains(text(),"${productPriceInList}")]  timeout=2s
    wait until element is visible  //a[@data-sel="availability-detail" and contains(text(),"${productAvailabilityInList}")]  timeout=2s
    wait until page contains element  //span[@data-sel="catalog-number" and not(text()="")]  timeout=2s

    set global variable  ${productNameInList}

    capture page screenshot  product_detail.png
    file should exist  ${OUTPUT_DIR}/product_detail.png