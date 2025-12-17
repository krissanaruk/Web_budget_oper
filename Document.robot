*** Settings ***

Resource    login_resource.robot
Library     SeleniumLibrary
Library    OperatingSystem
Library    Collections
Suite Setup    Set Screenshot Directory    ${OUTPUT DIR}${/}screenshots
Test Teardown    Close Browser
Test Setup       Login And Navigate To App

*** Variables ***
${INPUT_NAME_DOC}              //input[@placeholder='กรุณาระบุ']
${FILE_PATH}                   ${CURDIR}${/}test_upload.jpg
${Edit_FILE_PATH}              ${CURDIR}${/}test_upload1.0.jpg
${DOWNLOAD_DIR}                C:/Users/krissanaruks/Downloads

# Test data    
${ชื่อเอกสาร}                    เอกสารงบประมาณ
${เเก้ไขชื่อเอกสาร}                เอกสารงบประมาณ1
${ประเภทเอกสารหลัก}             เอกสารเงินนอกงบประมาณ
${ประเภทเอกสารย่อย}             ลักษณะงบบุคลากร
${เเก้ไขประเภทเอกสารหลัก}         เอกสารประกอบแผนงานบุคลากร
${เเก้ไขประเภทเอกสารย่อย}         ลักษณะงบดำเนินงาน

*** Test Cases ***
Go TO Document Success
    [Documentation]    การเข้าสู่หน้าเอกสารประกอบคำขอ
    [Tags]    smoke
    Go TO Document

Add Document Success 
    [Documentation]    เพิ่มเอกสารประกอบคำขอสำเร็จ 
    [Tags]     regression
    Go TO Document
    Wait Until Element Is Visible    xpath=//button[contains(normalize-space(), 'เพิ่มเอกสาร')]    30s
    Click Element    xpath=//button[contains(normalize-space(), 'เพิ่มเอกสาร')]
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'topic') and contains(text(), 'แนบไฟล์เอกสารประกอบ')]    30s
    Input Text    ${INPUT_NAME_DOC}    ${ชื่อเอกสาร} 
    Select Dropdown Option    ประเภทเอกสารหลัก    ${ประเภทเอกสารหลัก}
    Select Dropdown Option    ประเภทเอกสารย่อย    ${ประเภทเอกสารย่อย}
    Choose File    id=dropzone-file    ${FILE_PATH} 
    Sleep    2s
    Click Element    xpath=//button[contains(normalize-space(), 'บันทึก')]
    Wait Until Page Contains    ตกลง    10s
    Click Button    ตกลง
    Sleep    2s

Delete Document Success 
    [Documentation]    ลบเอกสารประกอบคำขอสำเร็จ 
    [Tags]     regression
    Go TO Document
    Wait Until Element Is Visible    xpath=//img[contains(@src, 'trash.svg')]    30s
    Click Element    xpath=//img[contains(@src, 'trash.svg')]
    Wait Until Page Contains    ตกลง    10s
    Click Button    ตกลง
    Sleep     2s

Edit Document Success 
    [Documentation]    เเก้ไขเอกสารประกอบคำขอสำเร็จ 
    [Tags]     regression
    Go TO Document
    Wait Until Element Is Visible    xpath=//img[contains(@src, 'edit.svg')]    30s
    Click Element    xpath=//img[contains(@src, 'edit.svg')]
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'topic') and contains(text(), 'แนบไฟล์เอกสารประกอบ')]    30s
    Input Text    ${INPUT_NAME_DOC}    ${เเก้ไขชื่อเอกสาร}
    Select Dropdown Option    ประเภทเอกสารหลัก    ${ประเภทเอกสารหลัก}
    Select Dropdown Option    ประเภทเอกสารย่อย    ${ประเภทเอกสารย่อย}
    Choose File    id=dropzone-file    ${Edit_FILE_PATH}
    Sleep    2s
    Click Element    xpath=//button[contains(normalize-space(), 'แก้ไข')]
    Wait Until Page Contains    ตกลง    10s
    Click Button    ตกลง
    Sleep    2s

Dowload Document Success 
    [Documentation]    ดาวน์โหลดเอกสารประกอบคำขอสำเร็จ 
    [Tags]     regression
    Go TO Document
    ${user_home}=    Get Environment Variable    USERPROFILE
    ${download_dir}=    Join Path    ${user_home}    Downloads
    @{files_before}=    List Directory    ${download_dir}
    ${count_before}=    Get Length    ${files_before}
    Wait Until Element Is Visible    xpath=//img[contains(@src, 'download-gray.svg')]    30s
    Click Element    xpath=//img[contains(@src, 'download-gray.svg')]
    FOR    ${i}    IN RANGE    10
        Sleep    1s   
        @{files_after}=    List Directory    ${download_dir}
        ${count_after}=    Get Length    ${files_after}
        Exit For Loop If    ${count_after} > ${count_before}
    END
    @{files_final}=    List Directory    ${download_dir}
    ${count_final}=    Get Length    ${files_final}
    Log    หลังกด มีไฟล์ทั้งหมด: ${count_final} ไฟล์
    Should Be True    ${count_final} > ${count_before}    msg=Download Failed! จำนวนไฟล์ไม่เพิ่มขึ้น

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

Go TO Document
    Click Element    xpath=//span[normalize-space()='หน่วยปฏิบัติ']
    Wait Until Keyword Succeeds    5x    1s    Wait Until Element Is Visible    xpath=//div[contains(text(), 'จัดทำคำของบประมาณ (2.3)')]    30s
    Click Element    xpath=//div[contains(text(), 'จัดทำคำของบประมาณ (2.3)')]
    Wait Until Element Is Visible    xpath=//div[contains(text(), 'เอกสารประกอบคำขอ')]    30s
    Click Element    xpath=//div[contains(text(), 'เอกสารประกอบคำขอ')]
    Wait Until Element Is Visible    xpath=//div[contains(text(), 'รายการเอกสาร')]    30s
    Element Should Contain    xpath=//div[contains(text(), 'รายการเอกสาร')]    รายการเอกสาร


*** Keywords ***
Select Dropdown Option
    [Arguments]    ${LABEL_NAME}    ${OPTION_TEXT}
    ${dropdown}=    Set Variable    xpath=//label[contains(., '${LABEL_NAME}')]/following::mat-select[1]
    Wait Until Element Is Visible    ${dropdown}    10s
    Click Element    ${dropdown}
    ${option_xpath}=    Set Variable    xpath=//mat-option//span[contains(normalize-space(), '${OPTION_TEXT}')]
    Wait Until Element Is Visible    ${option_xpath}    10s
    Click Element    ${option_xpath}
    Sleep    0.5s