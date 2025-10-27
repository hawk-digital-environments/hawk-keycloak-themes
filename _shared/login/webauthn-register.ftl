<#import "template.ftl" as layout>
<#import "password-commons.ftl" as passwordCommons>

<@layout.registrationLayout; section>
    <#if section = "title">
        title
    <#elseif section = "header">
        <hawk-typo>
            <h2>${kcSanitize(msg("webauthn-registration-title"))?no_esc}</h2>
        </hawk-typo>
    <#elseif section = "form">

        <form id="register" class="${properties.kcFormClass!}" action="${url.loginAction}" method="post">
            <div class="${properties.kcFormGroupClass!}">
                <input type="hidden" id="clientDataJSON" name="clientDataJSON"/>
                <input type="hidden" id="attestationObject" name="attestationObject"/>
                <input type="hidden" id="publicKeyCredentialId" name="publicKeyCredentialId"/>
                <input type="hidden" id="authenticatorLabel" name="authenticatorLabel"/>
                <input type="hidden" id="transports" name="transports"/>
                <input type="hidden" id="error" name="error"/>
                <hawk-typo>
                <@passwordCommons.logoutOtherSessions/>
                </hawk-typo>
            </div>
        </form>

        <script type="module">
            import { registerByWebAuthn } from "${url.resourcesPath}/js/webauthnRegister.js";
            const registerButton = document.getElementById('registerWebAuthn');
            registerButton.addEventListener("click", function() {
                const input = {
                    challenge : '${challenge}',
                    userid : '${userid}',
                    username : '${username}',
                    signatureAlgorithms : [<#list signatureAlgorithms as sigAlg>${sigAlg?c},</#list>],
                    rpEntityName : '${rpEntityName}',
                    rpId : '${rpId}',
                    attestationConveyancePreference : '${attestationConveyancePreference}',
                    authenticatorAttachment : '${authenticatorAttachment}',
                    requireResidentKey : '${requireResidentKey}',
                    userVerificationRequirement : '${userVerificationRequirement}',
                    createTimeout : ${createTimeout?c},
                    excludeCredentialIds : '${excludeCredentialIds}',
                    initLabel : "${msg("webauthn-registration-init-label")?no_esc}",
                    initLabelPrompt : "${msg("webauthn-registration-init-label-prompt")?no_esc}",
                    errmsg : "${msg("webauthn-unsupported-browser-text")?no_esc}"
                };
                registerByWebAuthn(input);
            }, { once: true });
        </script>

        <br>
        <div style="display: flex; gap: 10px; flex-direction: row;">
            <form class="form-actions" action="${url.loginAction}" method="POST">
                <hawk-button
                    id="registerWebAuthn"
                    size="large"
                    autofocus="autofocus"
                >
                    ${msg("doRegisterSecurityKey")}
                </hawk-button>
            </form>
            <#if !isSetRetry?has_content && isAppInitiatedAction?has_content>
                <form action="${url.loginAction}" class="${properties.kcFormClass!}" id="kc-webauthn-settings-form"
                      method="post">
                    <input type="hidden" name="cancel-aia" value="true"/>
                    <hawk-button
                        type="outlined"
                        submit="true"
                        size="large"
                        autofocus="autofocus"
                    >
                        ${msg("doCancel")}
                    </hawk-button>
                </form>
            </#if>
        </div>
    </#if>
</@layout.registrationLayout>
