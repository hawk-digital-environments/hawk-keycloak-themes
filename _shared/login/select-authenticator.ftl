<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=false; section>
    <#if section = "header" || section = "show-username">
        <#if section = "header">
            ${msg("loginChooseAuthenticator")}
        </#if>
    <#elseif section = "form">
            <br>
            <div class="${properties.kcSelectAuthListClass!}" style="display: flex; flex-direction: column; gap: 15px;">
                <#list auth.authenticationSelections as authenticationSelection>
                    <form id="kc-select-credential-form" class="${properties.kcFormClass!}" action="${url.loginAction}" method="post">
                        <input type="hidden" name="authenticationExecution" value="${authenticationSelection.authExecId}"/>
                        <hawk-button type="outlined" size="large" submit="true" name="authenticationExecution" value="${authenticationSelection.authExecId}">
                            <span class="${properties['${authenticationSelection.iconCssClass}']!authenticationSelection.iconCssClass} ${properties.kcSelectAuthListItemIconPropertyClass!}" style="font-size: 15px"></span>
                            ${msg('${authenticationSelection.displayName}')}
                        </hawk-button>
                        <hawk-typo>
                            <span class="size-s">${msg('${authenticationSelection.helpText}')}</span>
                        </hawk-typo>
                    </form>
                </#list>
            </div>
    </#if>
</@layout.registrationLayout>
