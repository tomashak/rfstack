*** Settings ***
Library  SeleniumLibrary
Library  OperatingSystem

# TODO: zmenit naming convention promennych!

*** Variables ***
${btnAddToCart}=  //button[@type='button' and contains(@class, 'btn--add-to-cart')]//span[contains(text(), 'Přidat do košíku')]
${btnContinueToCart}=  //p/button[@data-sel='continue-to-cart']/span[contains(text(), 'K objednávce')]
${btnContinueCheckout}=  //div[@class='cart-layout__topbar row']//button[@name='submitButton' and contains(text(), 'K pokladně')]
${btnShippingAndPayment}=  //button[@type='submit']/span[@class='btn-inset' and contains(text(), 'Pokračovat na Dopravu a platbu')]
${checkboxDeliveryType}=  //div[contains(@class, 'delivery-methods')]//input[@name='standardDelivery']/following::span[@class='form-radio']
${btnSubmitShippingType}=  //button[@type='button']/span[@class='btn-inset']
${btnOrderSummary}=  //button[@data-sel='cartContinueToSummaryDesktop']/span

*** Keywords ***
Add product to cart
    wait until element is visible   ${btnAddToCart}
    click element   ${btnAddToCart}
    #wait until element is visible  //p[contains(@class, 'hidden-mobile')]/span[contains(@class, 'lay-inline-block') and contains(text(), 'Položka byla úspěšně přidána do košíku')]
    wait until page contains  Položka byla úspěšně přidána do košíku

Proceed with order
    wait until page contains  ${productNameInList}
    wait until element is visible   ${btnContinueToCart}
    click element   ${btnContinueToCart}
    wait until element is visible  //h1[@class='cart-layout__heading' and contains(text(), 'Košík')]

    capture page screenshot  cart_step1.png
    file should exist   ${OUTPUT_DIR}/cart_step1.png

Continue to checkout
    wait until element is visible   ${btnContinueCheckout}
    click element   ${btnContinueCheckout}
    wait until element is visible  //span[@class='navigation-step-title' and contains(text(), 'Dodací údaje')]

    capture page screenshot  add_info_step2.png
    file should exist   ${OUTPUT_DIR}/add_info_step2.png

Continue to shipping and payment
    wait until page contains  ${productNameInList}
    wait until element is visible   ${btnShippingAndPayment}
    click element   ${btnShippingAndPayment}
    wait until element is visible   //div/h3[@class='cart-heading' and contains(text(), 'Vyberte si způsob doručení')]
    page should contain  Rekapitulace objednávky


Choose shipping type
    [Documentation]  Choose delivery purchase on set address type
    [Arguments]  ${shippingTypeName}
    wait until element is visible   //article[@data-sel= 'OpenCarrier']//div[contains(@class, 'cart-billing-method--button')]//span[contains(text(),'${shippingTypeName}')]
    click element  //article[@data-sel= 'OpenCarrier']//div[contains(@class, 'cart-billing-method--button')]//span[contains(text(),'${shippingTypeName}')]
    wait until element is visible  ${checkboxDeliveryType}
    wait until keyword succeeds  10s  1s  click element  ${checkboxDeliveryType}
    wait until element is visible  ${btnSubmitShippingType}
    click element  ${btnSubmitShippingType}


Choose payment method
    [Documentation]  Choose payment with set method
    [Arguments]  ${paymentMethodName}
    wait until element is visible   //label//span[contains(@class, 'cart-billing-method--button')]//span[contains(text(), '${paymentMethodName}')]
    wait until keyword succeeds  10s  1s  click element   //label//span[contains(@class, 'cart-billing-method--button')]//span[contains(text(), '${paymentMethodName}')]

    capture page screenshot  shiping_payment_step3.png
    file should exist   ${OUTPUT_DIR}/shiping_payment_step3.png

Proceed to order summary
    wait until page contains  ${productNameInList}
    wait until element is visible   ${btnOrderSummary}
    wait until keyword succeeds  10s  1s  click element  ${btnOrderSummary}

    capture page screenshot  summary.png
    file should exist   ${OUTPUT_DIR}/summary.png
