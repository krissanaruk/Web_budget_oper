*** Settings ***
Library     SeleniumLibrary    run_on_failure=Capture Page Screenshot

*** Variables ***
${BROWSER}           Chrome
${LOGIN_URL}         https://neb.centerapp.io/center-web/login
${WEBAPP_URL}        https://neb.centerapp.io/center-web/apps
${Main_URL}          https://neb.centerapp.io/center-web/micro-app?app=a3512d85-2967-4826-b8ec-667c8bf43c74
${APP_URL}           https://neb.centerapp.io/center-web/micro-app?app=5716e440-1ecb-475a-a2ea-26c0b9835fec
${EMAIL_INPUT}       xpath=//*[@id="root"]/div/main/div/div[2]/div/div[2]/div[1]/input
${PASSWORD_INPUT}    xpath=//*[@id="root"]/div/main/div/div[2]/div/div[2]/div[1]/span/input
${LOGIN_BUTTON}      xpath=//*[@id="root"]/div/main/div/div[2]/div/div[2]/div[3]/button

# Test data
${OPER_EMAIL}        oper-unit@neb.go.th
${DEPT_EMAIL}        dept-unit@neb.go.th
${MIN_EMAIL}         min-unit@neb.go.th
${VALID_PASSWORD}    P@ssw0rd
${MSG_LOGIN_SUCCESS}    เข้าสู่ระบบแอดมินสำเร็จ
${INVALID_EMAIL}     1234
${INVALID_PASSWORD}  1234
${NULL_EMAIL}
${NULL_PASSWORD}
${WRONG_MSG_LOGIN}   xpath=//*[contains(text(), 'ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง')]
${NULL_MSG_LOGIN}    xpath=//*[contains(text(), 'กรุณาระบุชื่อผู้ใช้งานและรหัสผ่าน')]

*** Keywords ***
Open Browser To Login Page
    ${chrome_options}    Evaluate    selenium.webdriver.ChromeOptions()    selenium
    Call Method    ${chrome_options}    add_argument    --disable-notifications
    Open Browser    ${LOGIN_URL}    ${BROWSER}    options=${chrome_options}
    Maximize Browser Window
    Wait Until Element Is Visible    ${EMAIL_INPUT}    30s

Perform Login
    [Arguments]    ${username}    ${password}
    Input Text    ${EMAIL_INPUT}       ${username}
    Input Text    ${PASSWORD_INPUT}    ${password}
    Click Element    ${LOGIN_BUTTON}