<#import "template.ftl" as layout>
<#import "hawk-title.ftl" as hawkTitle>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('password'); section>
    <#if section = "header">
        <@hawkTitle.content />
    <#elseif section = "form">
        <div id="kc-form">
            <div id="kc-form-wrapper">
                <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}"
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
                        </div>
                    </hawk-formwrap>
                </form>
            </div>
        </div>
    </#if>

</@layout.registrationLayout>
