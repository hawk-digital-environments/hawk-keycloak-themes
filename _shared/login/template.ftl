<#import "footer.ftl" as loginFooter>
<#import "hawk-logo.ftl" as hawkLogos>
<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayRequiredFields=false>
    <!DOCTYPE html>
    <html lang="${lang}"<#if realm.internationalizationEnabled> dir="${(locale.rtl)?then('rtl','ltr')}"</#if>>

    <head>
        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="robots" content="noindex, nofollow">

        <#if properties.meta?has_content>
            <#list properties.meta?split(' ') as meta>
                <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}"/>
            </#list>
        </#if>
        <title>${msg("loginTitle",(realm.displayName!''))}</title>
        <link rel="icon" href="${url.resourcesPath}/img/favicon.ico"/>
        <link rel="stylesheet" href="${url.resourcesPath}/components/css/theme.css"/>
        <link rel="stylesheet" href="${url.resourcesPath}/css/style.css"/>
        <link rel="stylesheet" href="${url.resourcesPath}/local/css/style.css"/>
        <script src="${url.resourcesPath}/components/js/svelte-components.js" type="module"></script>
        <#-- @todo check if we need those or if we do not want to allow this feature? -->
        <#--    <#if properties.stylesCommon?has_content>-->
        <#--        <#list properties.stylesCommon?split(' ') as style>-->
        <#--            <link href="${url.resourcesCommonPath}/${style}" rel="stylesheet" />-->
        <#--        </#list>-->
        <#--    </#if>-->
        <#--    <#if properties.styles?has_content>-->
        <#--        <#list properties.styles?split(' ') as style>-->
        <#--            <link href="${url.resourcesPath}/${style}" rel="stylesheet" />-->
        <#--        </#list>-->
        <#--    </#if>-->
        <#--    <#if properties.scripts?has_content>-->
        <#--        <#list properties.scripts?split(' ') as script>-->
        <#--            <script src="${url.resourcesPath}/${script}" type="text/javascript"></script>-->
        <#--        </#list>-->
        <#--    </#if>-->
        <script type="importmap">
            {
                "imports": {
                    "rfc4648": "${url.resourcesCommonPath}/vendor/rfc4648/rfc4648.js"
            }
        }
        </script>
        <script src="${url.resourcesPath}/js/menu-button-links.js" type="module"></script>
        <#if scripts??>
            <#list scripts as script>
                <script src="${script}" type="text/javascript"></script>
            </#list>
        </#if>
        <script type="module">
            import {startSessionPolling} from "${url.resourcesPath}/js/authChecker.js";

            startSessionPolling(
                "${url.ssoLoginInOtherTabsUrl?no_esc}"
            );
        </script>
        <script type="module">
            document.addEventListener("click", (event) => {
                const link = event.target.closest("a[data-once-link]");

                if (!link) {
                    return;
                }

                if (link.getAttribute("aria-disabled") === "true") {
                    event.preventDefault();
                    return;
                }

                const {disabledClass} = link.dataset;

                if (disabledClass) {
                    link.classList.add(...disabledClass.trim().split(/\s+/));
                }

                link.setAttribute("role", "link");
                link.setAttribute("aria-disabled", "true");
            });
        </script>
        <#if authenticationSession??>
            <script type="module">
                import {checkAuthSession} from "${url.resourcesPath}/js/authChecker.js";

                checkAuthSession(
                    "${authenticationSession.authSessionIdHash}"
                );
            </script>
        </#if>
    </head>

    <body class="hawk-body" data-page-id="login-${pageId}">

    <div class="hawk-logos">
        <a href="https://hawk.de" target="_blank" rel="noreferrer,noopener"title="${msg("logoHawk")}">
            <img src="${url.resourcesPath}/img/logo-hawk.png" alt="${msg("logoHawk")}" class="hawk-logos-logo" />
        </a>
        <@hawkLogos.content />
    </div>

    <div class="hawk-login-wrap">
        <div class="hawk-login-container">
            <div class="${properties.kcFormCardClass!}">
                <header class="${properties.kcFormHeaderClass!}">
                    <#if realm.internationalizationEnabled  && locale.supported?size gt 1>
                        <hawk-select
                                id="language-switch"
                                label="${msg("languageSwitch")}"
                                block="true">
                            <#assign i = 1>
                            <#list locale.supported as l>
                                <option value="${l.url}" <#if l.languageTag == locale.currentLanguageTag>selected</#if>>${l.label}</option>
                                <#assign i++>
                            </#list>
                        </hawk-select>
                        <script>
                            document.getElementById("language-switch").addEventListener("change", function (e) {
                                window.location.href = e.detail.value;
                            });
                        </script>
                        <br/>
                    </#if>
                    <#if !(auth?has_content && auth.showUsername() && !auth.showResetCredentials())>
                        <#nested "header">
                        <br/>
                    <#else>
                        <#if displayRequiredFields>
                            <div class="${properties.kcContentWrapperClass!}">
                                <div class="${properties.kcLabelWrapperClass!} subtitle">
                                    <span class="subtitle"><span
                                                class="required">*</span> ${msg("requiredFields")}</span>
                                </div>
                                <div class="col-md-10">
                                    <#nested "show-username">
                                    <div id="kc-username" class="${properties.kcFormGroupClass!}">
                                        <label id="kc-attempted-username">${auth.attemptedUsername}</label>
                                        <a id="reset-login" href="${url.loginRestartFlowUrl}"
                                           aria-label="${msg("restartLoginTooltip")}">
                                            <div class="kc-login-tooltip">
                                                <i class="${properties.kcResetFlowIcon!}"></i>
                                                <span class="kc-tooltip-text">${msg("restartLoginTooltip")}</span>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        <#else>
                            <#nested "show-username">
                            <div id="kc-username" class="${properties.kcFormGroupClass!}">
                                <label id="kc-attempted-username">${auth.attemptedUsername}</label>
                                <a id="reset-login" href="${url.loginRestartFlowUrl}"
                                   aria-label="${msg("restartLoginTooltip")}">
                                    <div class="kc-login-tooltip">
                                        <i class="${properties.kcResetFlowIcon!}"></i>
                                        <span class="kc-tooltip-text">${msg("restartLoginTooltip")}</span>
                                    </div>
                                </a>
                            </div>
                        </#if>
                    </#if>
                </header>
                <div id="kc-content">
                    <div id="kc-content-wrapper">

                        <#-- App-initiated actions should not see warning messages about the need to complete the action -->
                        <#-- during login.                                                                               -->
                        <#if displayMessage && message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
                            <hawk-typo>
                                <span style="color: var(--clr-signal-error)">${kcSanitize(message.summary)?no_esc}</span>
                            </hawk-typo>
                        </#if>

                        <#nested "form">

                        <#if auth?has_content && auth.showTryAnotherWayLink()>
                            <form id="kc-select-try-another-way-form" action="${url.loginAction}" method="post">
                                <div class="${properties.kcFormGroupClass!}">
                                    <input type="hidden" name="tryAnotherWay" value="on"/>
                                    <a href="#" id="try-another-way"
                                       onclick="document.forms['kc-select-try-another-way-form'].requestSubmit();return false;">${msg("doTryAnotherWay")}</a>
                                </div>
                            </form>
                        </#if>

                        <#nested "socialProviders">

                        <#if displayInfo>
                            <div id="kc-info" class="${properties.kcSignUpClass!}">
                                <div id="kc-info-wrapper" class="${properties.kcInfoAreaWrapperClass!}">
                                    <#nested "info">
                                </div>
                            </div>
                        </#if>
                    </div>
                </div>

                <@loginFooter.content/>
            </div>
        </div>
    </div>
    </body>
    </html>
</#macro>
