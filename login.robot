*** Settings ***
Resource    login_resource.robot
Suite Setup    Set Screenshot Directory    ${OUTPUT DIR}${/}screenshots
Test Teardown    Close Browser
Test Setup       Open Browser To Login Page

*** Test Cases ***
Login Success ตรวจสอบการเข้าสู่ระบบด้วยอีเมลและรหัสที่ถูกต้อง
    Perform Login    ${OPER_EMAIL}    ${VALID_PASSWORD}
    Wait Until Location Is    ${Main_URL}    30s

Login Fails ตรวจสอบการเข้าสู่ระบบด้วยอีเมลที่ไม่ถูกต้อง
    Perform Login    ${INVALID_EMAIL}    ${INVALID_PASSWORD}
    Wait Until Element Is Visible    ${WRONG_MSG_LOGIN}    30s

Login Fails ตรวจสอบการเข้าสู่ระบบด้วยการไม่กรอกข้อมูล
    Perform Login    ${NULL_EMAIL}    ${NULL_PASSWORD}
    Wait Until Element Is Visible    ${NULL_MSG_LOGIN}    30s