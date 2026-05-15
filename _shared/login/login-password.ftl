<#import "template.ftl" as layout>
<#import "hawk-title.ftl" as hawkTitle>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('password'); section>
    <#if section = "headerNoTypo">
        <@hawkTitle.content />
    <#elseif section = "formNoTypo">
        <div id="kc-form">
            <div id="kc-form-wrapper">
                <form id="kc-form-login" onsubmit="var button = this.querySelector('[name=login]'); if (button) button.setAttribute('disabled', 'true'); return true;" action="${url.loginAction}"
                      method="post">
                    <br>
                    <hawk-formwrap>
                        <div class="${properties.kcFormGroupClass!} no-bottom-margin">
                            <hawk-input-password
                                    id="password"
                                    label="${msg("password")}"
                                    name="password"
                                    block="true"
                                    autocomplete="current-password"
                                    <#if messagesPerField.existsError('password')>error="${kcSanitize(messagesPerField.getFirstError('password'))?no_esc}"</#if>
                            ></hawk-input-password>
                            <div class="hawk-native-fallback">
                                <label for="password-fallback">${msg("password")}</label>
                                <input
                                        id="password-fallback"
                                        type="password"
                                        data-fallback-name="password"
                                        autocomplete="current-password"
                                        <#if messagesPerField.existsError('password')>aria-invalid="true"</#if>
                                        disabled
                                />
                                <#if messagesPerField.existsError('password')>
                                    <span class="hawk-native-fallback-error">
                                        ${kcSanitize(messagesPerField.getFirstError('password'))?no_esc}
                                    </span>
                                </#if>
                            </div>
                        </div>

                        <#if realm.resetPasswordAllowed>
                            <hawk-typo>
                                    <span><a tabindex="6"
                                             href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a></span>
                            </hawk-typo>
                        </#if>

                        <div class="hawk-login-button">
                            <input type="hidden" id="id-hidden-input" name="credentialId"
                                   <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>

                            <hawk-button
                                    name="login"
                                    size="large"
                                    value="${msg("doLogIn")}"
                                    submit="true"
                            >${msg("doLogIn")}</hawk-button>
                            <button class="hawk-native-fallback hawk-native-fallback-button" type="submit" data-fallback-name="login" value="${msg("doLogIn")}" disabled>
                                ${msg("doLogIn")}
                            </button>
                        </div>
                    </hawk-formwrap>
                </form>
            </div>
        </div>
    </#if>

</@layout.registrationLayout>
