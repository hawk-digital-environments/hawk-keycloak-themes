<#import "template.ftl" as layout>
<#import "hawk-title.ftl" as hawkTitle>
<#import "passkeys.ftl" as passkeys>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username') displayInfo=(realm.password && realm.registrationAllowed && !registrationDisabled??); section>
    <#if section = "header">
        <@hawkTitle.content />
    <#elseif section = "form">
        <div id="kc-form">
            <div id="kc-form-wrapper">
                <#if realm.password>
                    <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}"
                          method="post">
                            <#if !usernameHidden??>
                                <hawk-input
                                        id="username"
                                        name="username"
                                        value="${(login.username!'')}"
                                        autofocus
                                        autocomplete="username"
                                        block="true"
                                        label="<#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if>"
                                        <#if messagesPerField.existsError('username','password')>error="${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}"</#if>
                                >
                                </hawk-input>
                            </#if>

                            <div>
                                <#if realm.rememberMe && !usernameHidden??>
                                    <hawk-checkbox
                                            label="${msg("rememberMe")}"
                                            checked="<#if login.rememberMe??>true<#else>false</#if>"
                                            id="rememberMe"
                                            name="rememberMe"></hawk-checkbox>
                                </#if>

                                <#if realm.resetPasswordAllowed>
                                    <hawk-typo>
                                            <span><a tabindex="6"
                                                     href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a></span>
                                    </hawk-typo>
                                </#if>
                            </div>
                            <br/>

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
                </#if>
            </div>
        </div>
        <@passkeys.conditionalUIData />

    <#elseif section = "info" >
        <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
            <div id="kc-registration-container">
                <div id="kc-registration">
                    <span>${msg("noAccount")} <a tabindex="8"
                                                 href="${url.registrationUrl}">${msg("doRegister")}</a></span>
                </div>
            </div>
        </#if>
    <#elseif section = "socialProviders" >
        <#if realm.password && social?? && social.providers?has_content>
            <hawk-typo>
                <hr/>
                <h2>${msg("identity-provider-login-label")}</h2>

                <ul class="${properties.kcFormSocialAccountListClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountListGridClass!}</#if>">
                    <#list social.providers as p>
                        <li>
                            <a data-once-link
                               data-disabled-class="${properties.kcFormSocialAccountListButtonDisabledClass!}"
                               id="social-${p.alias}"
                               class="${properties.kcFormSocialAccountListButtonClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountGridItem!}</#if>"
                               type="button" href="${p.loginUrl}">
                                <#if p.iconClasses?has_content>
                                    <i class="${properties.kcCommonLogoIdP!} ${p.iconClasses!}" aria-hidden="true"></i>
                                    <span class="${properties.kcFormSocialAccountNameClass!} kc-social-icon-text">${p.displayName!}</span>
                                <#else>
                                    <span class="${properties.kcFormSocialAccountNameClass!}">${p.displayName!}</span>
                                </#if>
                            </a>
                        </li>
                    </#list>
                </ul>
            </hawk-typo>
        </#if>
    </#if>

</@layout.registrationLayout>
