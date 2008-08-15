<%@ Control Language="C#" AutoEventWireup="true" Codebehind="DocSiteContents.ascx.cs" Inherits="MathNet.Iridium.DocSite.Controls.DocSiteContents" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>

<asp:UpdatePanel ID="tocUpdatePanel" runat="server">
	<Triggers>
		<asp:AsyncPostBackTrigger ControlID="tocSyncButton" EventName="Click" />
		<asp:PostBackTrigger ControlID="contentsTreeView" />
	</Triggers>
	<ContentTemplate>
	  <div class="toc_button_bar">
			<div class="toc_button_container">
			  <%-- This button's function is to cause an async partial postback; however, a server click event handler is not required. --%>
				<asp:ImageButton runat="server" SkinID="SyncTocImageButton" ID="tocSyncButton" CausesValidation="False" 
				                 ToolTip='<%$ Resources:General,DocSiteSyncButtonToolTip %>' meta:resourcekey="tocSyncButtonResource1" />
      </div><div class="toc_button_dynamic_container" id="toc_save_container">
			  <asp:ImageButton runat="server" SkinID="SaveImageButton" ID="saveImageButton" CausesValidation="False"
			                   OnClientClick="saveDocument(event); return false;"
                         ToolTip='<%$ Resources:General,DocSiteSaveButtonToolTip %>' meta:resourcekey="saveImageButtonResource1" />
      </div><div class="toc_button_dynamic_container" id="toc_bookmark_container">
        <asp:ImageButton runat="server" SkinID="BookmarkImageButton" ID="bookmarkImageButton" CausesValidation="False"
                         OnClientClick="bookmarkUrl(event, document.getElementById('selectedTopicUrl').value, document.getElementById('selectedTopicFullTitle').value); return false;"
                         ToolTip='<%$ Resources:General,DocSiteBookmarkButtonToolTip %>' meta:resourcekey="bookmarkImageButtonResource1" />
      </div><div class="toc_button_dynamic_container" id="toc_print_container">
			  <asp:ImageButton runat="server" SkinID="PrintImageButton" ID="printImageButton" CausesValidation="False"
			                   OnClientClick="printDocument(event); return false;"
                         ToolTip='<%$ Resources:General,DocSitePrintButtonToolTip %>' meta:resourcekey="printImageButtonResource1" />
      </div><div class="toc_button_container" id="toc_email_container">
        <%-- The client-side click event handler for this button is set in the code-behind. --%>
        <asp:ImageButton runat="server" SkinID="EmailImageButton" ID="emailImageButton" CausesValidation="False"
                         ToolTip='<%$ Resources:General,DocSiteEmailButtonToolTip %>' meta:resourcekey="emailImageButtonResource1" />
			</div>
			<%-- These inputs are used by the client-side click event handler of bookmarkImageButton (above). --%>
			<input type="hidden" id="selectedTopicUrl" value="<%= SelectedTopicUrl %>" />
			<input type="hidden" id="selectedTopicFullTitle" value="<%= SelectedTopicFullTitle %>" />
			<asp:UpdateProgress runat="server" ID="tocUpdateProgress" AssociatedUpdatePanelID="tocUpdatePanel">
				<ProgressTemplate>
					<div class="toc_sync_progress"><asp:Localize runat="server" ID="pleaseWaitLocalize" Text='<%$ Resources:General,PleaseWait %>' /></div>
				</ProgressTemplate>
			</asp:UpdateProgress>
		</div>
		<div class="toc">
			<asp:TreeView ID="contentsTreeView" runat="server" ExpandDepth="0" ImageSet="Msdn" DataSourceID="contentsXmlDataSource" Width="100%" 
				OnSelectedNodeChanged="contentsTreeView_SelectedNodeChanged" AutoGenerateDataBindings="False" meta:resourcekey="contentsTreeViewResource1">
				<ParentNodeStyle Font-Bold="False" />
				<HoverNodeStyle CssClass="topicitem_hot" />
				<SelectedNodeStyle CssClass="topicitem_selected" />
				<NodeStyle CssClass="topicitem" />
				<DataBindings>
					<asp:TreeNodeBinding DataMember="topic" SelectAction="SelectExpand" PopulateOnDemand="True" TextField="name" ValueField="name" meta:resourcekey="TreeNodeBindingResource1" />
				</DataBindings>
			</asp:TreeView>
		</div>

		<asp:XmlDataSource XPath="topics/topic" ID="contentsXmlDataSource" runat="server"></asp:XmlDataSource>
	</ContentTemplate>
</asp:UpdatePanel>