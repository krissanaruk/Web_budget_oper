*** Settings ***

Resource    login_resource.robot
Library     SeleniumLibrary
Suite Setup    Set Screenshot Directory    ${OUTPUT DIR}${/}screenshots
Test Teardown    Close Browser
Test Setup       Login And Navigate To App

*** Variables ***
# Test data
${ชื่อรายการเพิ่มเติม}        (TER)
${เเก้ไขชื่อรายการเพิ่มเติม}        (TERR)
${Operation area_button}        xpath=//div[contains(text(), 'เพิ่มพื้นที่ดำเนินการ')]

*** Test Cases ***
Go TO REGIS Success
    [Documentation]    การเข้าสู่หน้าทะเบียนรายการ
    [Tags]    smoke
    Go TO REGISTRATION
    Wait Until Element Is Visible    xpath=//div[contains(text(), 'จำนวนทะเบียนทั้งหมด (ไม่รวมปิดใช้งาน)')]    30s
    Wait Until Element Is Visible    xpath=//div[contains(text(), 'จำนวนทะเบียนที่เรียกใช้แล้ว')]    30s
    Wait Until Element Is Visible    xpath=//div[contains(text(), 'จำนวนทะเบียนที่ยังไม่ถูกเรียกใช้งาน')]    30s
    Wait Until Element Is Visible    xpath=//div[contains(text(), 'ปิดใช้งาน')]    30s



#E2E Testting
Add REGIS Success 
    [Documentation]    เพิ่มทะเบียนรายการสำเร็จ 
    [Tags]     integration    e2e
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
    ${target_view_btn}=    Set Variable    xpath=//td[contains(., '${ชื่อรายการเพิ่มเติม}')]/ancestor::tr//img[contains(@src, 'view.svg')]
    Wait Until Element Is Visible    ${target_view_btn}    30s
    ${generated_id}=    Get Text    xpath=//td[contains(., '${ชื่อรายการเพิ่มเติม}')]/ancestor::tr/td[2]
    Log To Console    \nรหัสทะเบียนที่ระบบสร้างให้คือ: ${generated_id}
    Click Element    ${target_view_btn}
    Check Field By Label    ทะเบียนรายการ
    Check Field By Label    พื้นที่ดำเนินการ
    Check Field By Label    หน่วยนับ
    Check Field By Label    วันที่เริ่มใช้งาน
    Sleep    5s

Edit REGIS Success
    [Documentation]    เเก้ไขทะเบียนรายการสำเร็จ
    [Tags]     regression
    Go TO REGISTRATION
    ${target_edit_btn}=    Set Variable    xpath=//td[contains(., '${ชื่อรายการเพิ่มเติม}')]/ancestor::tr//img[contains(@src, 'edit.svg')]
    Wait Until Element Is Visible    ${target_edit_btn}    30s
    Click Element    ${target_edit_btn}
    Sleep    5s
    Wait Until Element Is Visible    xpath=//label[normalize-space()='ชื่อรายการ (เพิ่มเติม)']    30s
    Input Text    xpath=//textarea[@placeholder='กรุณาเลือก']       ${ชื่อรายการเพิ่มเติม}
    Click Element    xpath=//button[normalize-space()='บันทึก']
    Wait Until Page Contains    ตกลง    10s
    Click Button    ตกลง
    Sleep    2s


Change status to Close
    [Documentation]    เปลี่ยนสถานะเป็นปิดใช้งาน
    [Tags]     regression
    Go TO REGISTRATION
    ${target_edit_btn}=    Set Variable    xpath=//td[contains(., '${ชื่อรายการเพิ่มเติม}')]/ancestor::tr//img[contains(@src, 'edit.svg')]
    Wait Until Element Is Visible    ${target_edit_btn}    30s
    Click Element    ${target_edit_btn}
    Sleep    5s
    Wait Until Element Is Visible    xpath=//label[normalize-space()='สถานะการใช้งาน']    30s
    ${is_currently_open}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//label[contains(normalize-space(), 'เปิดใช้งาน')]
    IF    ${is_currently_open} == ${True}
        Click Element    xpath=//label[normalize-space()='เปิดใช้งาน']
        Wait Until Element Is Visible    xpath=//label[normalize-space()='ปิดใช้งาน']    10s
    ELSE
                Click Element    xpath=//label[normalize-space()='ปิดใช้งาน']
        Wait Until Element Is Visible    xpath=//label[normalize-space()='เปิดใช้งาน']    10s
        Click Element    xpath=//label[normalize-space()='เปิดใช้งาน']
        Wait Until Element Is Visible    xpath=//label[normalize-space()='ปิดใช้งาน']    10s
    END
    Click Element    xpath=//button[normalize-space()='บันทึก']
    Wait Until Page Contains    ตกลง    10s
    Click Button    ตกลง
    Sleep    2s

Change status to open
    [Documentation]    เปลี่ยนสถานะเป็นเปิดใช้งาน
    [Tags]     regression
    Go TO REGISTRATION
    ${target_edit_btn}=    Set Variable    xpath=//td[contains(., '${ชื่อรายการเพิ่มเติม}')]/ancestor::tr//img[contains(@src, 'edit.svg')]
    Wait Until Element Is Visible    ${target_edit_btn}    30s
    Click Element    ${target_edit_btn}
    Sleep    5s
    Wait Until Element Is Visible    xpath=//label[normalize-space()='สถานะการใช้งาน']    30s
    ${is_currently_open}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//label[contains(normalize-space(), 'เปิดใช้งาน')]
    IF    ${is_currently_open} == ${True}
        Click Element    xpath=//label[normalize-space()='เปิดใช้งาน']
        Wait Until Element Is Visible    xpath=//label[normalize-space()='ปิดใช้งาน']    10s
        Click Element    xpath=//label[normalize-space()='ปิดใช้งาน']
        Wait Until Element Is Visible    xpath=//label[normalize-space()='เปิดใช้งาน']     10s
    ELSE
        Wait Until Element Is Visible    xpath=//label[normalize-space()='ปิดใช้งาน']    10s
        Click Element    xpath=//label[normalize-space()='ปิดใช้งาน']
        Wait Until Element Is Visible    xpath=//label[normalize-space()='เปิดใช้งาน']    10s
    END
    Click Element    xpath=//button[normalize-space()='บันทึก']
    Wait Until Page Contains    ตกลง    10s
    Click Button    ตกลง
    Sleep    2s

Delete REGIS Success
    [Documentation]    ลบทะเบียนรายการสำเร็จ
    [Tags]     regression
    Go TO REGISTRATION
    Wait Until Element Is Visible    xpath=//button[contains(normalize-space(), 'เลือกรายการ')]    30s
    Click Element    xpath=//button[contains(normalize-space(), 'เลือกรายการ')]
    ${target_checkbox}=    Set Variable    xpath=//td[contains(., '${ชื่อรายการเพิ่มเติม}')]/ancestor::tr//be1-checkbox-green//div[contains(@class, 'checkbox')]
    Wait Until Element Is Visible    ${target_checkbox}    30s
    Click Element    ${target_checkbox} 
    Click Button     ลบรายการ 
    Wait Until Page Contains    ตกลง    10s
    Click Button    ตกลง
    Wait Until Page Contains    ลบรายการสำเร็จ    10s
    Sleep    5s

Go to GIS Success
    [Documentation]    ไปที่GiSสำเร็จ
    [Tags]     smoke
    Go to GIS 
    Wait Until Element Is Visible    xpath=//mat-radio-button[.//input[@type='radio' and @value='N']]    30s
    Click Element    xpath=//mat-radio-button[.//input[@type='radio' and @value='N']]
    Wait Until Element Is Visible    xpath=//mat-radio-button[.//input[@type='radio' and @value='0']]    30s
    Click Element    xpath=//mat-radio-button[.//input[@type='radio' and @value='0']]
    Click Button    เพิ่ม
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'gis-tab') and contains(normalize-space(), 'ระบุพิกัดแบบ Point')]    30s
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'gis-tab') and contains(normalize-space(), 'Line/Polygon/Shape File')]    30s
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'gis-tab') and contains(normalize-space(), 'พิกัดหน่วยปฏิบัติงาน')]    30s


Central Operations Area
    [Documentation]    เลือกพื้นที่ดำเนินการส่วนกลาง
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

Add TH GIS Success
    [Documentation]    ระบุพื้นที่ดำเนินการเป็นไทย
    [Tags]     integration    e2e
    Go to GIS 
    Wait Until Element Is Visible    xpath=//mat-radio-button[.//input[@type='radio' and @value='N']]    30s
    Click Element    xpath=//mat-radio-button[.//input[@type='radio' and @value='N']]
    Wait Until Element Is Visible    xpath=//mat-radio-button[.//input[@type='radio' and @value='0']]    30s
    Click Element    xpath=//mat-radio-button[.//input[@type='radio' and @value='0']]
    Click Button    เพิ่ม
    Wait Until Element Is Visible    xpath=//tbody//tr[1]    10s
    Select GIS Table Dropdown    1    กรุงเทพมหานคร
    Select GIS Table Dropdown    2    ดุสิต
    Select GIS Table Dropdown    3    ดุสิต
    Sleep    3s
    Click Element    xpath=//mat-radio-button[.//input[@type='radio' and @value='true']]
    Run Keyword And Ignore Error    Wait Until Element Is Not Visible    xpath=//div[contains(@class, 'cdk-overlay-backdrop')]    5s
    ${save_btn}=    Get WebElement    xpath=//mat-dialog-container//button[contains(normalize-space(), 'บันทึก')]
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${save_btn}
    Wait Until Page Contains    ตกลง    10s
    Click Button    ตกลง
    ${expected_text}=    Set Variable    แขวงดุสิต เขตดุสิต จังหวัดกรุงเทพมหานคร
    Wait Until Element Is Visible    xpath=//label[contains(normalize-space(), 'พื้นที่ดำเนินการ')]/following::*[contains(normalize-space(), '${expected_text}')]    30s
    Element Should Contain    xpath=//label[contains(normalize-space(), 'พื้นที่ดำเนินการ')]/following::*[contains(normalize-space(), '${expected_text}')]    ${expected_text}
    Input Date Successfully    01/01/2025    30/06/2025
    Wait Until Element Is Visible    xpath=//label[normalize-space()='ปิดใช้งาน']        10s
    Click Element    xpath=//label[normalize-space()='ปิดใช้งาน']    
    Wait Until Element Is Visible    xpath=//label[normalize-space()='เปิดใช้งาน']        10s
    Click Element    xpath=//button[normalize-space()='บันทึก']
    Wait Until Page Contains    ตกลง    10s
    Click Button    ตกลง
    Sleep    2s

Edit TH GIS Success
    [Documentation]    เเก้ไขพื้นที่ดำเนินการไทย
    [Tags]     regression
    Go TO REGISTRATION
    Wait Until Element Is Visible    xpath=//img[contains(@src, 'edit.svg')]    30s
    Click Element    xpath=//img[contains(@src, 'edit.svg')]
    Click Element    ${Operation area_button}
    Wait Until Element Is Visible    xpath=//mat-dialog-container//tbody//tr[1]    10s
    Click Element    xpath=//mat-dialog-container//img[contains(@src, 'edit.svg')]
    Wait Until Element Is Visible    xpath=//tbody//tr[1]    10s
    Select GIS Table Dropdown    1    	กระบี่
    Select GIS Table Dropdown    2      เมืองกระบี่
    Select GIS Table Dropdown    3      ปากน้ำ
    Sleep    3s
    Click Element    xpath=//mat-radio-button[.//input[@type='radio' and @value='true']]
    Run Keyword And Ignore Error    Wait Until Element Is Not Visible    xpath=//div[contains(@class, 'cdk-overlay-backdrop')]    5s
    ${save_btn}=    Get WebElement    xpath=//mat-dialog-container//button[contains(normalize-space(), 'บันทึก')]
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${save_btn}
    Wait Until Page Contains    ตกลง    10s
    Click Button    ตกลง
    ${expected_text}=    Set Variable    แขวงปากน้ำ เขตเมืองกระบี่ จังหวัดกระบี่
    Wait Until Element Is Visible    xpath=//label[contains(normalize-space(), 'พื้นที่ดำเนินการ')]/following::*[contains(normalize-space(), '${expected_text}')]    30s
    Element Should Contain    xpath=//label[contains(normalize-space(), 'พื้นที่ดำเนินการ')]/following::*[contains(normalize-space(), '${expected_text}')]    ${expected_text}
    Sleep    2s

Add Column GIS Success
    [Documentation]    เพิ่มจำนวนพื้นที่ดำเนินการ
    [Tags]     regression
    Go TO REGISTRATION
    Sleep    2s
    Wait Until Element Is Visible    xpath=//img[contains(@src, 'edit.svg')]    30s
    Click Element    xpath=//img[contains(@src, 'edit.svg')]
    Click Element    ${Operation area_button}
    Wait Until Element Is Visible    xpath=//mat-dialog-container//tbody//tr[1]    10s
    Click Element    xpath=//mat-dialog-container//tbody//tr[1]//img[contains(@src, 'edit.svg')]
    Wait Until Element Is Visible    xpath=//tbody//tr[1]    10s
    Select GIS Table Dropdown    1    	กระบี่
    Select GIS Table Dropdown    2      เมืองกระบี่
    Select GIS Table Dropdown    3      ปากน้ำ
    Sleep    3s
    Click Element    xpath=//mat-radio-button[.//input[@type='radio' and @value='true']]
    Click Button    เพิ่ม
    Sleep    3s
    Wait Until Element Is Visible    xpath=//mat-dialog-container//tbody//tr[2]    10s
    Wait Until Element Is Visible    xpath=//tbody//tr[2]    10s
    Select GIS Table Dropdown2    1    		เชียงใหม่
    Select GIS Table Dropdown2    2      เมืองเชียงใหม่
    Select GIS Table Dropdown2    3      ศรีภูมิ
    Sleep    3s
    Run Keyword And Ignore Error    Wait Until Element Is Not Visible    xpath=//div[contains(@class, 'cdk-overlay-backdrop')]    5s
    ${save_btn}=    Get WebElement    xpath=//mat-dialog-container//button[contains(normalize-space(), 'บันทึก')]
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${save_btn}
    Wait Until Page Contains    ตกลง    10s
    Click Button    ตกลง
    ${krabi}=        Set Variable    แขวงปากน้ำ เขตเมืองกระบี่ จังหวัดกระบี่
    ${chiangmai}=    Set Variable    แขวงศรีภูมิ เขตเมืองเชียงใหม่ จังหวัดเชียงใหม่
    Wait Until Element Is Visible    xpath=//label[contains(normalize-space(), 'พื้นที่ดำเนินการ')]/following::*[contains(normalize-space(), '${krabi}')]    30s
    Element Should Contain    xpath=//label[contains(normalize-space(), 'พื้นที่ดำเนินการ')]/following::*[contains(normalize-space(), '${krabi}')]     ${krabi}
    Wait Until Element Is Visible    xpath=//label[contains(normalize-space(), 'พื้นที่ดำเนินการ')]/following::*[contains(normalize-space(), '${chiangmai}')]    30s
    Element Should Contain    xpath=//label[contains(normalize-space(), 'พื้นที่ดำเนินการ')]/following::*[contains(normalize-space(), '${chiangmai}')]    ${chiangmai}
    Sleep    2s

Add UN GIS Success
    [Documentation]    ระบุพื้นที่ดำเนินการเป็นต่างประเทศ
    [Tags]     regression
    Go to GIS 
    Wait Until Element Is Visible    xpath=//mat-radio-button[.//input[@type='radio' and @value='N']]    30s
    Click Element    xpath=//mat-radio-button[.//input[@type='radio' and @value='N']]
    Wait Until Element Is Visible    xpath=//mat-radio-button[.//input[@type='radio' and @value='1']]    30s
    Click Element    xpath=//mat-radio-button[.//input[@type='radio' and @value='1']]
    Click Button    เพิ่ม
    Wait Until Element Is Visible    xpath=//tbody//tr[1]    10s
    Select GIS Table Dropdown    1    รัฐกาตาร์
    Select GIS Table Dropdown    2    โดฮา
    Sleep    3s
    Click Element    xpath=//mat-radio-button[.//input[@type='radio' and @value='true']]
    Run Keyword And Ignore Error    Wait Until Element Is Not Visible    xpath=//div[contains(@class, 'cdk-overlay-backdrop')]    5s
    ${save_btn}=    Get WebElement    xpath=//mat-dialog-container//button[contains(normalize-space(), 'บันทึก')]
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${save_btn}
    Wait Until Page Contains    ตกลง    10s
    Click Button    ตกลง
    ${expected_text}=    Set Variable    เมืองโดฮา ประเทศรัฐกาตาร์
    Wait Until Element Is Visible    xpath=//label[contains(normalize-space(), 'พื้นที่ดำเนินการ')]/following::*[contains(normalize-space(), '${expected_text}')]    30s
    Element Should Contain    xpath=//label[contains(normalize-space(), 'พื้นที่ดำเนินการ')]/following::*[contains(normalize-space(), '${expected_text}')]    ${expected_text}
    Input Date Successfully    01/01/2025    30/06/2025
    Wait Until Element Is Visible    xpath=//label[normalize-space()='ปิดใช้งาน']        10s
    Click Element    xpath=//label[normalize-space()='ปิดใช้งาน']    
    Wait Until Element Is Visible    xpath=//label[normalize-space()='เปิดใช้งาน']        10s
    Click Element    xpath=//button[normalize-space()='บันทึก']
    Wait Until Page Contains    ตกลง    10s
    Click Button    ตกลง
    Sleep    2s

Edit UN GIS Success
    [Documentation]    เเก้ไขพื้นที่ดำเนินการต่างประเทศ
    [Tags]     regression
    Go TO REGISTRATION
    Wait Until Element Is Visible    xpath=//img[contains(@src, 'edit.svg')]    30s
    Click Element    xpath=//img[contains(@src, 'edit.svg')]
    Click Element    ${Operation area_button}
    Wait Until Element Is Visible    xpath=//mat-dialog-container//tbody//tr[1]    10s
    Click Element    xpath=//mat-dialog-container//img[contains(@src, 'edit.svg')]
    Wait Until Element Is Visible    xpath=//tbody//tr[1]    10s
    Select GIS Table Dropdown    1    รัฐกาตาร์
    Select GIS Table Dropdown    2    โดฮา
    Sleep    3s
    Click Element    xpath=//mat-radio-button[.//input[@type='radio' and @value='true']]
    Run Keyword And Ignore Error    Wait Until Element Is Not Visible    xpath=//div[contains(@class, 'cdk-overlay-backdrop')]    5s
    ${save_btn}=    Get WebElement    xpath=//mat-dialog-container//button[contains(normalize-space(), 'บันทึก')]
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${save_btn}
    Wait Until Page Contains    ตกลง    10s
    Click Button    ตกลง
    ${expected_text}=    Set Variable    เมืองโดฮา ประเทศรัฐกาตาร์
    Wait Until Element Is Visible    xpath=//label[contains(normalize-space(), 'พื้นที่ดำเนินการ')]/following::*[contains(normalize-space(), '${expected_text}')]    30s
    Element Should Contain    xpath=//label[contains(normalize-space(), 'พื้นที่ดำเนินการ')]/following::*[contains(normalize-space(), '${expected_text}')]    ${expected_text}
    Sleep    2s

Delete Column GIS
    [Documentation]    การลบคอลัมน์ในพื้นที่ดำเนินการ
    [Tags]     regression
    Go to GIS 
    Wait Until Element Is Visible    xpath=//mat-radio-button[.//input[@type='radio' and @value='N']]    30s
    Click Element    xpath=//mat-radio-button[.//input[@type='radio' and @value='N']]
    Wait Until Element Is Visible    xpath=//mat-radio-button[.//input[@type='radio' and @value='0']]    30s
    Click Element    xpath=//mat-radio-button[.//input[@type='radio' and @value='0']]
    Click Button    เพิ่ม
    Wait Until Element Is Visible    xpath=//tbody//tr[1]    10s
    Select GIS Table Dropdown    1    กรุงเทพมหานคร
    Select GIS Table Dropdown    2    ดุสิต
    Select GIS Table Dropdown    3    ดุสิต
    Sleep    3s
    Click Element    xpath=//mat-radio-button[.//input[@type='radio' and @value='true']]
    Wait Until Element Is Visible    xpath=//img[contains(@src, 'trash.svg')]    30s
    Click Element    xpath=//img[contains(@src, 'trash.svg')]   
    ${save_btn}=    Get WebElement    xpath=//mat-dialog-container//button[contains(normalize-space(), 'บันทึก')]
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${save_btn}
    Wait Until Page Contains    กรุณาเลือก สำหรับแสดงในเอกสารงบประมาณ    30s
    Sleep    5s



เลือกรายการกลางนอกมาตรฐาน
    [Documentation]    เลือกรายการกลางนอกมาตรฐาน
    [Tags]     integration    e2e  
    Go TO REGISTRATION
    Wait Until Element Is Visible    xpath=//button[normalize-space()='เพิ่มรายการ']    30s
    Click Element    xpath=//button[normalize-space()='เพิ่มรายการ']
    Wait Until Element Is Visible    xpath=//button[normalize-space()='เลือกรายการกลาง']    30s
    Click Element    xpath=//button[normalize-space()='เลือกรายการกลาง']
    Wait Until Element Is Visible    xpath=//input[@type='radio' and @value='2']/following-sibling::div[contains(@class, 'mdc-radio__background')]    30s
    Click Element    xpath=//mat-radio-button[.//input[@type='radio' and @value='2']]
    Sleep    1s
    Click Element    xpath=//mat-radio-button[.//input[@type='radio' and @value='2']]
    Select Option In Dialog    กลุ่มรายการ        ราคามาตรฐานครุภัณฑ์ (สงป.)
    Select Option In Dialog    ประเภทรายการ      0803 : ครุภัณฑ์การแพทย์
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
    Run Keyword And Ignore Error    Wait Until Element Is Not Visible    xpath=//div[contains(@class, 'cdk-overlay-backdrop')]    5s
    Sleep    1s
    Wait Until Element Is Visible    xpath=//*[contains(normalize-space(), 'ส่วนกลาง (ดำเนินการทั่วประเทศ หรือไม่สามารถระบุพื้นที่ดำเนินการได้)')]    30s
    ${unit_dropdown}=    Set Variable    xpath=//label[contains(normalize-space(), 'หน่วยนับ')]/following::mat-select[1]//div[contains(@class, 'mat-mdc-select-trigger')]
    Wait Until Element Is Visible    ${unit_dropdown}    30s
    Click Element    ${unit_dropdown}
    Wait Until Element Is Visible    xpath=//mat-option//span[contains(normalize-space(), 'รายการ')]    10s
    Click Element    xpath=//mat-option//span[contains(normalize-space(), 'รายการ')]
    ${amount_input}=    Set Variable    xpath=//label[contains(normalize-space(), 'จำนวนเงินแลกเปลี่ยน')]/following::input[1]
    Wait Until Element Is Visible    ${amount_input}    30s
    Input Text    ${amount_input}    100000
    Sleep    3s
    ${currency_dropdown}=    Set Variable    xpath=//be1-selected[@text='currencyName']//div[contains(@class, 'mat-mdc-select-trigger')]
    Wait Until Element Is Visible    ${currency_dropdown}    30s
    Click Element    ${currency_dropdown}
    Wait Until Element Is Visible    xpath=//mat-option//span[contains(normalize-space(), 'ไทย : บาท (THB)')]    10s
    Click Element    xpath=//mat-option//span[contains(normalize-space(), 'ไทย : บาท (THB)')]
    Sleep    1s   
    Click Element    xpath=//div[contains(@class, 'refresh-frame')]//img[contains(@src, 'refresh.svg')]
    Sleep    1s
    Input Date Successfully    01/01/2025    30/06/2025
    Wait Until Element Is Visible    xpath=//label[normalize-space()='ปิดใช้งาน']        10s
    Click Element    xpath=//label[normalize-space()='ปิดใช้งาน']    
    Wait Until Element Is Visible    xpath=//label[normalize-space()='เปิดใช้งาน']        10s
    Click Element    xpath=//button[normalize-space()='บันทึก']
    Wait Until Page Contains    ตกลง    10s
    Click Button    ตกลง
    Sleep    2s

ดูรายการกลางนอกมาตรฐาน
    [Documentation]    ดูรายการกลางนอกมาตรฐาน
    [Tags]     regression
    Go TO REGISTRATION
    ${target_view_btn}=    Set Variable    xpath=//td[contains(., '${ชื่อรายการเพิ่มเติม}')]/ancestor::tr//img[contains(@src, 'view.svg')]
    Wait Until Element Is Visible    ${target_view_btn}    30s
    ${generated_id}=    Get Text    xpath=//td[contains(., '${ชื่อรายการเพิ่มเติม}')]/ancestor::tr/td[2]
    Log To Console    \nรหัสทะเบียนที่ระบบสร้างให้คือ: ${generated_id}
    Click Element    ${target_view_btn}
    Check Field By Label    ทะเบียนรายการ
    Check Field By Label    พื้นที่ดำเนินการ
    Check Field By Label    หน่วยนับ
    Check Field By Label    จำนวนเงินแลกเปลี่ยน
    Check Field By Label    สกุลเงิน 
    Check Field By Label    ราคาต่อหน่วย (บาท)
    Check Field By Label    วันที่เริ่มใช้งาน
    Sleep    5s

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

Select Option In Dialog2
    [Arguments]    ${LABEL_NAME}    ${OPTION_TEXT}
    [Documentation]    เลือก นอกมาตรฐาน
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

#ไว้อ่านพิมพ์วันที่ตรงๆเข้าไป เเชทgenerate
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

#ไว้อ่าน เเชทgenerate
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
    Should Not Be Empty    ${final_val}    msg=Error! ช่อง '${LABEL_NAME}' (Tag: ${tag_name}) เป็นค่าว่าง
    Log    Checked '${LABEL_NAME}': Found value '${final_val}'


Go to GIS 
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

Select GIS Table Dropdown
    [Arguments]    ${INDEX}    ${OPTION_TEXT}
    [Documentation]    เลือก Dropdown ในตาราง GIS 
    ${dropdown_xpath}=    Set Variable    xpath=(//tbody//tr[1]//mat-select)[${INDEX}]//div[contains(@class, 'mat-mdc-select-trigger')]
    Run Keyword And Ignore Error    Wait Until Element Is Not Visible    xpath=//div[contains(@class, 'ngx-spinner-overlay')]    5s
    Wait Until Element Is Visible    ${dropdown_xpath}    30s
    Click Element    ${dropdown_xpath}
    Wait Until Element Is Visible    xpath=//mat-option//span[contains(normalize-space(), '${OPTION_TEXT}')]    10s
    Click Element    xpath=//mat-option//span[contains(normalize-space(), '${OPTION_TEXT}')]
    Sleep    0.5s
    Run Keyword And Ignore Error    Wait Until Element Is Not Visible    xpath=//div[contains(@class, 'ngx-spinner-overlay')]    5s

Select GIS Table Dropdown2
    [Arguments]    ${INDEX}    ${OPTION_TEXT}
    [Documentation]    เลือก Dropdown ในตาราง GIS 
    ${dropdown_xpath}=    Set Variable    xpath=(//tbody//tr[2]//mat-select)[${INDEX}]//div[contains(@class, 'mat-mdc-select-trigger')]
    Run Keyword And Ignore Error    Wait Until Element Is Not Visible    xpath=//div[contains(@class, 'ngx-spinner-overlay')]    5s
    Wait Until Element Is Visible    ${dropdown_xpath}    30s
    Click Element    ${dropdown_xpath}
    Wait Until Element Is Visible    xpath=//mat-option//span[contains(normalize-space(), '${OPTION_TEXT}')]    10s
    Click Element    xpath=//mat-option//span[contains(normalize-space(), '${OPTION_TEXT}')]
    Sleep    0.5s
    Run Keyword And Ignore Error    Wait Until Element Is Not Visible    xpath=//div[contains(@class, 'ngx-spinner-overlay')]    5s