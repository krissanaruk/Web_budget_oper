*** Settings ***

Resource    login_resource.robot
Library     SeleniumLibrary
Suite Setup    Set Screenshot Directory    ${OUTPUT DIR}${/}screenshots
Test Teardown    Close Browser
Test Setup       Login And Navigate To App

*** Variables ***
# Test data
${ชื่อรายการเพิ่มเติม}        (TER)
${Operation area_button}        xpath=//div[contains(text(), 'เพิ่มพื้นที่ดำเนินการ')]

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
    Click Element    xpath=//mat-radio-button[.//input[@type='radio' and @value='1']]
    Select Option In Dialog    กลุ่มรายการ        ราคามาตรฐานครุภัณฑ์ (สงป.)
    Select Option In Dialog    ประเภทรายการ      0801 : ครุภัณฑ์ก่อสร้าง
    Select Option In Dialog    หมวดรายจ่ายย่อย    600 : ค่าครุภัณฑ์
    Click Element    xpath=//mat-dialog-container//button[normalize-space()='ค้นหา']
    Wait Until Element Is Visible    xpath=//mat-dialog-container//tbody//tr[1]//mat-radio-button    30s
    Click Element    xpath=//mat-dialog-container//tbody//tr[1]//mat-radio-button
    Click Element    xpath=//mat-dialog-container//button[normalize-space()='บันทึก']
    Wait Until Element Is Not Visible    xpath=//mat-dialog-container    10s
    Wait Until Element Is Visible    xpath=//label[normalize-space()='ชื่อรายการ (เพิ่มเติม)']    30s
    Input Text    xpath=//textarea[@placeholder='กรุณาเลือก']       ${ชื่อรายการเพิ่มเติม}
    Scroll Element Into View    ${Operation area_button}
    Click Element    ${Operation area_button}
    Wait Until Element Is Visible    xpath=//mat-radio-button[.//input[@type='radio' and @value='Y']]    30s
    Click Element    xpath=//mat-radio-button[.//input[@type='radio' and @value='Y']]
    Click Element    xpath=//mat-dialog-container//button[normalize-space()='บันทึก']
    Wait Until Element Is Visible    xpath=//button[contains(@class, 'swal2-confirm')]    10s
    Click Element    xpath=//button[contains(@class, 'swal2-confirm')]
    Wait Until Element Is Visible    xpath=//*[contains(normalize-space(), 'ส่วนกลาง (ดำเนินการทั่วประเทศ หรือไม่สามารถระบุพื้นที่ดำเนินการได้)')]    30s
    ${unit_dropdown}=    Set Variable    xpath=//label[contains(normalize-space(), 'หน่วยนับ')]/following::mat-select[1]//div[contains(@class, 'mat-mdc-select-trigger')]
    Wait Until Element Is Visible    ${unit_dropdown}    30s
    Click Element    ${unit_dropdown}
    Input Date Successfully    01/01/2025    30/06/2025
    Wait Until Element Is Visible    xpath=//label[normalize-space()='ปิดใช้งาน']        10s
    Click Element    xpath=//label[normalize-space()='ปิดใช้งาน']    
    Wait Until Element Is Visible    xpath=//label[normalize-space()='เปิดใช้งาน']        10s
    Click Element    xpath=//button[normalize-space()='บันทึก']
    Wait Until Page Contains    ตกลง    10s
    Click Button    ตกลง
    Sleep    2s

See REGIS
    [Documentation]    ดูทะเบียนรายการ
    [Tags]     regression
    Go TO REGISTRATION
    ${first_view_btn}=    Set Variable    xpath=//tbody/tr[1]//img[contains(@src, 'view.svg')]
    Wait Until Element Is Visible    ${first_view_btn}    30s
    Click Element    ${first_view_btn}
    Check Field By Label    ทะเบียนรายการ
    Check Field By Label    พื้นที่ดำเนินการ
    Check Field By Label    หน่วยนับ
    Check Field By Label    วันที่เริ่มใช้งาน
    Sleep    5s

Edit REGIS Success
    [Documentation]    เเก้ไขทะเบียนรายการสำเร็จ
    [Tags]     regression
    Go TO REGISTRATION
    Wait Until Element Is Visible    xpath=//img[contains(@src, 'edit.svg')]    30s
    Click Element    xpath=//img[contains(@src, 'edit.svg')]
    Sleep     5s
    Wait Until Element Is Visible    xpath=//label[normalize-space()='ชื่อรายการ (เพิ่มเติม)']    30s
    Input Text    xpath=//textarea[@placeholder='กรุณาเลือก']       ${ชื่อรายการเพิ่มเติม}
    Click Element    xpath=//button[normalize-space()='บันทึก']
    Wait Until Page Contains    ตกลง    10s
    Click Button    ตกลง
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

Go TO REGISTRATION
    Click Element    xpath=//span[normalize-space()='หน่วยปฏิบัติ']
    Wait Until Keyword Succeeds    5x    1s    Wait Until Element Is Visible    xpath=//div[contains(text(), 'จัดทำคำของบประมาณ (2.3)')]    30s
    Click Element    xpath=//div[contains(text(), 'จัดทำคำของบประมาณ (2.3)')]
    Wait Until Element Is Visible    xpath=//div[contains(text(), 'ทะเบียนรายการหน่วยปฏิบัติ')]    30s
    Click Element    xpath=//div[contains(text(), 'ทะเบียนรายการหน่วยปฏิบัติ')]
    Wait Until Element Is Visible    xpath=//div[contains(text(), 'รายการข้อมูล')]    30s
    Element Should Contain    xpath=//div[contains(text(), 'รายการข้อมูล')]    รายการข้อมูล

#ไว้อ่าน เเชทgenerate
Select Option In Dialog
    [Arguments]    ${LABEL_NAME}    ${OPTION_TEXT}
    [Documentation]    เลือก Dropdown 
    ${dropdown_xpath}=    Set Variable    xpath=//mat-dialog-container//label[contains(., '${LABEL_NAME}')]/following::mat-select[1]//div[contains(@class, 'mat-mdc-select-trigger')]
    Wait Until Element Is Visible    ${dropdown_xpath}    30s
    ${element}=    Get WebElement    ${dropdown_xpath}
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${element}
    Sleep    1s   
    Wait Until Element Is Visible    xpath=//span[normalize-space()='${OPTION_TEXT}']    10s
    Click Element    xpath=//span[normalize-space()='${OPTION_TEXT}']

Scroll Down Until Element Found
    [Arguments]    ${locator}
    [Documentation]    เลื่อนลงจนกว่าจะเจอ Element
    FOR    ${i}    IN RANGE    10 
        ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${locator}     
        IF    ${is_visible}
            Scroll Element Into View    ${locator}
            BREAK
        ELSE
            Execute Javascript    window.scrollBy(0, 500)
            Sleep    1s    
        END
    END
    Wait Until Element Is Visible    ${locator}    5s

#ไว้อ่านพิมพ์วันที่ตรงๆ เเชทgenerate
Input Date Successfully
    [Arguments]    ${START_DATE}    ${END_DATE}
    [Documentation]    กรอกวันที่ให้ตรงปีงบประมาณและปิดปฏิทินให้เรียบร้อย
    
    # --- 1. วันที่เริ่มต้น ---
    ${start_locator}=    Set Variable    xpath=//label[contains(normalize-space(), 'วันที่เริ่มใช้งาน')]/following::input[@placeholder='ว/ด/ป'][1]
    Wait Until Element Is Visible    ${start_locator}    30s
    
    # ปลดล็อค -> กรอก -> Enter -> Tab
    ${elem_start}=    Get WebElement    ${start_locator}
    Execute Javascript    arguments[0].removeAttribute('readonly');    ARGUMENTS    ${elem_start}
    Input Text    ${start_locator}    ${START_DATE}
    Press Keys    ${start_locator}    ENTER
    Press Keys    ${start_locator}    TAB
    Sleep    0.5s
    
    # --- 2. วันที่สิ้นสุด ---
    ${end_locator}=      Set Variable    xpath=//label[contains(normalize-space(), 'วันที่สิ้นสุดใช้งาน')]/following::input[@placeholder='ว/ด/ป'][1]
    
    # ปลดล็อค -> กรอก -> Enter -> Tab
    ${elem_end}=      Get WebElement    ${end_locator}
    Execute Javascript    arguments[0].removeAttribute('readonly');    ARGUMENTS    ${elem_end}
    Input Text    ${end_locator}    ${END_DATE}
    Press Keys    ${end_locator}    ENTER
    Press Keys    ${end_locator}    TAB
    Sleep    0.5s
    
    # --- 3. บังคับปิดปฏิทิน (คลิกที่ว่าง) ---
    # คลิกที่ Label "สถานะการใช้งาน" เพื่อดึง Focus ออกมา ปฏิทินจะหุบทันที
    Click Element    xpath=//label[contains(normalize-space(), 'สถานะการใช้งาน')]
    Sleep    1s

Check Field By Label
    [Arguments]    ${LABEL_NAME}
    [Documentation]    เช็คข้อมูลโดยละเอียด (ข้าม Hidden Input และ Div เปล่า)
    ${target_locator}=    Set Variable    xpath=//label[contains(., '${LABEL_NAME}')]/following::*[self::input[not(@type='hidden')] or contains(@class, 'input-text') or self::textarea or self::mat-select][1]
    Wait Until Element Is Visible    ${target_locator}    15s
    ${tag_name}=    Get Element Attribute    ${target_locator}    tagName
    ${class_name}=  Get Element Attribute    ${target_locator}    class
    Log    Checking '${LABEL_NAME}': Found element <${tag_name}> class='${class_name}'
    ${text_val}=     Get Text     ${target_locator}
    ${input_val}=    Get Value    ${target_locator}
    ${final_val}=    Set Variable    ${text_val}${input_val}
    Should Not Be Empty    ${final_val}    msg=Error! ช่อง '${LABEL_NAME}' (Tag: ${tag_name}) เป็นค่าว่างครับ
    Log    Checked '${LABEL_NAME}': Found value '${final_val}'