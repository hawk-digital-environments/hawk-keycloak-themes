<#import "template.ftl" as layout>
<@layout.registrationLayout displayRequiredFields=false displayMessage=!messagesPerField.existsError('totp','userLabel'); section>
<!-- template: login-config-totp.ftl -->

    <#if section = "header">
        ${msg("loginTotpTitle")}
    <#elseif section = "form">
        <hawk-typo>
            <ol id="kc-totp-settings" class="pf-v5-c-list pf-v5-u-mb-md">
                <li>
                    <p>${msg("loginTotpStep1")}</p>

                    <ul id="kc-totp-supported-apps">
                        <#list totp.supportedApplications as app>
                            <li><strong>${msg(app)}</strong></li>
                        </#list>
                    </ul>
                </li>

                <#if mode?? && mode = "manual">
                    <li>
                        <p>${msg("loginTotpManualStep2")}</p>
                        <p><span id="kc-totp-secret-key">${totp.totpSecretEncoded}</span></p>
                        <p><a href="${totp.qrUrl}" id="mode-barcode">${msg("loginTotpScanBarcode")}</a></p>
                    </li>
                    <li>
                        <p>${msg("loginTotpManualStep3")}</p>
                        <p>
                        <ul>
                            <li id="kc-totp-type">${msg("loginTotpType")}: ${msg("loginTotp." + totp.policy.type)}</li>
                            <li id="kc-totp-algorithm">${msg("loginTotpAlgorithm")}: ${totp.policy.getAlgorithmKey()}</li>
                            <li id="kc-totp-digits">${msg("loginTotpDigits")}: ${totp.policy.digits}</li>
                            <#if totp.policy.type = "totp">
                                <li id="kc-totp-period">${msg("loginTotpInterval")}: ${totp.policy.period}</li>
                            <#elseif totp.policy.type = "hotp">
                                <li id="kc-totp-counter">${msg("loginTotpCounter")}: ${totp.policy.initialCounter}</li>
                            </#if>
                        </ul>
                        </p>
                    </li>
                <#else>
                    <li>
                        <p>${msg("loginTotpStep2")}</p>
                        <img id="kc-totp-secret-qr-code" src="data:image/png;base64, ${totp.totpSecretQrCode}" alt="Figure: Barcode"><br/>
                        <p><a href="${totp.manualUrl}" id="mode-manual">${msg("loginTotpUnableToScan")}</a></p>
                    </li>
                </#if>
                <li>
                    <p>${msg("loginTotpStep3")}</p>
                    <p>${msg("loginTotpStep3DeviceName")}</p>
                </li>
            </ol>
        </hawk-typo>

        <form action="${url.loginAction}" class="${properties.kcFormClass!}" id="kc-totp-settings-form" method="post" novalidate="novalidate">
            <hawk-formwrap>
                <hawk-input
                        id="totp"
                        name="totp"
                        block="true"
                        autocomplete="one-time-code"
                        inputmode="numeric"
                        required="true"
                        label="${msg("authenticatorCode")}"
                        <#if messagesPerField.existsError('totp')>error="${kcSanitize(messagesPerField.get('totp'))?no_esc}"</#if>
                ></hawk-input>
                <input type="hidden" id="totpSecret" name="totpSecret" value="${totp.totpSecret}" />
                <#if mode??><input type="hidden" id="mode" name="mode" value="${mode}"/></#if>
                <hawk-input
                        id="userLabel"
                        name="userLabel"
                        block="true"
                        <#if totp.otpCredentials?size gte 1>required="true"</#if>
                        label="${msg("loginTotpDeviceName")}"
                        <#if messagesPerField.existsError('userLabel')>error="${kcSanitize(messagesPerField.get('userLabel'))?no_esc}"</#if>
                >
                </hawk-input>
                <hawk-checkbox
                            label="${msg("logoutOtherSessions")}"
                            checked="false"
                            id="logout-sessions"
                            name="logout-sessions">
                </hawk-checkbox>
                <div class="pf-v5-c-form__group pf-m-action">
                    <div class="pf-v5-c-form__actions">
                        <#if isAppInitiatedAction??>
                            <hawk-button
                                    name="saveTOTPBtn"
                                    id="saveTOTPBtn"
                                    size="large"
                                    value="${msg("doSubmit")}"
                                    submit="true"
                            >${msg("doSubmit")}</hawk-button>
                            <form action="${url.loginAction}" method="post" novalidate="novalidate">
                                <hawk-button
                                        name="cancel-aia"
                                        id="cancelTOTPBtn"
                                        size="large"
                                        type="outlined"
                                        value="true"
                                        onclick="document.getElementById('cancel-totp-form').submit(); return false;"
                                >${msg("doCancel")}</hawk-button>
                            </form>
                        <#else>
                            <hawk-button
                                    name="saveTOTPBtn"
                                    id="saveTOTPBtn"
                                    size="large"
                                    value="${msg("doSubmit")}"
                                    submit="true"
                            >${msg("doSubmit")}</hawk-button>
                        </#if>
                    </div>
                </div>
            </hawk-formwrap>
        </form>
        <form action="${url.loginAction}" method="post" novalidate="novalidate" id="cancel-totp-form">
            <input type="hidden" name="cancel-aia" value="true"/>
        </form>
    </#if>
</@layout.registrationLayout>
