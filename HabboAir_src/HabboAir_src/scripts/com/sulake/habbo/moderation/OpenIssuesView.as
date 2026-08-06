package com.sulake.habbo.moderation
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IItemListWindow;
   
   public class OpenIssuesView implements IIssueBrowserView
   {
      private var UnknownVarFromOpenIssuesView_IssueManager_1:IssueManager;
      
      private var UnknownVarFromOpenIssuesView_IssueBrowser_1:IssueBrowser;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromOpenIssuesView_IssueListView_1:IssueListView;
      
      public function OpenIssuesView(param1:IssueManager, param2:IssueBrowser, param3:IWindowController_1)
      {
         super();
         UnknownVarFromOpenIssuesView_IssueManager_1 = param1;
         UnknownVarFromOpenIssuesView_IssueBrowser_1 = param2;
         _window = param3;
         _window.visible = false;
         var _loc4_:IItemListWindow = _window.findChildByName("issue_list") as IItemListWindow;
         UnknownVarFromOpenIssuesView_IssueListView_1 = new IssueListView(param1,param2,_loc4_);
      }
      
      public function get view() : IWindowController_1
      {
         return _window;
      }
      
      public function set visible(param1:Boolean) : void
      {
         _window.visible = param1;
      }
      
      public function update() : void
      {
         var _loc1_:Array = UnknownVarFromOpenIssuesView_IssueManager_1.getBundles("issue_bundle_open");
         UnknownVarFromOpenIssuesView_IssueListView_1.update(_loc1_);
      }
   }
}

