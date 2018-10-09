.hasMotif {
    margin-left: 0px;
}
#sidebarDiv .sidebarModuleHeader h2 {
    position: relative;
}
.sidebarModule {
    border: 1px solid #ccc;
    border-radius: 5px;
}
#accordion {
    padding: 0 2px 2px 2px;
}
.sidebarModuleBody label {
    min-width: 49px;
    display: inline-block;
    font-size:13px
}
.sidebarModuleBody span {
    font-size:13px;
}
.sidebarModuleBody input {
    width: 64px;
}
.mdl_button {
    height: 20px;
    margin: 5px;
    color: #fff;
}
.user_button {
    width:30%;
}
.session_buttons {
    width: 95%;
    border-radius: 5px;
    height: 25px;
}
.transfer_buttons, .save_btn{
    font-size: .9em!important;
    font: 11px;
    font-family: BlinkMacSystemFont!important;
    width: 95%;
    border-radius: 5px;
    height: 25px;
}
button:disabled{
    background: #ccc;

}
.grn_button {
    background: linear-gradient(#4ba614,#008c00);
    border-color: #4cae4c;
}
.grn_button:not([disabled]):hover {
    background: #008c00 !important;
}
.red_button {
    background: linear-gradient(#d43f3a,#AB0903);
    border-color: #d43f3a;
}
.red_button:not([disabled]):hover {
    background: #AB0903 !important;
}
.warning_button {
    background-image: linear-gradient(to bottom, #f0ad4e 0%, #eb9316 100%);
}
.warning_button:not([disabled]):hover {
    background-color: #eb9316;
    background-position: 0 -15px;
}
.blue_button{
    background-image: linear-gradient(to bottom, #428bca 0%, #2d6ca2 100%);
}
.blue_button:not([disabled]):hover{
    background-color: #2d6ca2;
    background-position: 0 -15px;
}
.call_details {
    padding: 2px 4px 2px 6px;
}
.circleBase {
    display: inline-block;
    border-radius: 50%;
    width: 14px;
}
.mdl-label {
    display:block;
    width: 130px;
    margin: 0 auto;
    font-size: 16px;
    font-weight: bold;
    font-family: "Times New Roman", Georgia, Serif;
}
.mdl-label input {
    display:inline-block;
    border:1px solid black;
    border-radius: 3px;
    height: 24px;
    box-sizing: border-box;
    padding-left: 5px;
}
.mdl-label input:focus {
    border: none;
    outline: none;
}
.sidebarModule .ui-accordion .ui-accordion-content {
    height:auto !important;
    padding: 4px;
    padding-top: 10px;
    font-size: 12px;
}
.sidebarModule .ui-widget input, .sidebarModule .ui-widget textarea {
    margin-bottom: 5px;
}
.sidebarModule .ui-accordion .ui-accordion-header {
    font-weight:bold;
    font-family: Verdana,Arial,sans-serif;
    font-size: 13px;
}
.accordion-field {
    position: relative;
    margin-bottom: 3px;
}
.accordion-field-label {
    font-weight: bold;
}
.accordion-field span {
    position: absolute;
    left: 77px;
    display: inline-block;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    width: 110px;
}
#sessionDropdown {
    padding-left: 3px;
    float: right;
    margin: 5px 3px 3px 3px;
    height: 20px;
    width: 75px;
    background-color: #fff;
    border: 1px solid black;
}
.dispositionDropdown, .voicemailDropdown {
    -webkit-appearance: none; 
    -moz-appearance: none; 
    height: 21px;
    width: 99%;
    margin-bottom: 5px;
    color: rgb(169,169,169);
    padding-left: 3px;
    background: url(..{!$Resource.DropDownArrow_2}) no-repeat; 
    background-position: 167px;
    border-radius: 2px;
}
.accordion-field span.phone-status-span {
    left: 58px;
}
.session-dropdown-wrapper {
    position: absolute;
    right: 1px;
    top: 0px;
}
.session-dropdown-wrapper select {
    -webkit-appearance: none; 
    -moz-appearance: none; 
     background: url(..{!$Resource.DropDownArrow}) no-repeat;  
     background-position: 60px 5px;  
}
.secondary-header {
    position: relative;
}
.alert-danger {
    background-color: #f2dede;
    border-color: #eed3d7;
    color: #b94a48;
}
.alert-success {
    background-color: #fcf8e3;
    border-color: #fbeed5;
    color: #8A621C;
}
.alert-dismissable, .alert-dismissible {
    padding-right: 35px;
}
.alert {
    padding: 5px 9px;
    margin: 10px 5px 5px 5px;
    border: 1px solid transparent;
    border-radius: 4px;
}
.login-dialer-wrapper {
    position: relative;
}
.datepicker, .timepicker{
    width: 180px;
    height: 20px;
}
.ui-datepicker {
    width: 14em; 
}
.ui-timepicker-wrapper{
    width: 15em;
}
.setting {
    width: 182px;
    height: 182px;
    position: absolute;
    top: 30px;
    left: 3px;
    border: 1px solid black;
    padding: 5px;
    z-index: 9;
    background-color: white;
    display: none;
    border-radius: 4px;
}

.callerId-label, .localtouch-label{
    font-weight: bold;
    margin-left: 5px;
}
.callerId-field, .localtouch-field{
    position: relative;
    margin-bottom: 10px;
    margin-top: 10px;
}
.settingsIcon:hover{
    cursor: pointer;
}
.clearCache{
    float: right;
    color: blue;
}
.clearCache:hover{
    cursor: pointer;
}
.loader{
    position: absolute;
    top: 25%;
    left: 25%;
    z-index: 10;
}
.overlay {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    height: 100%;
    width: 100%;
    z-index: 10;
    background-color: rgba(0,0,0,0.78);
    border-radius: 5px;
}