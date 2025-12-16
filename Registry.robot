*** Settings ***

Resource    login_resource.robot
Library     SeleniumLibrary
Suite Setup    Set Screenshot Directory    ${OUTPUT DIR}${/}screenshots
Test Setup       Login And Navigate To App

*** Variables ***
# Test data
${Test}        (TR)(Najarแก้ไข)1

*** Test Cases ***
Go TO REGIS Success
    [Documentation]    การเข้าสู่หน้าทะเบียนรายการ
    [Tags]    smoke
    Go TO REGISTRATION

Add REGIS Success
    [Documentation]    เพิ่มทะเบียนรายการสำเร็จ
    [Tags]     regression
    Go TO REGISTRATION
    Wait Until Element Is Visible    xpath=//button[normalize-space()='เพิ่มรายการ']    30s
    Click Element    xpath=//button[normalize-space()='เพิ่มรายการ']
    Wait Until Element Is Visible    xpath=//button[normalize-space()='เลือกรายการกลาง']    30s
    Click Element    xpath=//button[normalize-space()='เลือกรายการกลาง']
    Wait Until Element Is Visible    xpath=//input[@type='radio' and @value='1']/following-sibling::div[contains(@class, 'mdc-radio__background')]    30s
    Click Element    xpath=//mat-radio-button[.//input[@type='radio' and @value='1']]
    Sleep    1s
    Select Option By Label    กลุ่มรายการ    ราคามาตรฐานครุภัณฑ์ (สงป.)

# Edit REGIS Success
#     [Documentation]    เเก้ไขทะเบียนรายการสำเร็จ
#     [Tags]     regression
#     Go TO REGISTRATION
#     Wait Until Element Is Visible    xpath=//img[contains(@src, 'edit.svg')]    30s
#     Click Element    xpath=//tr[.//td[normalize-space()='111093']]//img[contains(@src, 'edit.svg')]
#     Wait Until Element Is Visible    xpath=//label[normalize-space()='ชื่อรายการ (เพิ่มเติม)']    30s
#     Input Text    xpath=//textarea[@placeholder='กรุณาเลือก']       ${Test} 
#     Click Element    xpath=//button[normalize-space()='บันทึก']
#     # ใช้ Wait Until Keyword Succeeds เพื่อรอและกดปุ่ม 'ตกลง' แค่ทีเดียว (ทนต่อ Animation)
#     Wait Until Page Contains    ตกลง    10s
#     Click Button    ตกลง
#     Sleep    2s

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

Go TO REGISTRATION
    Click Element    xpath=//span[normalize-space()='หน่วยปฏิบัติ']
    Wait Until Keyword Succeeds    5x    1s    Wait Until Element Is Visible    xpath=//div[contains(text(), 'จัดทำคำของบประมาณ (2.3)')]    30s
    Click Element    xpath=//div[contains(text(), 'จัดทำคำของบประมาณ (2.3)')]
    Wait Until Element Is Visible    xpath=//div[contains(text(), 'ทะเบียนรายการหน่วยปฏิบัติ')]    30s
    Click Element    xpath=//div[contains(text(), 'ทะเบียนรายการหน่วยปฏิบัติ')]
    Wait Until Element Is Visible    xpath=//div[contains(text(), 'รายการข้อมูล')]    30s
    Element Should Contain    xpath=//div[contains(text(), 'รายการข้อมูล')]    รายการข้อมูล

Select Option By Label
    [Arguments]    ${LABEL_NAME}    ${OPTION_TEXT}
    [Documentation]    เลือก Dropdown โดยอ้างอิงจากชื่อหัวข้อ (Label) และกดที่ Trigger ตัวจริง
    
    # 1. สร้าง XPath หาตัว Trigger (div) โดยเริ่มหาจากชื่อหัวข้อ (${LABEL_NAME})
    # ความหมาย: หาข้อความชื่อหัวข้อ -> มองไล่ลงมาหา mat-select ตัวแรก -> เจาะเข้าไปหา div class='mat-mdc-select-trigger'
    ${trigger_xpath}=    Set Variable    xpath=(//*[contains(text(), '${LABEL_NAME}')]/following::mat-select)[1]//div[contains(@class, 'mat-mdc-select-trigger')]
    
    # 2. รอให้ Dropdown ปรากฏ (Visible)
    Wait Until Element Is Visible    ${trigger_xpath}    30s
    Sleep    1s    # รอให้นิ่งสนิทจริงๆ
    
    # 3. ใช้ JavaScript สั่งคลิกที่ Trigger (ไม้ตาย! ทะลุทุกการบัง)
    ${element}=    Get WebElement    ${trigger_xpath}
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${element}
    
    # 4. รอและเลือกรายการที่ต้องการ (Option)
    Wait Until Element Is Visible    xpath=//span[normalize-space()='${OPTION_TEXT}']    10s
    Click Element    xpath=//span[normalize-space()='${OPTION_TEXT}']
    
    # 5. เช็คความเรียบร้อย (รอให้ตัวเลือกหายไป = เลือกเสร็จแล้ว)
    Wait Until Element Is Not Visible    xpath=//span[normalize-space()='${OPTION_TEXT}']    5s
