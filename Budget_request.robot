*** Settings ***

Resource    login_resource.robot
Library     SeleniumLibrary
Library    OperatingSystem
Library    Collections
Suite Setup    Set Screenshot Directory    ${OUTPUT DIR}${/}screenshots
Test Setup       Login And Navigate To App


*** Variables ***
# Test data      
${amount}        xpath=//*[@id="mat-mdc-dialog-8"]/div/div/app-form-budget-dialog-request/div[1]/div[2]/div[1]/div[4]/div/div[2]/div[2]/be1-number-only
${Elucidation}      xpath=//*[@id="mat-mdc-dialog-8"]/div/div/app-form-budget-dialog-request/div[1]/div[2]/div[6]/input
${FILE_PATH}                   ${CURDIR}${/}test_upload.jpg
${Edit_FILE_PATH}              ${CURDIR}${/}test_upload1.0.jpg
${DOWNLOAD_DIR}                C:/Users/krissanaruks/Downloads

*** Test Cases ***
Go TO Budget Success
    [Documentation]    การเข้าสู่หน้ารายการงบประมาณ
    [Tags]    smoke
    Go TO Budget request

#E2E Testing
Requese Budget success
    [Documentation]    สร้างรายการงบประมาณสำเร็จ
    [Tags]     regression    e2e
    Go TO Budget request
    Click Element    xpath=//button[contains(normalize-space(), 'เพิ่มรายการ')]
    Wait Until Element Is Visible    xpath=//div[contains(text(), 'รายละเอียดรายการ')]    30s
    Element Should Contain    xpath=//div[contains(text(), 'รายละเอียดรายการ')]    รายละเอียดรายการ
    Click Element    id=mat-radio-2
    Select Option Dialog        แผนงานตามยุทธศาสตร์การจัดสรร     6400 : แผนงานบูรณาการต่อต้านการทุจริตและประพฤติมิชอบ   
    Select Option Dialog        ผลผลิต/โครงการ      68000005 : ผลลิตทดสอบแผนงาน 1   
    Select Option Dialog        กิจกรรม             68000044 : กิจกรรมผลลิตทดสอบแผนงาน 1  
    Select Option Dialog        ประเภทงบรายจ่าย      03 : งบลงทุน         
    Select Option Dialog        หมวดรายจ่ายย่อ       600 : ค่าครุภัณฑ์       
    Sleep    3s
    Click Element    xpath=//*[@id="register-list"]/div/div[2]/div[1]
    Wait Until Element Is Visible    xpath=//button[contains(normalize-space(), 'ค้นหา')]    30s
    Click Element    xpath=//button[contains(normalize-space(), 'ค้นหา')]    
    Sleep    5s
    Wait Until Page Contains Element    xpath=//mat-dialog-container//input[@type='radio']    30s
    ${radio_input}=    Get WebElement    xpath=//mat-dialog-container//input[@type='radio']
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${radio_input}
    Sleep    5s
    Wait Until Page Contains Element    xpath=//mat-dialog-container//button[contains(normalize-space(), 'บันทึก')]    30s
    ${save_btn_in_popup}=    Get WebElement    xpath=//mat-dialog-container//button[contains(normalize-space(), 'บันทึก')]
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${save_btn_in_popup}
    Wait Until Element Is Not Visible    xpath=//mat-dialog-container    10s
    Wait Until Element Is Visible    xpath=//button[contains(normalize-space(), 'เพิ่มข้อมูล')]    30s
    Click Element    xpath=//button[contains(normalize-space(), 'เพิ่มข้อมูล')]
    Wait Until Element Is Visible    xpath=//button[contains(normalize-space(), 'เพิ่มประเภทเงิน')]    30s
    Click Element    xpath=//button[contains(normalize-space(), 'เพิ่มประเภทเงิน')]
    Wait Until Element Is Visible    xpath=//div[contains(normalize-space(), 'ค่าใช้จ่ายตามสิทธิ (Entitlement)')]/preceding-sibling::div[contains(@class, 'checkbox')]    30s
    Click Element    xpath=//div[contains(normalize-space(), 'ค่าใช้จ่ายตามสิทธิ (Entitlement)')]/preceding-sibling::div[contains(@class, 'checkbox')]
    Click Button    ตกลง
    Sleep    5s
    Input Text    xpath=//div[contains(@class, 'body-cell')]//input     250
    Sleep    5s
    Wait Until Element Is Visible    xpath=//label[contains(normalize-space(), 'คำชี้แจง')]/following::input[@placeholder='กรุณาระบุ'][1]    30s
    Input Text    xpath=//label[contains(normalize-space(), 'คำชี้แจง')]/following::input[@placeholder='กรุณาระบุ'][1]           Ter
    Click Button    เพิ่มรายละเอียดตัวคูณ
    Element Should Be Visible    xpath=//div[contains(normalize-space(), 'เพิ่มรายละเอียดตัวคูณ')]
    Wait Until Page Contains Element    xpath=//label[contains(normalize-space(), 'เลือกรายการจากราคามาตรฐาน')]/preceding-sibling::mat-radio-button//input[@type='radio']    30s
    ${standard_radio}=    Get WebElement    xpath=//label[contains(normalize-space(), 'เลือกรายการจากราคามาตรฐาน')]/preceding-sibling::mat-radio-button//input[@type='radio']
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${standard_radio}
    Select Option Dialog        กลุ่มรายการ    เกณฑ์ราคากลางคอมพิวเตอร์ (DE)
    Wait Until Page Contains    ตกลง    10s
    Click Button    ตกลง
    Wait Until Page Contains    บันทึก    10s
    Select Option Dialog        เอกสารราคามาตรฐาน    3 2566
    Select Option Dialog        รายการอ้างอิงราคามาตรฐาน    เครื่องคอมพิวเตอร์ สำหรับงานประมวลผล แบบที่ 1 * (จอแสดงภาพขนาดไม่น้อยกว่า 19 นิ้ว)
    Input Text    xpath=//label[contains(normalize-space(), 'จำนวน')]/following-sibling::input      200
    Wait Until Element Is Visible    xpath=(//mat-dialog-container)[last()]//button[normalize-space()='บันทึก']    30s
    ${save_popup_btn}=    Get WebElement    xpath=(//mat-dialog-container)[last()]//button[normalize-space()='บันทึก']
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${save_popup_btn}
    Wait Until Element Is Visible    xpath=//button[contains(normalize-space(), 'แนบเอกสารคำชี้แจง')]    30s
    ${attach_doc_btn}=    Get WebElement    xpath=//button[contains(normalize-space(), 'แนบเอกสารคำชี้แจง')]
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${attach_doc_btn}
    Wait Until Element Is Visible    xpath=//label[contains(normalize-space(), 'ชื่อเอกสาร')]    30s
    Input Text    xpath=//label[contains(normalize-space(), 'ชื่อเอกสาร')]/following::input[1]    เอกสารงบประมาณ
    Choose File    id=dropzone-file    ${FILE_PATH} 
    Sleep    2s
    Click Button    ตกลง
    Wait Until Page Contains    ต่อไป    10s
    Click Button    ต่อไป
    Wait Until Element Is Visible    xpath=//div[contains(text(), 'แผนการใช้จ่ายงบประมาณ')]    30s
    Sleep    2s


*** Keywords ***
Login And Navigate To App
    Open Browser To Login Page
    Perform Login     ${OPER_EMAIL}    ${VALID_PASSWORD}
    Wait Until Location Is    ${Main_URL}    30s
    Wait Until Element Is Visible    xpath=//li[contains(., 'แอปพลิเคชันของฉัน')]    30s
    Click Element    xpath=//li[contains(., 'แอปพลิเคชันของฉัน')]
    ${c2web_locator} =    Set Variable    xpath=//*[contains(text(), 'C2-WEB')]
    Wait Until Element Is Visible    ${c2web_locator}    30s
    Click Element    ${c2web_locator}
    Wait Until Element Is Not Visible    ${c2web_locator}    30s
    Wait Until Element Is Visible    id=iframemicroapp    30s
    Select Frame    id=iframemicroapp
    sleep     5s
    Wait Until Element Is Visible    xpath=//span[normalize-space()='หน่วยปฏิบัติ']    30s

Go TO Budget request
    Click Element    xpath=//span[normalize-space()='หน่วยปฏิบัติ']
    Wait Until Keyword Succeeds    5x    1s    Wait Until Element Is Visible    xpath=//div[contains(text(), 'จัดทำคำของบประมาณ (2.3)')]    30s
    Click Element    xpath=//div[contains(text(), 'จัดทำคำของบประมาณ (2.3)')]
    Wait Until Element Is Visible    xpath=//div[contains(text(), 'รายการงบประมาณ')]    30s
    Click Element    xpath=//div[contains(text(), 'รายการงบประมาณ')]
    sleep     10s
    Wait Until Element Is Visible    xpath=//button[contains(normalize-space(), 'เพิ่มรายการ')]    30s


Select Option Dialog
    [Arguments]    ${LABEL_NAME}    ${OPTION_TEXT}    ${INDEX}=1
    [Documentation]    เลือก Dropdown
    ${dropdown_xpath}=    Set Variable     xpath=//label[contains(., '${LABEL_NAME}')]/following::mat-select[${INDEX}]//div[contains(@class, 'mat-mdc-select-trigger')]
    Wait Until Element Is Visible    ${dropdown_xpath}    30s
    Click Element    ${dropdown_xpath}
    Wait Until Element Is Visible    xpath=//mat-option//span[contains(normalize-space(), '${OPTION_TEXT}')]    10s
    Click Element    xpath=//mat-option//span[contains(normalize-space(), '${OPTION_TEXT}')]
    Sleep    1s

