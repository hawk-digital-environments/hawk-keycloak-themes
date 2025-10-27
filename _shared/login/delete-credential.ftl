<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
    <#if section = "header">
        <hawk-typo>
            <h2>${msg("deleteCredentialTitle", credentialLabel)}</h2>
        </hawk-typo>
    <#elseif section = "form">
    <div id="kc-delete-text">
        <hawk-typo>
            <span>${msg("deleteCredentialMessage", credentialLabel)}</span>
            <br>
        </hawk-typo>
    </div>
    <br>
    <div style="display: flex; gap: 10px; flex-direction: row;">
        <form class="form-actions" action="${url.loginAction}" method="POST">
            <input type="hidden" name="accept" value="true"/>
            <hawk-button
                submit="true"
                size="large"
                autofocus="autofocus"
            >
                ${msg("doConfirmDelete")}
            </hawk-button>
        </form>
        <form class="form-actions" action="${url.loginAction}" method="POST">
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
    </div>
    </#if>
</@layout.registrationLayout>
