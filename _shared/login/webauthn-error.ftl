<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=true; section>
    <#if section = "header">
        <hawk-typo>
            <h2>${kcSanitize(msg("webauthn-error-title"))?no_esc}</h2>
        </hawk-typo>
    <#elseif section = "form">

        <script type="text/javascript">
            refreshPage = () => {
                document.getElementById('isSetRetry').value = 'retry';
                document.getElementById('executionValue').value = '${execution}';
                document.getElementById('kc-error-credential-form').requestSubmit();
            }
        </script>

        <form id="kc-error-credential-form" class="${properties.kcFormClass!}" action="${url.loginAction}"
              method="post">
            <input type="hidden" id="executionValue" name="authenticationExecution"/>
            <input type="hidden" id="isSetRetry" name="isSetRetry"/>
        </form>

        <br>
        <div style="display: flex; gap: 10px; flex-direction: row;">
            <hawk-button
                onclick="refreshPage()"
                size="large"
                autofocus="autofocus"
            >
                ${kcSanitize(msg("doTryAgain"))?no_esc}
            </hawk-button>
            <#if isAppInitiatedAction??>
                <form action="${url.loginAction}" class="${properties.kcFormClass!}" id="kc-webauthn-settings-form" method="post">
                    <input type="hidden" name="cancel-aia" value="true"/>
                    <div style="display: flex; justify-content: center;">
                        <hawk-button
                            type="outlined"
                            submit="true"
                            size="large"
                            autofocus="autofocus"
                        >
                            ${kcSanitize(msg("doCancel"))?no_esc}
                        </hawk-button>
                    </div>
                </form>
            </#if>
        </div>

    </#if>
</@layout.registrationLayout>
