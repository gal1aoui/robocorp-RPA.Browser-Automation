*** Settings ***
Documentation       Template robot main suite.
Library             RPA.Browser.Selenium    auto_close=${FALSE}
Library             String
Library             RPA.Robocorp.Process
Library             OperatingSystem

*** Variables ***
${var}        css:button[title="voir le numéro"]
${nav}        css:xpath://*[id="container"]/div[1]/div/div[1]/div[2]/div/header/div[1]/nav[2]/div[2]/a[3]/div/span
${profile}    css:xpath://*[id="container"]/div[2]/div/div[1]/div/header/div[1]/nav[2]/div[2]/a[4]/div/div/svg
${nav}        css:xpath://*[id="container"]/div[1]/div/div[1]/div[2]/div/header/div[1]/nav[2]/div[2]/a[3]/div/span
*** Tasks ***
Minimal task
    Attach Chrome Browser                9222
    Go To                                https://www.leboncoin.fr/
    #Wait Until Element Is Visible        ${profile}          
    Read Links


*** Keywords ***
Read Links
    ${File}=    Get File                 contacts.txt
    @{list}=    Split to lines           ${File}

    FOR    ${line}   IN    @{list}
        Go To                                   ${line}
        ${present}    Get Element Count     ${var}

        IF  ${present} != 0
            Wait Until Element Is Visible     ${var}
            Click Element When Visible        ${var}
            Wait Until Element Is Visible     css:a[class="_2qvLx _3osY2 _35pAC _1Vw3w _kC3e _32ILh _2L9kx _30q3D _1y_ge _3QJkO"]    80.0   
            ${number}=     Get Text    css:a[class="_2qvLx _3osY2 _35pAC _1Vw3w _kC3e _32ILh _2L9kx _30q3D _1y_ge _3QJkO"]
            Append To File    phone_numbers.txt      ${number}\n
            Append To File     links_numbers.txt      ${number} :: ${line}\n
        END
        IF  ${present} == 0    CONTINUE
    END