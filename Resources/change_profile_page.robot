*** Settings ***
Library  SeleniumLibrary
Library  String

# TODO: zmenit naming convention promennych!

*** Variables ***
${btnMyAccount}=  //section[contains(@class,'nav-customer-content')]//li/a[@data-sel='clientMyAccount' and contains(text(), 'Můj účet')]  # TODO prepsat selektor
${btnModifyAccount}=  //a[@id='modify_account']
${phoneField}=  //input[@id='account-phone']
${btnSaveChanges}=  //p/button[@type='submit']/span[contains(text(), 'Uložit změny')]  # TODO prepsat selektor, at nepouziva text

*** Keywords ***
Go to "Muj ucet"
    wait until element is visible  ${btnMyAccount}
    click element  ${btnMyAccount}

Change profile information
    [Documentation]  Change phone number in client's profile
    wait until element is visible  ${btnModifyAccount}
    click element  ${btnModifyAccount}
    ${existingPhoneNumber}    get text   ${phoneField}
    clear element text  ${phoneField}
    ${newPhoneNumber}   generate random string   6  [NUMBERS]
    input text   ${phoneField}   700${newPhoneNumber}

    set test variable  ${existingPhoneNumber}
    set test variable  ${newPhoneNumber}

Save changes
    wait until element is visible   ${btnSaveChanges}
    click element  ${btnSaveChanges}
    should not be equal   ${existingPhoneNumber}  ${newPhoneNumber}


Check confirming message
    wait until element is visible   //div[@id='flashmessages']//p[contains(text(), 'Vaše údaje byly úspěšně aktualizovány.')]