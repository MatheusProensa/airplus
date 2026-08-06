package com.sulake.habbo.moderation
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IItemListWindow;
   
   public class PickedIssuesView implements IIssueBrowserView
   {
      private var UnknownVarFromPickedIssuesView_IssueManager_1:IssueManager;
      
      private var UnknownVarFromPickedIssuesView_IssueBrowser_1:IssueBrowser;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromPickedIssuesView_IssueListView_1:IssueListView;
      
      public function PickedIssuesView(param1:IssueManager, param2:IssueBrowser, param3:IWindowController_1)
      {
         super();
         UnknownVarFromPickedIssuesView_IssueManager_1 = param1;
         UnknownVarFromPickedIssuesView_IssueBrowser_1 = param2;
         _window = param3;
         _window.visible = false;
         var _loc4_:IItemListWindow = _window.findChildByName("issue_list") as IItemListWindow;
         UnknownVarFromPickedIssuesView_IssueListView_1 = new IssueListView(param1,param2,_loc4_);
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
         var _loc1_:Array = UnknownVarFromPickedIssuesView_IssueManager_1.getBundles("issue_bundle_picked");
         UnknownVarFromPickedIssuesView_IssueListView_1.update(_loc1_);
      }
   }
}

